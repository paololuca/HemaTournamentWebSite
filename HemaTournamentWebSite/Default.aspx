<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="HemaTournamentWebSite._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1><asp:Image ID="Image1" runat="server"  ImageUrl="~/assets/img/swords.png" width="5%"/>HEMA Chronicles</h1>
        <%--<h3 class="mb-2 mx-2">Under Construction! 🚧</h3>--%>
        <p class="lead">The site provide the experience of HEMA Chronicles: get your achievements and rewards in our tournaments system</p>
    </div>

    <div class="container-p-y">
        <a href="TournamentDates.aspx" class="btn btn-primary">Go to Dates</a>

       
    </div>

</asp:Content>
