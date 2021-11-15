using System;
using System.Collections.Generic;
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
                lblSessionValue.Text = $"Session Value is \"{sessionData}\"";
            }
            else
            {
                lblSessionValue.Text = "There is no data saved to Session";
            }
    
        }
    }
}