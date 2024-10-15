<%@ Page Language="C#" MasterPageFile="~/CFCUI.Master" AutoEventWireup="true" CodeBehind="CreateUser.aspx.cs" Inherits="CFCAssignment.CreateUser" Title="Sign Up"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
        text-align: center;
        width: 613px;
    }
        .center-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100%;
            background-color: #FFFEFE;
            margin-left: 5%;
            margin-right: 5%;
            padding: 2%;
        }
        .auto-style2 {
            text-align: left;
            width: 80%;
            max-width: 600px;
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
        .custom-checkbox {
            margin-bottom: 10px;
        }

        .error-message {
            color: red;
            font-size: 12px;
            margin-bottom: 5px;
            display: block; 
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
        .form-group {
            margin-bottom: 20px;
        }
        .row {
            display: flex;
            justify-content: space-between;
        }
        .half-width {
            width: 48%;
        }
        .auto-style3 {
            text-align: center;
        }
        .lblFrom {
            text-align:left;
        }
        .lblPass {
            font-size:small;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="center-container">
        <div class="auto-style2">
            <table>
                <tr>
                    <td class="auto-style1" colspan="4" style="font-family: 'Candara Light'">Let&#39;s Get Started!</td>
                </tr>
                <tr>
                    <td class="auto-style1" colspan="4" style="font-family: 'Candara Light'">Sign up now to enjoy finger lickin&#39; good deals and rewards, it&#39;s absolutely</td>
                </tr>
                <tr>
                    <td class="auto-style1" colspan="4" style="font-family: 'Candara Light';">free!</td>
                </tr>
            </table>
            <div class="auto-style3" style="font-family: 'Candara Light'">
            <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" ContinueDestinationPageUrl="~/MyAccount/MyAccount.aspx" OnCreatingUser="CreateUserWizard1_CreatingUser" CreateUserButtonText="Register Now" ContinueButtonText="Get Started" Width="617px">
                <ContinueButtonStyle BackColor="Red" BorderColor="White" Font-Size="Large" ForeColor="Black" Height="50px" Width="600px" />
                <CreateUserButtonStyle CssClass="submit-button" />
                <WizardSteps>
                    <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server">
                        <ContentTemplate>
                            <div class="row">
                                <div class="form-group half-width">
                                    <asp:Label ID="FirstNameLabel" runat="server" CssClass="lblFrom" Text="First Name:"></asp:Label>
                                    <asp:TextBox ID="FirstName" runat="server" CssClass="custom-input"></asp:TextBox>
                                </div>
                                <div class="form-group half-width">
                                    <asp:Label ID="LastNameLabel" runat="server" Text="Last Name:"></asp:Label>
                                    <asp:TextBox ID="LastName" runat="server" CssClass="custom-input"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="UserNameLabel" runat="server" Text="User ID:"></asp:Label>
                                <asp:TextBox ID="UserName" runat="server" CssClass="custom-input"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="MobileNumberLabel" runat="server" Text="Mobile Number:"></asp:Label>
                                <asp:TextBox ID="MobileNumber" runat="server" CssClass="custom-input"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="MobileNumberRequired" runat="server" ControlToValidate="MobileNumber" ErrorMessage="Mobile Number is required." CssClass="error-message" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="MobileNumberValidator" runat="server" ControlToValidate="MobileNumber" 
                                    ErrorMessage="*Enter valid phone number that starts with 0." 
                                    ValidationExpression="^01\d{8,9}$" 
                                    CssClass="error-message" 
                                    Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>

                            <div class="form-group">
                                <asp:Label ID="EmailLabel" runat="server" Text="E-mail:"></asp:Label>
                                <asp:TextBox ID="Email" runat="server" CssClass="custom-input"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="EmailValidator" runat="server" ControlToValidate="Email" ErrorMessage="Please enter a valid email." ValidationExpression="^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$" CssClass="error-message" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="PasswordLabel" runat="server" Text="Password:"></asp:Label><br />
                                <asp:Label ID="Label1" runat="server" Text="* Conatins At Least 8 Character, Include At Least One Uppercase letter , one lowercase letter, and a special symbol (@$!%*?&) " CssClass="lblPass"></asp:Label>
                                <asp:TextBox ID="Password" runat="server" TextMode="Password" CssClass="custom-input"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="ConfirmPasswordLabel" runat="server" Text="Confirm Password:"></asp:Label>
                                <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password" CssClass="custom-input"></asp:TextBox>
                                <asp:CompareValidator ID="PasswordCompareValidator" runat="server" ControlToValidate="ConfirmPassword" ControlToCompare="Password" ErrorMessage="Passwords do not match." CssClass="error-message" Display="Dynamic"></asp:CompareValidator>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="DateOfBirthLabel" runat="server" Text="Date of Birth:"></asp:Label>
                                <asp:TextBox ID="DateOfBirth" runat="server" CssClass="custom-input" placeholder="DD-MM-YYYY"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <!-- Optional News and Promotions Checkbox -->
                            <asp:CheckBox ID="NewsCheckbox" runat="server" Text="I want the latest news and promotions!" CssClass="custom-checkbox" />

                            </div>
                            <div class="form-group">
                                <!-- Required Terms and Conditions Checkbox -->
                             <asp:CheckBox ID="TermsCheckbox" runat="server" Text="I accept the Terms and Condition and Privacy Policy" CssClass="custom-checkbox" />
                            </div>
                        </ContentTemplate>
                    </asp:CreateUserWizardStep>
                    <asp:CompleteWizardStep runat="server" />
                </WizardSteps>
            </asp:CreateUserWizard>
            </div>
        </div>
    </div>
</asp:Content>
