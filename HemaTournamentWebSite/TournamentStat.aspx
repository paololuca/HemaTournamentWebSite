<%@ Page Title="Tournament Stats" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="TournamentStat.aspx.cs" Inherits="HemaTournamentWebSite.WebForm1Prova" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    / <a href="Default.aspx">Home</a> / <a href="TournamentDates.aspx">Tournaments</a>
    <h3>Tournament Stats -
        <asp:Label ID="lblTournament" runat="server"></asp:Label><asp:Label ID="lblDiscipline" runat="server"></asp:Label></h3>
    <%--    <div class="btn-group" runat="server" id="btnTournament">
        <asp:Button type="button" Text="Choose tournament" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false" runat="server" />
        <ul class="dropdown-menu " runat="server" id="dropdownTournamentMenu">
        </ul>
        <ul class="dropdown-menu " runat="server" id="Ul1">
        </ul>

    </div>--%>

    <%--<div class="btn-group" runat="server" id="btnDiscipline">--%>
    
    <div class="row gy-3">
        <%--<div class="col-lg-3 col-md-6">
    <div class="mt-4">
        
    </div>
</div>--%>
        
        <div class="col-lg-3 col-md-6">
            <div class="mt-4">
                                        <asp:Button type="button" Text="Choose discipline" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false" runat="server" />
