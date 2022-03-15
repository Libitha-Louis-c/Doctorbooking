using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Doctorbooking
{
    public partial class drprofile : System.Web.UI.Page
    {
        public bookingdbEntities1 db = new bookingdbEntities1();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["role"] == null || Session["role"].ToString() != "doctor")
            {
                lblerror.Text = "You may need to Login as Doctor to access Doctor's profile..!";
                return;
            }
            if (!IsPostBack)
            {
                fillspec();
                int id = Convert.ToInt32(Session["id"]);
                hidnid.Value = id.ToString();
                drimage.ImageUrl = "/images/drimage/" + id.ToString() + ".png";
                doctor p = GetDoctor(id);
                p.drspecialisations.ToList().ForEach(f => {
                    try {
                        drpspec1.Items.FindByValue(f.spid.ToString()).Selected = true;
                    } catch { }
                });
                var specs = p.drspecialisations.Select(c => c.spectab.specname);
                if (specs.Any())
                {
                    spec.Value = string.Join(",", specs);
                }
                name.Value = p.docname;
                email.Value = p.email;
                hosp.Value = p.hosploc;
                phone.Value = p.mob.ToString();
            }
        }


        void fillspec()
        {
            drpspec1.DataTextField = "specname";
            drpspec1.DataValueField = "id";
            drpspec1.DataSource = db.spectabs.ToList();
            drpspec1.DataBind();

        }
        protected void drRegButton_Click(object sender, EventArgs e)
        {
            string result = updateProfile(Convert.ToInt32(hidnid.Value), name.Value,
                phone.Value,  hosp.Value);
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

        doctor GetDoctor(int id)
        {
            return db.doctors.FirstOrDefault(f => f.docId == id);
        }
        string updateProfile(int pid, string name, string mob,  string hloc)
        {
            int[] i_sel = drpspec1.GetSelectedIndices();
            string s = "";

            foreach (int i in i_sel)
                s += drpspec1.Items[i].Value;
            string[] s1 = i_sel.Select(i => drpspec1.Items[i].Value).ToArray();//lamdda expression

            int id = pid;
            doctor d = GetDoctor(id);
            if (d == null) return "Profile unavailable";
            d.docname = name;
            d.mob = Convert.ToDecimal(mob.Replace("-", ""));
            d.hosploc = hloc;
            int[] selval = i_sel.Select(k => Convert.ToInt32(drpspec1.Items[k].Value)).ToArray();

            var removed = d.drspecialisations.Where(c => !selval.Contains(c.Id)).ToList();
         
            if(removed.Any())
            {
                var remspecid = removed.Select(i => i.Id).ToList();
                remspecid.ForEach(f => {
                    var sp=d.drspecialisations.FirstOrDefault(sn => sn.Id == f);
                    if (sp != null)
                        d.drspecialisations.Remove(sp);
                    });

            }
            if (selval.Any() )
            {
                Func<int, drspecialisation> getspec = (sv) => { return null; };
                if (d.drspecialisations.Any())
                    getspec = (sv) =>
                  {
                      return d.drspecialisations.FirstOrDefault(sn => sn.Id == sv);
                  };
              
                selval.ToList().ForEach(sv =>
                {
                    var slvl = getspec(sv);
                    //var slvl = d.drspecialisations.Any() ? d.drspecialisations.FirstOrDefault(sn => sn.Id == sv) : null;
                    if (slvl == null)
                        d.drspecialisations.Add(new drspecialisation { spid = sv, drid = pid });
                });
            }
          

            int n = db.SaveChanges();
            if (n == 0) return "Error unable to save profile changes";
            return "";
        }
        string changepwd(int pid, string oldpwd, string newpwd)
        {
            int id = pid;
            doctor p = GetDoctor(id);
            if (p == null) return "Profile unavailable";
            if (p.pwd != oldpwd) return "Wrong Password.. ";
            p.pwd = newpwd;
            int n = db.SaveChanges();
            if (n == 0) return "Error unable to change password";
            return "";
        }

    }
}