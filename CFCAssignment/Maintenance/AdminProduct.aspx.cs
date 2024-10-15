using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace CFCAssignment.Maintenance
{
    public partial class AdminProduct : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProducts();
            }
        }
        protected void LoadProducts(string searchKeyword = "")
        {
            // Get the connection string
            string strCon = ConfigurationManager.ConnectionStrings["CFC"].ConnectionString;
            using (SqlConnection con = new SqlConnection(strCon))
            {
                con.Open();

                // SQL query to get products (with optional search)
                string query = "SELECT ProductID, ProductName,UnitPrice, Quantity, ImagePath FROM Products";
                if (!string.IsNullOrEmpty(searchKeyword))
                {
                    query += " WHERE ProductName LIKE @searchKeyword AND Discontinued = 0";
                }
                else {
                    query += " WHERE Discontinued = 0";
                }

                SqlCommand cmd = new SqlCommand(query, con);
                if (!string.IsNullOrEmpty(searchKeyword))
                {
                    cmd.Parameters.AddWithValue("@searchKeyword", "%" + searchKeyword + "%");
                }

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Bind data to GridView
                gvProducts.DataSource = dt;
                gvProducts.DataBind();
            }
        }


        // Handle edit and discontinue button clicks
        protected void gvProducts_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditProduct")
            {
                // Get the ProductID
                int productId = Convert.ToInt32(e.CommandArgument);

                // Redirect to edit page (replace with your actual edit page)
                Response.Redirect($"~/Maintenance/AdminProductEdit.aspx?ProductID={productId}");
            }
            else if (e.CommandName == "DiscontinueProduct")
            {
                int productId = Convert.ToInt32(e.CommandArgument);
                DiscontinueProduct(productId);
            }
        }

        private void DiscontinueProduct(int productId)
        {
            string strCon = ConfigurationManager.ConnectionStrings["CFC"].ConnectionString;
            using (SqlConnection con = new SqlConnection(strCon))
            {
                con.Open();

                string query = "UPDATE Products SET Discontinued = 1 WHERE ProductID = @ProductID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@ProductID", productId);
                cmd.ExecuteNonQuery();

                // Reload products after updating
                LoadProducts();
                lblStatus.Text = "Product Deactivated Successfully!";
            }
        }

        protected void btnCheckProdName_Click(object sender, EventArgs e)
        {
            string searchKeyword = txtProdName.Text.Trim();
            LoadProducts(searchKeyword);
            gvProd.Visible = true;
            addProd.Visible = false;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (addProd.Visible == false)
            {
                addProd.Visible = true;
                ReActi.Visible = false;
                gvProd.Visible = false;
            }
            else { 
                addProd.Visible = false;
                gvProd.Visible = true;
                ReActi.Visible = false;
            }
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            //estabilsh the connection
            SqlConnection con;
            string strCon = ConfigurationManager.ConnectionStrings["CFC"].ConnectionString;

            con = new SqlConnection(strCon);
            con.Open();

            string name = txtName.Text;
            string Desc = txtDescription.Text;
            string IMG = txtImage.Text;
            string Price = txtPrice.Text;
            string CID = DropDownList1.SelectedValue;
            string QTY = txtQty.Text;

            //string strRetrieve = "Select * from Products where ProductID = '" + strProdIDSearch + "'";
            //use parameterized to prevent sql injection (Expliod all data)
            string strRetrieve = "INSERT INTO Products (ProductName, Description, ImagePath, UnitPrice, CategoryID, Discontinued, Quantity) VALUES (@name, @Desc, @IMG, @Price, @CID,0,@QTY)";

            SqlCommand cmdRetrieve;
            cmdRetrieve = new SqlCommand(strRetrieve, con);
            cmdRetrieve.Parameters.AddWithValue("@name", name);
            cmdRetrieve.Parameters.AddWithValue("@Desc", Desc);
            cmdRetrieve.Parameters.AddWithValue("@IMG", IMG);
            cmdRetrieve.Parameters.AddWithValue("@Price", Price);
            cmdRetrieve.Parameters.AddWithValue("@CID", CID);
            cmdRetrieve.Parameters.AddWithValue("@QTY", QTY);


            cmdRetrieve.ExecuteReader();

            lblStatus.Text = "Add Successfully ! ";
            LoadProducts();
            addProd.Visible = false;
            gvProd.Visible = true;
            ReActi.Visible = false;
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (fileUploadImage.HasFile)
            {
                try
                {
                    string fileName = Path.GetFileName(fileUploadImage.PostedFile.FileName);
                    string filePath = Server.MapPath("~/Catalog/Images/Thumbs/") + fileName;
                    fileUploadImage.SaveAs(filePath);

                    // Set the TextBox value to the image path relative to the application root
                    txtImage.Text = fileName;

                    lblStatus.Text = "Image uploaded successfully!";
                }
                catch (Exception ex)
                {
                    lblStatus.Text = "Error: " + ex.Message;
                }
            }
            else
            {
                lblStatus.Text = "Please select an image file to upload.";
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            if (ReActi.Visible == false)
            {
                // Force the data source to refresh
                SqlDataSource3.DataBind();
                ddlActiProd.DataBind();

                addProd.Visible = false;
                ReActi.Visible = true;
                gvProd.Visible = false;
            }
            else
            {
                addProd.Visible = false;
                gvProd.Visible = true;
                ReActi.Visible = false;
            }
        }
        protected void btnEnable_Click(object sender, EventArgs e)
        {
            //estabilsh the connection
            SqlConnection con;
            string strCon = ConfigurationManager.ConnectionStrings["CFC"].ConnectionString;

            con = new SqlConnection(strCon);
            con.Open();

            //sqlcommand 
            string id = ddlActiProd.SelectedValue;
            if (!string.IsNullOrEmpty(id))
            {
                //string strRetrieve = "Select * from Products where ProductID = '" + strProdIDSearch + "'";
                //use parameterized to prevent sql injection (Expliod all data)
                string strRetrieve = "Update Products SET Discontinued = @CID WHERE ProductID = @id";

                SqlCommand cmdRetrieve;
                cmdRetrieve = new SqlCommand(strRetrieve, con);
                cmdRetrieve.Parameters.AddWithValue("@CID", 0);
                cmdRetrieve.Parameters.AddWithValue("@id", id);

                //method used to execute reader
                SqlDataReader drProducts;
                drProducts = cmdRetrieve.ExecuteReader();

                lblStatus.Text = "Enable Successfully ! ";
                LoadProducts();
                addProd.Visible = false;
                gvProd.Visible = true;
                ReActi.Visible = false;
            }
            else {
                lblStatus.Text = "Error! Product Is Not Selected.";
            }

        }
    }
}