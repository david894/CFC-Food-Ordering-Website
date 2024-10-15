using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CFCAssignment.Maintenance
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblDate.Text = "Today is " + DateTime.Now.ToString("D");

            if (!IsPostBack)
            {
                LoadSalesData();
                LoadHourlySalesData();
                LoadWeeklySalesData();
                LoadTopSellingProducts();
                LoadTodayTopSellingProducts();
            }
        }
        private void LoadSalesData()
        {
            // Establish the connection
            SqlConnection con;
            string strCon = ConfigurationManager.ConnectionStrings["CFC"].ConnectionString;
            con = new SqlConnection(strCon);
            con.Open();

            // Get today's total sales
            string queryToday = @"
        SELECT ISNULL(SUM(Total), 0) 
        FROM Orders 
        WHERE CAST(OrderDate AS DATE) = CAST(GETDATE() AS DATE)";
            SqlCommand cmdToday = new SqlCommand(queryToday, con);
            decimal totalSalesToday = (decimal)cmdToday.ExecuteScalar();

            // Get total sales for the previous day
            string queryYesterday = @"
        SELECT ISNULL(SUM(Total), 0) 
        FROM Orders 
        WHERE CAST(OrderDate AS DATE) = CAST(DATEADD(day, -1, GETDATE()) AS DATE)";
            SqlCommand cmdYesterday = new SqlCommand(queryYesterday, con);
            decimal totalSalesYesterday = (decimal)cmdYesterday.ExecuteScalar();

            // Get total sales for the week
            string queryThisWeek = @"
        SELECT ISNULL(SUM(Total), 0) 
        FROM Orders 
        WHERE DATEPART(week, OrderDate) = DATEPART(week, GETDATE()) 
        AND DATEPART(year, OrderDate) = DATEPART(year, GETDATE())";
            SqlCommand cmdThisWeek = new SqlCommand(queryThisWeek, con);
            decimal totalSalesThisWeek = (decimal)cmdThisWeek.ExecuteScalar();

            // Get total sales for the previous week
            string queryLastWeek = @"
        SELECT ISNULL(SUM(Total), 0) 
        FROM Orders 
        WHERE DATEPART(week, OrderDate) = DATEPART(week, DATEADD(week, -1, GETDATE())) 
        AND DATEPART(year, OrderDate) = DATEPART(year, GETDATE())";
            SqlCommand cmdLastWeek = new SqlCommand(queryLastWeek, con);
            decimal totalSalesLastWeek = (decimal)cmdLastWeek.ExecuteScalar();

            // Get total sales for the month
            string queryThisMonth = @"
        SELECT ISNULL(SUM(Total), 0) 
        FROM Orders 
        WHERE DATEPART(month, OrderDate) = DATEPART(month, GETDATE()) 
        AND DATEPART(year, OrderDate) = DATEPART(year, GETDATE())";
            SqlCommand cmdThisMonth = new SqlCommand(queryThisMonth, con);
            decimal totalSalesThisMonth = (decimal)cmdThisMonth.ExecuteScalar();

            // Get total sales for the previous month
            string queryLastMonth = @"
        SELECT ISNULL(SUM(Total), 0) 
        FROM Orders 
        WHERE DATEPART(month, OrderDate) = DATEPART(month, DATEADD(month, -1, GETDATE())) 
        AND DATEPART(year, OrderDate) = DATEPART(year, GETDATE())";
            SqlCommand cmdLastMonth = new SqlCommand(queryLastMonth, con);
            decimal totalSalesLastMonth = (decimal)cmdLastMonth.ExecuteScalar();

            con.Close();

            // Calculate percentage changes
            decimal dailyChange = CalculatePercentageChange(totalSalesYesterday, totalSalesToday);
            decimal weeklyChange = CalculatePercentageChange(totalSalesLastWeek, totalSalesThisWeek);
            decimal monthlyChange = CalculatePercentageChange(totalSalesLastMonth, totalSalesThisMonth);

            // Assign to labels on the dashboard
            lblDailySales.Text = totalSalesToday.ToString("C");
            lblDailyChange.Text = FormatPercentage(dailyChange);
            lblDailyChange.ForeColor = dailyChange >= 0 ? Color.Green : Color.Red;

            lblWeeklySales.Text = totalSalesThisWeek.ToString("C");
            lblWeeklyChange.Text = FormatPercentage(weeklyChange);
            lblWeeklyChange.ForeColor = weeklyChange >= 0 ? Color.Green : Color.Red;

            lblMonthlySales.Text = totalSalesThisMonth.ToString("C");
            lblMonthlyChange.Text = FormatPercentage(monthlyChange);
            lblMonthlyChange.ForeColor = monthlyChange >= 0 ? Color.Green : Color.Red;
        }

        private decimal CalculatePercentageChange(decimal previous, decimal current)
        {
            if (previous == 0) return 100;
            return ((current - previous) / previous) * 100;
        }

        private string FormatPercentage(decimal percentage)
        {
            return percentage.ToString("0.00") + "%";
        }

        private void LoadHourlySalesData()
        {
            // Establish the connection
            SqlConnection con;
            string strCon = ConfigurationManager.ConnectionStrings["CFC"].ConnectionString;
            con = new SqlConnection(strCon);
            con.Open();

            // Get hourly sales for today
            string queryHourlySales = @"
        SELECT DATEPART(HOUR, OrderDate) AS HourOfDay, ISNULL(SUM(Total), 0) AS TotalSales
        FROM Orders 
        WHERE CAST(OrderDate AS DATE) = CAST(GETDATE() AS DATE)
        GROUP BY DATEPART(HOUR, OrderDate)
        ORDER BY HourOfDay";
            SqlCommand cmdHourlySales = new SqlCommand(queryHourlySales, con);
            SqlDataReader reader = cmdHourlySales.ExecuteReader();

            // Store the result in a list to bind to the chart
            List<HourlySales> hourlySalesData = new List<HourlySales>();
            while (reader.Read())
            {
                hourlySalesData.Add(new HourlySales
                {
                    Hour = reader.GetInt32(0),
                    TotalSales = reader.GetDecimal(1)
                });
            }

            reader.Close();
            con.Close();

            if (hourlySalesData.Any())
            {
                // Bind the data to the chart
                Chart1.DataSource = hourlySalesData;
                Chart1.DataBind();
                lblNoDataChart1.Visible = false;
            }
            else
            {
                lblNoDataChart1.Visible = true;
            }
        }

        public class HourlySales
        {
            public int Hour { get; set; }
            public decimal TotalSales { get; set; }
        }
        private void LoadWeeklySalesData()
        {
            // Establish the connection
            SqlConnection con;
            string strCon = ConfigurationManager.ConnectionStrings["CFC"].ConnectionString;
            con = new SqlConnection(strCon);
            con.Open();

            // Get daily sales for the current week (from Monday to Sunday)
            string queryWeeklySales = @"
        SELECT 
            DATENAME(WEEKDAY, OrderDate) AS DayOfWeek,
            ISNULL(SUM(Total), 0) AS TotalSales
        FROM Orders 
        WHERE OrderDate >= DATEADD(DAY, 1 - DATEPART(WEEKDAY, GETDATE()), CAST(GETDATE() AS DATE))
          AND OrderDate < DATEADD(DAY, 8 - DATEPART(WEEKDAY, GETDATE()), CAST(GETDATE() AS DATE))
        GROUP BY DATENAME(WEEKDAY, OrderDate), DATEPART(WEEKDAY, OrderDate)
        ORDER BY DATEPART(WEEKDAY, OrderDate)";

            SqlCommand cmdWeeklySales = new SqlCommand(queryWeeklySales, con);
            SqlDataReader reader = cmdWeeklySales.ExecuteReader();

            // Store the result in a list to bind to the chart
            List<DailySales> dailySalesData = new List<DailySales>();
            while (reader.Read())
            {
                dailySalesData.Add(new DailySales
                {
                    DayOfWeek = reader.GetString(0),
                    TotalSales = reader.GetDecimal(1)
                });
            }

            reader.Close();
            con.Close();
            if (dailySalesData.Any())
            {
                // Bind the data to the chart
                Chart2.DataSource = dailySalesData;
                Chart2.DataBind();
                lblNoDataChart2.Visible = false;
            }
            else
            {
                lblNoDataChart2.Visible = true;
            }

        }

        public class DailySales
        {
            public string DayOfWeek { get; set; }
            public decimal TotalSales { get; set; }
        }
        private void LoadTopSellingProducts()
        {
            string strCon = ConfigurationManager.ConnectionStrings["CFC"].ConnectionString;
            using (SqlConnection con = new SqlConnection(strCon))
            {
                string query = @"
                    SELECT TOP 3 
                        P.ProductID,
                        P.ProductName,
                        P.ImagePath,
                        SUM(OD.Quantity) AS TotalSold
                    FROM 
                        Products P
                    JOIN 
                        OrderDetails OD ON P.ProductID = OD.ProductId
                    GROUP BY 
                        P.ProductID, P.ProductName, P.ImagePath
                    ORDER BY 
                        TotalSold DESC;";

                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    rptTopSellingProducts.DataSource = reader;
                    rptTopSellingProducts.DataBind();
                    lblNoDataRepeater2.Visible = false;
                }
                else
                {
                    lblNoDataRepeater2.Visible = true;
                }

                con.Close();
            }
        }
        private void LoadTodayTopSellingProducts()
        {
            string strCon = ConfigurationManager.ConnectionStrings["CFC"].ConnectionString;
            using (SqlConnection con = new SqlConnection(strCon))
            {
                string query = @"
                    SELECT TOP 3 
                        P.ProductID,
                        P.ProductName,
                        P.ImagePath,
                        SUM(OD.Quantity) AS TotalSold
                    FROM 
                        Products P
                    JOIN 
                        OrderDetails OD ON P.ProductID = OD.ProductId
                    JOIN
                        Orders O ON OD.OrderId = O.OrderId
                    WHERE
                        CAST(O.OrderDate AS DATE) = CAST(GETDATE() AS DATE)
                    GROUP BY 
                        P.ProductID, P.ProductName, P.ImagePath
                    ORDER BY 
                        TotalSold DESC;";

                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    rptTopToday.DataSource = reader;
                    rptTopToday.DataBind();
                    lblNoDataRepeater1.Visible = false;
                }
                else
                {
                    lblNoDataRepeater1.Visible = true;
                }

                con.Close();
            }
        }
    }
}