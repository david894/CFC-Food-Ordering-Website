<%@ Page Title="Assign Role" Language="C#" MasterPageFile="~/Maintenance/Admin.Master" AutoEventWireup="true" CodeBehind="AdminAssign.aspx.cs" Inherits="CFCAssignment.Maintenance.AdminAssign" %>
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
            text-align:left;
        }
        td {
            padding: 10px;
            background-color: #FFFEFE;
            border-radius: 10px; 
            text-align:left;

        }
        td:first-child {
            text-align:left;
            font-weight: bold;
        }
        td:nth-child(2) {
            width: 10px; 
            text-align:left;
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
 
     </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="center-container">
        <h3 class="h1Title">Assign User Role Page</h3>
        <table>
            <tr>
                <td>Users</td>
                <td>:</td>
                <td>
                    <asp:DropDownList ID="ddlUser" runat="server"></asp:DropDownList>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btnGetUser" runat="server" OnClick="btnGetUser_Click" Text="Get Users" CssClass="aspButton" />
                </td>
            </tr>
            <tr>
                <td>Create Role</td>
                <td>:</td>
                <td>
                    <asp:TextBox ID="txtCreateRole" runat="server"></asp:TextBox>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btnCreateRole" runat="server" OnClick="btnCreateRole_Click" Text="Create Role" CssClass="aspButton" />
                </td>
            </tr>
            <tr>
                <td>Roles</td>
                <td>:</td>
                <td>
                    <asp:DropDownList ID="ddlRole" runat="server"></asp:DropDownList>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btnRole" runat="server" OnClick="btnRole_Click" Text="Get Roles" CssClass="aspButton" />
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btnAssign" runat="server" OnClick="btnAssign_Click" Text="Assign" CssClass="aspButton" />
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btnVerify" runat="server" OnClick="btnVerify_Click" Text="Verify" CssClass="aspButton" />
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td style="font-family: 'Candara Light'; font-style: normal; color: #FF0000">Role List</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>
                    <asp:ListBox ID="LstUsers" runat="server"></asp:ListBox>
                </td>
            </tr>

        </table>
    </div>

</asp:Content>
