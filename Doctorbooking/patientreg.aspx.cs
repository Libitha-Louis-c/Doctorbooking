using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Net;

namespace Doctorbooking
{
    public partial class patientreg1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void PatientRegButton_Click(object sender, EventArgs e)
        {
            try
            {
                bookingdbEntities1 db = new bookingdbEntities1();
                patientreg d = db.patientregs.FirstOrDefault(f => f.email == email.Value.Trim());
                if (d != null)
                {
                    lblmsg.InnerText = "This email is already registered for another patient...!";
                    lblmsg.Style["color"] = "red";
                    return;
                }
                string pwd = Guid.NewGuid().ToString().Substring(0, 10);
                patientreg p = new patientreg { name = name.Value, email = email.Value, gender = gender.Value, address = address.Value, mob = Convert.ToDecimal(phone.Value.Replace("-", "")), password = pwd };
                int val = (Convert.ToInt32(pincode.Value));
                db.patientregs.Add(p);
                int n = db.SaveChanges();
                try
                {
                if (n < 0)
                {
                    lblmsg.InnerText = "Registration failed.please try again later";
                }
                    else
                    {
                       
                        //send pwd to registerd email
                        SmtpClient mcl = new SmtpClient("smtp.gmail.com", 587);
                        mcl.EnableSsl = true;
                        mcl.Credentials = new NetworkCredential("libithalouis1@gmail.com", "libitha123");
                        string msg = $"dear Patient,\nThank you for registering with doctor booking system.\nYour login password is {pwd}  \nThank you\nAdministrator,\nDoctor booking system.";

                        mcl.Send("libithalouis1@gmail.com", p.email, "confirmed patient registration", msg);
                    }
                }
                catch (Exception ex)
                {
                    lblmsg.InnerText = "Unable to continue... " + ex.Message;
                }



                Response.Redirect("patientreg.aspx", true);
            }
            catch (Exception ex)
            {
                lblmsg.InnerText = "Error occurerd...please try at later";
            }
        }
        
    }
}

