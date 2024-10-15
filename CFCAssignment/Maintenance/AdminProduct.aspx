<%@ Page Title="Manage Product" Language="C#" MasterPageFile="~/Maintenance/Admin.Master" AutoEventWireup="true" CodeBehind="AdminProduct.aspx.cs" Inherits="CFCAssignment.Maintenance.AdminProduct" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
            <style type="text/css">
        .center-container {
            background-color: #FFFEFE;
            margin-left: 5%;
            margin-right: 5%;
        }
        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 10px;
            text-align: left;
        }
        td {
            padding: 10px;
            background-color: #FFFEFE;
            border-radius: 10px;
            text-align: left;
        }
        td:first-child {
            font-weight: bold;
            text-align: right;
            width: 20%;
        }
        td:nth-child(2) {
            width: 80%;
        }
        td:last-child {
            text-align: left;
        }
        button, input[type="button"], input[type="submit"], .aspButton {
            background-color: #FF0000;
            color: white;
            border: none;
            border-radius: 50px;
            padding: 10px 20px;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        button:hover, input[type="button"]:hover, input[type="submit"]:hover, .aspButton:hover {
            background-color: #cc0000;
        }

        .input-field {
            width: 80%;
            padding: 10px;
            border-radius: 10px;
            border: 1px solid #ccc;
            font-size: 16px;
        }
        .error-message {
            color: red;
            font-size: 16px;
            margin-bottom: 5px;
            display: block;
        }
        .submit-button {
            width: 100px;
            padding: 10px;
            margin: 5px 1%;
            border-radius: 10px;
            border: none;
            font-size: 16px;
            background-color: #FF0000;
            color: white;
            cursor: pointer;
        }
        .submit-button:hover {
            background-color: #e60000;
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
        .headtxt {
            text-align:left;
        }
        .Editbutton {
            width: 120px;
            padding: 10px;
            margin: 5px 1%;
            border-radius: 10px;
            border: none;
            font-size: 16px;
            background-color: #FF0000;
            color: white;
            cursor: pointer;
        }
        .Editbutton:hover {
            background-color: #e60000;

        }
        .imgProd {
            width: 80px;
            height: 80px;
            border-radius: 50%;
        }
        .IMGbgColo {
            width:100px;     
            background-color:#FFEEEE;
            border-radius:0px;
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
                .auto-style1 {
            width: 130px;
        }
        .auto-style2 {
            width: 130px;
            height: 23px;
        }
        .auto-style3 {
            height: 23px;
            width: 582px;
        }
        .auto-style4 {
            height: 23px;
            width: 91px;
        }
        .auto-style5 {
                    width: 91px;
                    font-size:large;
                    font-weight:bold;
                }
        .auto-style6 {
            width: 582px;
        }
        .buttonD {
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
            padding:10px;
            border-radius:10px;
            text-decoration:none;
            color:#000000;
            margin-bottom:3%;
            margin:2%;
            padding-left:20px;
            padding-right:20px;
            background-color:#FFFFFF;

        }
        .buttonD:hover {
            font-weight:bold;
            text-decoration:underline;
            text-decoration-color:#FF0000;
            text-decoration-thickness:5px;
        }
        .upButton {

        }
        .upButton:hover {


        }
        .lblstat {
               color: #FF0000;
               font-weight:bold;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="center-container">
        <h3 class="h1Title">Manage Product</h3>
        <asp:Panel ID="prodName" runat="server" Visible="true" DefaultButton="btnCheckProdName">
            <div class="form-group">
                <asp:RequiredFieldValidator ID="ProdNameRequired" runat="server" 
                    ControlToValidate="txtProdName" 
                    ErrorMessage="Product Name is required." 
                    CssClass="error-message" 
                    Display="Dynamic"
                    ValidationGroup="SearchValidation"></asp:RequiredFieldValidator><br />                
                <asp:TextBox ID="txtProdName" runat="server" onEn CssClass="input-field" Placeholder="Enter Product Name to Search..."></asp:TextBox>
                <asp:Button ID="btnCheckProdName" runat="server" CssClass="submit-button" Text="Search" OnClick="btnCheckProdName_Click" ValidationGroup="SearchValidation" />
            </div>
        </asp:Panel>
        <asp:Button ID="Button1" runat="server" CssClass="Addbutton" Text="+ Add New Product" OnClick="Button1_Click" />
        <asp:Button ID="Button2" runat="server" CssClass="Addbutton" Text= "Reactivate Product" OnClick="Button2_Click" />

        <br /><br />
        <asp:Label ID="lblStatus" runat="server" CssClass="lblstat"></asp:Label>
        <br /><br />
        <div id="addProd" runat="server" visible="false">
            <h3>Add New Product</h3>
            <table>
                <tr>
                    <td class="auto-style2">Product Name :</td>
                    <td class="auto-style4">
                        <asp:TextBox ID="txtName" runat="server" ValidationGroup="AddProductValidation"></asp:TextBox>
                    </td>
                    <td class="auto-style3">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                            ErrorMessage="Name is Required" 
                            ForeColor="Red" 
                            ControlToValidate="txtName" 
                            ValidationGroup="AddProductValidation">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">Description :</td>
                    <td class="auto-style5">
                        <asp:TextBox ID="txtDescription" runat="server" ValidationGroup="AddProductValidation"></asp:TextBox>
                    </td>
                    <td class="auto-style6">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                            ErrorMessage="Description is Required" 
                            ForeColor="Red" 
                            ControlToValidate="txtDescription" 
                            ValidationGroup="AddProductValidation">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">Image :</td>
                    <td class="auto-style5">
                        <asp:FileUpload ID="fileUploadImage" runat="server" />
                        <br /><br />
                        <asp:Button ID="btnUpload" runat="server" Text="Upload Image" OnClick="btnUpload_Click" CausesValidation="false" ValidationGroup="AddProductValidation" />
                        <br /><br />
                        <asp:TextBox ID="txtImage" runat="server" ReadOnly="true" ValidationGroup="AddProductValidation"></asp:TextBox>
                    </td>
                    <td class="auto-style6">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                            ErrorMessage="Image is Required" 
                            ForeColor="Red" 
                            ControlToValidate="txtImage" 
                            ValidationGroup="AddProductValidation">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">Unit Price :</td>
                    <td class="auto-style5">
                        <asp:TextBox ID="txtPrice" runat="server" ValidationGroup="AddProductValidation"></asp:TextBox>
                    </td>
                    <td class="auto-style6">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
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
                            ValidationGroup="AddProductValidation">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">Category :</td>
                    <td class="auto-style5">
                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="CategoryName" DataValueField="CategoryID" ValidationGroup="AddProductValidation">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CFC %>" SelectCommand="SELECT * FROM [Categories]"></asp:SqlDataSource>
                    </td>
                    <td class="auto-style6">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                            ErrorMessage="Category is Required" 
                            ForeColor="Red" 
                            ControlToValidate="DropDownList1" 
                            ValidationGroup="AddProductValidation">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style5">
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" ValidationGroup="AddProductValidation" />
                    </td>
                    <td class="auto-style6">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style5">
                        <asp:Button ID="btnAdd" runat="server" OnClick="btnAdd_Click" Text="Add" CssClass="buttonD" ValidationGroup="AddProductValidation" />
                    </td>
                    <td class="auto-style6">&nbsp;</td>
                </tr>

            </table>
        </div>
        <div id="ReActi" runat="server" visible="false">
             <h3>Enable Discontinued Product</h3>
             <table>
             <tr>
                 <td class="auto-style2">Product :</td>
                 <td class="auto-style4">
                     <asp:DropDownList ID="ddlActiProd" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource3" DataTextField="ProductName" DataValueField="ProductID" >
                     </asp:DropDownList>
                     <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:CFC %>" SelectCommand="SELECT * FROM [Products] WHERE ([Discontinued] = @Discontinued)">
                         <SelectParameters>
                             <asp:Parameter DefaultValue="1" Name="Discontinued" Type="Int32" />
                         </SelectParameters>
                     </asp:SqlDataSource>
                 </td>
                 <td class="auto-style3">&nbsp;</td>
             </tr>
             <tr>
                 <td class="auto-style1">&nbsp;</td>
                 <td class="auto-style5">
                     <asp:Button ID="Button3" runat="server" Text="Enable" OnClick="btnEnable_Click" CssClass="buttonD"/>
                 </td>
                 <td class="auto-style6">&nbsp;</td>
             </tr>
             </table>
        </div>
        <div id="gvProd" runat="server" visible="true">
            <!-- GridView for displaying product list -->
            <asp:GridView ID="gvProducts" runat="server" AutoGenerateColumns="False" GridLines="None" 
                    EmptyDataText="No Product Found" CssClass="table" OnRowCommand="gvProducts_RowCommand">
                <Columns>
                    <asp:ImageField DataImageUrlField="ImagePath" DataImageUrlFormatString="~/Catalog/Images/Thumbs/{0}" ControlStyle-CssClass="imgProd" HeaderStyle-CssClass="headtxt" ItemStyle-Width="120px" ItemStyle-CssClass="IMGbgColo" />
                    <asp:BoundField DataField="ProductName" HeaderText="Product Name" HeaderStyle-CssClass="headtxt" ItemStyle-Width="60%" ItemStyle-CssClass="bgColo" />
                    <asp:BoundField DataField="UnitPrice" HeaderText="Product Price" DataFormatString="{0:C}" ItemStyle-Width="20%" HeaderStyle-CssClass="headtxt" ItemStyle-CssClass="bgColo" />
                    <asp:BoundField DataField="Quantity" HeaderText="Quantity" HeaderStyle-CssClass="headtxt" ItemStyle-Width="10%" ItemStyle-CssClass="bgColo" />
                    <asp:TemplateField  HeaderStyle-CssClass="headtxt" ItemStyle-CssClass="bgColo">
                        <ItemTemplate>
                            <asp:Button ID="btnEdit" runat="server" CommandName="EditProduct" CommandArgument='<%# Eval("ProductID") %>' Text="Edit Product" CssClass="Editbutton" />
                            <asp:Button ID="btnDiscontinue" runat="server" CommandName="DiscontinueProduct" CommandArgument='<%# Eval("ProductID") %>' Text="Discontinue" CssClass="Editbutton" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
