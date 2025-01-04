<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TournamentDates.aspx.cs" Inherits="WebApplication2.TournamentDates" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-xxl container-p-y">
    <h2>Active tournaments</h2>
        <div class="row mb-12 g-6" id="activeTournament" runat="server">
            
            
        </div>
    </div>


    <div class="container-xxl container-p-y">
    <h2>Closed tournaments</h2>
        <div class="row mb-12 g-6" id="closedTournament" runat="server">
            
        </div>
    </div>
    
</asp:Content>
