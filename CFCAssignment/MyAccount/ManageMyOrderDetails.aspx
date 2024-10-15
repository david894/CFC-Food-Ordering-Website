<%@ Page Title="My Order Details" Language="C#" MasterPageFile="~/CFCUI.Master" AutoEventWireup="true" CodeBehind="ManageMyOrderDetails.aspx.cs" Inherits="CFCAssignment.MyAccount.ManageMyOrderDetails" %>
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
          padding-bottom:5%;
          height:fit-content;
          min-height:650px;
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
        .ProdTable td {
            padding: 10px;
            border-top: 1px solid #ddd;
        }
        .bgColo, .prodItem , .qtyItem {
            background-color:#FFEEEE;
            border-radius:0px;
        }
        .ProdTable .prodDetails {
            width: 60%;
        }

        .qtyItem {
            text-align:right;
        }

        .fooTxt, .qtyItem , .ttlTxt, .itemTotal{
            text-align:right;
        }
        .headTxt {
            text-align:left;
        }
        .linkBtn {
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
            padding:1%;
            border-radius:20px;
            text-decoration:none;
            color:#000000;
            margin-bottom:3%;

        }
            .linkBtn:hover {
                font-size:large;
                font-weight:bold;
                text-decoration:underline;
                text-decoration-color:#FF0000;
                text-decoration-thickness:5px;
            }
        .prodDetails {
            font-weight:normal;
            width:60%;
        }
        .order-total {
            text-align: right;
        }
    </style>
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
                <br />
                <asp:HyperLink ID="HyperLink6" runat="server" NavigateUrl="~/MyAccount/ManageMyOrder.aspx" CssClass="linkBtn">&lt; Back To Manage Order</asp:HyperLink>
                <br /><br />
            <h3 class="h1Title">Order Details</h3>
            <table style="width: 100%;">
                <tr>
                    <td>Order ID :</td>
                    <td>
                        <asp:Label ID="lblOrderID" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>Order Date :</td>
                    <td>
                        <asp:Label ID="lblOrderDate" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>Payment Details : </td>
                    <td>
                        <asp:Label ID="lblPayment" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
            <asp:GridView ID="ProdList" runat="server" AutoGenerateColumns="False" ShowFooter="True" GridLines="None" CellPadding="4"
                CssClass="ProdTable">
                <Columns>
                    <asp:TemplateField HeaderText="Product" HeaderStyle-CssClass="headTxt" ItemStyle-CssClass="prodItem">
                        <ItemTemplate>
                            <div class="prodDetails">
                                <strong><%# Eval("ProductName") %></strong>
                                <br />
                                <%# GetFormattedDescription(Eval("Description") as string) %>
                            </div>
                        </ItemTemplate>
                        <ItemStyle Width="50%" />
                    </asp:TemplateField>

                    <asp:BoundField DataField="Quantity" HeaderText="Quantity" HeaderStyle-CssClass="fooTxt" ItemStyle-CssClass="qtyItem">
                        <ItemStyle Width="10%" />
                    </asp:BoundField>

                    <asp:TemplateField HeaderText="Item Total" HeaderStyle-CssClass="ttlTxt" ItemStyle-CssClass="bgColo">
                        <ItemTemplate>
                            <div class="itemTotal">
                                <%# Eval("Quantity") %> x <%# String.Format("{0:c}", Eval("UnitPrice")) %><br />
                                <%# String.Format("{0:c}", (Convert.ToDouble(Eval("Quantity")) * Convert.ToDouble(Eval("UnitPrice")))) %>
                            </div>
                        </ItemTemplate>
                        <ItemStyle Width="30%" />
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <div class="order-total">
                <span>Subtotal: RM 
                    <asp:Label ID="lblSub" runat="server" Text=""></asp:Label></span>
                <br />
                <span>Service Tax (6%): RM 
                    <asp:Label ID="lblTax" runat="server" Text=""></asp:Label></span>
                <br />
                <span><strong>Order Total: RM 
                    <asp:Label ID="lblTotal" runat="server" Text=""></asp:Label></strong></span>
            </div>

        </div>
        
        </div>
    </div>

</asp:Content>
