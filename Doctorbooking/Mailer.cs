using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;

namespace Doctorbooking
{
    public class Mailer
    {
        public static string SendMail(string to, string subject, string msg)
        {
            try
            {
                SmtpClient mcl = new SmtpClient("smtp.gmail.com", 587);
                mcl.EnableSsl = true;
                mcl.Credentials = new NetworkCredential("libithalouis1@gmail.com", "libitha123");

                mcl.Send("libithalouis1@gmail.com", to, subject, msg);
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
            return "success";
        }
    }
}