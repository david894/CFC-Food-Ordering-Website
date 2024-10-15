    <%@ Page Title="Item Details" Language="C#" MasterPageFile="~/CFCUI.Master" AutoEventWireup="true" CodeBehind="ProductDetails.aspx.cs" Inherits="CFCAssignment.ProductDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .form {
            background-color:#FFFEFE;
            margin-left:5%;
            margin-right:5%;
            padding:2%;
        }
        .button {
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
            padding:1%;
            border-radius:15%;
            text-decoration:none;
            color:#000000;
            margin-bottom:3%;
        }
        .button:hover {
            font-size:large;
            font-weight:bold;
            text-decoration:underline;
            text-decoration-color:#FF0000;
            text-decoration-thickness:5px;
        }
        .itemImg {
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
            height:300px;
            border-radius:5%;
        }
        .ProductListItem {
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
            border-radius:10%;
            text-decoration:none;
            background-color:#EE0000;
            color:#FFFEFE;
            padding:10px;
        }
        .ProductListItem:hover {
            text-decoration:underline;
            text-decoration-color:#FFFEFE;
            text-decoration-thickness:3px;
        }

        .cartbtn {
            margin-top:50px;

        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <asp:FormView ID="productDetail" runat="server" ItemType="CFCAssignment.Models.Product" SelectMethod ="GetProduct" RenderOuterTable="false">
        <ItemTemplate>
            <div class="form">
                <asp:HyperLink ID="HyperLink1" runat="server" CssClass="button" NavigateUrl="~/menu.aspx">< Back to Menu</asp:HyperLink>
                <br /><br />
                <h1><%#:Item.ProductName %></h1>
                <br />
                <table>
                    <tr>
                        <td>
                            <img src="/Catalog/Images/Thumbs/<%#:Item.ImagePath %>" class="itemImg" alt="<%#:Item.ProductName %>"/>
                        </td>
                        <td>&nbsp;</td>  
                        <td style="vertical-align: top; text-align:left; padding-left:50px;">
                            <b>Description:</b><br /><%# GetFormattedDescription(Item.Description) %><br /><br />
                            <span><b>Price:</b>&nbsp;<%#: String.Format("{0:c}", Item.UnitPrice) %></span><br />
                            <div class="cartbtn">
                                <a href="/AddToCart.aspx?productID=<%#:Item.ProductID %>" style="text-decoration:none;">               
                                    <span class="ProductListItem">
                                        <b>Add To Cart<b>
                                    </span>           
                                </a>
                            </div>    

                        </td>
                    </tr>
                </table>
            </div>

        </ItemTemplate>
        </asp:FormView>
    </div>
    
</asp:Content>
