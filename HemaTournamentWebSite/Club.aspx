<%@ Page Title="Club" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Club.aspx.cs" Inherits="WebApplication2.Club" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        / <a href="Default.aspx">Home</a> / <a href="Clubs.aspx">Clubs</a>
    <h4><asp:Label ID="lblClubName" runat="server"></asp:Label><asp:Label ID="lblClubPlace" runat="server"></asp:Label></h4>
    <br />
    <div class="card">
    <h4 class="card-header">Associates</h4>
    <div class="table-responsive text-nowrap" id="divAssociatesList" runat="server">
    </div>
        </div>
</asp:Content>
