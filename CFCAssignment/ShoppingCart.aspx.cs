using CFCAssignment.Logic;
using CFCAssignment.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Specialized;
using System.Collections;
using System.Configuration;
using System.Data.SqlClient;

namespace CFCAssignment
{
    public partial class ShoppingCart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                UpdateCartDisplay();
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

        private void UpdateCartDisplay()
        {
            using (ShoppingCartActions usersShoppingCart = new ShoppingCartActions())
            {
                decimal cartTotal = usersShoppingCart.GetTotal();
                decimal serviceTax = CalculateServiceTax(cartTotal);
                decimal totalAmount = cartTotal + serviceTax;

                if (cartTotal > 0)
                {
                    LabelSubTotalText.Visible = true;
                    LabelTax.Visible = true;
                    LabelTotalText.Visible = true;
                    lblSubtotal.Text = String.Format("RM {0:F2}", cartTotal);
                    lblSubtotal.Visible = true;
                    lblTax.Text = String.Format("RM {0:F2}", serviceTax);
                    lblTax.Visible = true;
                    lblTotal.Text = String.Format("RM {0:F2}", totalAmount);
                    lblTotal.Visible = true;
                    lblempty.Text = "";
                }
                else
                {
                    LabelSubTotalText.Visible = false;
                    LabelTax.Visible = false;
                    LabelTotalText.Visible = false;
                    lblSubtotal.Text = "";
                    lblTax.Text = "";
                    lblTotal.Text = "";
                    lblSubtotal.Visible = false;
                    lblTax.Visible = false;
                    lblTotal.Visible = false;
                    lblempty.Text = "Your Cart looks hungry! Order Now";
                    CheckoutBtn.Visible = false;
                }
            }
        }

        public List<CartItem> GetShoppingCartItems()
        {
            ShoppingCartActions actions = new ShoppingCartActions();
            return actions.GetCartItems();
        }

        public List<CartItem> UpdateCartItems()
        {
            using (ShoppingCartActions usersShoppingCart = new ShoppingCartActions())
            {
                String cartId = usersShoppingCart.GetCartId();

                ShoppingCartActions.ShoppingCartUpdates[] cartUpdates = new ShoppingCartActions.ShoppingCartUpdates[CartList.Rows.Count];
                for (int i = 0; i < CartList.Rows.Count; i++)
                {
                    IOrderedDictionary rowValues = new OrderedDictionary();
                    rowValues = GetValues(CartList.Rows[i]);
                    cartUpdates[i].ProductId = Convert.ToInt32(rowValues["ProductID"]);

                    TextBox quantityTextBox = (TextBox)CartList.Rows[i].FindControl("PurchaseQuantity");
                    cartUpdates[i].PurchaseQuantity = Convert.ToInt16(quantityTextBox.Text.ToString());
                }

                usersShoppingCart.UpdateShoppingCartDatabase(cartId, cartUpdates);
                CartList.DataBind();

                UpdateCartDisplay();

                return usersShoppingCart.GetCartItems();
            }
        }


        public static IOrderedDictionary GetValues(GridViewRow row)
        {
            IOrderedDictionary values = new OrderedDictionary();
            foreach (DataControlFieldCell cell in row.Cells)
            {
                if (cell.Visible)
                {
                    // Extract values from the cell.
                    cell.ContainingField.ExtractValuesFromCell(values, cell, row.RowState, true);
                }
            }
            return values;
        }

        protected void CheckoutBtn_Click(object sender, EventArgs e)
        {

            using (ShoppingCartActions usersShoppingCart = new ShoppingCartActions())
            {
                decimal totalAmountDecimal = usersShoppingCart.GetTotal() + CalculateServiceTax(usersShoppingCart.GetTotal());
                decimal tax = CalculateServiceTax(usersShoppingCart.GetTotal());
                // Convert the total amount to double and round it to 2 decimal places
                double totalAmountDouble = Math.Round((double)totalAmountDecimal, 2);
                double Totaltax = Math.Round((double)tax, 2);
                // Store the rounded double value in the session
                Session["subTotal"] = usersShoppingCart.GetTotal();
                Session["tax_amt"] = Totaltax;
                Session["payment_amt"] = totalAmountDouble;
            }
            Response.Redirect("CheckoutReview.aspx");
        }

        private decimal CalculateServiceTax(decimal cartTotal)
        {
            // Assuming a 6% service tax
            return cartTotal * 0.06m;
        }

        protected void RemoveItem_Click(object sender, EventArgs e)
        {
            LinkButton removeButton = (LinkButton)sender;
            int productId = Convert.ToInt32(removeButton.CommandArgument);

            using (ShoppingCartActions usersShoppingCart = new ShoppingCartActions())
            {
                string cartId = usersShoppingCart.GetCartId();
                usersShoppingCart.RemoveItem(cartId, productId);
                CartList.DataBind();
                UpdateCartDisplay();
            }
        }
        protected void IncrementQuantity_Click(object sender, EventArgs e)
        {
            // Get the button that triggered the event
            Button incrementButton = (Button)sender;

            // Get the product ID from the button's CommandArgument
            int productId = Convert.ToInt32(incrementButton.CommandArgument);

            // Create an instance of the ShoppingCartActions
            using (ShoppingCartActions usersShoppingCart = new ShoppingCartActions())
            {
                string cartId = usersShoppingCart.GetCartId();

                // Query to get the current product quantity from the Products table
                int availableQuantity = GetAvailableProductQuantity(productId);

                // Get the current quantity of the product in the cart
                int currentCartQuantity = usersShoppingCart.GetItemQuantity(cartId, productId);

                // Check if the available quantity is greater than the cart quantity plus the increment
                if (availableQuantity > currentCartQuantity)
                {
                    // Increment the item quantity in the shopping cart
                    usersShoppingCart.UpdateItemQuantity(cartId, productId, 1);

                    // Rebind the data to reflect the updated cart
                    CartList.DataBind();

                    // Update cart display
                    UpdateCartDisplay();
                }
                else
                {
                    // Show message to the user that they cannot increment beyond available stock
                    DisplayOutOfStockMessage();
                }
            }
        }

        // Method to get the available quantity of the product from the Products table
        private int GetAvailableProductQuantity(int productId)
        {
            int quantity = 0;

            // Your connection string here
            string connectionString = ConfigurationManager.ConnectionStrings["CFC"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT Quantity FROM Products WHERE ProductId = @ProductId";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ProductId", productId);

                    con.Open();

                    // Execute the command and read the result
                    quantity = Convert.ToInt32(cmd.ExecuteScalar());
                }
            }

            return quantity;
        }

        // Example method to display an out-of-stock message to the user
        private void DisplayOutOfStockMessage()
        {
            // You can implement any message display logic here, such as a label or popup
            lblError.Text = "Product is out of stock or exceeds available quantity.";
        }


        protected void DecrementQuantity_Click(object sender, EventArgs e)
        {
            Button decrementButton = (Button)sender;
            int productId = Convert.ToInt32(decrementButton.CommandArgument);

            using (ShoppingCartActions usersShoppingCart = new ShoppingCartActions())
            {
                string cartId = usersShoppingCart.GetCartId();
                usersShoppingCart.UpdateItemQuantity(cartId, productId, -1);
                CartList.DataBind();
                UpdateCartDisplay();
            }
        }

    }
}
