<%@ Page Title="Menu" Language="C#" MasterPageFile="~/CFCUI.Master" AutoEventWireup="true" CodeBehind="menu.aspx.cs" Inherits="CFCAssignment.menu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .menuimg{
            margin:-3px;
            height:20vh;
            width:26vh;
            border-radius: 5%;

        }
        .menu a:hover {
            font-size:larger;
        }
        a{
            text-decoration:none;
            color:#000000;
        }
        .menu {
            background-color:#FFFFFF;
            text-align:center;
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
            border-radius: 5%; 
            margin:1%;
            margin-bottom:5%;
        }
        .itemContainer {
            margin-left:auto;
            margin-right:auto;
            margin-top:2%;
            width:75%;
            text-align:center;
            background-color:#FFFEFE;

        }
        .intromenu {
            font-family: "Eras Demi ITC";
            font-size: x-large;
            font-weight: bold;
            font-style: normal;
            padding:2%;
            text-align:center;

        }
        .introMenuContainer {
            width:100%;
            text-align:center;

        }
        .catMenu {
            width:98%;
            text-align: center; 
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
            padding:1%;
            background-color:#FFFEFE;
        }
        .catControl {
            font-size: large; 
            font-style: normal; 
            padding:2%;
        }
        .catControl a:hover {
            text-decoration:underline; 
            text-decoration-color:red;
            font-size:larger;
            font-weight:bold;
            text-decoration-thickness:5px;

        }
        .mainmenu {
            background-color:#FFFEFE;
            margin-left:5%;
            margin-right:5%;
            margin-bottom:0%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="mainmenu">
            <p class="auto-style1">               
                &nbsp;</p>
            <p class="introMenuContainer">               
                <strong class="intromenu">MENU</strong></p>
        <div id="CategoryMenu" class="catMenu">       
            <asp:ListView ID="categoryList"  
                ItemType="CFCAssignment.Models.Category" 
                runat="server"
                SelectMethod="GetCategories" >
                <ItemTemplate>
                    <b class="catControl">
                        <a href="/menu.aspx?id=<%#: Item.CategoryID %>">
                        <%#: Item.CategoryName %>
                        </a>
                    </b>
                </ItemTemplate>
                <ItemSeparatorTemplate>  |  </ItemSeparatorTemplate>
            </asp:ListView>
        </div>
        <section>
        <div>
            <asp:ListView ID="productList" runat="server" 
            DataKeyNames="ProductID" GroupItemCount="4"
            ItemType="CFCAssignment.Models.Product" SelectMethod="GetProducts">
            <EmptyDataTemplate>
                <table >
                    <tr>
                        <td>No data was returned.</td>
                    </tr>
                </table>
            </EmptyDataTemplate>
            <EmptyItemTemplate>
                <td/>
            </EmptyItemTemplate>
            <GroupTemplate>
                <tr id="itemPlaceholderContainer" runat="server">
                    <td id="itemPlaceholder" runat="server"></td>
                </tr>
            </GroupTemplate>
                    <ItemTemplate>
                        <td runat="server">
                            <table class="menu">
                                <tr>
                                    <td>
                                        <a href="ProductDetails.aspx?productID=<%#:Item.ProductID%>">
                                            <img src="/Catalog/Images/Thumbs/<%#:Item.ImagePath%>"
                                                width="100" height="75" class="menuimg" /></a>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <a href="ProductDetails.aspx?productID=<%#:Item.ProductID%>">
                                            <span>
                                                <b><%#:Item.ProductName %></b>
                                            </span>
                                        </a>
                                        <br />
                                        <span>
                                            <b><br /></b><%#:String.Format("{0:c}", Item.UnitPrice)%>
                                        </span>
                                        <br />
                                    </td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                </tr>
                            </table>
                            </p>
                        </td>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <table class="itemContainer">
                            <tbody>
                                <tr>
                                    <td>
                                        <table id="groupPlaceholderContainer" runat="server" style="width:100%;">
                                            <tr id="groupPlaceholder"></tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                </tr>
                                <tr></tr>
                            </tbody>
                        </table>
                    </LayoutTemplate>
                </asp:ListView>
            </div>
        </section>
    </div>
            
</asp:Content>
