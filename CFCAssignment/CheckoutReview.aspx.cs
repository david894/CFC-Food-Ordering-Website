using CFCAssignment.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PayPalCheckoutSdk.Core;
using PayPalCheckoutSdk.Orders;
using PayPalHttp;
using System.Reflection.Emit;
using System.Threading.Tasks;
using PayPal.Api;

namespace CFCAssignment
{
    public partial class CheckoutReview : System.Web.UI.Page
    {
        private static string PayPalClientId = System.Configuration.ConfigurationManager.AppSettings["PayPalClientId"];
        private static string PayPalClientSecret = System.Configuration.ConfigurationManager.AppSettings["PayPalClientSecret"];

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                // Ensure session data exists to avoid crashes
                if (Session["subTotal"] == null || Session["tax_amt"] == null || Session["payment_amt"] == null)
                {
                    throw new Exception("Session data is missing. Please try again.");
                }
                if (Request.QueryString != null && Request.QueryString.Count != 0)
                {
                    string approvalToken = Request.QueryString["token"];
                    var response = Task.Run(async () => await captureOrder(approvalToken));  // Use .Result since Page_Load is not asynchronous

                    // Process the response or handle errors as needed
                    if (response.Result != null)
                    {
                        PayPalCheckoutSdk.Orders.Order result = response.Result.Result<PayPalCheckoutSdk.Orders.Order>();
                        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CFC"].ConnectionString))
                        {
                            con.Open();

                            // Insert a new order
                            string orderInsertQuery = @"
                                INSERT INTO Orders (OrderDate, UserID, Total, PaymentId, CartId)
                                OUTPUT INSERTED.OrderId
                                VALUES (@OrderDate, @UserID, @Total, @PaymentId, @CartId)";

                            SqlCommand orderCmd = new SqlCommand(orderInsertQuery, con);
                            orderCmd.Parameters.AddWithValue("@OrderDate", DateTime.Now);
                            orderCmd.Parameters.AddWithValue("@UserID", User.Identity.Name); // Assuming the user is logged in
                            orderCmd.Parameters.AddWithValue("@Total", Session["payment_amt"]);
                            orderCmd.Parameters.AddWithValue("@PaymentId", DBNull.Value); // Initially NULL, update after inserting payment
                            orderCmd.Parameters.AddWithValue("@CartId", DBNull.Value); // Add CartId if available

                            // Get the newly inserted OrderId
                            int orderId = (int)orderCmd.ExecuteScalar();

                            // Insert each product into the OrderDetails table
                            using (CFCAssignment.Logic.ShoppingCartActions usersShoppingCart = new CFCAssignment.Logic.ShoppingCartActions())
                            {
                                List<CartItem> myOrderList = usersShoppingCart.GetCartItems();

                                foreach (var item in myOrderList)
                                {
                                    string orderDetailInsertQuery = @"
                                        INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice, UserId)
                                        VALUES (@OrderId, @ProductId, @Quantity, @UnitPrice, @UserId)";

                                    SqlCommand orderDetailCmd = new SqlCommand(orderDetailInsertQuery, con);
                                    orderDetailCmd.Parameters.AddWithValue("@OrderId", orderId);
                                    orderDetailCmd.Parameters.AddWithValue("@ProductId", item.ProductId);
                                    orderDetailCmd.Parameters.AddWithValue("@Quantity", item.Quantity);
                                    orderDetailCmd.Parameters.AddWithValue("@UnitPrice", item.Product.UnitPrice);
                                    orderDetailCmd.Parameters.AddWithValue("@UserId", User.Identity.Name);

                                    orderDetailCmd.ExecuteNonQuery();

                                    string updateProductQuantityQuery = @"
                                    UPDATE Products 
                                    SET Quantity = CASE WHEN Quantity - @Quantity >= 0 THEN Quantity - @Quantity ELSE Quantity END
                                    WHERE ProductId = @ProductId";


                                    SqlCommand updateProductCmd = new SqlCommand(updateProductQuantityQuery, con);
                                    updateProductCmd.Parameters.AddWithValue("@Quantity", item.Quantity);
                                    updateProductCmd.Parameters.AddWithValue("@ProductId", item.ProductId);
                                    updateProductCmd.ExecuteNonQuery();
                                }
                            }

                            // Insert payment information
                            string paymentInsertQuery = @"
                                    INSERT INTO Payment (OrderId, UserId, PaymentCard, PaymentType)
                                    OUTPUT INSERTED.PaymentId
                                    VALUES (@OrderId, @UserId, @PaymentCard , @PaymentType)";

                            SqlCommand paymentCmd = new SqlCommand(paymentInsertQuery, con);
                            paymentCmd.Parameters.AddWithValue("@OrderId", orderId);
                            paymentCmd.Parameters.AddWithValue("@UserId", User.Identity.Name);

                            paymentCmd.Parameters.AddWithValue("@PaymentCard", "0000");
                            paymentCmd.Parameters.AddWithValue("@PaymentType", "PayPal");


                            // Get the newly inserted PaymentId
                            int paymentId = (int)paymentCmd.ExecuteScalar();

                            // Update the Order with the PaymentId
                            string orderUpdateQuery = "UPDATE Orders SET PaymentId = @PaymentId WHERE OrderId = @OrderId";
                            SqlCommand orderUpdateCmd = new SqlCommand(orderUpdateQuery, con);
                            orderUpdateCmd.Parameters.AddWithValue("@PaymentId", paymentId);
                            orderUpdateCmd.Parameters.AddWithValue("@OrderId", orderId);

                            orderUpdateCmd.ExecuteNonQuery();

                            Response.Redirect($"CheckoutComplete.aspx?OrderId={orderId}",false);

                        }

                    }
                    else
                    {
                        // Handle null response (error handling)
                        lblError.Text = "Error! Please Try Again.";

                    }

                }

