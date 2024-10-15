<%@ Page Title="Order Complete!" Language="C#" MasterPageFile="~/CFCUI.Master" AutoEventWireup="true" CodeBehind="CheckoutComplete.aspx.cs" Inherits="CFCAssignment.CheckoutComplete" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .complete {
            background-color:#FFFEFE;
            margin-left:5%;
            margin-right:5%;
            padding:2%;
            text-align:center;
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
    <div class="complete">
        <h1>Thank You!</h1>
        <h1>Your Order has been submitted</h1>
        <hr />
        <h3>Your Order Number is</h3>
        <h1><asp:Label ID="lblOrderNo" runat="server"></asp:Label></h1>
        <h3>Order Amount: RM
            <asp:Label ID="lblAmmount" runat="server"></asp:Label>
        </h3>
        <h3 style="margin-bottom:100px;">Payment Method:
            <asp:Label ID="lblPayment" runat="server"></asp:Label>
        </h3>
        <asp:HyperLink ID="HyperLink1" runat="server" CssClass="button" NavigateUrl="~/menu.aspx">Continue to Order ></asp:HyperLink>

    </div>
</asp:Content>
