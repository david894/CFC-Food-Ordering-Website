using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using System.Data.Entity;
using CFCAssignment.Models;

namespace CFCAssignment
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            // Initialize the product database.
            Database.SetInitializer(new ProductDatabaseInitializer());
        }
        void Application_Error(object sender, EventArgs e)
        {
            Exception ex = Server.GetLastError();
            // Store the error for later
            Application["exception"] = ex;
            // Store the URL where the error occurred
            Application["location"] = Request.Url.ToString();
            // Clear the error to continue
            Server.ClearError();
            // Redirect to GeneralError page
            Response.Redirect("~/ErrorPage.aspx");
        }
    }

}