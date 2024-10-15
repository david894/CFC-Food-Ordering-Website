<%@ Page Title="Error :(" Language="C#" MasterPageFile="~/CFCUI.Master" AutoEventWireup="true" CodeBehind="ErrorPage.aspx.cs" Inherits="CFCAssignment.ErrorPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .lblpage {
            text-align:center;
            height: 100%;
            background-color: #FFFEFE;
            margin-left: 5%;
            margin-right: 5%;
            padding: 2%;
        }
            .linkBtn {
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
            padding:1%;
            border-radius:20px;
            text-decoration:none;
            color:#000000;
            margin-bottom:3%;

        }
            .linkBtn:hover {
                font-size:large;
                font-weight:bold;
                text-decoration:underline;
                text-decoration-color:#FF0000;
                text-decoration-thickness:5px;
            }
        .morebtn {
            background-color:#FFFFFF;
            text-align:left;
            float:left;
            padding:5px;
            border:none;
            text-decoration:underline;
            font-weight:bold;
        }
            .morebtn:hover {
                text-decoration:underline;
                color:#FF0000;
            }
        #details {
            text-align:left;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="lblpage">
            <br />
            <h2>Oops, an error occurred!</h2><br />
            <p>We are sorry, but something went wrong. Please try again later.</p>
            <p>Error Details: <asp:Label ID="lblErrorMessage" runat="server" Text=""></asp:Label></p>
            <asp:Button ID="Button1" runat="server" Text="&#709; View More Details" OnClick="Button1_Click" CssClass="morebtn"/><br />
            <div id="details" runat="server" visible="false" >
                <p> <asp:Label ID="lblErrorFile" runat="server" Text=""></asp:Label></p>
                <p><asp:Label ID="lblErrorRoot" runat="server" Text=""></asp:Label></p>
            </div>

            <br /><br />
            <asp:HyperLink ID="HyperLink6" runat="server" NavigateUrl="~/home.aspx" CssClass="linkBtn">&lt; Return To Home</asp:HyperLink>

        </div>
</asp:Content>
