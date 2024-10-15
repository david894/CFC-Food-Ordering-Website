using CFCAssignment.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CFCAssignment
{
    public partial class menu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public IQueryable<Category> GetCategories()
        {
            var _db = new CFCAssignment.Models.ProductContext();
            IQueryable<Category> query = _db.Categories;
            return query;
        }

        public IQueryable<Product> GetProducts([QueryString("id")] int? categoryId)
        {
            // Establish the connection
            SqlConnection con;
            string strCon = ConfigurationManager.ConnectionStrings["CFC"].ConnectionString;
            con = new SqlConnection(strCon);
            con.Open();

            // SQL query to retrieve products with Discontinued = 0
            string strRetrieve = "Select * from Products where Discontinued = 0 AND Quantity > 0";
            if (categoryId.HasValue && categoryId > 0)
            {
                strRetrieve += " AND CategoryID = @CategoryId";
            }

            SqlCommand cmdRetrieve = new SqlCommand(strRetrieve, con);

            if (categoryId.HasValue && categoryId > 0)
            {
                cmdRetrieve.Parameters.AddWithValue("@CategoryId", categoryId.Value);
            }

            SqlDataReader drProducts = cmdRetrieve.ExecuteReader();

            // List to hold Product objects
            List<Product> products = new List<Product>();

            // Mapping data from SqlDataReader to Product objects
            while (drProducts.Read())
            {
                Product product = new Product
                {
                    ProductID = Convert.ToInt32(drProducts["ProductID"]),
                    ProductName = drProducts["ProductName"].ToString(),
                    CategoryID = Convert.ToInt32(drProducts["CategoryID"]),
                    UnitPrice = Convert.ToDouble(drProducts["UnitPrice"]),
                    ImagePath = drProducts["ImagePath"].ToString(),
                };
                products.Add(product);
            }

            drProducts.Close();
            con.Close();

            // Convert List<Product> to IQueryable<Product>
            return products.AsQueryable();
        }


        //public IQueryable<Product> GetProducts([QueryString("id")] int? categoryId)
        //{
        //    //estabilsh the connection
        //    SqlConnection con;
        //    string strCon = ConfigurationManager.ConnectionStrings["CFC"].ConnectionString;

        //    con = new SqlConnection(strCon);
        //    con.Open();
        //    string strRetrieve = "Select * from Products where Discontinued = 0";
        //    SqlCommand cmdRetrieve;
        //    cmdRetrieve = new SqlCommand(strRetrieve, con);
        //    SqlDataReader drProducts;
        //    drProducts = cmdRetrieve.ExecuteReader();
        //    return drProducts;

        //    var _db = new CFCAssignment.Models.ProductContext();
        //    IQueryable<Product> query = _db.Products;
        //    if (categoryId.HasValue && categoryId > 0)
        //    {
        //        query = query.Where(p => p.CategoryID == categoryId );
        //    }

        //    return query;
        //}
    }
}