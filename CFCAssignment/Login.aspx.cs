using Antlr.Runtime;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Runtime.Serialization;
using System.Text;
using System.Net;
using System.Runtime.Serialization;
using System.IO;

namespace CFCAssignment
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Ensure the account locked message is hidden on initial load
            AccountLockedPanel.Visible = false;
        }

        private void ShowAccountFrozenMessage()
        {
            // Hide the login form and show the account frozen message
            Login1.Visible = false;
            AccountLockedPanel.Visible = true;
            lblErrorMessage.Text = "Your account is frozen. Please activate it.";
        }
        private bool ValidateReCaptcha(string reCaptchaResponse)
        {
            var secretKey = ConfigurationManager.AppSettings["ReCaptchaSecretKey"];
            var client = new System.Net.WebClient();
            var result = client.DownloadString($"https://www.google.com/recaptcha/api/siteverify?secret={secretKey}&response={reCaptchaResponse}");
            var obj = Newtonsoft.Json.Linq.JObject.Parse(result);
            return (bool)obj["success"];
        }

        protected void LoginButton_Click1(object sender, EventArgs e)
        {

            string reCaptchaResponse = Request.Form["g-recaptcha-response"];
            bool isReCaptchaValid = ValidateReCaptcha(reCaptchaResponse);

            if (!isReCaptchaValid)
            {
                return; // Stop further execution if reCAPTCHA is not valid
            }
            

            
            string username = Login1.UserName;
            string password = Login1.Password;
            
            string connectionString = ConfigurationManager.ConnectionStrings["CFC"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                // Check the account's status and failed login attempts
                string checkStatusQuery = "SELECT Status, FailedLoginAttempts FROM UserDetail WHERE UserId = @UserId";
                SqlCommand checkStatusCmd = new SqlCommand(checkStatusQuery, con);
                checkStatusCmd.Parameters.AddWithValue("@UserId", username);

                SqlDataReader reader = checkStatusCmd.ExecuteReader();
                if (reader.Read())
                {
                    bool isActive = Convert.ToBoolean(reader["Status"]);
                    int failedAttempts = Convert.ToInt32(reader["FailedLoginAttempts"]);

                    // If the account is locked/inactive, show the account frozen message
                    if (!isActive)
                    {
                     
                        ShowAccountFrozenMessage();
                        return ; // Stop further execution
                    }

                    // Close reader for further queries
                    reader.Close();

                    // Validate the user login using Membership (or custom logic)
                    if (Membership.ValidateUser(username, password))
                    {
                        // Reset failed login attempts on successful login
                        string resetAttemptsQuery = "UPDATE UserDetail SET FailedLoginAttempts = 0 WHERE UserId = @UserId";
                        SqlCommand resetAttemptsCmd = new SqlCommand(resetAttemptsQuery, con);
                        resetAttemptsCmd.Parameters.AddWithValue("@UserId", username);
                        resetAttemptsCmd.ExecuteNonQuery();

                        // Redirect to the specified page on successful login
                        FormsAuthentication.SetAuthCookie(username, false);
                        Response.Redirect("~/MyAccount/MyAccount.aspx");
                    }
                    else
                    {
                        // Increment failed login attempts
                        failedAttempts++;
                        string updateAttemptsQuery = "UPDATE UserDetail SET FailedLoginAttempts = @FailedLoginAttempts WHERE UserId = @UserId";
                        SqlCommand updateAttemptsCmd = new SqlCommand(updateAttemptsQuery, con);
                        updateAttemptsCmd.Parameters.AddWithValue("@FailedLoginAttempts", failedAttempts);
                        updateAttemptsCmd.Parameters.AddWithValue("@UserId", username);
                        updateAttemptsCmd.ExecuteNonQuery();

                        // Lock the account if 5 failed attempts have been reached
                        if (failedAttempts >= 5)
                        {
                            string lockAccountQuery = "UPDATE UserDetail SET Status = 0 WHERE UserId = @UserId";
                            SqlCommand lockAccountCmd = new SqlCommand(lockAccountQuery, con);
                            lockAccountCmd.Parameters.AddWithValue("@UserId", username);
                            lockAccountCmd.ExecuteNonQuery();

                            // Show the account frozen message
                            ShowAccountFrozenMessage();
                        }
                        else
                        {
                            // Show the remaining attempts and error message
                            lblErrorMessage.Text = $"Invalid login attempt. {5 - failedAttempts} attempt(s) remaining.";
                        }
                    }
                }
                else
                {
                    // User does not exist
                    lblErrorMessage.Text = "User does not exist.";
                }

                con.Close();
            }
        }
    }
}