using PayPalCheckoutSdk.Core;
using PayPalCheckoutSdk.Orders;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using WebGrease.Activities;

namespace CFCAssignment
{
    public partial class CheckoutComplete : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                // Retrieve the Order ID from the query string
                string orderId = Request.QueryString["OrderId"];
                if (!string.IsNullOrEmpty(orderId))
                {
                    showEnd(orderId);
                }
            }
            else
            {
                string orderID = Session["order_id"].ToString();
                showEnd(orderID);
            }
        }
        protected void showEnd(string orderID) {
            string amt = Session["payment_amt"].ToString();
            lblAmmount.Text = amt;
            lblOrderNo.Text = orderID;

            SqlConnection con;
            string strCon = ConfigurationManager.ConnectionStrings["CFC"].ConnectionString;

            con = new SqlConnection(strCon);
            con.Open();
            string strRetrieve = "Select * from Payment Where OrderId = @orderId";
            SqlCommand cmdRetrieve;
            cmdRetrieve = new SqlCommand(strRetrieve, con);
            cmdRetrieve.Parameters.AddWithValue("@orderId", orderID);
            SqlDataReader drProducts;
            drProducts = cmdRetrieve.ExecuteReader();
            string paymentMethod = "";
            string paymentType = "";
            if (drProducts.HasRows)
            {
                while (drProducts.Read())
                {
                    paymentMethod += drProducts["PaymentCard"];
                    paymentType += drProducts["PaymentType"];
                }
            }
            if (paymentMethod == "0000")
            {
                if (paymentType == "Cash")
                {
                    lblPayment.Text = "Cash";
                }
                else if (paymentType == "PayPal")
                {
                    lblPayment.Text = "PayPal";
                }
                else {
                    lblPayment.Text = "Unknown";
                }
            }
            else
            {
                lblPayment.Text = "Card [" + paymentMethod + "]";
            }
            // Clear shopping cart.
            using (CFCAssignment.Logic.ShoppingCartActions usersShoppingCart =
                new CFCAssignment.Logic.ShoppingCartActions())
            {
                usersShoppingCart.EmptyCart();
            }
            
        }

    }
}