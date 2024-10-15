<%@ Page Title="Cart" Language="C#" MasterPageFile="~/CFCUI.Master" AutoEventWireup="true" CodeBehind="ShoppingCart.aspx.cs" Inherits="CFCAssignment.ShoppingCart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style type="text/css">
        .cartform {
            background-color: #FFFEFE;
            margin-left: 5%;
            margin-right: 5%;
            padding: 2%;
        }
        .orderTable {
            width: 90%;
            border-collapse: collapse;
        }
        .cartTable {
            width: 90%;
            border-bottom: 1px solid #ddd;
            margin-bottom: 20px;
            margin-left:auto;
            margin-right:auto;
        }
        .cartTable td {
            padding: 10px;
            border-top: 1px solid #ddd;
        }
        .cartTable .itemDetails {
            width: 60%;
        }
        .cartTable .itemTotal, .cartTable .removeItem {
            text-align: right;
        }
        .summarySection {
            width: 90%;
            margin-top: 20px;
            text-align: right;
            margin-left:auto;
            margin-right:auto;
        }
        .summarySection .totalAmount {
            font-weight: bold;
            font-size: 1.2em;
        }
        .btn {
            background-color: #ff0000;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            font-size: 1em;
            text-transform: uppercase;
            margin: 5px 0;
            border-radius:20px;
        }
        .btn:hover {
            background-color: #e60000;
        }
        .headTxt {
            text-align:left;
        }
        .ttlTxt {
            text-align:right;
        }
        .cartPrint {
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
            padding:2%;
            border-radius:30px;
        }
        .removeBtn {
            color:#FF0000;
            padding:10px;
            border-radius:20px;
        }
            .removeBtn:hover {
                background-color:#EE0000;
                color:#FFFFFF;
                text-decoration-color:#FFFFFF;
                text-decoration-thickness:3px;
            }
        .quantity-controls {
            display: flex;
            float:right;
        }

        .quantityTextBox {
            width: 40px;
            text-align: center;
            margin: 0 10px;
        }
        .cartTable .quantity-controls {
            text-align:right;
        }
        .qtyTxt {
            text-align:right;
            padding-right:2%;
        }
        .bgColo {
            background-color:#FFEEEE;

        }
        .error {
            color:#FF0000;
            font-weight:bold;
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="ShoppingCartTitle" runat="server" class="cartform">
        <h1 style="text-align:center;">Shopping Cart</h1>
        <div class="cartPrint">
            <asp:Label ID="lblError" runat="server" Text="" CssClass="error"></asp:Label>
            <asp:GridView ID="CartList" runat="server" AutoGenerateColumns="False" ShowFooter="True" GridLines="None" CellPadding="4"
            ItemType="CFCAssignment.Models.CartItem" SelectMethod="GetShoppingCartItems" 
            CssClass="cartTable">
            <Columns>
                <asp:TemplateField HeaderText="Product" HeaderStyle-CssClass="headTxt" ItemStyle-CssClass="bgColo">
                    <ItemTemplate>
                            <div class="itemDetails">
                                <strong><%#: Item.Product.ProductName %></strong><br />
                                <%# GetFormattedDescription(Item.Product.Description) %>
                                <br /><br />
                                <asp:LinkButton ID="RemoveItem" runat="server" CommandArgument='<%# Eval("ProductID") %>' 
                                    Text="Remove" OnClick="RemoveItem_Click" CssClass="removeBtn"></asp:LinkButton>
                            </div>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Quantity" HeaderStyle-CssClass="qtyTxt" ItemStyle-CssClass="bgColo">
                    <ItemTemplate>
                        <div class="quantity-controls">
                            <%-- Decrement Button --%>
                            <asp:Button ID="DecrementButton" runat="server" Text="-" OnClick="DecrementQuantity_Click"
                                CommandArgument='<%# Eval("ProductID") %>' Visible='<%# Item.Quantity > 1 %>' />

                            <%-- Quantity Textbox --%>
                            <asp:TextBox ID="QuantityTextBox" runat="server" Text='<%# Eval("Quantity") %>' 
                                CssClass="quantityTextBox" ReadOnly="true" />

                            <%-- Increment Button --%>
                            <asp:Button ID="IncrementButton" runat="server" Text="+" OnClick="IncrementQuantity_Click"
                                CommandArgument='<%# Eval("ProductID") %>' />
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Item Total" HeaderStyle-CssClass="ttlTxt" ItemStyle-CssClass="bgColo">
                    <ItemTemplate>
                        <div class="itemTotal">
                            <%#: Item.Quantity %> x <%#: String.Format("{0:c}", Item.Product.UnitPrice) %><br />
                            <%#: String.Format("{0:c}", ((Convert.ToDouble(Item.Quantity)) *  Convert.ToDouble(Item.Product.UnitPrice)))%>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:Label ID="lblempty" runat="server" Text="" CssClass="emptyCartMessage"></asp:Label>

        <div class="summarySection">
            <asp:Label ID="LabelSubTotalText" runat="server" Text="Subtotal: " Visible="false"></asp:Label><asp:Label ID="lblSubtotal" runat="server" Text="RM 0.00"></asp:Label><br />
            <asp:Label ID="LabelTax" runat="server" Text="Service Tax (6%): " Visible="false"></asp:Label><asp:Label ID="lblTax" runat="server" Text="RM 0.00"></asp:Label><br />
            <asp:Label ID="LabelTotalText" runat="server" Text="Total (incl. SST): " Visible="false"></asp:Label><asp:Label ID="lblTotal" runat="server" CssClass="totalAmount" Text="RM 0.00"></asp:Label>
        </div>
            <div style="text-align:center;">
                <asp:Button ID="CheckoutBtn" runat="server" CssClass="btn" Text="Proceed to Checkout" OnClick="CheckoutBtn_Click" />
            </div>
        
    </div>
        </div>

</asp:Content>

