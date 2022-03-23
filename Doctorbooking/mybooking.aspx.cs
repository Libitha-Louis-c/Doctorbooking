using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Doctorbooking
{
    public partial class mybooking : System.Web.UI.Page
    {
        bookingdbEntities1 db = new bookingdbEntities1();
        protected void Page_Load(object sender, EventArgs e)
        {
            lblerror.Text = "";
            lblerror.ForeColor = System.Drawing.Color.Red;
            if (Session["role"] == null || Session["role"].ToString() != "patient")
            {
                Response.Write("Requires patient login");
                Server.Transfer("login.aspx");
                return;
            }
        }

        protected void grddiags_SelectedIndexChanged(object sender, EventArgs e)
        {
            Control txtfbk = grddiags.SelectedRow.FindControl("txtfeedback");
            if (txtfbk != null)
                txtfbk.Visible = true;

            Control btnfbk = grddiags.SelectedRow.FindControl("btnfback");
            if(btnfbk!=null)
                btnfbk.Visible = true;
        }

        protected void btnfback_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)(((Button)sender).NamingContainer);
            HiddenField hdnId = (HiddenField)row.FindControl("HiddenID");
            TextBox tfbak = (TextBox)row.FindControl("txtfeedback");
            string fbak = tfbak.Text;

            //update feeedback
            int apid = (int)Session["id"];
            appointment ap = db.appointments.Find(apid);
            //string to = ap.patientreg.email+",isprasadin@gmail.com";
            string to = "isprasadin@gmail.com";
            if (ap != null)
            {

                string msg = $"dear {ap.pname},\nThank you for your valuable feedback.\n\n Your feedback:{fbak }  \nThank you\nAdministrator,\nDoctor booking system.";

                string status = Mailer.SendMail(to, "receieved feedback", msg);

                if (status != "success")
                {
                    lblerror.Text = "Unable to SEnd your feedback..!";
                }
                else
                {
                    lblerror.Text = "Your valuable feedback is Succesfully reported.. Thank you.!";
                    lblerror.ForeColor = System.Drawing.Color.Green;
                }
            }
            tfbak.Text = "";
            tfbak.Visible = false;
            ((Button)sender).Visible = false;
        }

        //protected void grddiags_RowCommand(object sender, GridViewCommandEventArgs e)
        //{
        //    if (e.CommandName == "feedback")
        //    {
        //        GridViewRow row = (GridViewRow)(((Button)e.CommandSource).NamingContainer);
        //        HiddenField hdnId = (HiddenField)row.FindControl("HiddenID");
        //        TextBox tfbak = (TextBox)row.FindControl("txtfeedback");
        //        string fbak = tfbak.Text;

        //        //update feeedback
        //        int apid = (int)Session["id"];
        //        appointment ap = db.appointments.Find(apid);
        //        //string to = ap.patientreg.email+",isprasadin@gmail.com";
        //        string to = "isprasadin@gmail.com";
        //        if (ap != null)
        //        {

        //            string msg = $"dear {ap.pname},\nThank you for your valuable feedback.\n\n Your feedback:{fbak }  \nThank you\nAdministrator,\nDoctor booking system.";

        //            string status = Mailer.SendMail(to, "receieved feedback", msg);

        //            if (status != "success")
        //            {
        //                lblerror.Text = "Unable to SEnd your feedback..!";
        //            }
        //            else
        //            {
        //                lblerror.Text = "Your valuable feedback is Succesfully reported.. Thank you.!";
        //                lblerror.ForeColor = System.Drawing.Color.Green;
        //            }
        //        }
        //        tfbak.Text = "";
        //        tfbak.Visible = false;
        //        ((Button)e.CommandSource).Visible = false;
        //    }
        //}
    }
}