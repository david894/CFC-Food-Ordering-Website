using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CFCAssignment
{
    public partial class ErrorPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Optionally display the error message passed via query string
            if (Request.QueryString["errorMsg"] != null)
            {
                lblErrorMessage.Text = Server.HtmlEncode(Request.QueryString["errorMsg"]);
            }

            if (Application["exception"] != null)
            {
                Exception ex = (Exception)Application["exception"];
                string fileUrl = (string)Application["location"];

                // Display detailed error message
                lblErrorMessage.Text = ex.Message;
                lblErrorFile.Text = "Error occurred at: " + fileUrl;
                lblErrorRoot.Text = "Error Root : " + ex.StackTrace;
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (details.Visible == false)
            {
                details.Visible = true;
            }
            else { 
                details.Visible = false;
            }
        }
    }
}