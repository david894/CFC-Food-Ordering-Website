using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Configuration;
using System.Web.UI.WebControls;

namespace CFCAssignment
{
    public partial class CreateUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void CreateUserWizard1_CreatingUser(object sender, LoginCancelEventArgs e)
        {
            TextBox UserName = (TextBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("UserName");
            TextBox Password = (TextBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("Password");
            TextBox Email = (TextBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("Email");
            TextBox FirstName = (TextBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("FirstName");
            TextBox LastName = (TextBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("LastName");
            TextBox MobileNumber = (TextBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("MobileNumber");
            TextBox ConfirmPassword = (TextBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("ConfirmPassword");
            TextBox DateOfBirth = (TextBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("DateOfBirth");
            CheckBox NewsCheckbox = (CheckBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("NewsCheckbox");
            CheckBox TermsCheckbox = (CheckBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("TermsCheckbox");

            bool isValid = true;

            // Check for empty fields and set error messages
            isValid &= ValidateField(UserName, "User ID is required.");
            isValid &= ValidateField(Password, "*Password must be a minimum of 8 characters with at least 1 uppercase, 1 special character and 1 number.");
            isValid &= ValidateField(Email, "E-mail is required.");
            isValid &= ValidateField(FirstName, "*Enter your name.");
            isValid &= ValidateField(MobileNumber, "Mobile Number is required.");
            isValid &= ValidateField(ConfirmPassword, "*Password must be a minimum of 8 characters with at least 1 uppercase, 1 special character and 1 number.");
            isValid &= ValidateField(DateOfBirth, "Date of Birth is required.");

            if (!IsValidDateFormat(DateOfBirth.Text))
            {
                SetErrorMessage(DateOfBirth, "Date of Birth must be in the format dd-mm-yyyy.");
                isValid = false;
            }

            // Password validation: 8 characters, at least 1 uppercase, 1 special character, and 1 number
            if (!IsValidPassword(Password.Text))
            {
                SetErrorMessage(Password, "*Password must be at least 8 characters long, contain at least one uppercase letter, one number, and one special character.");
                isValid = false;
            }

            // Check if passwords match
            if (Password.Text != ConfirmPassword.Text)
            {
                SetErrorMessage(ConfirmPassword, "Passwords do not match.");
                isValid = false;
            }

            // Check if username is unique
            if (Membership.GetUser(UserName.Text) != null)
            {
                SetErrorMessage(UserName, "User ID already exists. Please choose another one.");
                isValid = false;
            }

            // Check if terms checkbox is accepted
            if (!TermsCheckbox.Checked)
            {
                SetErrorMessage(TermsCheckbox, "You must accept the Terms and Conditions.");
                isValid = false;
            }

            if (isValid)
            {
                // Insert data into UserDetail table
                string connectionString = ConfigurationManager.ConnectionStrings["CFC"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "INSERT INTO UserDetail (UserId, FirstName, LastName, MobileNumber, Email, DateOfBirth, PromotionNews, TermsAndCondition) " +
                                   "VALUES (@UserId, @FirstName, @LastName, @MobileNumber, @Email, @DateOfBirth, @PromotionNews, @TermsAndCondition)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserId", UserName.Text);
                        cmd.Parameters.AddWithValue("@FirstName", FirstName.Text);
                        cmd.Parameters.AddWithValue("@LastName", LastName.Text);
                        cmd.Parameters.AddWithValue("@MobileNumber", MobileNumber.Text);
                        cmd.Parameters.AddWithValue("@Email", Email.Text);
                        cmd.Parameters.AddWithValue("@DateOfBirth", DateOfBirth.Text);
                        cmd.Parameters.AddWithValue("@PromotionNews", NewsCheckbox.Checked ? "Yes" : "No");
                        cmd.Parameters.AddWithValue("@TermsAndCondition", TermsCheckbox.Checked ? "Yes" : "No");

                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
            }

            e.Cancel = !isValid;
        }

        // New date format validation method
        private bool IsValidDateFormat(string dateInput)
        {
            DateTime parsedDate;
            return DateTime.TryParseExact(dateInput, "dd-MM-yyyy", null, System.Globalization.DateTimeStyles.None, out parsedDate);
        }

        private bool IsValidPassword(string password)
        {
            // Regular expression to validate the password (min 8 chars, 1 uppercase, 1 number, 1 special character)
            string pattern = @"^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$";
            return System.Text.RegularExpressions.Regex.IsMatch(password, pattern);
        }
        private bool ValidateField(TextBox textBox, string errorMessage)
        {
            if (string.IsNullOrWhiteSpace(textBox.Text))
            {
                SetErrorMessage(textBox, errorMessage);
                return false;
            }
            return true;
        }

        private void SetErrorMessage(Control control, string errorMessage)
        {
            Label errorLabel = new Label();
            errorLabel.CssClass = "error-message";
            errorLabel.Text = errorMessage;

            // Find the parent control and insert the error label immediately after the control
            int controlIndex = control.Parent.Controls.IndexOf(control);
            control.Parent.Controls.AddAt(controlIndex + 1, errorLabel);
        }
    }
}