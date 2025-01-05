<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TournamentDates.aspx.cs" Inherits="WebApplication2.TournamentDates" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Active tournaments</h2>
    <div class="mt-6" id="divTba" runat="server" visible="false">
          <img
            src="../assets/img/elements/TBA.png"
            width="500"
            class="img-fluid"
            data-app-light-img="illustrations/TBA.png"
            data-app-dark-img="illustrations/TBA.png" />
        </div>
        <div class="row mb-12 g-6" id="activeTournament" runat="server">            
            
        </div>


    <h2>Closed tournaments</h2>
        <div class="row mb-12 g-6" id="closedTournament" runat="server">
            
        </div>

    
</asp:Content>
