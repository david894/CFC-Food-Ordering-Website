<%@ Page Language="C#" MasterPageFile="~/CFCUI.Master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="CFCAssignment.MyAccount.ChangePassword" Title="Change Password" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .change-password-container {
            text-align:left;
            display: flex;
            height: 80%;
            background-color: #FFFEFE;
            margin-left: 5%;
            margin-right: 5%;
            padding: 2%;
            flex-direction: column;
        }

        .change-password-container table {
            width: 100%;
            border-spacing: 10px;
            background-color:#FFFEFE;
        }

        .change-password-container td {
            padding: 10px;
            font-size: 16px;
            background-color:#FFFEFE;
            border-radius: 10px;
        }

        .change-password-container td:first-child {
            font-weight: bold;
            text-align: right;
            width: 20%;
        }

        .change-password-container input[type="text"],
        .change-password-container input[type="password"] {
            width: 100%;
            padding: 10px;
            border-radius: 10px;
            border: 1px solid #ccc;
            font-size: 16px;
        }


        .change-password-container .button-row input[type="submit"],
        .change-password-container .button-row input[type="button"] {
            width: 48%;
            padding: 10px;
            margin: 5px 1%;
            border-radius: 10px;
            border: none;
            font-size: 16px;
            background-color: #FF0000;
            color: white;
            cursor: pointer;
        }

        .change-password-container .button-row input[type="submit"]:hover,
        .change-password-container .button-row input[type="button"]:hover {
            background-color: #e60000;
        }

        .change-password-container .change-password-title {
            font-weight: bold;
            font-size: 24px;
            padding-bottom: 20px;
            width: 100%;
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
        .ManagePD{
          background-color:#FFFEFE;
          margin-left:5%;
          margin-right:5%;
          padding:2%;
          height:650px;
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
        .h1Title {
            text-align:left;
        }
        .success-message {
            text-align: left;
        }
        .lblPass {
            font-size:small;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
          <div class="ManagePD">
<h1><asp:Label ID="lblpage" runat="server"></asp:Label></h1>
    <hr />
<div class="PDmenu" id="PDmenu" runat="server" >
     <div id="adminNav" runat="server" visible="false">
         <asp:HyperLink ID="HyperLink6" runat="server" CssClass="PDbutton" NavigateUrl="~/Maintenance/Dashboard.aspx">Dashboard</asp:HyperLink><br /><br />
         <asp:HyperLink ID="HyperLink1" runat="server" CssClass="PDbutton" NavigateUrl="~/Maintenance/AdminProfile.aspx">My Profile</asp:HyperLink><br /><br />
         <asp:HyperLink ID="HyperLink5" runat="server" CssClass="PDbutton" NavigateUrl="~/MyAccount/ChangePassword.aspx">Change Password</asp:HyperLink><br /><br />
         <asp:HyperLink ID="HyperLink2" runat="server" CssClass="PDbutton" NavigateUrl="~/Maintenance/AdminAssign.aspx">Assign User Role</asp:HyperLink><br /><br />
         <asp:HyperLink ID="HyperLink3" runat="server" CssClass="PDbutton" NavigateUrl="~/Maintenance/AdminProduct.aspx">Manage Product</asp:HyperLink><br /><br />
         <asp:HyperLink ID="HyperLink7" runat="server" CssClass="PDbutton" NavigateUrl="~/Maintenance/AdminOrder.aspx">Manage Order</asp:HyperLink><br /><br />
         <asp:HyperLink ID="HyperLink8" runat="server" CssClass="PDbutton" NavigateUrl="~/Maintenance/AdminActivate.aspx">Manual Activation</asp:HyperLink><br /><br />
         <asp:HyperLink ID="HyperLink9" runat="server" CssClass="PDbutton" NavigateUrl="~/MyAccount/SetSecurityInfo.aspx">Set Security Question</asp:HyperLink><br /><br />
     </div>
     <div id="userNav" runat="server" visible="false">
          <asp:HyperLink ID="HyperLink4" runat="server" CssClass="PDbutton" NavigateUrl="~/MyAccount/MyAccount.aspx">My Profile</asp:HyperLink><br /><br />
          <asp:HyperLink ID="HyperLink10" runat="server" CssClass="PDbutton" NavigateUrl="~/MyAccount/ManageMyOrder.aspx">Manage My Order</asp:HyperLink><br /><br />
          <asp:HyperLink ID="HyperLink11" runat="server" CssClass="PDbutton" NavigateUrl="~/MyAccount/ChangePassword.aspx">Change Password</asp:HyperLink><br /><br />
          <asp:HyperLink ID="HyperLink12" runat="server" CssClass="PDbutton" NavigateUrl="~/MyAccount/SetSecurityInfo.aspx">Set Security Question</asp:HyperLink><br /><br />
     </div>

    <asp:Button ID="Button1" runat="server" NavigateUrl="~/home.aspx" CssClass="logout-button" Text="Logout" OnClick="Logout_Click" />

</div>
    <div class="PDLayout">
        <h3 class="h1Title">Change Password</h3>
        <p> <asp:Label ID="lblError" runat="server"></asp:Label></p>
        <div class="change-password-container">
          <asp:ChangePassword 
            ID="ChangePassword1" 
            runat="server" 
            CancelDestinationPageUrl="~/MyAccount/MyAccount.aspx" 
            ContinueDestinationPageUrl="~/MyAccount/MyAccount.aspx" 
            OnChangingPassword="ChangePassword1_ChangingPassword" 
            ChangePasswordFailureText="Password change failed. Please try again." 
            FailureTextStyle-ForeColor="Red"
            CssClass="button-row">
    
            <ChangePasswordTemplate>
                <div style="text-align:left;">
                    <table>
                        <tr>
                            <td>Current Password:</td>
                            <td><asp:TextBox ID="CurrentPassword" runat="server" TextMode="Password" /></td>
                        </tr>
                        <tr>
                            <td>New Password:<br /> <asp:Label ID="Label1" runat="server" Text="* Conatins At Least 8 Character, Include At Least One Uppercase letter , one lowercase letter, and a special symbol (@$!%*?&) " CssClass="lblPass"></asp:Label></td>
                            <td><asp:TextBox ID="NewPassword" runat="server" TextMode="Password" /></td>
                        </tr>
                        <tr>
                            <td>Confirm New Password:</td>
                            <td><asp:TextBox ID="ConfirmNewPassword" runat="server" TextMode="Password" /></td>
                        </tr>
                    
                        <tr class="button-row">
                            <td colspan="2" style="text-align:center;">
                                <asp:Button ID="ChangePasswordPushButton" runat="server" CommandName="ChangePassword" Text="Change Password" />
                            </td>
                        </tr>
                        <tr class="button-row">
                            <td colspan="2" style="text-align:center;">
                                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                            </td>
                        </tr>
                    </table>
                </div>
            </ChangePasswordTemplate>
              <SuccessTemplate>
                 <div style="text-align: left;">
                    <h2>Change Password Complete</h2>
                    <p>Your password has been changed!</p>
                    <asp:Button ID="ContinueButton" runat="server" CommandName="Continue" Text="Continue" />
                </div>
              </SuccessTemplate>
              <SuccessTextStyle HorizontalAlign="Left" />
              <TitleTextStyle HorizontalAlign="Left" />
        </asp:ChangePassword>

        </div>
    </div>
</div>
    
</asp:Content>
