<%@ Page Title="My Profile" Language="C#" MasterPageFile="~/Maintenance/Admin.Master" AutoEventWireup="true" CodeBehind="AdminProfile.aspx.cs" Inherits="CFCAssignment.Maintenance.AdminProfile" %>
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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="center-container">
            <h3 class="h1Title">My Profile</h3>

            <table>
                <tr>
                    <td class="auto-style1">Hi <asp:LoginName ID="LoginName1" runat="server" FormatString="{0}" /></td>
                    <td class="spacer">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="spacer">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1">First Name:</td>
                    <td><asp:Label ID="FirstNameLabel" runat="server" /></td>
                </tr>
                <tr>
                    <td class="auto-style1">Last Name:</td>
                    <td><asp:Label ID="LastNameLabel" runat="server" /></td>
                </tr>
                <tr>
                    <td class="auto-style1">Email:</td>
                    <td><asp:Label ID="EmailLabel" runat="server" /></td>
                </tr>
                <tr>
                    <td class="auto-style1">Mobile Number:</td>
                    <td><asp:Label ID="MobileNumberLabel" runat="server" /></td>
                </tr>
                <tr>
                    <td class="auto-style1">Date of Birth:</td>
                    <td><asp:Label ID="DateOfBirthLabel" runat="server" /></td>
                </tr>
                <tr>
                    <td class="auto-style1">Subscribed to News:</td>
                    <td><asp:Label ID="PromotionNewsLabel" runat="server" /></td>
                </tr>
                <tr>
                    <td class="auto-style1">Accepted Terms and Conditions:</td>
                    <td><asp:Label ID="TermsAndConditionLabel" runat="server" /></td>
                </tr>
                </table>
        </div>

</asp:Content>
