using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Doctorbooking
{
    public partial class patprofile : System.Web.UI.Page
    {
        public bookingdbEntities1 db = new bookingdbEntities1();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["role"]==null || Session["role"].ToString() != "patient")
            {
                lblerror.Text = "You may need to Login as patient to access patient profile..!";
                // Server.Transfer("default.aspx");
               
                  
                return;
            }
           if(!IsPostBack)
            {
                int id = Convert.ToInt32(Session["id"]);
                hidnid.Value = id.ToString();
                patientreg p = GetPatient(id);
                name.Value = p.name;
                phone.Value = p.mob.ToString();
                gender.SelectedIndex = gender.Items.IndexOf(gender.Items.FindByValue(id.ToString()));
                address.Value = p.address;
                pincode.Value = p.pincode.ToString();
                email.Value = p.email;
            }
        }

        protected void PatientRegButton_Click(object sender, EventArgs e)
        {
            string result = updateProfile(Convert.ToInt32(hidnid.Value),name.Value,
                phone.Value, Convert.ToInt32(pincode.Value), address.Value, gender.Value);
            if (!string.IsNullOrWhiteSpace(result))
            {
                lblerror.Text = result;
            }
            else
            {
                lblerror.Text = "Profile successfully updated";
                lblerror.ForeColor = System.Drawing.Color.Green;
            }
        }
        protected void btnpwd_Click(object sender, EventArgs e)
        {
            string result = changepwd(Convert.ToInt32(hidnid.Value), opwd.Text, txtnew.Text);
            if (!string.IsNullOrWhiteSpace(result))
            {
                lblerror.Text = result;
            }
            else
            {
                lblerror.Text = "Successfully updated Password";
                lblerror.ForeColor = System.Drawing.Color.Green;
            }

        }

        patientreg GetPatient(int id)
        {
            return db.patientregs.FirstOrDefault(f => f.pid == id);
        }
        string updateProfile(int pid,string name,string mob,decimal pin,string addr,string gndr)
        {
            int id = pid;
            patientreg p = GetPatient (id);
            if (p == null) return "Profile unavailable";
            p.name = name;
            p.mob = Convert.ToDecimal(mob.Replace("-", ""));
            p.pincode = pin;
            p.address = addr;
            p.gender = gndr;
            int n = db.SaveChanges();
            if (n == 0) return "Error unable to save profile changes";
            return "";
        }
        string changepwd(int pid, string oldpwd, string newpwd)
        {
            int id = pid;
            patientreg p = GetPatient(id);
            if (p == null) return "Profile unavailable";
            if (p.password != oldpwd) return "Wrong Password.. ";
            p.password = newpwd;
            int n = db.SaveChanges();
            if(n==0) return "Error unable to change password";
            return "";
        }

        
    }
    
}