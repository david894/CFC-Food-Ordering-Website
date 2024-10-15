<%@ Page Language="C#" MasterPageFile="~/CFCUI.Master" AutoEventWireup="true" CodeBehind="SetSecurityInfo.aspx.cs" Inherits="CFCAssignment.MyAccount.SetSecurityInfo" Title="Set Security Info"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .set-security-container {
            text-align: left;
            display: flex;
            height: 80%;
            background-color: #FFFEFE;
            margin-left: 5%;
            margin-right: 5%;
            padding: 2%;
            flex-direction: column;
        }

        .set-security-container table {
            width: 100%;
            border-spacing: 10px;
            background-color: #FFFEFE;
        }

        .set-security-container td {
            padding: 10px;
            font-size: 16px;
            background-color: #FFFEFE;
            border-radius: 10px;
        }

        .set-security-container td:first-child {
            font-weight: bold;
            text-align: right;
            width: 20%;
        }

        .set-security-container select,
        .set-security-container input[type="text"] {
            width: 100%;
            padding: 10px;
            border-radius: 10px;
            border: 1px solid #ccc;
            font-size: 16px;
        }

        .set-security-container .button-row input[type="submit"],
        .set-security-container .button-row input[type="button"] {
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

        .set-security-container .button-row input[type="submit"]:hover,
        .set-security-container .button-row input[type="button"]:hover {
            background-color: #e60000;
        }

        .set-security-container .set-security-title {
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

        .ManagePD {
            background-color: #FFFEFE;
            margin-left: 5%;
            margin-right: 5%;
            padding: 2%;
            height: fit-content;
            min-height:650px;
            margin-bottom: 0px;
           
        }

        .PDmenu {
            position: absolute;
            width: 200px;
            box-shadow: 0px 4px 8px 0px rgba(0, 0, 0, 0.2);
            height: 250px;
            padding-top: 30px;
            text-align: center;
        }

        .PDbutton {
            padding: 5%;
            margin-bottom: 5%;
            text-decoration: none;
            color: black;
        }

        .PDLayout {
            margin-left: 250px;
        }

        .PDbutton:hover {
            text-decoration: underline;
            text-decoration-color: black;
            text-decoration-thickness: 5px;
            font-weight: bold;
        }

        .h1Title {
            text-align: left;
        }

        .success-message {
            text-align: left;
        }
        .error-message {
            color: red;
            font-size: 32px;
            margin-bottom: 5px;
            display: block; 
  }
        .continue-button {
            width: 100%;
            padding: 10px;
            background-color: red;
            color: white;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            text-align: center;
            font-size: 16px;
            margin-top: 20px;
        }
        .continue-button:hover {
    background-color: darkred;
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
            <h3 class="h1Title">Set Security Information</h3>
            <p><asp:Label ID="lblError" runat="server" CssClass ="error-message"></asp:Label></p>
            <div class="set-security-container">
                <asp:Panel ID="SetSecurityPanel" runat="server">
                    <table>
                        <tr>
                            <td>Security Question 1:</td>
                            <td><asp:DropDownList ID="ddlSecurityQuestion1" runat="server">
                                <asp:ListItem>What is the first name of your best friend in high school?</asp:ListItem>
                                <asp:ListItem>What is the first name of your oldest nephew?</asp:ListItem>
                                <asp:ListItem>What is the first name of your oldest niece?</asp:ListItem>
                                <asp:ListItem>What is the middle name of your oldest child?</asp:ListItem>
                                <asp:ListItem>What is your oldest cousin&#39;s first name?</asp:ListItem>
                                <asp:ListItem Value="What was the first name of the first person you dated?"></asp:ListItem>
                                <asp:ListItem>What was the first name of your favorite childhood friend?</asp:ListItem>
                                <asp:ListItem Value="What was the last name of your third grade teacher?"></asp:ListItem>
                                <asp:ListItem Value="What was the street name where your best friend in high school lived (street name only)?"></asp:ListItem>
                                </asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td>Answer 1:</td>
                            <td><asp:TextBox ID="txtAnswer1" runat="server" CssClass="input-field"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>Security Question 2:</td>
                            <td><asp:DropDownList ID="ddlSecurityQuestion2" runat="server">
                                <asp:ListItem>What is the first name of your best friend in high school?</asp:ListItem>
                                <asp:ListItem Value="What is the first name of your oldest nephew?"></asp:ListItem>
                                <asp:ListItem>What is the first name of your oldest niece?</asp:ListItem>
                                <asp:ListItem Value="What is the middle name of your oldest child?"></asp:ListItem>
                                <asp:ListItem>What is your oldest cousin&#39;s first name?</asp:ListItem>
                                <asp:ListItem>What was the first name of the first person you dated?</asp:ListItem>
                                <asp:ListItem>What was the first name of your favorite childhood friend?</asp:ListItem>
                                <asp:ListItem>What was the last name of your third grade teacher?</asp:ListItem>
                                <asp:ListItem Value="What was the street name where your best friend in high school lived (street name only)?"></asp:ListItem>
                                </asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td>Answer 2:</td>
                            <td><asp:TextBox ID="txtAnswer2" runat="server" CssClass="input-field"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>Security Question 3:</td>
                            <td><asp:DropDownList ID="ddlSecurityQuestion3" runat="server">
                                <asp:ListItem>What is the first name of your best friend in high school?</asp:ListItem>
                                <asp:ListItem>What is the first name of your oldest nephew?</asp:ListItem>
                                <asp:ListItem>What is the first name of your oldest niece?</asp:ListItem>
                                <asp:ListItem>What is the middle name of your oldest child?</asp:ListItem>
                                <asp:ListItem>What is your oldest cousin&#39;s first name?</asp:ListItem>
                                <asp:ListItem>What was the first name of the first person you dated?</asp:ListItem>
                                <asp:ListItem>What was the first name of your favorite childhood friend?</asp:ListItem>
                                <asp:ListItem>What was the last name of your third grade teacher?</asp:ListItem>
                                <asp:ListItem Value="What was the street name where your best friend in high school lived (street name only)?"></asp:ListItem>
                                </asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td>Answer 3:</td>
                            <td><asp:TextBox ID="txtAnswer3" runat="server" CssClass="input-field"></asp:TextBox></td>
                        </tr>
                        <tr class="button-row">
                            <td colspan="2" style="text-align: center;">
                                <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" CssClass="submit-button" />
                            </td>
                        </tr>
                        <tr class="button-row">
                            <td colspan="2" style="text-align: center;">
                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" CssClass="submit-button" PostBackUrl="~/MyAccount/MyAccount.aspx" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                
               <asp:Panel ID="SuccessPanel" runat="server" Visible="false">
        <div style="text-align: left;">
            <h2>Security Information Updated</h2>
            <p>Your security questions and answers have been updated successfully.</p>
            <asp:Button ID="ContinueButton" runat="server" CommandName="Continue" Text="Continue" CssClass="continue-button" PostBackUrl="~/MyAccount/MyAccount.aspx" />
        </div>
    </asp:Panel>
            </div>
           </div>
         </div>
</asp:Content>
