<%@ Page Title="Club" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Club.aspx.cs" Inherits="WebApplication2.Club" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="Default.aspx">Home</a></li>
            <li class="breadcrumb-item"><a href="Clubs.aspx">Clubs</a></li>
            <li class="breadcrumb-item active">Club Details</li>
        </ol>
    </nav>

    / <a href="Default.aspx">Home</a> / <a href="Clubs.aspx">Clubs</a>

    <div class="card">
        <br />
        <div class="d-flex align-items-start align-items-sm-center gap-6 pb-4 border-bottom">
    <img alt="Club Logo" class="d-block w-px-230 h-px-150 rounded" id="clubAvatar" runat="server" src="#" />
            <h4>
    <asp:Label ID="lblClubName" runat="server"></asp:Label><asp:Label ID="lblClubPlace" runat="server"></asp:Label></h4>
</div>
        
        <br />
        
        <div class="overflow-auto p-3 mb-3 mb-md-0 me-md-3 bg-light" style="max-width: 8000px; max-height: 480px;">
            <div class="table-responsive text-nowrap" id="divAssociatesList" runat="server">
            </div>
        </div>
    </div>
</asp:Content>
