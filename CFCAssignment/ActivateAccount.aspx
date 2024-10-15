<%@ Page Language="C#" MasterPageFile="~/CFCUI.Master" AutoEventWireup="true" CodeBehind="ActivateAccount.aspx.cs" Inherits="CFCAssignment.ActivateAccount" Title="Activate Account" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .center-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #FFFEFE;
            margin-left: 5%;
            margin-right: 5%;
            padding: 2%;
        }

        .auto-style1 {
            text-align: center;
        }

        .auto-style2 {
            width: 80%;
            max-width: 400px;
            margin: auto;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
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

        .submit-button {
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

        .submit-button:hover {
            background-color: darkred;
        }

        .failure-message {
            color: red;
            font-size: 12px;
        }

        .success-message {
            color: green;
            font-size: 14px;
            margin-top: 20px;
        }

        .security-question-container {
            margin-top: 20px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="center-container">
        <table class="auto-style2">
            <tr>
                <td class="auto-style1" style="font-family: 'Candara Light'; font-size: medium">
                    Activate Your Account<br />
                </td>
            </tr>

            <tr>
                <td class="auto-style1">
                    <asp:Label ID="lblMessage" runat="server" CssClass="failure-message" />
                </td>
            </tr>

            <tr>
                <td class="auto-style1">
                    <!-- User ID Input Panel -->
                    <asp:Panel ID="UserIdPanel" runat="server" Visible="true">
                        <div class="form-group">
                            <asp:TextBox ID="txtUserId" runat="server" CssClass="custom-input" Placeholder="Enter User ID"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="UserIdRequired" runat="server" ControlToValidate="txtUserId" ErrorMessage="User ID is required." CssClass="error-message" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                        <asp:Button ID="btnCheckUserId" runat="server" CssClass="submit-button" Text="Check User ID" OnClick="btnCheckUserId_Click" />
                    </asp:Panel>
                </td>
            </tr>

            <!-- Security Question Panel -->
            <tr>
                <td class="auto-style1">
                    <asp:Panel ID="SecurityQuestionPanel" runat="server" Visible="false" CssClass="security-question-container">
                        <h3>Select a Security Question</h3>
                        <div class="form-group">
                            <asp:DropDownList ID="ddlSecurityQuestions" runat="server" CssClass="custom-input"></asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="txtAnswer" runat="server" CssClass="custom-input" Placeholder="Answer"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="AnswerRequired" runat="server" ControlToValidate="txtAnswer" ErrorMessage="Answer is required." CssClass="error-message" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                        <asp:Button ID="btnSubmitAnswer" runat="server" CssClass="submit-button" Text="Submit Answer" OnClick="btnSubmitAnswer_Click" />
                        <asp:Label ID="lblErrorMessage" runat="server" CssClass="failure-message" />
                    </asp:Panel>
                </td>
            </tr>

            <!-- Password Reset Panel -->
            <tr>
                <td class="auto-style1">
                    <asp:Panel ID="PasswordResetPanel" runat="server" Visible="false" CssClass="security-question-container">
                        <h3>Account Activated Successfully!</h3>
                        <p class="success-message">
                            Your account is now active. Here is your temporary password:
                            <asp:Label ID="lblNewPassword" runat="server" ForeColor="Blue"></asp:Label>
                        </p>
                        <p class="success-message">Please change your password as soon as possible.</p>
                        <asp:Button ID="btnGoToLogin" runat="server" CssClass="submit-button" Text="Go to Login" OnClick="btnGoToLogin_Click" />
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td class="auto-style1">
                    <!-- Customer Service Panel -->
                    <asp:Panel ID="CustomerServicePanel" runat="server" Visible="false" CssClass="security-question-container">
                        <h3>Account Assistance</h3>
                        <p>Please contact our customer service:</p>
                        <p>Email: KFCCustomerService@gmail.com</p>
                        <p>Phone: 1300-222-888</p>
                        <asp:Button ID="btnCustomerServiceOk" runat="server" CssClass="submit-button" Text="OK" OnClick="btnCustomerServiceOk_Click" />
                    </asp:Panel>
                </td>
            </tr>

        </table>
    </div>
</asp:Content>
