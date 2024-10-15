<%@ Page Language="C#" MasterPageFile="~/CFCUI.Master" AutoEventWireup="true" CodeBehind="MyAccount.aspx.cs" Inherits="CFCAssignment.MyAccount.MyAccount" Title="My Account" %>
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
        .logout-button {
            width:120px;
            padding: 10px;
            border-radius:10%;
            background-color: red;
            color: white;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            text-align: center;
            font-size: 16px;
            margin-top: 20px;
        }
        .logout-button:hover {
            background-color: darkred;
        }
        .auto-style1 {
            width: 3%;
        }
        .logout {
            text-align:center;
        }
        .h1Title {
            text-align:left;
        }
        .ManagePD{
          background-color:#FFFEFE;
          margin-left:5%;
          margin-right:5%;
          padding:2%;
          height:fit-content;
          min-height:650px;
          margin-bottom:0px;
          }
          .PDmenu {
              position:absolute;
              width:200px;
              box-shadow: 0px 4px 8px 0px rgba(0, 0, 0, 0.2);
              height:250px;
              padding-top:30px;
              text-align:center;
          }
          .PDbutton {
              padding:5%;
              margin-bottom:5%;
              text-decoration:none;
              color:black;
          }
          .PDLayout {
               margin-left:250px;
          }
          .PDbutton:hover {
              text-decoration:underline;
              text-decoration-color:black;
              text-decoration-thickness:5px;
              font-weight:bold;
          }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="ManagePD">
    <h1>User Page</h1><hr />
    <div class="PDmenu">
        <asp:HyperLink ID="HyperLink1" runat="server" CssClass="PDbutton" NavigateUrl="~/MyAccount/MyAccount.aspx">My Profile</asp:HyperLink><br /><br />
        <asp:HyperLink ID="HyperLink2" runat="server" CssClass="PDbutton" NavigateUrl="~/MyAccount/ManageMyOrder.aspx">Manage My Order</asp:HyperLink><br /><br />
        <asp:HyperLink ID="HyperLink3" runat="server" CssClass="PDbutton" NavigateUrl="~/MyAccount/ChangePassword.aspx">Change Password</asp:HyperLink><br /><br />
        <asp:HyperLink ID="HyperLink4" runat="server" CssClass="PDbutton" NavigateUrl="~/MyAccount/SetSecurityInfo.aspx">Set Security Question</asp:HyperLink><br /><br />

        <asp:Button ID="Logout" runat="server" NavigateUrl="~/home.aspx" CssClass="logout-button" Text="Logout" OnClick="Logout_Click" />
    </div>
    <div class="PDLayout">
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
    </div>
</div>


</asp:Content>
