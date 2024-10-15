using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CFCAssignment.MyAccount
{
    public partial class SetSecurityInfo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        { 
             if (!IsPostBack)
            {
                LoadExistingSecurityInfo(); // Load the security questions only on the first load
            }
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

        private void LoadExistingSecurityInfo()
        {
            string userId = GetUserId();
            if (string.IsNullOrEmpty(userId))
            {
                return; // Exit if the user is not logged in or userId is not set
            }

            // SQL query to get the current security questions and answers
            string query = "SELECT SecurityQuestion1, SecurityAnswer1, SecurityQuestion2, SecurityAnswer2, SecurityQuestion3, SecurityAnswer3 " +
                           "FROM UserDetail WHERE UserId = @UserId";

            string connectionString = ConfigurationManager.ConnectionStrings["CFC"].ConnectionString;

            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        con.Open();

                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            // Populate the dropdowns and textboxes with the user's existing security info
                            ddlSecurityQuestion1.SelectedValue = reader["SecurityQuestion1"].ToString();
                            txtAnswer1.Text = reader["SecurityAnswer1"].ToString();
                            ddlSecurityQuestion2.SelectedValue = reader["SecurityQuestion2"].ToString();
                            txtAnswer2.Text = reader["SecurityAnswer2"].ToString();
                            ddlSecurityQuestion3.SelectedValue = reader["SecurityQuestion3"].ToString();
                            txtAnswer3.Text = reader["SecurityAnswer3"].ToString();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "An error occurred while loading your security information: " + ex.Message;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            // Get the selected security questions and answers
            string question1 = ddlSecurityQuestion1.SelectedValue;
            string answer1 = txtAnswer1.Text.Trim();
            string question2 = ddlSecurityQuestion2.SelectedValue;
            string answer2 = txtAnswer2.Text.Trim();
            string question3 = ddlSecurityQuestion3.SelectedValue;
            string answer3 = txtAnswer3.Text.Trim();

            // Validate that no two questions are the same
            if (question1 == question2 || question1 == question3 || question2 == question3)
            {
                lblError.Text = "Please choose three different security questions.";
                return;
            }
            // Validate that none of the answers are empty
            if (string.IsNullOrEmpty(answer1) || string.IsNullOrEmpty(answer2) || string.IsNullOrEmpty(answer3))
            {
                lblError.Text = "All security answers must be provided. Please fill in all answers.";
                return; // Prevent form submission if any answer is empty
            }

            string userId = GetUserId();
            if (string.IsNullOrEmpty(userId))
            {
                lblError.Text = "Error: User is not logged in or session expired.";
                return;
            }

            UpdateSecurityInfo(userId, question1, answer1, question2, answer2, question3, answer3);
        }

        private string GetUserId()
        {
             string username = User.Identity.Name;
             return username;
        }

        private void UpdateSecurityInfo(string userId, string question1, string answer1, string question2, string answer2, string question3, string answer3)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["CFC"].ConnectionString;
            string query = "UPDATE UserDetail " +
                           "SET SecurityQuestion1 = @Question1, SecurityAnswer1 = @Answer1, " +
                           "    SecurityQuestion2 = @Question2, SecurityAnswer2 = @Answer2, " +
                           "    SecurityQuestion3 = @Question3, SecurityAnswer3 = @Answer3 " +
                           "WHERE UserId = @UserId";

            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        cmd.Parameters.AddWithValue("@Question1", question1);
                        cmd.Parameters.AddWithValue("@Answer1", answer1);
                        cmd.Parameters.AddWithValue("@Question2", question2);
                        cmd.Parameters.AddWithValue("@Answer2", answer2);
                        cmd.Parameters.AddWithValue("@Question3", question3);
                        cmd.Parameters.AddWithValue("@Answer3", answer3);

                        con.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            // Show success message by making SuccessPanel visible
                            SetSecurityPanel.Visible = false;
                            lblError.Text = "";
                            SuccessPanel.Visible = true; // Make the success panel visible here
                        }
                        else
                        {
                            lblError.Text = "An error occurred while updating your security information. Please try again.";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "An error occurred: " + ex.Message;
            }
        }


        protected void btnCancel_Click(object sender, EventArgs e)
        {
          
        }

        protected void Logout_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Response.Redirect("~/Login.aspx");
        }
    }
}