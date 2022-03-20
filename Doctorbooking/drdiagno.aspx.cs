using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Doctorbooking
{
    public partial class drdiagno : System.Web.UI.Page
    {
        bookingdbEntities1 db = new bookingdbEntities1();
        protected void Page_Load(object sender, EventArgs e)
        {
            lblerror.Text = "";

            if (Session["role"] == null || Session["role"].ToString() != "doctor")
            {
                Response.Write("Requires Doctor login");
                Server.Transfer("login.aspx");
                //Response.End();
                return;
            }
            else
            {
                int did = (int)Session["id"];
                if (!IsPostBack)
                {
                    doctor dr = db.doctors.Find(did);
                    if (dr == null)
                    {
                        lblerror.Text = "Sorry Doctor ..please Re Login.. we are uanble to access your credntials..!";
                        btnsave.Enabled = false;
                        return;
                    }
                    lblPresTitle.Text = "Dr." + dr.docname + " Mob: " + dr.mob.ToString();
                    txtamt.Text = (dr?.fee).ToString();
                    bool isall = (Request.QueryString["bk"] ?? "") == "all";
                    if (!dofillBooking(did, isall))
                    {
                        string today = !isall ? "today" : "";
                        lblerror.Text = $"No bookings found for {today}...!";
                        btnsave.Enabled = false;
                        return;
                    }
                  
                }
                
            }
            btnsave.Enabled = drpbooking.Items.Count > 1;
        }

        private bool dofillBooking(int did,bool all=false)
        {
            drpbooking.Items.Clear();
            drpbooking.Items.Add("....select booking....");
            //grddiags.DataSourceID = "";
            //grddiags.DataSource = null;
            //grddiags.DataBind();
            //grddiags.DataSourceID = "SqldsTest";
            List<appointment> bookings = new List<appointment>();
            if (!all)
            {
                DateTime dt = DateTime.Now.Date;
                bookings = db.appointments.Where(f => f.bookingdate == dt && f.drcid == did && (f.Cancelled ?? false) == false).OrderByDescending(o => o.apid).ToList();
            }
            else
            {
                bookings = db.appointments.Where(f => f.drcid == did && (f.Cancelled ?? false) == false).OrderByDescending(o => o.apid).ToList();
            }
            if (bookings.Any())
            {
                var bookinglist = bookings.Select(s =>
                {
                    return new
                    {
                        aid = s.apid,
                        pname = s.pname +
                        (all ? " " + s.bookingdate.ToString("dd-MM-yyyy") + " " + s.time.Trim() : "")
                    };
                }).ToList();
            
                drpbooking.DataSource = bookinglist;
                drpbooking.DataTextField = "pname";
                drpbooking.DataValueField = "aid";
                drpbooking.DataBind();
            }
            return bookings.Any();

        }

        protected void btnsave_Click(object sender, EventArgs e)
        {
            if (drpbooking.SelectedIndex <= 0)
            {
                lblerror.Text = "please select patient from booking List";
                return;
            }
            //get doctor
            int did = (int)Session["id"];
            doctor dr = db.doctors.Find(did);
            //get patient
            int pid = Convert.ToInt32(hidnpid.Value);
            patientreg pr = db.patientregs.Find(pid);
            //get test fee
            int tamt = 0;
            int.TryParse(txttestamt.Text, out tamt);

            //get Consultation fee
            int amt = 0;
            int.TryParse(txtamt.Text, out amt);
            test t = null;

            if (!string.IsNullOrWhiteSpace(hidntid.Value) &&((Button) sender).ID=="btnupdate")
            {
                int tid = Convert.ToInt32(hidntid.Value);
                t = db.tests.Find(tid);
            }
            if (t == null) t = new test();
            appointment ap = db.appointments.Find(Convert.ToInt32(drpbooking.SelectedValue));

            t.test_details = txtdetails.Text;t.date = DateTime.Now;t.docname = dr.docname;t.docid = did;
            t.pid = pid;t.pname = ap.pname; t.testamt = tamt;

            if (t.tid == 0)
                db.tests.Add(t);

            ap.Consulted = true;
            ap.Feepaid = amt + tamt;

            int n = db.SaveChanges();
            if (n > 0)
            {
                btnupdate.Visible = false;
                lblerror.Text = "Consultation Details Saved...!";
                lblerror.ForeColor = System.Drawing.Color.Green;
                grddiags.DataBind();
            }
            else
            {
                lblerror.Text = "Unable to Save Consultaion Details..!";
            }

        }

        protected void drpbooking_SelectedIndexChanged(object sender, EventArgs e)
        {
           //clear inputs
            txtamt.Text = "";
            txttestamt.Text = "";
            txtdetails.Text = "";
            hidnbid.Value = "";
            hidntid.Value = "";
            hidnpid.Value = "";
        

            if (drpbooking.SelectedIndex > 0)
            {
                string sel_id = drpbooking.SelectedValue;
                int bid = Convert.ToInt32(sel_id);
                appointment bk = db.appointments.Find(bid);
                int pid = bk.patid;
                patientreg pr = db.patientregs.Find(pid);
                if (pr == null)
                {
                    btnsave.Enabled = false;
                    lblerror.Text = "unable to access selected patient record.../mat be removed..?/or try later.!";
                    return;
                }
                hidnbid.Value = sel_id;
                hidnpid.Value = pid.ToString();
                lblpat.Text = pr.name + " Phone: " + pr.mob + " email: " + pr.email;
                
            }
            else
                lblerror.Text = "Please select a patient from booked list..!";
        }

        protected void grddiags_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int tid = (int)e.Keys["tid"];
            test t = db.tests.Find(tid);
            if (t != null)
            {
                db.tests.Remove(t);
                int n = db.SaveChanges();
                if (n == 0)
                    lblerror.Text = "Unable to delete selecetd Diagnosis details of this patient";
            }
            
            grddiags.DataBind();
        }

        protected void grddiags_SelectedIndexChanged(object sender, EventArgs e)
        {
            hidntid.Value = "";
            if (grddiags.SelectedIndex >= 0)
            {
                int tid = (int)grddiags.SelectedDataKey["tid"];
                test t = db.tests.Find(tid);
                if (t != null)
                {
                    hidntid.Value = tid.ToString();
                    txtdetails.Text = t.test_details;
                    txttestamt.Text = t.testamt.ToString();
                    btnupdate.Visible = true;
                }
            }
        }
    }
}