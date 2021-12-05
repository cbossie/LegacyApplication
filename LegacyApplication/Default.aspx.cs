using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LegacyApplication
{
    public partial class _Default : Page
    {
        public int OriginalServer { get; set; }


        protected void Page_PreRender(object sender, EventArgs e)
        {
            pnlAlert.Visible = ShowNotification;
        }

        protected void lblSessionState_Load(object sender, EventArgs e)
        {
            var lbl = sender as Label;

            lbl.Text = Session.Mode.ToString();

        }

        protected void lblId_Load(object sender, EventArgs e)
        {
            var lbl = sender as Label;

            lbl.Text = Session.SessionID;
        }



        protected void btnSave_Click(object sender, EventArgs e)
        {
            var data = txtSessionItem.Text;
            if(!string.IsNullOrEmpty(data))
            {
                Session["savedData"] = data;
                ShowNotification = true;
            }
        }


        public bool ShowNotification { get; private set; }

        protected void lblSessionValue_PreRender(object sender, EventArgs e)
        {
            var sessionData = Session["savedData"];

            if(sessionData != null)
            {
                lblSessionValue.Text = $"Session Value is <strong>{sessionData}</strong>.";
            }
            else
            {
                lblSessionValue.Text = "There is no data saved to Session";
            }
    
        }

        protected void btnDivideByZero_Click(object sender, EventArgs e)
        {
            var a = 4;
            var b = a / 0;
        }

        protected void btnListDirectory_Click(object sender, EventArgs e)
        {
            var fileList = System.IO.Directory.GetFiles(@"C:\Images");
            litText.Text = string.Join("<br/>", fileList);
        }

        protected void btnWriteTimestamp_Click(object sender, EventArgs e)
        {
            string timestamp = DateTime.Now.ToString();
            var data = $"Current Timestamp is {timestamp}";
            string filename = $@"C:\images\{DateTime.Now.Ticks}";
            File.WriteAllText(filename, timestamp);
        }
    }
}