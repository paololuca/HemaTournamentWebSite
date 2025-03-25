<%@ Page Title="Contacts" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="HemaTournamentWebSite.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="Default.aspx">Home</a></li>
            <li class="breadcrumb-item active">Contact</li>
        </ol>
    </nav>
    
    <h2><%: Title %></h2>
    

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<div class="container d-flex justify-content-center align-items-center min-vh-400">
    <div class="card profile-card">
        <div class="card-body text-center">

            <img src="assets/img/avatars/genderFencing.png" alt="User Profile" class="rounded-circle profile-img mb-3">
            <h3 class="card-title mb-2">HEMA Dev</h3>
            <p class="card-text text-muted mb-3"><i class="bi bi-gender-trans"></i>Passionate Web Developers</p>
            <p class="card-text mb-4">This site is provided by professional <b>keypressers</b>.</p>
            <div class="social-icons mb-4">
                <a href="https://www.facebook.com/SchermaStoricaASC" target="_blank" class="me-2"><i class="fab fa-facebook-f"></i></a>
                <a href="mailto:campionatoschermastorica@gmail.com" class="me-2"><i class="fa-sharp fa-solid fa-envelope"></i></a>
                <a href="https://www.instagram.com/schermastoricaasc?utm_source=ig_web_button_share_sheet&igsh=ZDNlZDc0MzIxNw==" target="_blank" class="me-2"><i class="fa-brands fa-instagram"></i></a>
                <a href="https://t.me/schermastoricaasc" target="" class="me-2"><i class="fa-brands fa-telegram"></i></a>
            </div>
        </div>
    </div>
</div>
</asp:Content>
