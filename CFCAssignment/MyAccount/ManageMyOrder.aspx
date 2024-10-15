<%@ Page Title="My Order" Language="C#" MasterPageFile="~/CFCUI.Master" AutoEventWireup="true" CodeBehind="ManageMyOrder.aspx.cs" Inherits="CFCAssignment.MyAccount.ManageMyOrder" %>
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

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 10px; 
        }

        td {
            padding: 10px;
            border-radius: 10px; 
            font-size: 16px;
            width: 30%; 
        }

        td:first-child {
            font-weight: bold;
            width: 15%; 
        }

        td a {
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
        }

        td a:hover {
            color: #0056b3; 
        }

        .spacer {
            width: 30%;
        }
        .logout-button {
            width:120px;
            padding: 10px;
            border-radius:10%;
            background-color: red;
            color: white;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            text-align: center;
            font-size: 16px;
            margin-top: 20px;
        }
        .logout-button:hover {
            background-color: darkred;
        }
        .auto-style1 {
            width: 3%;
        }
        .logout {
            text-align:center;
        }
        .h1Title {
            text-align:left;
        }
                .h1Title {
            text-align:left;
        }
        .ManagePD{
          background-color:#FFFEFE;
          margin-left:5%;
          margin-right:5%;
          padding:2%;
          height:fit-content;
          min-height:650px;
          padding-bottom:5%;
          margin-bottom:0px;
          }
          .PDmenu {
              position:absolute;
              width:200px;
              box-shadow: 0px 4px 8px 0px rgba(0, 0, 0, 0.2);
              height:250px;
              padding-top:30px;
              text-align:center;
          }
          .PDbutton {
              padding:5%;
              margin-bottom:5%;
              text-decoration:none;
              color:black;
          }
          .PDLayout {
               margin-left:250px;
          }
          .PDbutton:hover {
              text-decoration:underline;
              text-decoration-color:black;
              text-decoration-thickness:5px;
              font-weight:bold;
          }
        .headtxt {
            text-align:left;
        }
        .table{
            border-bottom: 1px solid #ddd;

        }
        .table td {
            padding: 10px;
            border-top: 1px solid #ddd;
        }
        .bgColo {
            background-color:#FFEEEE;
            border-radius:0px;
        }
        .select-button {
            background-color: #ff0000;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            text-transform: uppercase;
            margin: 5px 0;
            border-radius:5px;
        }
            .select-button:hover {
                background-color: #dd0000;
                text-decoration:underline;
                text-decoration-color:#FFFFFF;
            }
            .datePicker {
                width: 150px;
                padding: 5px;
                font-size: 14px;
                cursor: pointer;
            }

            .calendarStyle, .RcalendarStyle {
                position: absolute;
                z-index: 1000;
                background-color: white;
                border: 1px solid #ccc;
                width:300px;
                margin-top:-30px;
            }
            .RcalendarStyle  {
                z-index:1100;
               
            }
            .dateRangeContainer {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .dateRangeContainer > div {
                display: flex;
                flex-direction: column;
            }

            .datePicker {
                width: 160px; /* Adjust width as needed */
                padding: 5px;
                font-size: 14px;
                cursor: pointer;
            }

            .calendarStyle, .RcalendarStyle {
                position: absolute;
                z-index: 1000;
                background-color: white;
                border: 1px solid #ccc;
                width: 160px;
                margin-top: -30px;
            }
        .lblDate {
            color:#FF0000;
            font-weight:bold;
        }
            .RcalendarStyle {
                z-index: 1100;
            }
        .lCal, .rCal {
            margin-top:50px;
        }
    </style>
    <script type="text/javascript">
    function toggleCalendarVisibility(calendarId) {
        function toggleCalendarVisibility(calendarId) {
            // Hide all calendars
            var calendars = ['calStartDate', 'calEndDate'];
            for (var i = 0; i < calendars.length; i++) {
                if (calendars[i] !== calendarId) {
                    document.getElementById(calendars[i]).style.display == 'none';
                }
            }

            // Toggle the selected calendar
            var calendar = document.getElementById(calendarId);
            calendar.style.display = calendar.style.display === 'none' || calendar.style.display === '' ? 'block' : 'none';
        }
    }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="ManagePD">
    <h1>User Page</h1>
    <hr />
    <div class="PDmenu" id="PDmenu" runat="server" >
        <asp:HyperLink ID="HyperLink1" runat="server" CssClass="PDbutton" NavigateUrl="~/MyAccount/MyAccount.aspx">My Profile</asp:HyperLink><br /><br />
        <asp:HyperLink ID="HyperLink2" runat="server" CssClass="PDbutton" NavigateUrl="~/MyAccount/ManageMyOrder.aspx">Manage My Order</asp:HyperLink><br /><br />
        <asp:HyperLink ID="HyperLink3" runat="server" CssClass="PDbutton" NavigateUrl="~/MyAccount/ChangePassword.aspx">Change Password</asp:HyperLink><br /><br />
        <asp:HyperLink ID="HyperLink4" runat="server" CssClass="PDbutton" NavigateUrl="~/MyAccount/SetSecurityInfo.aspx">Set Security Question</asp:HyperLink><br /><br />

        <asp:Button ID="Logout" runat="server" NavigateUrl="~/home.aspx" CssClass="logout-button" Text="Logout" OnClick="Logout_Click" />

    </div>

      <div class="PDLayout">
          <div class="center-container">
          <h3 class="h1Title">Manage My Order</h3>
              <h3>Select Payment Method : <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                  <asp:ListItem>Card</asp:ListItem>
                  <asp:ListItem>Cash</asp:ListItem>
                  <asp:ListItem>PayPal</asp:ListItem>
                  </asp:DropDownList>
          </h3>
          <div class="dateRangeContainer">
              <h3>Select Date Range:</h3>
              <div>
                  <label for="txtStartDate">From:</label>
                  <asp:TextBox ID="txtStartDate" runat="server" CssClass="datePicker" ReadOnly="True" OnFocus="toggleCalendarVisibility('calStartDate')" AutoPostBack="True" />
                  <asp:Button ID="btnStartCalendar" runat="server" Text="▼" OnClick="btnStartCalendar_Click" />
                  <div class="lCal">
                      <asp:Calendar ID="calStartDate" runat="server" OnSelectionChanged="calStartDate_SelectionChanged" Visible="False" CssClass="calendarStyle" />
                  </div>
              </div>
              <div>
                  <label for="txtEndDate">To:</label>
                  <asp:TextBox ID="txtEndDate" runat="server" CssClass="datePicker" ReadOnly="True" OnFocus="toggleCalendarVisibility('calEndDate')" AutoPostBack="True" />
                  <asp:Button ID="btnEndCalendar" runat="server" Text="▼" OnClick="btnEndCalendar_Click" />
                  <div class="rCal">
                      <asp:Calendar ID="calEndDate" runat="server" OnSelectionChanged="calEndDate_SelectionChanged" Visible="False" CssClass="RcalendarStyle" />
                  </div>
              </div>
              <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="select-button" OnClick="btnSearch_Click" /> <br />
              <br />
              <asp:Label ID="lblDateError" runat="server" Text="" CssClass="lblDate"></asp:Label>
          </div>


               <asp:GridView ID="GridViewOrders" runat="server" AutoGenerateColumns="False" GridLines="None" 
                  EmptyDataText="No Orders Found" CssClass="table" OnSelectedIndexChanged="GridViewOrders_SelectedIndexChanged" DataKeyNames="OrderId">
                  <Columns>
                      <asp:BoundField DataField="OrderId" HeaderText="Order ID" HeaderStyle-CssClass="headtxt" ItemStyle-CssClass="bgColo"/>
                      <asp:BoundField DataField="OrderDate" HeaderText="Order Date" HeaderStyle-CssClass="headtxt" ItemStyle-CssClass="bgColo"
                          DataFormatString="{0:dd/MM/yyyy, HH:mm}" />
                      <asp:BoundField DataField="Total" HeaderText="Order Amount" HeaderStyle-CssClass="headtxt" ItemStyle-CssClass="bgColo"
                          DataFormatString="{0:C}" />
                      <asp:TemplateField HeaderText="Payment Method" HeaderStyle-CssClass="headtxt" ItemStyle-CssClass="bgColo">
                          <ItemTemplate>
                              <%# Eval("PaymentType").ToString() == "Cash" ? "Cash" :Eval("PaymentType").ToString() == "PayPal" ? "PayPal" : Eval("PaymentType")+ " ["+ Eval("PaymentCard") + "]" %>
                          </ItemTemplate>
                      </asp:TemplateField>                   
                       <asp:TemplateField ItemStyle-CssClass="bgColo">
                          <ItemTemplate>
                              <asp:Button ID="SelectButton" runat="server" Text="Select" CommandName="Select" CssClass="select-button" />
                          </ItemTemplate>
                      </asp:TemplateField>
                  </Columns>
              </asp:GridView>
      </div>
      </div>
  </div>
</asp:Content>
