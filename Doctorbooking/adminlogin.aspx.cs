using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Doctorbooking
{
    public partial class adminlogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void loginButton_Click(object sender, EventArgs e)
        {
            //if(txtusr.Text=="admin@mysite.com" && txtpwd.Text=="123")
            //{
            //    System.Web.Security.FormsAuthentication.RedirectFromLoginPage(txtusr.Text, false);
            //}

            bookingdbEntities1 db = new bookingdbEntities1();
            usertab d = db.usertabs.FirstOrDefault(f => f.email == txtusr.Text && f.pwd == txtpwd.Text);
            if (d == null)
            {
                lblmsg.InnerText = "Error occurred.please try again later";
                return;
            }
            Session["role"] = "admin";
            System.Web.Security.FormsAuthentication.RedirectFromLoginPage(txtusr.Text, false);
        }
    }
}