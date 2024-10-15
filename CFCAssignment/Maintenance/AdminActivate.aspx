<%@ Page Title="Manual Activate" Language="C#" MasterPageFile="~/Maintenance/Admin.Master" AutoEventWireup="true" CodeBehind="AdminActivate.aspx.cs" Inherits="CFCAssignment.Maintenance.AdminActivate" %>
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
            width: 160px;
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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="center-container">
        <h3 class="h1Title">Admin Manual Account Activation</h3>

        <table class="auto-style2">
            <tr>
                <td class="auto-style1">
                    <!-- User ID Input Panel -->
                    <asp:Panel ID="UserIdPanel" runat="server" Visible="true" DefaultButton="btnCheckUserId">
                        <div class="form-group">
                            <asp:RequiredFieldValidator ID="UserIdRequired" runat="server" ControlToValidate="txtUserId" ErrorMessage="User ID is required." CssClass="error-message" Display="Dynamic" ValidationGroup="SearchValidation"></asp:RequiredFieldValidator><br />
                            <asp:TextBox ID="txtUserId" runat="server" CssClass="input-field" Placeholder="Enter User ID"></asp:TextBox>
                            <asp:Button ID="btnCheckUserId" runat="server" CssClass="submit-button" Text="Activate Account" OnClick="btnCheckUserId_Click" ValidationGroup="SearchValidation"/>

                        </div>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td class="auto-style1">
                    <asp:Label ID="lblMessage" runat="server" CssClass="error-message" />
                </td>
            </tr>
            <!-- Password Reset Panel -->
            <tr>
                <td class="auto-style1">
                    <asp:Panel ID="PasswordResetPanel" runat="server" Visible="false">
                        <h3>Account Activated Successfully!</h3>
                        <p class="success-message">
                            The account has been manually activated. Here is the temporary password:
                            <asp:Label ID="lblNewPassword" runat="server" ForeColor="Blue"></asp:Label>
                        </p>
                        <p class="success-message">Please inform the user to change their password as soon as possible.</p>
                        <asp:Button ID="btnGoToHome" runat="server" CssClass="submit-button" Text="Go to Home" OnClick="btnGoToHome_Click" PostBackUrl="~/home.aspx" />
                    </asp:Panel>
                </td>
            </tr>
            <!-- Error Message Panel -->
            <tr>
                <td class="auto-style1">
                    <asp:Panel ID="ErrorPanel" runat="server" Visible="false">
                        <p class="error-message">Invalid User ID or security information.</p>
                    </asp:Panel>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
