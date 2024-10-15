<%@ Page Title="Edit Product Details" Language="C#" MasterPageFile="~/Maintenance/Admin.Master" AutoEventWireup="true" CodeBehind="AdminProductEdit.aspx.cs" Inherits="CFCAssignment.Maintenance.AdminProductEdit" %>
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

            .h1Title {
                text-align:left;
            }
                    .h1Title {
                text-align:left;
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
            .prodImg {
                width: 150px;
                height: 150px;
                border-radius: 5px;
            }
            .Addbutton {
                width: 200px;
                padding: 10px;
                margin: 5px 1%;
                border-radius: 10px;
                border: none;
                font-size: 16px;
                background-color: #FF0000;
                color: white;
                cursor: pointer; 
                margin-right:100px;
            }
            .Addbutton:hover {
                background-color: #e60000;

            }
            .lblstat {
                   color: #FF0000;
                   font-weight:bold;
            }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="center-container">
        <br />
        <asp:HyperLink ID="HyperLink6" runat="server" NavigateUrl="~/Maintenance/AdminProduct.aspx" CssClass="linkBtn">&lt; Back To Manage Product</asp:HyperLink>
        <br /><br />
        <h3 class="h1Title">Edit Product Details</h3>
        <asp:Label ID="lblStatus" runat="server" CssClass="lblstat"></asp:Label><br />

        <table>
            <tr>
                <td class="auto-style2">Product :</td>
                <td class="auto-style4">
                    <asp:Label ID="prodName" runat="server" Text=""></asp:Label>
                    <asp:Image ID="prodImg" runat="server" CssClass="prodImg"/>
                </td>
                <td class="auto-style3">&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style2">&nbsp;</td>
                <td class="auto-style4">
                    &nbsp;</td>
                <td class="auto-style3">&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style2">Product Name :</td>
                <td class="auto-style4">
                    <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
                </td>
                <td class="auto-style3">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName" ErrorMessage="Name is Required" ForeColor="Red">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style1">Description :</td>
                <td class="auto-style5">
                    <asp:TextBox ID="txtDescription" runat="server"></asp:TextBox>
                </td>
                <td class="auto-style6">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDescription" ErrorMessage="Description is Required" ForeColor="Red">*</asp:RequiredFieldValidator>
                </td>
            </tr>
                <tr>
                    <td class="auto-style1">Unit Price :</td>
                    <td class="auto-style5">
                        <asp:TextBox ID="txtPrice" runat="server" ValidationGroup="AddProductValidation"></asp:TextBox>
                    </td>
                    <td class="auto-style6">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                            ErrorMessage="Price is Required" 
                            ForeColor="Red" 
                            ControlToValidate="txtPrice" 
                            ValidationGroup="AddProductValidation">*</asp:RequiredFieldValidator>
                         <!-- Regular expression validator to allow only double values -->
                        <asp:RegularExpressionValidator ID="revPrice" runat="server"
                            ErrorMessage="Please enter a valid price (e.g. 10.99)" 
                            ForeColor="Red" 
                            ControlToValidate="txtPrice"
                            ValidationExpression="^\d+(\.\d{1,2})?$" 
                            ValidationGroup="AddProductValidation">*</asp:RegularExpressionValidator>
                    </td>
                </tr>
            <tr>
                <td class="auto-style1">Quantity :</td>
                <td class="auto-style5">
                    <asp:TextBox ID="txtQty" runat="server" ValidationGroup="AddQtyValidation" TextMode="Number"></asp:TextBox>
                </td>
                <td class="auto-style6">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                        ErrorMessage="Quantity is Required" 
                        ForeColor="Red" 
                        ControlToValidate="txtQty" 
                        ValidationGroup="AddQtyValidation">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style1">Category :</td>
                <td class="auto-style5">
                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="CategoryName" DataValueField="CategoryID">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CFC %>" SelectCommand="SELECT * FROM [Categories]"></asp:SqlDataSource>
                </td>
                <td class="auto-style6">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="DropDownList1" ErrorMessage="Category is Required" ForeColor="Red">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style1">&nbsp;</td>
                <td class="auto-style5">
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />
                </td>
                <td class="auto-style6">&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style1">&nbsp;</td>
                <td class="auto-style5">
                    <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click" CssClass="Addbutton"/>
                </td>
                <td class="auto-style6">&nbsp;</td>
            </tr>
        </table>
    </div>
</asp:Content>
