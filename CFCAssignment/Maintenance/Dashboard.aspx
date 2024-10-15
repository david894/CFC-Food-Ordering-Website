<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/Maintenance/Admin.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="CFCAssignment.Maintenance.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <style type="text/css">
        .center-container {
            background-color: #FFFEFE;
            margin-left: 5%;
            margin-right: 5%;
        }

        .title {
            font-weight: bold;
            font-size: 24px;
            padding-bottom: 20px;
            width: 100%;
        }
        
        .h1Title {
            text-align:left;
        }
       
        .headtxt {
            text-align:left;
        }
         .dashboard-container {
            background-color: #FFFEFE;
            margin: 0 5%;
            padding: 2%;
        }

        .dashboard-header {
            font-weight: bold;
            font-size: 24px;
            padding-bottom: 20px;
            width: 100%;
        }

        .stats-container {
            display: flex;
            justify-content: space-between;
            margin-bottom: 30px;
        }

        .stat-box {
            width: 30%;
            background-color: #FFFFFF;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0px 4px 8px 0px rgba(0, 0, 0, 0.2);
            text-align: center;
            margin:3%;
        }

        .stat-value {
            font-size: 32px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .stat-percentage {
            font-size: 18px;
            font-weight: bold;
        }

        .percentage-increase {
            color: green;
        }

        .percentage-decrease {
            color: red;
        }
        .graph {
            text-align:center;
            padding:1%;
            margin:1%;
            box-shadow: 0px 4px 8px 0px rgba(0, 0, 0, 0.2);
        }
        .product-box {
            display: flex;
            align-items: center;
            margin: 10px;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            width:90%;
            text-align:center;
        }

        .product-image img {
            width: 80px;
            height: 80px;
            border-radius: 50%;
        }

        .product-info {
            width:500px;
            margin-left: 20px;
        }

        .product-info h2 {
            margin: 0;
            font-size: 24px;
            font-weight: bold;
        }

        .product-info p {
            margin: 5px 0 0 0;
            font-size: 16px;
        }
        .product-rank {
            font-size: 24px;
            font-weight: bold;
            color: black;
            margin-right: 15px;
        }
        .topSell {
            width:40%;
            margin-right:2%;
        }
        .graphContainer {
            display: flex;
            justify-content: space-between;
            margin-bottom: 30px;
            box-shadow: 0px 4px 8px 0px rgba(0, 0, 0, 0.2);
            padding:2%;

        }
        .Lgraph {
            width:60%;
        }
        .graphW {
            width:100%;
        }
        .no-data-label {
            color: red;
            font-weight: bold;
            text-align: center;
            display: block;
            margin: 20px 0;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2 class="h1Title">Admin Dahboard</h2>
    <h3>
        <asp:Label ID="lblDate" runat="server" Text=""></asp:Label>
    </h3>
    <div class="stats-container">
        <div class="stat-box">
            <h3>Total Sales Today</h3>
            <asp:Label ID="lblDailySales" runat="server" Text="RM 0.00"></asp:Label>
            <br />(
            <asp:Label ID="lblDailyChange" runat="server" Text="0.00%" ForeColor="Green"></asp:Label>)
        </div>
        <div class="stat-box">
            <h3>Total Sales This Week</h3>
            <asp:Label ID="lblWeeklySales" runat="server" Text="RM 0.00"></asp:Label>
            <br />(
            <asp:Label ID="lblWeeklyChange" runat="server" Text="0.00%" ForeColor="Green"></asp:Label>)
        </div>
        <div class="stat-box">
             <h3>Total Sales This Month</h3>
            <asp:Label ID="lblMonthlySales" runat="server" Text="RM 0.00"></asp:Label>
            <br />(
            <asp:Label ID="lblMonthlyChange" runat="server" Text="0.00%" ForeColor="Green"></asp:Label>)
        </div>
    </div>
     <div class="graphContainer">
         <div class="Lgraph">
             <h2>Hourly Sales Histogram For Today</h2>
            <asp:Label ID="lblNoDataChart1" runat="server" Text="No Data" Visible="False" CssClass="no-data-label"></asp:Label>
            <asp:Chart ID="Chart1" runat="server" Width="600px" Height="400px" CssClass="graphW">
                <Series>
                    <asp:Series Name="Sales" ChartType="Column" XValueMember="Hour" YValueMembers="TotalSales" />
                </Series>
                <ChartAreas>
                    <asp:ChartArea Name="ChartArea1">
                        <AxisX Title="Hour of Day" Interval="1" LineColor="Transparent">
                            <MajorGrid LineColor="Transparent" />
                            <MinorGrid LineColor="Transparent" />
                            <MajorTickMark LineColor="Transparent" />
                            <MinorTickMark LineColor="Transparent" />
                        </AxisX>
                        <AxisY Title="Total Sales (RM)" LineColor="Transparent">
                            <MajorGrid LineColor="Transparent" />
                            <MinorGrid LineColor="Transparent" />
                            <MajorTickMark LineColor="Transparent" />
                            <MinorTickMark LineColor="Transparent" />
                        </AxisY>
                    </asp:ChartArea>
                </ChartAreas>
            </asp:Chart>
         </div>
         <div class="topSell">
             <h2>Top Selling Product of Today</h2>
             <asp:Label ID="lblNoDataRepeater1" runat="server" Text="No Data" Visible="False" CssClass="no-data-label"></asp:Label>
             <asp:Repeater ID="rptTopToday" runat="server">
                 <ItemTemplate>
                     <div class="product-box" style="background-color: <%# Container.ItemIndex == 0 ? "#FFE993" : (Container.ItemIndex == 1 ? "#E1E1E1" : "#D2B48C") %>;">
                         <div class="product-rank">
                             <span>Top <%# Container.ItemIndex + 1 %></span>
                         </div>
                         <div class="product-image">
                             <img src="/Catalog/Images/Thumbs/<%# Eval("ImagePath") %>" alt="<%# Eval("ProductName") %>" />
                         </div>
                         <div class="product-info">
                             <h2><%# Eval("ProductName") %></h2>
                             <p><%# Eval("TotalSold") %> Items Sold!</p>
                         </div>
                     </div>
                 </ItemTemplate>
             </asp:Repeater>
         </div>
     </div>
    <br />
    <div class="graphContainer">
        <div class="Lgraph">
            <h2>Weekly Sales Line Graph For This Week</h2>
            <asp:Label ID="lblNoDataChart2" runat="server" Text="No Data" Visible="False" CssClass="no-data-label"></asp:Label>
            <asp:Chart ID="Chart2" runat="server" Width="600px" Height="400px" CssClass="graphW">
                <Series>
                    <asp:Series Name="DailySales" ChartType="Line" XValueMember="DayOfWeek" YValueMembers="TotalSales" />
                </Series>
                <ChartAreas>
                    <asp:ChartArea Name="ChartArea2">
                        <AxisX Title="Day of Week" Interval="1" LineColor="Transparent">
                            <MajorGrid LineColor="Transparent" />
                            <MinorGrid LineColor="Transparent" />
                            <MajorTickMark LineColor="Transparent" />
                            <MinorTickMark LineColor="Transparent" />
                        </AxisX>
                        <AxisY Title="Total Sales (RM)" LineColor="Transparent">
                            <MajorGrid LineColor="Transparent" />
                            <MinorGrid LineColor="Transparent" />
                            <MajorTickMark LineColor="Transparent" />
                            <MinorTickMark LineColor="Transparent" />
                        </AxisY>
                    </asp:ChartArea>
                </ChartAreas>
            </asp:Chart>
        </div>
        <div class="topSell">
            <h2>Top Selling Product of All Time</h2>
            <asp:Label ID="lblNoDataRepeater2" runat="server" Text="No Data" Visible="False" CssClass="no-data-label"></asp:Label>
            <asp:Repeater ID="rptTopSellingProducts" runat="server">
                <ItemTemplate>
                    <div class="product-box" style="background-color: <%# Container.ItemIndex == 0 ? "#FFE993" : (Container.ItemIndex == 1 ? "#E1E1E1" : "#D2B48C") %>;">
                        <div class="product-rank">
                            <span>Top <%# Container.ItemIndex + 1 %></span>
                        </div>
                        <div class="product-image">
                            <img src="/Catalog/Images/Thumbs/<%# Eval("ImagePath") %>" alt="<%# Eval("ProductName") %>" />
                        </div>
                        <div class="product-info">
                            <h2><%# Eval("ProductName") %></h2>
                            <p><%# Eval("TotalSold") %> Items Sold!</p>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>   
</asp:Content>
