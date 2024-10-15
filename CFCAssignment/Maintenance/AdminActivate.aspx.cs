using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CFCAssignment.Maintenance
{
    public partial class AdminActivate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnCheckUserId_Click(object sender, EventArgs e)
        {
            string userId = txtUserId.Text.Trim();
            string connectionString = ConfigurationManager.ConnectionStrings["CFC"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                // Check if the user exists
                string checkUserQuery = "SELECT Status FROM UserDetail WHERE UserId = @UserId";
                SqlCommand cmd = new SqlCommand(checkUserQuery, con);
                cmd.Parameters.AddWithValue("@UserId", userId);

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    bool isActive = Convert.ToBoolean(reader["Status"]);

                    if (isActive)
                    {
                        lblMessage.Text = "This user account is already active.";
                    }
                    else
                    {
                        // Activate the account and reset the password using the Membership API
                        ActivateAccountAndResetPassword(userId);
                    }
                }
                else
                {
                    lblMessage.Text = "User ID does not exist.";
                }

                con.Close();
            }
        }

        private void ActivateAccountAndResetPassword(string userId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["CFC"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                // Use Membership API to reset password
                MembershipUser user = Membership.GetUser(userId);
                if (user != null)
                {
                    try
                    {
                        // Reset the user's password
                        string resetPassword = user.ResetPassword();
                        string newPassword = GenerateRandomPassword();

                        // Set the new password
                        user.ChangePassword(resetPassword, newPassword);

                        // Update the user status in your custom UserDetail table
                        string updateUserQuery = "UPDATE UserDetail SET Status = 1, FailedLoginAttempts = 0 WHERE UserId = @UserId";
                        SqlCommand updateCmd = new SqlCommand(updateUserQuery, con);
                        updateCmd.Parameters.AddWithValue("@UserId", userId);
                        updateCmd.ExecuteNonQuery();

                        // Show the new password and activation success message
                        lblNewPassword.Text = newPassword;
                        UserIdPanel.Visible = false;
                        PasswordResetPanel.Visible = true;
                    }
                    catch (MembershipPasswordException ex)
                    {
                        lblMessage.Text = "Error resetting the password. " + ex.Message;
                    }
                }
                else
                {
                    lblMessage.Text = "User does not exist in the membership system.";
                }

                con.Close();
            }
        }


        protected void Logout_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();


            Response.Redirect("~/Login.aspx");
        }

        protected void btnGoToHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }
        private string GenerateRandomPassword()
        {
            const int passwordLength = 8;
            const string upperChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            const string lowerChars = "abcdefghijklmnopqrstuvwxyz";
            const string numberChars = "0123456789";
            const string specialChars = "@$!%*?&";

            Random random = new Random();

            char[] password = new char[passwordLength];

            // Ensure at least one uppercase letter
            password[0] = upperChars[random.Next(upperChars.Length)];

            // Ensure at least one number
            password[1] = numberChars[random.Next(numberChars.Length)];

            // Ensure at least one special character
            password[2] = specialChars[random.Next(specialChars.Length)];

            // Fill the rest of the password with random characters from all character sets
            string allChars = upperChars + lowerChars + numberChars + specialChars;
            for (int i = 3; i < passwordLength; i++)
            {
                password[i] = allChars[random.Next(allChars.Length)];
            }

            // Shuffle the characters to ensure randomness
            return new string(password.OrderBy(c => random.Next()).ToArray());
        }
    }
}