                // Get DB context.
                ProductContext _db = new ProductContext();


                // Get the shopping cart items and process them.
                using (CFCAssignment.Logic.ShoppingCartActions usersShoppingCart = new CFCAssignment.Logic.ShoppingCartActions())
                {
                    List<CartItem> myOrderList = usersShoppingCart.GetCartItems();

                    // Add OrderDetail information to the DB for each product purchased.
                    for (int i = 0; i < myOrderList.Count; i++)
                    {
                        // Create a new OrderDetail object.
                        var myOrderDetail = new OrderDetail();
                        myOrderDetail.Username = User.Identity.Name;
                        myOrderDetail.ProductId = myOrderList[i].ProductId;
                        myOrderDetail.Quantity = myOrderList[i].Quantity;
                        myOrderDetail.UnitPrice = myOrderList[i].Product.UnitPrice;
                    }


                    // Display Order information.
                    List<Models.Order> orderList = new List<Models.Order>();

                    // Display OrderDetails.
                    OrderItemList.DataSource = myOrderList;
                    OrderItemList.DataBind();
                    string subT = Session["subTotal"].ToString();
                    string tax = Session["tax_amt"].ToString();
                    string amt = Session["payment_amt"].ToString();
                    lblSub.Text = subT;
                    lblTax.Text = tax;
                    lblTotal.Text = amt;
                }
            }
            catch (Exception ex)
            {
                // Redirect to the error page with error message
                Response.Redirect($"ErrorPage.aspx?errorMsg={HttpUtility.UrlEncode(ex.Message)}");
            }
        }
        public async static Task<string> createOrder(string payment)
        {
            // Construct a request object and set desired parameters
            // Here, OrdersCreateRequest() creates a POST request to /v2/checkout/orders
            var order = new OrderRequest()
            {
                CheckoutPaymentIntent = "CAPTURE",
                PurchaseUnits = new List<PurchaseUnitRequest>()
                {
                    new PurchaseUnitRequest()
                    {
                        AmountWithBreakdown = new AmountWithBreakdown()
                        {
                            CurrencyCode = "MYR",
                            Value = payment
                        }
                    }
                },
                ApplicationContext = new ApplicationContext()
                {
                    ReturnUrl = "https://localhost:44365/CheckoutReview.aspx",
                    CancelUrl = "https://localhost:44365/CheckoutCancel.aspx"
                }
            };


            // Call API with your client and get a response for your call
            var request = new OrdersCreateRequest();
            request.Prefer("return=representation");
            request.RequestBody(order);
            var environment = new SandboxEnvironment(PayPalClientId, PayPalClientSecret);
            var response = await (new PayPalHttpClient(environment).Execute(request));
            var statusCode = response.StatusCode;
            PayPalCheckoutSdk.Orders.Order result = response.Result<PayPalCheckoutSdk.Orders.Order>();
            Console.WriteLine("Status: {0}", result.Status);
            Console.WriteLine("Order Id: {0}", result.Id);
            Console.WriteLine("Intent: {0}", result.CheckoutPaymentIntent);
            Console.WriteLine("Links:");
            foreach (LinkDescription link in result.Links)
            {
                Console.WriteLine("\t{0}: {1}\tCall Type: {2}", link.Rel, link.Href, link.Method);
            }
            return GetApprovalUrl(result);
        }



        public async static Task<PayPalHttp.HttpResponse> captureOrder(string token)
        {
            // Construct a request object and set desired parameters
            // Replace ORDER-ID with the approved order id from create order
            var request = new OrdersCaptureRequest(token);
            request.RequestBody(new OrderActionRequest());
            var environment = new SandboxEnvironment(PayPalClientId, PayPalClientSecret);
            var response = await (new PayPalHttpClient(environment).Execute(request));
            var statusCode = response.StatusCode;
            PayPalCheckoutSdk.Orders.Order result = response.Result<PayPalCheckoutSdk.Orders.Order>();
            Console.WriteLine("Status: {0}", result.Status);
            Console.WriteLine("Capture Id: {0}", result.Id);
            return response;
        }
        public static string GetApprovalUrl(PayPalCheckoutSdk.Orders.Order result)
        {

            // Check if there are links in the response
            if (result.Links != null)
            {
                // Find the approval URL link in the response
                LinkDescription approvalLink = result.Links.Find(link => link.Rel.ToLower() == "approve");
                if (approvalLink != null)
                {
                    return approvalLink.Href;
                }
            }


            // Return a default URL or handle the error as needed
            return "https://localhost:44365/home.aspx"; // Replace with your default URL
        }


        protected void CheckoutConfirm_Click(object sender, EventArgs e)
        {
            // Ensure that at least one payment option is selected
            if (!rdoCard.Checked && !rdoCash.Checked && !rdoPaypal.Checked )
            {
                lblError.Text = "Please Select At Least One Payment Method.";
                return;
            }
            if (rdoPaypal.Checked) {
                var response = Task.Run(async() => await createOrder(Session["payment_amt"].ToString()));
                Response.Redirect(response.Result);
            }
            // Perform validation only if card payment is selected
            if (rdoCard.Checked)
            {
                string cardNumber = txtCardNumber.Text.Trim();
                string expiryDate = txtExpiryDate.Text.Trim();
                string cvv = txtCVV.Text.Trim();

                // Validate card number (must be 16 digits)
                if (!Regex.IsMatch(cardNumber, @"^\d{16}$"))
                {
                    revCardNumber.IsValid = false;
                    revCardNumber.ErrorMessage = "Card number must be 16 digits.";
                    return;
                }

                // Validate expiry date (MM/YY format)
                if (!Regex.IsMatch(expiryDate, @"^(0[1-9]|1[0-2])\/\d{2}$"))
                {
                    revExpiryDate.IsValid = false;
                    revExpiryDate.ErrorMessage = "Expiry date must be in MM/YY format.";
                    return;
                }

                // Validate CVV (must be 3 digits)
                if (!Regex.IsMatch(cvv, @"^\d{3}$"))
                {
                    revCVV.IsValid = false;
                    revCVV.ErrorMessage = "CVV must be 3 digits.";
                    return;
                }
            }

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CFC"].ConnectionString))
            {
                con.Open();

                // Insert a new order
                string orderInsertQuery = @"
            INSERT INTO Orders (OrderDate, UserID, Total, PaymentId, CartId)
            OUTPUT INSERTED.OrderId
            VALUES (@OrderDate, @UserID, @Total, @PaymentId, @CartId)";

                SqlCommand orderCmd = new SqlCommand(orderInsertQuery, con);
                orderCmd.Parameters.AddWithValue("@OrderDate", DateTime.Now);
                orderCmd.Parameters.AddWithValue("@UserID", User.Identity.Name); // Assuming the user is logged in
                orderCmd.Parameters.AddWithValue("@Total", Session["payment_amt"]);
                orderCmd.Parameters.AddWithValue("@PaymentId", DBNull.Value); // Initially NULL, update after inserting payment
                orderCmd.Parameters.AddWithValue("@CartId", DBNull.Value); // Add CartId if available

                // Get the newly inserted OrderId
                int orderId = (int)orderCmd.ExecuteScalar();

                // Insert each product into the OrderDetails table
                CFCAssignment.Logic.ShoppingCartActions usersShoppingCart = new CFCAssignment.Logic.ShoppingCartActions();
                List<CartItem> myOrderList = usersShoppingCart.GetCartItems();

                foreach (var item in myOrderList)
                {
                    if (item.Quantity > 0)
                    {
                        // Deduct product quantity
                        string updateProductQuantityQuery = @"
                        UPDATE Products 
                        SET Quantity = CASE WHEN Quantity - @Quantity >= 0 THEN Quantity - @Quantity ELSE Quantity END
                        WHERE ProductId = @ProductId";


                        SqlCommand updateProductCmd = new SqlCommand(updateProductQuantityQuery, con);
                        updateProductCmd.Parameters.AddWithValue("@Quantity", item.Quantity);
                        updateProductCmd.Parameters.AddWithValue("@ProductId", item.ProductId);
                        updateProductCmd.ExecuteNonQuery();
                    }

                    string orderDetailInsertQuery = @"
                INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice, UserId)
                VALUES (@OrderId, @ProductId, @Quantity, @UnitPrice, @UserId)";

                    SqlCommand orderDetailCmd = new SqlCommand(orderDetailInsertQuery, con);
                    orderDetailCmd.Parameters.AddWithValue("@OrderId", orderId);
                    orderDetailCmd.Parameters.AddWithValue("@ProductId", item.ProductId);
                    orderDetailCmd.Parameters.AddWithValue("@Quantity", item.Quantity);
                    orderDetailCmd.Parameters.AddWithValue("@UnitPrice", item.Product.UnitPrice);
                    orderDetailCmd.Parameters.AddWithValue("@UserId", User.Identity.Name);

                    orderDetailCmd.ExecuteNonQuery();

                }




                    // Insert payment information
                    string paymentInsertQuery = @"
            INSERT INTO Payment (OrderId, UserId, PaymentCard, PaymentType)
            OUTPUT INSERTED.PaymentId
            VALUES (@OrderId, @UserId, @PaymentCard , @PaymentType)";

                SqlCommand paymentCmd = new SqlCommand(paymentInsertQuery, con);
                paymentCmd.Parameters.AddWithValue("@OrderId", orderId);
                paymentCmd.Parameters.AddWithValue("@UserId", User.Identity.Name);

                // Check the selected payment method
                if (rdoCard.Checked)
                {
                    string cardNumber = txtCardNumber.Text.Trim();
                    string last4Digits = cardNumber.Substring(cardNumber.Length - 4);
                    paymentCmd.Parameters.AddWithValue("@PaymentCard", last4Digits);
                    if (cardNumber.StartsWith("4"))
                    {
                        paymentCmd.Parameters.AddWithValue("@PaymentType", "Visa");
                    }
                    else if (cardNumber.StartsWith("5"))
                    {
                        paymentCmd.Parameters.AddWithValue("@PaymentType", "Master");
                    }
                    else
                    {
                        paymentCmd.Parameters.AddWithValue("@PaymentType", "Unknown");
                    }
                }
                else if (rdoCash.Checked)
                {
                    paymentCmd.Parameters.AddWithValue("@PaymentCard", "0000");
                    paymentCmd.Parameters.AddWithValue("@PaymentType", "Cash");
                }

                // Get the newly inserted PaymentId
                int paymentId = (int)paymentCmd.ExecuteScalar();

                // Update the Order with the PaymentId
                string orderUpdateQuery = "UPDATE Orders SET PaymentId = @PaymentId WHERE OrderId = @OrderId";
                SqlCommand orderUpdateCmd = new SqlCommand(orderUpdateQuery, con);
                orderUpdateCmd.Parameters.AddWithValue("@PaymentId", paymentId);
                orderUpdateCmd.Parameters.AddWithValue("@OrderId", orderId);

                orderUpdateCmd.ExecuteNonQuery();
                Session["order_id"] = orderId;

                // Redirect to the CheckoutComplete page
                Response.Redirect($"CheckoutComplete.aspx?OrderId={orderId}", false);
            }


        }


        protected void CheckoutCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("CheckoutCancel.aspx");

        }
    }
}