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
    public partial class AdminOrderDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Retrieve the Order ID from the query string
                string orderId = Request.QueryString["OrderId"];
                if (!string.IsNullOrEmpty(orderId))
                {
                    LoadOrderDetails(orderId);
                    LoadProductDetails(orderId);
                    getSubTotal(orderId);
                }
            }
        }
        private void LoadOrderDetails(string orderId)
        {
            string strCon = ConfigurationManager.ConnectionStrings["CFC"].ConnectionString;

            using (SqlConnection con = new SqlConnection(strCon))
            {
                string query = "SELECT  o.OrderId, o.OrderDate, o.Total, p.PaymentCard, p.PaymentType " +
                               "FROM Orders o " +
                               "INNER JOIN Payment p ON o.OrderId = p.OrderId " +
                               "WHERE o.OrderId = @OrderId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@OrderId", orderId);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    lblOrderID.Text = reader["OrderId"].ToString();
                    lblOrderDate.Text = Convert.ToDateTime(reader["OrderDate"]).ToString("dd/MM/yyyy, HH:mm:ss");
                    string paymentCard = reader["PaymentCard"].ToString();
                    string paymentType = reader["PaymentType"].ToString();
                    lblPayment.Text = paymentType == "Cash" ? "Cash" : paymentType == "PayPal" ? "PayPal": paymentType + " [" + paymentCard + "]";
                    lblTotal.Text = reader["Total"].ToString();
                }

                reader.Close();
            }
        }

        private void LoadProductDetails(string orderId)
        {
            string strCon = ConfigurationManager.ConnectionStrings["CFC"].ConnectionString;

            using (SqlConnection con = new SqlConnection(strCon))
            {
                string query = "SELECT od.ProductID, p.ProductName, p.Description, od.Quantity, od.UnitPrice " +
                               "FROM OrderDetails od " +
                               "INNER JOIN Products p ON od.ProductID = p.ProductID " +
                               "WHERE od.OrderID = @OrderID";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@OrderID", orderId);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                ProdList.DataSource = reader;
                ProdList.DataBind();

                reader.Close();
            }
        }

        private void getSubTotal(string orderID)
        {
            SqlConnection con;
            string strCon = ConfigurationManager.ConnectionStrings["CFC"].ConnectionString;

            con = new SqlConnection(strCon);
            con.Open();

            //string strRetrieve = "Select * from Products where ProductID = '" + strProdIDSearch + "'";
            //use parameterized to prevent sql injection (Expliod all data)
            string strRetrieve = "Select * from OrderDetails where OrderId =@PID";

            SqlCommand cmdRetrieve;
            cmdRetrieve = new SqlCommand(strRetrieve, con);
            cmdRetrieve.Parameters.AddWithValue("@PID", orderID);

            //method used to execute reader
            SqlDataReader drProducts;
            drProducts = cmdRetrieve.ExecuteReader();

            double subtotal = 0;
            if (drProducts.HasRows)
            {
                while (drProducts.Read())
                {
                    int quantity = Convert.ToInt32(drProducts["Quantity"]);
                    double unitPrice = Convert.ToDouble(drProducts["UnitPrice"]);
                    subtotal += quantity * unitPrice;
                }
                lblSub.Text = subtotal.ToString("F2"); // Formatting to 2 decimal places
                double tax = Convert.ToDouble(Convert.ToDecimal(subtotal) * 0.06m);
                lblTax.Text = Math.Round(tax, 2).ToString();
            }
        }
        protected string GetFormattedDescription(string description)
        {
            if (!string.IsNullOrEmpty(description))
            {
                // Replace commas with comma followed by a line break
                return description.Replace(",", ",<br />");
            }
            return string.Empty;
        }
    }
}