<ul class="dropdown-menu" runat="server" id="dropdownDisciplineMenu"></ul>
                <button
                    class="btn btn-icon btn-primary"
                    type="button"
                    data-bs-toggle="offcanvas"
                    data-bs-target="#offcanvasBackdrop"
                    aria-controls="offcanvasBackdrop"
                    title="Pool's Performance Indicators" disabled id="btnPoolsIndicators" runat="server">
                    <span class="tf-icons bx bx-bar-chart bx-22px"></span>
                </button>
                <div
                    class="offcanvas offcanvas-end"
                    tabindex="-1"
                    id="offcanvasBackdrop"
                    aria-labelledby="offcanvasBackdropLabel">
                    <div class="offcanvas-header">
                        <h5 id="offcanvasBackdropLabel" class="offcanvas-title">Pools Indicators</h5>
                        <button
                            type="button"
                            class="btn-close text-reset"
                            data-bs-dismiss="offcanvas"
                            aria-label="Close">
                        </button>
                    </div>
                    <div class="offcanvas-body my-auto mx-0 flex-grow-0">
                        <div class="card" runat="server" id="kpiDiv" visible="false">
                            <div class="card-header">
                                <div class="card-widget-separator-wrapper">
                                    <div class="card-body card-widget-separator">

                                        <div class="d-flex justify-content-between align-items-start card-widget-1 border-end pb-4 pb-sm-0">
                                            <div>
                                                <p class="mb-1">Best Delta</p>
                                                <h4 class="mb-1">
                                                    <asp:Label ID="lblBestDelta" runat="server"></asp:Label></h4>
                                                <p class="mb-0">
                                                    <span class="me-2">Sorts by <span class="badge bg-label-info">Delta</span> in descending order and selects the top player.</span>
                                            </div>
                                            <span class="avatar p-2 me-sm-6">
                                                <span class="avatar-initial rounded w-px-44 h-px-44">
                                                    <i class="bx bx-detail bx-lg text-heading"></i>
                                                </span>
                                            </span>
                                        </div>
                                        <hr class="d-none d-sm-block d-lg-none me-6" />

                                        <div class="d-flex justify-content-between align-items-start card-widget-2 border-end pb-4 pb-sm-0">
                                            <div>
                                                <p class="mb-1">Most Wins</p>
                                                <h4 class="mb-1">
                                                    <asp:Label ID="lblMostWins" runat="server"></asp:Label></h4>
                                                <p class="mb-0">
                                                    <span class="me-2">Sorts by <span class="badge bg-label-success">Victory</span> in descending order and selects the top player.</span>
                                            </div>
                                            <span class="avatar p-2 me-lg-6">
                                                <span class="avatar-initial rounded w-px-44 h-px-44">
                                                    <i class="bx bx-medal bx-lg text-heading"></i>
                                                </span>
                                            </span>
                                        </div>
                                        <hr class="d-none d-sm-block d-lg-none" />

                                        <div class="d-flex justify-content-between align-items-start border-end pb-4 pb-sm-0 card-widget-3">
                                            <div>
                                                <p class="mb-1">Best Win Percentage</p>
                                                <h4 class="mb-1">
                                                    <asp:Label ID="lblPointEfficiency" runat="server"></asp:Label></h4>
                                                <p class="mb-0">Calculates the percentage of points scored (Hit) compared to total points involved (<span class="badge bg-label-success">Hit</span> + <span class="badge bg-label-danger">Hitted</span>).</p>
                                            </div>
                                            <span class="avatar p-2 me-sm-6">
                                                <span class="avatar-initial rounded w-px-44 h-px-44">
                                                    <i class="bx bx-arrow-to-top bx-lg text-heading"></i>
                                                </span>
                                            </span>
                                        </div>

                                        <div class="d-flex justify-content-between align-items-start border-end pb-4 pb-sm-0 card-widget-3">
                                            <div>
                                                <p class="mb-1">Most Points Scored</p>
                                                <h4 class="mb-1">
                                                    <asp:Label ID="lblMostPointScored" runat="server"></asp:Label></h4>
                                                <p class="mb-0">
                                                    <span class="me-2">Sorts by <span class="badge bg-label-success">Hit</span> in descending order and selects the top player.
                                                    </span>
                                                </p>
                                            </div>
                                            <span class="avatar p-2 me-sm-6">
                                                <span class="avatar-initial rounded w-px-44 h-px-44">
                                                    <i class="bx bx-award bx-lg text-heading"></i>
                                                </span>
                                            </span>
                                        </div>

                                        <div class="d-flex justify-content-between align-items-start card-widget-1 border-end pb-4 pb-sm-0">
                                            <div>
                                                <p class="mb-1">Fewest Points Taken</p>
                                                <h4 class="mb-1">
                                                    <asp:Label ID="lblFewestPointsTaken" runat="server"></asp:Label></h4>
                                                <p class="mb-0">
                                                    <span class="me-2">Sorts by <span class="badge bg-label-danger">Hitted</span> in ascending order and selects the top player.</span>
                                            </div>
                                            <span class="avatar p-2 me-sm-6">
                                                <span class="avatar-initial rounded w-px-44 h-px-44">
                                                    <i class="bx bx-arrow-from-top bx-lg text-heading"></i>
                                                </span>
                                            </span>
                                        </div>
                                        <hr class="d-none d-sm-block d-lg-none me-6">

                                        <div class="d-flex justify-content-between align-items-start card-widget-2 border-end pb-4 pb-sm-0">
                                            <div>
                                                <p class="mb-1">Best Ranking</p>
                                                <h4 class="mb-1">
                                                    <asp:Label ID="lblBestranking" runat="server"></asp:Label></h4>
                                                <p class="mb-0">
                                                    <span class="me-2">Sorts by <span class="badge bg-label-success">Position</span> and selects the top player.</span>
                                            </div>
                                            <span class="avatar p-2 me-lg-6">
                                                <span class="avatar-initial rounded w-px-44 h-px-44">
                                                    <i class="bx bx-medal bx-lg text-heading"></i>
                                                </span>
                                            </span>
                                        </div>
                                        <hr class="d-none d-sm-block d-lg-none">

                                        <div class="d-flex justify-content-between align-items-start border-end pb-4 pb-sm-0 card-widget-3">
                                            <div>
                                                <p class="mb-1">Average Delta</p>
                                                <h4 class="mb-1">
                                                    <asp:Label ID="lblAverageDelta" runat="server"></asp:Label></h4>
                                                <p class="mb-0">Calculates the average value of the <span class="badge bg-label-info">Delta</span> across all players.</p>
                                            </div>
                                            <span class="avatar p-2 me-sm-6">
                                                <span class="avatar-initial rounded w-px-44 h-px-44">
                                                    <i class="bx bx-math bx-lg text-heading"></i>
                                                </span>
                                            </span>
                                        </div>
                                        <div class="d-flex justify-content-between align-items-start border-end pb-4 pb-sm-0 card-widget-3">
                                            <div>
                                                <p class="mb-1">Best Win/Loss Ratio:</p>
                                                <h4 class="mb-1">
                                                    <asp:Label ID="lblBestWinLossRatio" runat="server"></asp:Label></h4>
                                                <p class="mb-0"><span class="me-2">Calculates the ratio of wins to losses for each player and selects the highest.</span></p>
                                            </div>
                                            <span class="avatar p-2 me-sm-6">
                                                <span class="avatar-initial rounded w-px-44 h-px-44">
                                                    <i class="bx bx-bar-chart bx-lg text-heading"></i>
                                                </span>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                        </div>

                    </div>     
                    <button
                        type="button"
                        class="btn btn-primary d-grid w-100"
                        data-bs-dismiss="offcanvas">
                        Close
                    </button>
                </div>
                </div>
                        

            </div>
        </div>
        
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
                            data-bs-target="#navs-pills-justified-pools"
                            aria-controls="navs-pills-justified-pools"
                            aria-selected="false">
                            <span class="d-none d-sm-block"><i class="tf-icons bx bx-list-check bx-sm me-1_5 align-text-bottom"></i>Pools</span><i class="bx bx-list-check bx-sm d-sm-none"></i>
                        </button>
                    </li>
                    <li class="nav-item mb-1 mb-sm-0">
                        <button
                            type="button"
                            class="nav-link"
                            role="tab"
                            data-bs-toggle="tab"
                            data-bs-target="#navs-pills-justified-matches"
                            aria-controls="navs-pills-justified-matches"
                            aria-selected="true">
                            <span class="d-none d-sm-block"><i class="tf-icons bx bx-git-branch bx-sm me-1_5 align-text-bottom"></i>Matches</span><i class="bx bx-git-branch bx-sm d-sm-none"></i>
                        </button>
                    </li>
                    <li class="nav-item mb-1 mb-sm-0">
                        <button
                            type="button"
                            class="nav-link"
                            role="tab"
                            data-bs-toggle="tab"
                            data-bs-target="#navs-pills-justified-qualification"
                            aria-controls="navs-pills-justified-qualification"
                            aria-selected="false">
                            <span class="d-none d-sm-block"><i class="tf-icons bx bx-arrow-to-top bx-sm me-1_5 align-text-bottom"></i>Qualification</span><i class="bx bx-arrow-to-top bx-sm d-sm-none"></i>
                        </button>
                    </li>
                    <li class="nav-item mb-1 mb-sm-0">
                        <button
                            type="button"
                            class="nav-link"
                            role="tab"
                            data-bs-toggle="tab"
                            data-bs-target="#navs-pills-justified-final"
                            aria-controls="navs-pills-justified-final"
                            aria-selected="false">
                            <span class="d-none d-sm-block"><i class="tf-icons bx bx-flag bx-sm me-1_5 align-text-bottom"></i>Final Phases</span><i class="bx bx-flag bx-sm d-sm-none"></i>
                        </button>
                    </li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane fade show active" id="navs-pills-justified-pools" role="tabpanel">
                        <div class="text-nowrap" id="divPoolsList" runat="server">
                        </div>
                    </div>
                    <div class="tab-pane fade" id="navs-pills-justified-matches" role="tabpanel">
                        <div class="text-nowrap" id="div1" runat="server">
                        </div>
                    </div>
                    <div class="tab-pane fade" id="navs-pills-justified-qualification" role="tabpanel">
                        <div class="table-responsive text-nowrap" id="divRankingTable" runat="server">
                        </div>
                    </div>
                    <div class="tab-pane fade" id="navs-pills-justified-final" role="tabpanel">
                        <div class="container-xxl container-p-y">
                            <ul class="nav nav-pills mb-4 nav-fill" role="tablist">
                                <li class="nav-item mb-1 mb-sm-0">
                                    <button
                                        type="button"
                                        class="nav-link active"
                                        role="tab"
                                        data-bs-toggle="tab"
                                        data-bs-target="#navs-pills-justified-16th"
                                        aria-controls="navs-pills-justified-16th"
                                        aria-selected="true">
                                        <span class="d-none d-sm-block"><i class="tf-icons bx bx-bar-chart bx-sm me-1_5 align-text-bottom"></i>16th</span><i class="bx bx-bar-chart bx-sm d-sm-none"></i>
                                    </button>
                                </li>
                                <li class="nav-item mb-1 mb-sm-0">
                                    <button
                                        type="button"
                                        class="nav-link"
                                        role="tab"
                                        data-bs-toggle="tab"
                                        data-bs-target="#navs-pills-justified-8th"
                                        aria-controls="navs-pills-justified-8th"
                                        aria-selected="true">
                                        <span class="d-none d-sm-block"><i class="tf-icons bx bx-bar-chart bx-sm me-1_5 align-text-bottom"></i>8th</span><i class="bx bx-bar-chart bx-sm d-sm-none"></i>
                                    </button>
                                </li>
                                <li class="nav-item mb-1 mb-sm-0">
                                    <button
                                        type="button"
                                        class="nav-link"
                                        role="tab"
                                        data-bs-toggle="tab"
                                        data-bs-target="#navs-pills-justified-4th"
                                        aria-controls="navs-pills-justified-4th"
                                        aria-selected="true">
                                        <span class="d-none d-sm-block"><i class="tf-icons bx bx-bar-chart bx-sm me-1_5 align-text-bottom"></i>4th</span><i class="bx bx-bar-chart bx-sm d-sm-none"></i>
                                    </button>
                                </li>
                                <li class="nav-item mb-1 mb-sm-0">
                                    <button
                                        type="button"
                                        class="nav-link"
                                        role="tab"
                                        data-bs-toggle="tab"
                                        data-bs-target="#navs-pills-justified-semifinal"
                                        aria-controls="navs-pills-justified-semifinal"
                                        aria-selected="true">
                                        <span class="d-none d-sm-block"><i class="tf-icons bx bx-bar-chart bx-sm me-1_5 align-text-bottom"></i>Semifinal</span><i class="bx bx-bar-chart bx-sm d-sm-none"></i>
                                    </button>
                                </li>
                                <li class="nav-item mb-1 mb-sm-0">
                                    <button
                                        type="button"
                                        class="nav-link"
                                        role="tab"
                                        data-bs-toggle="tab"
                                        data-bs-target="#navs-pills-justified-finalResult"
                                        aria-controls="navs-pills-justified-finalResult"
                                        aria-selected="true">
                                        <span class="d-none d-sm-block"><i class="tf-icons bx bx-bar-chart bx-sm me-1_5 align-text-bottom"></i>Final</span><i class="bx bx-home bx-sm d-sm-none"></i>
                                    </button>
                                </li>
                            </ul>
                        </div>
                        <div class="tab-content">
                            <div class="tab-pane fade show active" id="navs-pills-justified-16th" role="tabpanel">
                                <div class="table-responsive text-nowrap" id="div16th" runat="server">
                                    <h3 class="mb-2 mx-2">Under Maintenance! 🚧</h3>
                                    <div class="mt-6">
                                        <img
                                            src="../assets/img/illustrations/girl-doing-yoga-light.png"
                                            alt="girl-doing-yoga-light"
                                            width="500"
                                            class="img-fluid"
                                            data-app-light-img="illustrations/girl-doing-yoga-light.png"
                                            data-app-dark-img="illustrations/girl-doing-yoga-dark.png" />
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade show" id="navs-pills-justified-8th" role="tabpanel">
                                <div class="table-responsive text-nowrap" id="div8th" runat="server">
                                    <h3 class="mb-2 mx-2">Under Maintenance! 🚧</h3>
                                    <div class="mt-6">
                                        <img
                                            src="../assets/img/illustrations/girl-doing-yoga-light.png"
                                            alt="girl-doing-yoga-light"
                                            width="500"
                                            class="img-fluid"
                                            data-app-light-img="illustrations/girl-doing-yoga-light.png"
                                            data-app-dark-img="illustrations/girl-doing-yoga-dark.png" />
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade show" id="navs-pills-justified-4th" role="tabpanel">
                                <div class="table-responsive text-nowrap" id="div4th" runat="server">
                                    <h3 class="mb-2 mx-2">Under Maintenance! 🚧</h3>
                                    <div class="mt-6">
                                        <img
                                            src="../assets/img/illustrations/girl-doing-yoga-light.png"
                                            alt="girl-doing-yoga-light"
                                            width="500"
                                            class="img-fluid"
                                            data-app-light-img="illustrations/girl-doing-yoga-light.png"
                                            data-app-dark-img="illustrations/girl-doing-yoga-dark.png" />
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade show" id="navs-pills-justified-semifinal" role="tabpanel">
                                <div class="table-responsive text-nowrap" id="divSemifinal" runat="server">
                                    <h3 class="mb-2 mx-2">Under Maintenance! 🚧</h3>
                                    <div class="mt-6">
                                        <img
                                            src="../assets/img/illustrations/girl-doing-yoga-light.png"
                                            alt="girl-doing-yoga-light"
                                            width="500"
                                            class="img-fluid"
                                            data-app-light-img="illustrations/girl-doing-yoga-light.png"
                                            data-app-dark-img="illustrations/girl-doing-yoga-dark.png" />
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade show" id="navs-pills-justified-finalResult" role="tabpanel">
                                <div class="table-responsive text-nowrap" id="divFinal" runat="server">
                                    <h3 class="mb-2 mx-2">Under Maintenance! 🚧</h3>
                                    <div class="mt-6">
                                        <img
                                            src="../assets/img/illustrations/girl-doing-yoga-light.png"
                                            alt="girl-doing-yoga-light"
                                            width="500"
                                            class="img-fluid"
                                            data-app-light-img="illustrations/girl-doing-yoga-light.png"
                                            data-app-dark-img="illustrations/girl-doing-yoga-dark.png" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                </div>
            </div>
        </div>
    </div>
</asp:Content>
