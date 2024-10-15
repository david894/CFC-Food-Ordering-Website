using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CFCAssignment.Maintenance
{
    public partial class AdminOrder : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DropDownList1.SelectedValue = "Card";
                getOrder();
            }
        }
        protected void GridViewOrders_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Get the selected Order ID from the GridView
            string selectedOrderId = GridViewOrders.SelectedDataKey.Value.ToString();

            // Redirect to ManageOrderDetails page with the selected Order ID as a query string
            Response.Redirect($"AdminOrderDetails.aspx?OrderId={selectedOrderId}");
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            getOrder();
        }
        private void getOrder()
        {
            //estabilsh the connection
            SqlConnection con;
            string strCon = ConfigurationManager.ConnectionStrings["CFC"].ConnectionString;

            con = new SqlConnection(strCon);
            con.Open();
            if (DropDownList1.SelectedValue == "Cash")
            {
                string strRetrieve = @"
                    SELECT o.OrderId, o.OrderDate, o.Total, p.PaymentCard, p.PaymentType
                    FROM Orders o
                    INNER JOIN Payment p ON o.OrderId = p.OrderId
                    WHERE p.PaymentType = @card 
                    ORDER BY o.OrderDate DESC; ";
                SqlCommand cmdRetrieve = new SqlCommand(strRetrieve, con);
                cmdRetrieve.Parameters.AddWithValue("@card", "Cash");

                SqlDataReader drProducts = cmdRetrieve.ExecuteReader();

                // Bind the retrieved data to a GridView
                GridViewOrders.DataSource = drProducts;
                GridViewOrders.DataBind();

                drProducts.Close();

            } else if (DropDownList1.SelectedValue == "PayPal") {
                string strRetrieve = @"
                    SELECT o.OrderId, o.OrderDate, o.Total, p.PaymentCard, p.PaymentType
                    FROM Orders o
                    INNER JOIN Payment p ON o.OrderId = p.OrderId
                    WHERE p.PaymentType = @card 
                    ORDER BY o.OrderDate DESC; ";
                SqlCommand cmdRetrieve = new SqlCommand(strRetrieve, con);
                cmdRetrieve.Parameters.AddWithValue("@card", "PayPal");

                SqlDataReader drProducts = cmdRetrieve.ExecuteReader();

                // Bind the retrieved data to a GridView
                GridViewOrders.DataSource = drProducts;
                GridViewOrders.DataBind();

                drProducts.Close();
            }
            else
            {
                string strRetrieve = @"
                    SELECT o.OrderId, o.OrderDate, o.Total, p.PaymentCard, p.PaymentType
                    FROM Orders o
                    INNER JOIN Payment p ON o.OrderId = p.OrderId
                    WHERE p.PaymentCard != @card 
                    ORDER BY o.OrderDate DESC; ";
                SqlCommand cmdRetrieve = new SqlCommand(strRetrieve, con);
                cmdRetrieve.Parameters.AddWithValue("@card", "0000");

                SqlDataReader drProducts = cmdRetrieve.ExecuteReader();

                // Bind the retrieved data to a GridView
                GridViewOrders.DataSource = drProducts;
                GridViewOrders.DataBind();

                drProducts.Close();
            }
            con.Close();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (calEndDate.SelectedDate < calStartDate.SelectedDate)
            {
                lblDateError.Text = "End Date Must Greater Than Start Date";
                calEndDate.SelectedDate = DateTime.MinValue;
                return;
            }
            DateTime? startDate = null;
            DateTime? endDate = null;

            if (DateTime.TryParse(txtStartDate.Text, out DateTime start))
            {
                startDate = start;
            }

            if (DateTime.TryParse(txtEndDate.Text, out DateTime end))
            {
                endDate = end;
            }

            LoadOrders(startDate, endDate);
        }
        private void LoadOrders(DateTime? startDate, DateTime? endDate)
        {
            string strCon = ConfigurationManager.ConnectionStrings["CFC"].ConnectionString;
            if (endDate.HasValue)
            {
                // Set the endDate to the end of the day (23:59:59.999)
                endDate = endDate.Value.Date.AddDays(1).AddTicks(-1);
            }
            using (SqlConnection con = new SqlConnection(strCon))
            {
                if (DropDownList1.SelectedValue == "Cash")
                {
                    string query = "SELECT o.OrderId, o.OrderDate, o.Total, p.PaymentCard, p.PaymentType " +
                                   "FROM Orders o " +
                                   "INNER JOIN Payment p ON o.OrderId = p.OrderId " +
                                   "WHERE (@StartDate IS NULL OR o.OrderDate >= @StartDate) " +
                                   "AND (@EndDate IS NULL OR o.OrderDate < @EndDate) AND p.PaymentCard = @card " +
                                   "ORDER BY o.OrderDate DESC; ";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@card", "0000");
                    cmd.Parameters.AddWithValue("@StartDate", startDate.HasValue ? (object)startDate.Value : DBNull.Value);
                    cmd.Parameters.AddWithValue("@EndDate", endDate.HasValue ? (object)endDate.Value : DBNull.Value);

                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    GridViewOrders.DataSource = reader;
                    GridViewOrders.DataBind();
                    reader.Close();

                }
                else
                {
                    string query = "SELECT o.OrderId, o.OrderDate, o.Total, p.PaymentCard, p.PaymentType " +
                   "FROM Orders o " +
                   "INNER JOIN Payment p ON o.OrderId = p.OrderId " +
                   "WHERE (@StartDate IS NULL OR o.OrderDate >= @StartDate) " +
                   "AND (@EndDate IS NULL OR o.OrderDate < @EndDate) AND p.PaymentCard != @card " +
                   "ORDER BY o.OrderDate DESC; ";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@card", "0000");
                    cmd.Parameters.AddWithValue("@StartDate", startDate.HasValue ? (object)startDate.Value : DBNull.Value);
                    cmd.Parameters.AddWithValue("@EndDate", endDate.HasValue ? (object)endDate.Value : DBNull.Value);

                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    GridViewOrders.DataSource = reader;
                    GridViewOrders.DataBind();
                    reader.Close();

                }

            }
        }

        protected void btnStartCalendar_Click(object sender, EventArgs e)
        {
            calEndDate.Visible = false;
            lblDateError.Text = "";
            calStartDate.Visible = !calStartDate.Visible;
        }

        protected void btnEndCalendar_Click(object sender, EventArgs e)
        {
            calStartDate.Visible = false;

            calEndDate.Visible = !calEndDate.Visible;
        }

        protected void calStartDate_SelectionChanged(object sender, EventArgs e)
        {
            txtStartDate.Text = calStartDate.SelectedDate.ToString("dd/MM/yyyy");
            calStartDate.Visible = false;
        }

        protected void calEndDate_SelectionChanged(object sender, EventArgs e)
        {
            if (calStartDate.SelectedDate == DateTime.MinValue)
            {
                lblDateError.Text = "Please Select A Start Date Before Selecting End Date";
                calEndDate.Visible = false;
                calEndDate.SelectedDate = DateTime.MinValue;
                return;
            }
            else if (calEndDate.SelectedDate < calStartDate.SelectedDate)
            {
                lblDateError.Text = "End Date Must Greater Than Start Date";
                calEndDate.SelectedDate = DateTime.MinValue;
                return;
            }
            else
            {
                lblDateError.Text = "";
                txtEndDate.Text = calEndDate.SelectedDate.ToString("dd/MM/yyyy");
                calEndDate.Visible = false;
            }

        }
    }
}