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
    public partial class AdminProductEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Retrieve the Order ID from the query string
                string prodID = Request.QueryString["ProductID"];
                if (!string.IsNullOrEmpty(prodID))
                {
                    udtLbl(prodID);
                }
            }
        }
        private void udtLbl(string productId)
        {
            //estabilsh the connection
            SqlConnection con;
            string strCon = ConfigurationManager.ConnectionStrings["CFC"].ConnectionString;

            con = new SqlConnection(strCon);
            con.Open();

            //sqlcommand 
            string id = productId;

            //string strRetrieve = "Select * from Products where ProductID = '" + strProdIDSearch + "'";
            //use parameterized to prevent sql injection (Expliod all data)
            string strRetrieve = "Select * FROM Products WHERE ProductID = @id";

            SqlCommand cmdRetrieve;
            cmdRetrieve = new SqlCommand(strRetrieve, con);
            cmdRetrieve.Parameters.AddWithValue("@id", id);

            //method used to execute reader
            SqlDataReader drProducts;
            drProducts = cmdRetrieve.ExecuteReader();

            string strName = "";
            string desc = "";
            string price = "";
            string catID = "";
            string imgPath = "";
            string qty = "";
            if (drProducts.HasRows)
            {
                while (drProducts.Read())
                {
                    imgPath += drProducts["ImagePath"];
                    strName += drProducts["ProductName"];
                    desc += drProducts["Description"];
                    price += drProducts["UnitPrice"];
                    catID += drProducts["CategoryID"];
                    qty += drProducts["Quantity"];
                }
                prodImg.ImageUrl = "~/Catalog/Images/Thumbs/"+imgPath;
                txtName.Text = strName;
                txtDescription.Text = desc;
                txtPrice.Text = price;
                DropDownList1.SelectedValue = catID;
                txtQty.Text = qty;
            }
            else
            {
                txtName.Text = "";

            }
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string prodID = Request.QueryString["ProductID"];

            if (!string.IsNullOrEmpty(prodID))
            {
                //estabilsh the connection
                SqlConnection con;
                string strCon = ConfigurationManager.ConnectionStrings["CFC"].ConnectionString;

                con = new SqlConnection(strCon);
                con.Open();

                //sqlcommand 
                string id = prodID;
                string name = txtName.Text;
                string Desc = txtDescription.Text;
                string Price = txtPrice.Text;
                string CID = DropDownList1.SelectedValue;
                string qty = txtQty.Text;
                //string strRetrieve = "Select * from Products where ProductID = '" + strProdIDSearch + "'";
                //use parameterized to prevent sql injection (Expliod all data)
                string strRetrieve = "Update Products Set ProductName = @name, Description = @Desc, UnitPrice = @Price, CategoryID = @CID, Quantity = @QTY WHERE ProductID = @id";

                SqlCommand cmdRetrieve;
                cmdRetrieve = new SqlCommand(strRetrieve, con);
                cmdRetrieve.Parameters.AddWithValue("@name", name);
                cmdRetrieve.Parameters.AddWithValue("@Desc", Desc);
                cmdRetrieve.Parameters.AddWithValue("@Price", Price);
                cmdRetrieve.Parameters.AddWithValue("@CID", CID);
                cmdRetrieve.Parameters.AddWithValue("@id", id);
                cmdRetrieve.Parameters.AddWithValue("@QTY", qty);

                //method used to execute reader
                SqlDataReader drProducts;
                drProducts = cmdRetrieve.ExecuteReader();
                lblStatus.Text = "Update Successfully! ";
            }
            else
            {
                lblStatus.Text = "Error! Product Not Found!";
            }
        }
    }
}