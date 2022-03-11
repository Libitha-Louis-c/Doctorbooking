using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Net;


namespace Doctorbooking
{
    public partial class drreg : System.Web.UI.Page
    {
        SqlConnection cn = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|datadirectory|\bookingdb.mdf;Integrated Security = True; MultipleActiveResultSets=True;Application Name = EntityFramework");
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["role"]==null || Session["role"].ToString() != "admin")
            {
                Response.Write("Requires an administration login");
                Server.Transfer("default.aspx");
                return;
            }
            if(!IsPostBack)
            {
                fillspec();
            }
           // drimage.ImageUrl = "~/images/Drimage/1.png";
        }
        void fillspec()
        {
            SqlCommand cmd = new SqlCommand("select * from spectab ", cn);
            cn.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            drpspec1.DataTextField = "specname";
            drpspec1.DataValueField = "id";
            drpspec1.DataSource = dr;
            drpspec1.DataBind();
        }

        protected void drRegButton_Click(object sender, EventArgs e)
        {
            try
            {
                int[] i_sel = drpspec1.GetSelectedIndices();
                string s = "";

                foreach (int i in i_sel)
                    s += drpspec1.Items[i].Value;
                string[] s1 = i_sel.Select(i => drpspec1.Items[i].Value).ToArray();//lamdda expression
                Response.Write(string.Join(",", s1));

                bookingdbEntities1 db = new bookingdbEntities1();
                doctor d = db.doctors.FirstOrDefault(f => f.email == email.Value.Trim());

                if (d != null)
                {
                    lblmsg.InnerText = "Doctor with this email is already registered...!";
                    lblmsg.Style["color"] = "red";
                    return;
                }
                string pwd = Guid.NewGuid().ToString().Substring(0, 4);

                doctor added1 = db.doctors.Add(new doctor { docname = name.Value, email = email.Value, hosploc = hosp.Value, mob = Convert.ToDecimal(phone.Value.Replace("-", "")), pwd = pwd });
                int[] selval = i_sel.Select(k => Convert.ToInt32(drpspec1.Items[k].Value)).ToArray();
                foreach (int i in selval)
                    added1.drspecialisations.Add(new drspecialisation { spid = i });
                //db.doctors.Add(added1);

                int n = db.SaveChanges();
                try
                {
                    if (n < 0)
                    {
                        lblmsg.InnerText = "Registration failed.please try again later";
                    }
                    else
                    {
                        int nid = added1.docId;
                        if(FileUpload1.HasFile)
                        {

                            string path = Server.MapPath("images") + "\\Drimage\\" + nid.ToString() + ".png";
                            //lblmsg.InnerText=path;
                            //return;
                            FileUpload1.PostedFile.SaveAs(path);
                        }
                        //send pwd to registerd email
                        SmtpClient mcl = new SmtpClient("smtp.gmail.com", 587);
                        mcl.EnableSsl = true;
                        mcl.Credentials = new NetworkCredential("libithalouis1@gmail.com", "libitha123");
                        string msg = $"dear doctor,\nThank you for registering with doctor booking system.\nYour login password is {pwd}  \nThank you\nAdministrator,\nDoctor booking system.";

                        mcl.Send("libithalouis1@gmail.com", added1.email, "confirmed doctor registration", msg);
                    }
                }
                catch(Exception ex)
                {
                    lblmsg.InnerText = "Unable to continue... " + ex.Message;
                }
                


                //Func<int, int, int> test = ( a, b) => { return a+b; };
                //Action dowelcome = () => { Response.Write("Welcome to my web.."); };
                //dowelcome();
                //Predicate<int> check = (a) => { return a>10; };
                //check(5);
                //check(12);

                Response.Redirect("drreg.aspx", true);
            }
            catch(Exception ex)
            {
                lblmsg.InnerText = "Error occurerd...please try at later "+ex.Message;
            }
        }
    }
}