using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Doctorbooking
{
    public partial class booking : System.Web.UI.Page
    {
       public bookingdbEntities1 db = new bookingdbEntities1();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["role"] == null || Session["role"].ToString() != "patient")
            {
                Response.Write("Requires patient login");
                //Response.End();
                return;
            }

        }
    }
}