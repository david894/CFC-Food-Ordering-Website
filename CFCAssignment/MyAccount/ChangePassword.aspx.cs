using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CFCAssignment.MyAccount
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Roles.IsUserInRole("Admin"))
            {
                lblpage.Text = "Admin Page";
                adminNav.Visible = true;
                PDmenu.Style.Add("height", "400px");
                return;
            }
            else
            {
                lblpage.Text = "User Page";
                userNav.Visible = true;
                return;

            }

        }
        protected void Logout_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();


            Response.Redirect("~/Login.aspx");
        }
        protected void ChangePassword1_ChangingPassword(object sender, LoginCancelEventArgs e)
        {
            // Get the current user's name
            string username = User.Identity.Name;


            // Validate the current password
            if (!Membership.ValidateUser(username, ChangePassword1.CurrentPassword))
            {
                // If the current password is incorrect, cancel the password change
                e.Cancel = true;

                // Display an error message
                ChangePassword1.ChangePasswordFailureText = "The current password is incorrect. Please try again.";
                lblError.Text = "The current password is incorrect. Please try again.";
            }
            else if (ChangePassword1.NewPassword != ChangePassword1.ConfirmNewPassword)
            {
                // If the passwords do not match, cancel the password change
                e.Cancel = true;

                // Display an error message
                ChangePassword1.ChangePasswordFailureText = "The new password and confirmation password do not match. Please try again.";
                lblError.Text = "The new password and confirmation password do not match. Please try again.";
            }
            else if (ChangePassword1.NewPassword.Length < 8)
            {
                // If the passwords do not match, cancel the password change
                e.Cancel = true;

                // Display an error message
                ChangePassword1.ChangePasswordFailureText = "The new password must not less than 8 character.";
                lblError.Text = "The new password must not less than 8 character.";
            }
            else if (!IsValidPasswordFormat(ChangePassword1.NewPassword))
            {
                // If the password does not meet format requirements, cancel the password change
                e.Cancel = true;

                // Display an error message
                ChangePassword1.ChangePasswordFailureText = "The new password must contain at least one uppercase letter, one lowercase letter, one number, and one special character.";
                lblError.Text = "The new password must contain at least one uppercase letter, one lowercase letter, one number, and one special character.";
            }
            else
            {
                lblError.Text = "";
            }

        }

        private bool IsValidPasswordFormat(string password)
        {
            bool hasUpperChar = password.Any(char.IsUpper);
            bool hasLowerChar = password.Any(char.IsLower);
            bool hasDigit = password.Any(char.IsDigit);
            bool hasSpecialChar = password.Any(ch => !char.IsLetterOrDigit(ch)); // Checks for special characters

            // Password is valid if it contains at least one of each type of character
            return hasUpperChar && hasLowerChar && hasDigit && hasSpecialChar;
        }
    }
}