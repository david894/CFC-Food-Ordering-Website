using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CFCAssignment.Models;
using System.Web.ModelBinding;

namespace CFCAssignment
{
    public partial class ProductDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

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
        public IQueryable<Product> GetProduct([QueryString("productID")] int? productId)
        {
            var _db = new CFCAssignment.Models.ProductContext();
            IQueryable<Product> query = _db.Products;
            if (productId.HasValue && productId > 0)
            {
                query = query.Where(p => p.ProductID == productId);
            }
            else
            {
                query = null;
            }
            return query;
        }
    }
}