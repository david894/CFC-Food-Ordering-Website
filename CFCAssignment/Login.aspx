<%@ Page Language="C#" MasterPageFile="~/CFCUI.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CFCAssignment.Login" Title="Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .center-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color:#FFFEFE;
            margin-left:5%;
            margin-right:5%;
            padding:2%;
        }
        .auto-style1 {
            text-align: center;
        }
        .auto-style2 {
            width: 80%;
            max-width: 400px;
            margin: auto;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 10px;
        }
        .custom-input {
            border: none;
            border-bottom: 1px solid #ccc;
            padding: 10px 0;
            width: 100%;
            font-size: 16px;
            outline: none;
            margin-bottom: 10px;
            background-color: transparent;
        }
        .custom-input:focus {
            border-bottom: 1px solid red;
        }
        .error-message {
            color: red;
            font-size: 12px;
        }
        .login-button {
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
        .login-button:hover {
            background-color: darkred;
        }
        .login-options {
            text-align: center;
            margin-top: 10px;
        }
        .login-options a {
            color: #007BFF;
            text-decoration: none;
        }
        .login-options a:hover {
            text-decoration: underline;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .failure-message {
            color: red;
            font-size: 12px;
        }
        .lblrecap {
            color:#FF0000;
            font-size:small;
        }
        #g-recaptcha-response {
          display: block !important;
          position: absolute;
          margin: -78px 0 0 0 !important;
          width: 302px !important;
          height: 76px !important;
          z-index: -999999;
          opacity: 0;
        }
    </style>
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    <script type="text/javascript">
        window.addEventListener('load', () => {
            const $recaptcha = document.querySelector('#g-recaptcha-response');
            if ($recaptcha) {
                $recaptcha.setAttribute('required', 'required');
            }
        })

    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="center-container">
        <table class="auto-style2">
            <tr>
                <td class="auto-style1" style="font-family: 'Candara Light'; font-size: medium">Log in now to enjoy exclusive CFC deals and discounts!&nbsp;<br />
                </td>
       
            </tr>
            <tr>
                <td class="auto-style1" style="font-family: 'Candara Light'; font-size: medium">&nbsp;
                     <asp:Label ID="lblErrorMessage" runat="server" CssClass="failure-message" />
                 </td>
            </tr>
           
            <tr>
                <td class="auto-style1">
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Login ID="Login1" runat="server" DestinationPageUrl="~/MyAccount/MyAccount.aspx" Width="533px" OnAuthenticate="LoginButton_Click1" FailureText="Invalid username or password.">
                        <LayoutTemplate>
                            <div class="form-group">
                                <asp:TextBox ID="UserName" runat="server" CssClass="custom-input" Placeholder="User ID"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="This field is required." CssClass="error-message" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <asp:TextBox ID="Password" runat="server" TextMode="Password" CssClass="custom-input" Placeholder="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="This field is required." CssClass="error-message" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                            <div>
                                <div class="g-recaptcha" data-sitekey="6Lehh0UqAAAAAFDlHoxvobcqKHCxTwRofgSjE8j9"></div>
                            </div>
                            <div id="failureTextContainer" class="failure-message">
                                <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                               
                            </div>
                            <div>
                                <asp:Button ID="LoginButton" runat="server" CommandName="Login" CssClass="login-button" Text="Log In" CausesValidation="true" OnClick="LoginButton_Click1"/>
                            </div>
                        </LayoutTemplate>
                    </asp:Login>

           <!-- Account Locked Panel -->
                    <asp:Panel ID="AccountLockedPanel" runat="server" Visible="false" CssClass="auto-style1">
                        <p>Your account is frozen. Please 
                            <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/ActivateAccount.aspx">Click Here</asp:HyperLink>
                            &nbsp;to reactivate your account.</p>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td class="auto-style1">
                    _____________________________or____________________________
                <br />
                </td>
            </tr>
            <tr>
                <td class="auto-style1">
                    &nbsp;&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style1">
                    Don’t have an account?
                    <asp:HyperLink ID="HyperLink1" runat="server" BorderStyle="None" Font-Underline="False" ForeColor="Black" NavigateUrl="~/CreateUser.aspx">Sign up now!</asp:HyperLink>
                    <br />
                </td>
            </tr>
            <tr>
                <td class="auto-style1">
                    <asp:HyperLink ID="HyperLink2" runat="server" Font-Underline="False" ForeColor="Black" NavigateUrl="~/home.aspx">Continue As Guest</asp:HyperLink>
                    <br />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
