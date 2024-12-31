<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="WebForm1Prova.aspx.cs" Inherits="WebApplication2.WebForm1Prova" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="btn-group" runat="server" id="btnTournament">
    <asp:Button type="button" Text="Choose tournament" class="btn btn-primary dropdown-toggle overflow-hidden d-sm-inline-flex d-block text-truncate" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false" runat="server" />
    <ul class="dropdown-menu dropdown-menu-end" runat="server" id="dropdownMenu">
    </ul>
</div>
</asp:Content>
