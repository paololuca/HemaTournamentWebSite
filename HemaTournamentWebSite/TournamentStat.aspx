<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="TournamentStat.aspx.cs" Inherits="WebApplication2.WebForm1Prova" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <h1>Tournament Stats </h1>
    <div class="btn-group" runat="server" id="btnTournament">
        <asp:Button type="button" Text="Choose tournament" class="btn btn-primary dropdown-toggle overflow-hidden d-sm-inline-flex d-block text-truncate" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false" runat="server" />
        <ul class="dropdown-menu dropdown-menu-end" runat="server" id="dropdownTournamentMenu">
        </ul>
        <ul class="dropdown-menu dropdown-menu-end" runat="server" id="Ul1">
        </ul>

    </div>

    <div class="btn-group" runat="server" id="btnDiscipline">
        <asp:Button type="button" Text="Choose discipline" class="btn btn-primary dropdown-toggle overflow-hidden d-sm-inline-flex d-block text-truncate" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false" runat="server" />
        <ul class="dropdown-menu dropdown-menu-end" runat="server" id="dropdownDisciplineMenu">
        </ul>
        <ul class="dropdown-menu dropdown-menu-end" runat="server" id="Ul2">
        </ul>

    </div>


    <div class="divider"></div>

    <div class="card">
    </div>

    <div class="row my-6">
        <div class="col">
            
            <div class="nav-align-top mb-6">
                <ul class="nav nav-pills mb-4 nav-fill" role="tablist">
                    <li class="nav-item mb-1 mb-sm-0">
                        <button
                            type="button"
                            class="nav-link active"
                            role="tab"
                            data-bs-toggle="tab"
                            data-bs-target="#navs-pills-justified-home"
                            aria-controls="navs-pills-justified-home"
                            aria-selected="true">
                            <span class="d-none d-sm-block"><i class="tf-icons bx bx-sync bx-sm me-1_5 align-text-bottom"></i>Pools</span><i class="bx bx-home bx-sm d-sm-none"></i>
                        </button>
                    </li>
                    <li class="nav-item mb-1 mb-sm-0">
                        <button
                            type="button"
                            class="nav-link"
                            role="tab"
                            data-bs-toggle="tab"
                            data-bs-target="#navs-pills-justified-profile"
                            aria-controls="navs-pills-justified-profile"
                            aria-selected="false">
                            <span class="d-none d-sm-block"><i class="tf-icons bx bx-arrow-to-top bx-sm me-1_5 align-text-bottom"></i>Ranking</span><i class="bx bx-user bx-sm d-sm-none"></i>
                        </button>
                    </li>
                    <li class="nav-item mb-1 mb-sm-0">
                        <button
                            type="button"
                            class="nav-link"
                            role="tab"
                            data-bs-toggle="tab"
                            data-bs-target="#navs-pills-justified-profile"
                            aria-controls="navs-pills-justified-profile"
                            aria-selected="false">
                            <span class="d-none d-sm-block"><i class="tf-icons bx bx-flag bx-sm me-1_5 align-text-bottom"></i>Final Phases</span><i class="bx bx-user bx-sm d-sm-none"></i>
                        </button>
                    </li>
                    <li class="nav-item">
                        <button
                            type="button"
                            class="nav-link"
                            role="tab"
                            data-bs-toggle="tab"
                            data-bs-target="#navs-pills-justified-messages"
                            aria-controls="navs-pills-justified-messages"
                            aria-selected="false">
                            <span class="d-none d-sm-block"><i class="tf-icons bx bx-bar-chart bx-sm me-1_5 align-text-bottom"></i>Stats</span><i class="bx bx-message-square bx-sm d-sm-none"></i>
                        </button>
                    </li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane fade show active" id="navs-pills-justified-home" role="tabpanel">
                        <div class="accordion" id="collapsibleSection" runat="server">
                            <div class="card accordion-item">
                                <div id="collapseDeliveryAddress" class="accordion-collapse collapse" data-bs-parent="#collapsibleSection" style="">
                                    <div class="accordion-body">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="navs-pills-justified-profile" role="tabpanel">
                        <p class="mb-0">
                            classifica
                        </p>
                    </div>
                    <div class="tab-pane fade" id="navs-pills-justified-messages" role="tabpanel">
                        <p class="mb-0">
                            Altro
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
