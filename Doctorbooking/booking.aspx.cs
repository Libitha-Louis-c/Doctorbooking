using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Doctorbooking
{
    public partial class booking : System.Web.UI.Page
    {
       public bookingdbEntities1 db = new bookingdbEntities1();
        patientreg p = null; //patient logged in
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["role"] == null || Session["role"].ToString() != "patient")
            {
                Response.Write("Requires patient login");
                Server.Transfer("login.aspx");
                //Response.End();
                return;
            }
            else
            {
                int pid = (int)Session["id"];
                 p = db.patientregs.FirstOrDefault(f => f.pid == pid);
                if (p == null)
                {
                    Response.Write("Requires patient login");
                    return;
                }
                txtemail.Text = p.email;
                txtname.Text = p.name;
                txtemail.ReadOnly = true;
                //txtname.ReadOnly = true;
                
            }

        }
        protected void btnbook_Click(object sender, EventArgs e)
        {
            if (p == null)
            {
                Response.Write("Requires patient login");
                return;
            }
            else
            {
                
                try
                {
                    //Format Booking Date
                    DateTime dt = Convert.ToDateTime(txtdate.Text);
                    if (dt <= DateTime.Now)
                    {
                       
                        ShowMsg("Sorry, Booking permitted for up coming dates only..!");
                        return;
                    }
                    string dts = dt.ToString("yyyy-MM-dd");
                    DateTime bdt = Convert.ToDateTime(dts);
                    if (bdt.ToString("ddd").ToLower() == "sun")
                    {
                        ShowMsg("Sorry, Holiday (Sunday) Booking not permitted ..!");
                        return;
                    }
                    //Verify Doctor Info
                    int did = Convert.ToInt32(hidndr.Value);
                    doctor d = db.doctors.Find(did);
                    if (d == null)
                    {
                        ShowMsg( "Error retrieveing Doctor Info..please re login and try again..!");
                        lblerror.Focus();
                        return;
                    }
                    p.appointments.Add(new appointment
                    {
                        Date = DateTime.Now,
                        bookingdate = bdt,
                        time = txttime.Text,
                        drcid = did,
                        pname = txtname.Text,
                        ailments = txtmessage.Text,
                        drloc = ""
                    });
                    int n = db.SaveChanges();
                    if (n > 0)
                    {
                        ShowMsg($"Your Booking is received for Dr.{d.docname.ToUpper()}");
                        lblerror.ForeColor = System.Drawing.Color.Green;
                        lblerror.Focus();
                        string msg = $"dear {p.name},\nThank you for Booking.\n\n Booking for Appointment with Dr:{d.docname }  on {bdt.ToString("dd-MM-yyyy")} at {txttime.Text} received successfully \nThank you\nAdministrator,\nDoctor booking system.";
                        Mailer.SendMail(p.email, "Booking Confirmation", msg);
                    }
                }
                //catch (DbEntityValidationException ex)
                //{
                //    string err = "";
                //    foreach (var evr in ex.EntityValidationErrors)
                //    {
                //        err += string.Format("Entity of type \"{0}\" in state \"{1}\" has the following validation errors:",
                //             evr.Entry.Entity.GetType().Name, evr.Entry.State) + Environment.NewLine;
                //        foreach (var ve in evr.ValidationErrors)
                //        {
                //            err += string.Format("- Property: \"{0}\", Error: \"{1}\"",
                //                ve.PropertyName, ve.ErrorMessage) + Environment.NewLine;
                //        }
                //    }
                //    lblerror.Text = err;
                //    lblerror.Focus();
                //    return;
                //}
                catch (Exception ex1)
                {
                    ShowMsg("Error occured while Booking.. please try after some time..! ");
                    return;
                }
            }

        }

        private void ShowMsg(string msg)
        {
            lblerror.Text = msg;
            lblerror.Focus();
        }
    }
}