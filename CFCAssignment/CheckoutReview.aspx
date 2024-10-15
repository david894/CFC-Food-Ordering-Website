<%@ Page Title="Checkout Review" Language="C#" MasterPageFile="~/CFCUI.Master" AutoEventWireup="true" CodeBehind="CheckoutReview.aspx.cs" Inherits="CFCAssignment.CheckoutReview" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        /* Existing CSS Styles */
        .payment-method-section {
            margin-left: 5%;
            margin-right: 5%;
            padding: 2%;
            background-color: #FFFEFE;
        }

        .payment-method-section h3 {
            margin-bottom: 15px;
        }

        .payment-method-section .option {
            display: flex;
            justify-content: space-between;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            margin-bottom: 10px;
            background-color: #FFEEEE;
            cursor: pointer;
        }

        .option:hover {
            background-color: #FFDDDD;
            text-decoration: underline;
            text-decoration-color: #FFFFFF;
        }

        .order-summary {
            border-top: 1px solid #ddd;
            padding-top: 15px;
            margin-top: 20px;
        }

        .order-summary table {
            width: 100%;
            margin-bottom: 15px;
        }

        .order-summary td {
            padding: 5px 0;
        }

        .order-total {
            text-align: right;
        }

        .pay-now-btn {
            display: block;
            width: 100%;
            padding: 15px;
            background-color: #EE0000;
            color: white;
            text-align: center;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            text-decoration: none;
        }

        .pay-now-btn:hover {
            background-color: #CC0000;
        }

        .terms {
            font-size: 0.8em;
            margin-top: 15px;
            text-align: center;
            color: #666;
        }

        .checkbox {
            margin-bottom: 15px;
        }

        .cartTable {
            width: 90%;
            border-bottom: 1px solid #ddd;
            margin-bottom: 20px;
            margin-left: auto;
            margin-right: auto;
        }

        .cartTable td {
            padding: 10px;
            border-top: 1px solid #ddd;
        }

        .cartTable .itemDetails {
            width: 60%;
        }

        .headTxt {
            text-align: left;
        }

        .itemTxt,
        .fooTxt {
            text-align: right;
        }

        .prodTxt,
        .itemTxt {
            background-color: #FFEEEE;
        }

        /* New CSS for Credit Card Form */
        .card-details {
            display: none;
            margin-top: 20px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #FFEEEE;
            margin-bottom:40px;
        }

        .card-details label {
            display: block;
            margin-bottom: 5px;
        }

        .card-details input {
            width: 80%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .errorstat {
            color:#FF0000;
            font:large;
            font-weight:bold;
        }
    </style>

    <script type="text/javascript">
        function toggleCardDetails() {
            var cardDetails = document.getElementById('<%= pnlCardDetails.ClientID %>');
            var rdoCard = document.getElementById('<%= rdoCard.ClientID %>');
            var lblError = document.getElementById('<%= lblError.ClientID %>');

            if (rdoCard.checked) {
                cardDetails.style.display = 'block';
            } else {
                cardDetails.style.display = 'none';
            }
            lblError.textContent = "";
        }
        function detectCardType() {
            var cardNumber = document.getElementById("<%= txtCardNumber.ClientID %>").value;
             var lblCardType = document.getElementById("<%= lblCardType.ClientID %>");

             if (cardNumber.startsWith("4")) {
                 lblCardType.innerText = " [ Visa Card ]";
             } else if (cardNumber.startsWith("5")) {
                 lblCardType.innerText = " [ MasterCard ]";
             } else {
                 lblCardType.innerText = "";
             }
         }
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="payment-method-section">
        <h1 style="text-align:center;">SELECT PAYMENT METHOD</h1>
        <asp:Label ID="lblError" runat="server" Text="" CssClass="errorstat"></asp:Label>
        <div class="option">
            <span>Debit or Credit Card</span>
                <asp:RadioButton ID="rdoCard" runat="server" GroupName="PaymentMethod" OnClick="toggleCardDetails()" />
        </div>
        <!-- Credit Card Details Form -->
        <asp:Panel ID="pnlCardDetails" runat="server" CssClass="card-details">
            <asp:RegularExpressionValidator ID="revCardNumberVisaMaster" runat="server" 
                ControlToValidate="txtCardNumber" 
                ValidationExpression="^(4\d{15}|5[1-5]\d{14})$" 
                ErrorMessage="Card number must be a valid Visa or MasterCard." 
                ForeColor="Red" 
                Display="Dynamic" /><br />
            <label for="txtCardNumber">Card Number: <asp:Label ID="lblCardType" runat="server" Text=""></asp:Label></label>
            <asp:TextBox ID="txtCardNumber" runat="server" MaxLength="16" onkeyup="detectCardType();" ClientIDMode="Static"></asp:TextBox>
                <asp:RegularExpressionValidator ID="revCardNumber" runat="server" 
                    ControlToValidate="txtCardNumber" 
                    ValidationExpression="^\d{16}$" 
                    ErrorMessage="Card number must be 16 digits." 
                    ForeColor="Red" 
                    Display="Dynamic" />
                <br />
                <asp:RegularExpressionValidator ID="revExpiryDate" runat="server" 
                    ControlToValidate="txtExpiryDate" 
                    ValidationExpression="^(0[1-9]|1[0-2])\/\d{2}$" 
                    ErrorMessage="Expiry date must be in MM/YY format." 
                    ForeColor="Red" 
                    Display="Dynamic" />
                <label for="txtExpiryDate">Expiry Date (MM/YY):</label>
                <asp:TextBox ID="txtExpiryDate" runat="server" MaxLength="5"></asp:TextBox>
            <br />
                    <asp:RegularExpressionValidator ID="revCVV" runat="server" 
                    ControlToValidate="txtCVV" 
                    ValidationExpression="^\d{3}$" 
                    ErrorMessage="CVV must be 3 digits." 
                    ForeColor="Red" 
                    Display="Dynamic" /><br />
                <label for="txtCVV">CVV:</label>
                <asp:TextBox ID="txtCVV" runat="server" MaxLength="3"></asp:TextBox>


                <label for="txtNameOnCard">Name on Card:</label>
                <asp:TextBox ID="txtNameOnCard" runat="server"></asp:TextBox>
            </asp:Panel>

            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />

        
        <div class="option">
            <span>Cash</span>
            <asp:RadioButton ID="rdoCash" runat="server" GroupName="PaymentMethod" OnClick="toggleCardDetails()" />
        </div>
        <div class="option">
            <span>Pay with PayPal</span>
            <asp:RadioButton ID="rdoPaypal" runat="server" GroupName="PaymentMethod" OnClick="toggleCardDetails()" />
        </div>
        <div class="order-summary">
            <h4>ORDER SUMMARY</h4>
            <asp:GridView ID="OrderItemList" runat="server" AutoGenerateColumns="False" ShowFooter="True" GridLines="None" CellPadding="4" CssClass="cartTable">
                <Columns>
                    <asp:BoundField DataField="Product.ProductName" HeaderText="Product Name" HeaderStyle-CssClass="headTxt" ItemStyle-CssClass="prodTxt" />
                    <asp:BoundField DataField="Quantity" HeaderText="Quantity" HeaderStyle-CssClass="fooTxt" ItemStyle-CssClass="itemTxt" />
                    <asp:TemplateField HeaderText="Subtotal" HeaderStyle-CssClass="fooTxt" ItemStyle-CssClass="itemTxt">
                        <ItemTemplate>
                            <!-- Display Quantity x UnitPrice -->
                            <asp:Label ID="lblPriceQty" runat="server" 
                                Text='<%# Eval("Quantity") != null && Eval("Product.UnitPrice") != null ? 
                                    Eval("Quantity") + " x " + String.Format("{0:c}", Eval("Product.UnitPrice")) : "N/A" %>'></asp:Label>
                            <br />
                            <!-- Display Subtotal -->
                            <asp:Label ID="lblSubtotal" runat="server" 
                                Text='<%# Eval("Quantity") != null && Eval("Product.UnitPrice") != null ? 
                                    String.Format("{0:c}", Convert.ToDouble(Eval("Quantity")) * Convert.ToDouble(Eval("Product.UnitPrice"))) : "N/A" %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <div class="order-total">
                <span>Subtotal: RM 
                    <asp:Label ID="lblSub" runat="server" Text=""></asp:Label></span>
                <br />
                <span>Service Tax (6%): RM 
                    <asp:Label ID="lblTax" runat="server" Text=""></asp:Label></span>
                <br />
                <strong><span>Order Total: RM 
                    <asp:Label ID="lblTotal" runat="server" Text=""></asp:Label></strong></span>
            </div>
        </div>

        <br /><br />
        <asp:Button ID="btnPayNow" runat="server" CssClass="pay-now-btn" Text="PAY NOW" OnClick="CheckoutConfirm_Click" />

        <div class="terms">
            By placing an order, you agree to our privacy policy and security policy.
        </div>
    </div>
</asp:Content>
