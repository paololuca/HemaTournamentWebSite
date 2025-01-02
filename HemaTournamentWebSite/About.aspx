<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="HemaTournamentWebSite.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<div class="card ">
      <div class="card-body">
        <small class="card-text text-uppercase text-muted small">About</small>
        <ul class="list-unstyled my-3 py-1">
          <li class="d-flex align-items-center mb-4"><i class="bx bx-user"></i><span class="fw-medium mx-2">Full Name:</span> <span>John Doe</span></li>
          <li class="d-flex align-items-center mb-4"><i class="bx bx-check"></i><span class="fw-medium mx-2">Status:</span> <span>Active</span></li>
          <li class="d-flex align-items-center mb-4"><i class="bx bx-crown"></i><span class="fw-medium mx-2">Role:</span> <span>Developer</span></li>
          <li class="d-flex align-items-center mb-4"><i class="bx bx-flag"></i><span class="fw-medium mx-2">Country:</span> <span>USA</span></li>
          <li class="d-flex align-items-center mb-2"><i class="bx bx-detail"></i><span class="fw-medium mx-2">Languages:</span> <span>English</span></li>
        </ul>
        <small class="card-text text-uppercase text-muted small">Contacts</small>
        <ul class="list-unstyled my-3 py-1">
          <li class="d-flex align-items-center mb-4"><i class="bx bx-phone"></i><span class="fw-medium mx-2">Contact:</span> <span>(123) 456-7890</span></li>
          <li class="d-flex align-items-center mb-4"><i class="bx bx-chat"></i><span class="fw-medium mx-2">Skype:</span> <span>john.doe</span></li>
          <li class="d-flex align-items-center mb-4"><i class="bx bx-envelope"></i><span class="fw-medium mx-2">Email:</span> <span>john.doe@example.com</span></li>
        </ul>
        <small class="card-text text-uppercase text-muted small">Teams</small>
        <ul class="list-unstyled mb-0 mt-3 pt-1">
          <li class="d-flex flex-wrap mb-4"><span class="fw-medium me-2">Backend Developer</span><span>(126 Members)</span></li>
          <li class="d-flex flex-wrap">
            <span class="fw-medium me-2">React Developer</span><span>(98 Members)</span>
          </li>
        </ul>
      </div>
    </div>
</asp:Content>
