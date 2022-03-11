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
           
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("patientdetail.aspx");
        }
    }
    
}