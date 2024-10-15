using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CFCAssignment.Maintenance
{
    public partial class AdminAssign : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnGetUser_Click(object sender, EventArgs e)
        {
            ddlUser.DataSource = Membership.GetAllUsers();
            ddlUser.DataBind();
        }

        protected void btnCreateRole_Click(object sender, EventArgs e)
        {
            Roles.CreateRole(txtCreateRole.Text);

        }

        protected void btnRole_Click(object sender, EventArgs e)
        {
            ddlRole.DataSource = Roles.GetAllRoles();
            ddlRole.DataBind();
        }

        protected void btnAssign_Click(object sender, EventArgs e)
        {
            Roles.AddUserToRole(ddlUser.SelectedValue, ddlRole.SelectedValue);
        }

        protected void btnVerify_Click(object sender, EventArgs e)
        {
            LstUsers.DataSource = Roles.GetUsersInRole(ddlRole.SelectedValue);
            LstUsers.DataBind();
        }
    }
}