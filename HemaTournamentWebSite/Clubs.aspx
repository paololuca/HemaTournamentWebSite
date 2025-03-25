<%@ Page Title="Clubs" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Clubs.aspx.cs" Inherits="WebApplication2.Clubs" %>

<asp:Content ID="head" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="Default.aspx">Home</a></li>
            <li class="breadcrumb-item active">Clubs</li>
        </ol>
    </nav>
    <h2>Clubs</h2>

    <div class="row mb-12 g-6" id="activeClubs" runat="server">
        

    </div>
</asp:Content>
