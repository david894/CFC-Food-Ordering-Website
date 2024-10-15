<%@ Page Title="Checkout Canceled" Language="C#" MasterPageFile="~/CFCUI.Master" AutoEventWireup="true" CodeBehind="CheckoutCancel.aspx.cs" Inherits="CFCAssignment.CheckoutCancel" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .checkout-cancel {
            background-color:#FFFEFE;
            margin-left:5%;
            margin-right:5%;
            margin-bottom:0%;
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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="checkout-cancel">
        <asp:HyperLink ID="HyperLink1" runat="server" CssClass="button" NavigateUrl="~/menu.aspx">< Back to Menu</asp:HyperLink>
        <h1 style="margin-top:50px;">Checkout Cancelled</h1>
        <p></p>
        <h3>Your order has been cancelled.</h3>

    </div>


</asp:Content>
