<%@ Page Title="Fighters" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Fighters.aspx.cs" Inherits="WebApplication2.Fighters" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    / <a href="Default.aspx">Home</a> / <a href="Clubs.aspx">Clubs</a>
    <h2>Associates</h2>
    <div class="card">
         <div class="overflow-auto p-3 mb-3 mb-md-0 me-md-3 bg-light" style="max-width: 8000px; max-height: 600px;">
        <div class="responsive-iframe-container small-container">
        <div class="table-responsive text-nowrap" id="divAssociatesList" runat="server">

        </div>
            </div>
             </div>
    </div>
</asp:Content>
