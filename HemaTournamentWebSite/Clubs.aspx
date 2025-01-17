<%@ Page Title="Clubs" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Clubs.aspx.cs" Inherits="WebApplication2.Clubs" %>

<asp:Content ID="head" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    / <a href="Default.aspx">Home</a>
    <h2>Clubs</h2>

    <div class="row mb-12 g-6" id="activeClubs" runat="server">
        

    </div>
</asp:Content>
