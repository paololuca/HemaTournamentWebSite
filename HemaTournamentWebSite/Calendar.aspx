<%@ Page Title="Calendar" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Calendar.aspx.cs" Inherits="WebApplication2.Calendar" %>

<asp:Content ID="headContent" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        @media (max-width: 550px) {
            .big-container {
                display: none;
            }
        }

        @media (min-width: 550px) {
            .small-container {
                display: none;
            }
        }
        /* Responsive iFrame */
        .responsive-iframe-container {
            position: relative;
            padding-bottom: 56.25%;
            padding-top: 30px;
            height: 0;
            overflow: hidden;
        }

            .responsive-iframe-container iframe,
            .vresponsive-iframe-container object,
            .vresponsive-iframe-container embed {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
            }
    </style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="Default.aspx">Home</a></li>
            <li class="breadcrumb-item active">Calendar</li>
        </ol>
    </nav>
    <h2 class="card-header">Calendar</h2>
    <div class="card">
        <div class="table-responsive text-nowrap" id="divAssociatesList" runat="server">
            <div class="responsive-iframe-container big-container">
                <iframe src="https://calendar.google.com/calendar/embed?src=campionatoschermastorica%40gmail.com&ctz=UTC" style="border-width: 0" width="800" height="600" frameborder="0" scrolling="no"></iframe>
            </div>

            <div class="responsive-iframe-container small-container">
                <iframe src="https://calendar.google.com/calendar/embed?src=campionatoschermastorica%40gmail.com&ctz=UTC" style="border-width: 0" width="800" height="600" frameborder="0" scrolling="no"></iframe>
            </div>
        </div>
    </div>
</asp:Content>
