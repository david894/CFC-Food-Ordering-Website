using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CFCAssignment.Maintenance
{
    public partial class AdminProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadUserDetails();
            }
        }
        private void LoadUserDetails()
        {
            string username = User.Identity.Name;

            if (!string.IsNullOrEmpty(username))
            {
                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["CFC"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "SELECT FirstName, LastName, Email, MobileNumber, DateOfBirth, PromotionNews, TermsAndCondition " +
                                   "FROM UserDetail WHERE UserId = @UserId";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserId", username);
                        conn.Open();

                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            FirstNameLabel.Text = reader["FirstName"].ToString();
                            LastNameLabel.Text = reader["LastName"].ToString();
                            EmailLabel.Text = reader["Email"].ToString();
                            MobileNumberLabel.Text = reader["MobileNumber"].ToString();
                            DateOfBirthLabel.Text = reader["DateOfBirth"].ToString();
                            PromotionNewsLabel.Text = reader["PromotionNews"].ToString() == "Yes" ? "Subscribed" : "Not Subscribed";
                            TermsAndConditionLabel.Text = reader["TermsAndCondition"].ToString() == "Yes" ? "Accepted" : "Not Accepted";
                        }
                    }
                }
            }
        }
    }
}