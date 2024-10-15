using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CFCAssignment
{
    public partial class ActivateAccount : System.Web.UI.Page
    {
        private static int attemptCounter = 0; // Track the number of failed attempts

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                attemptCounter = 0; // Reset the attempt counter on page load
            }
        }

        protected void btnCheckUserId_Click(object sender, EventArgs e)
        {
            string userId = txtUserId.Text.Trim();
            string connectionString = ConfigurationManager.ConnectionStrings["CFC"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                // Check if the user exists and retrieve account status and security questions
                string checkUserQuery = "SELECT Status, SecurityQuestion1, SecurityAnswer1, SecurityQuestion2, SecurityAnswer2, SecurityQuestion3, SecurityAnswer3 FROM UserDetail WHERE UserId = @UserId";
                SqlCommand cmd = new SqlCommand(checkUserQuery, con);
                cmd.Parameters.AddWithValue("@UserId", userId);

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    bool isActive = Convert.ToBoolean(reader["Status"]);
                    string question1 = reader["SecurityQuestion1"].ToString();
                    string question2 = reader["SecurityQuestion2"].ToString();
                    string question3 = reader["SecurityQuestion3"].ToString();

                    if (isActive)
                    {
                        lblMessage.Text = "This user account is already active.";
                    }
                    else if (string.IsNullOrEmpty(question1) && string.IsNullOrEmpty(question2) && string.IsNullOrEmpty(question3))
                    {
                        lblMessage.Text = "";
                        SecurityQuestionPanel.Visible = false;
                        UserIdPanel.Visible = false;
                        CustomerServicePanel.Visible = true; // Show the customer service panel
                    }
                    else
                    {
                        // Populate security questions in the dropdown list
                        ddlSecurityQuestions.Items.Clear();
                        if (!string.IsNullOrEmpty(question1)) ddlSecurityQuestions.Items.Add(question1);
                        if (!string.IsNullOrEmpty(question2)) ddlSecurityQuestions.Items.Add(question2);
                        if (!string.IsNullOrEmpty(question3)) ddlSecurityQuestions.Items.Add(question3);

                        // Show the security question panel and hide the UserId panel
                        SecurityQuestionPanel.Visible = true;
                        UserIdPanel.Visible = false;
                    }
                }
                else
                {
                    lblMessage.Text = "User ID does not exist.";
                }

                con.Close();
            }
        }

        protected void btnSubmitAnswer_Click(object sender, EventArgs e)
        {
            string userId = txtUserId.Text.Trim();
            string selectedQuestion = ddlSecurityQuestions.SelectedValue;
            string userAnswer = txtAnswer.Text.Trim();
            string connectionString = ConfigurationManager.ConnectionStrings["CFC"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                // Retrieve the security answers to validate against the selected question
                string checkSecurityQuery = "SELECT SecurityQuestion1, SecurityAnswer1, SecurityQuestion2, SecurityAnswer2, SecurityQuestion3, SecurityAnswer3 FROM UserDetail WHERE UserId = @UserId";
                SqlCommand cmd = new SqlCommand(checkSecurityQuery, con);
                cmd.Parameters.AddWithValue("@UserId", userId);

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    bool isAnswerCorrect = false;
                    if (selectedQuestion == reader["SecurityQuestion1"].ToString() && userAnswer == reader["SecurityAnswer1"].ToString())
                    {
                        isAnswerCorrect = true;
                    }
                    else if (selectedQuestion == reader["SecurityQuestion2"].ToString() && userAnswer == reader["SecurityAnswer2"].ToString())
                    {
                        isAnswerCorrect = true;
                    }
                    else if (selectedQuestion == reader["SecurityQuestion3"].ToString() && userAnswer == reader["SecurityAnswer3"].ToString())
                    {
                        isAnswerCorrect = true;
                    }

                    if (isAnswerCorrect)
                    {
                        // Use Membership API to reset password
                        MembershipUser user = Membership.GetUser(userId);
                        if (user != null)
                        {
                            try
                            {
                                // Reset the user's password
                                string resetPassword = user.ResetPassword(); // ResetPassword requires no parameters if not using a password question
                                string newPassword = GenerateRandomPassword();
                                // Set the new password
                                user.ChangePassword(resetPassword, newPassword);

                                // Update the user status in your custom UserDetail table (optional)
                                string updateUserQuery = "UPDATE UserDetail SET Status = 1, FailedLoginAttempts = 0 WHERE UserId = @UserId";
                                SqlCommand updateCmd = new SqlCommand(updateUserQuery, con);
                                updateCmd.Parameters.AddWithValue("@UserId", userId);
                                reader.Close(); // Close reader before executing the next command
                                updateCmd.ExecuteNonQuery();

                                // Show the new password and activation success message
                                lblNewPassword.Text = newPassword;
                                SecurityQuestionPanel.Visible = false;
                                PasswordResetPanel.Visible = true;
                            }
                            catch (MembershipPasswordException ex)
                            {
                                lblErrorMessage.Text = "Error resetting the password. " + ex.Message;
                            }
                        }
                        else
                        {
                            lblErrorMessage.Text = "User does not exist in the membership system.";
                        }
                    }
                    else
                    {
                        attemptCounter++;

                        if (attemptCounter >= 3)
                        {
                            // Reset security questions and answers to NULL after 3 failed attempts
                            string resetSecurityQuery = "UPDATE UserDetail SET SecurityQuestion1 = NULL, SecurityAnswer1 = NULL, SecurityQuestion2 = NULL, SecurityAnswer2 = NULL, SecurityQuestion3 = NULL, SecurityAnswer3 = NULL WHERE UserId = @UserId";
                            SqlCommand resetCmd = new SqlCommand(resetSecurityQuery, con);
                            resetCmd.Parameters.AddWithValue("@UserId", userId);
                            reader.Close(); // Close reader before executing the next command
                            resetCmd.ExecuteNonQuery();

                            // Show the customer service panel
                            lblErrorMessage.Text = "";
                            SecurityQuestionPanel.Visible = false;
                            CustomerServicePanel.Visible = true;
                        }
                        else
                        {
                            lblErrorMessage.Text = $"Incorrect answer. {3 - attemptCounter} attempts remaining.";
                        }
                    }
                }
                else
                {
                    lblErrorMessage.Text = "User ID does not exist.";
                }

                con.Close();
            }
        }

        protected void btnGoToLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
        protected void btnCustomerServiceOk_Click(object sender, EventArgs e)
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