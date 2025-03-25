<%@ Page Title="Tournament Stats" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="TournamentStat.aspx.cs" Inherits="HemaTournamentWebSite.WebForm1Prova" %>

<asp:Content ID="head" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .tournament-bracket {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 40px 20px;
            position: relative;
            min-height: 600px;
        }

        .bracket-half {
            display: flex;
            flex: 1;
            justify-content: space-around;
        }

        .bracket-final {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin: 0 40px;
        }

        .round {
            display: flex;
            flex-direction: column;
            justify-content: space-around;
            padding: 20px;
        }

        .match-pair {
            display: flex;
            flex-direction: column;
            justify-content: space-around;
            margin: 20px 0;
            position: relative;
        }

        .match {
            display: flex;
            flex-direction: column;
            margin: 10px 0;
            position: relative;
        }

        .match-box {
            border: 2px solid #ccc;
            padding: 8px 12px;
            margin: 5px 0;
            width: 150px;
            height: 40px;
            background-color: #fff;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .match-box.droppable {
            border-style: solid;
        }

        .match-box.droppable.dragover {
            background-color: #e2e6ea;
            border-color: #007bff;
        }

        .trophy {
            font-size: 2em;
            color: gold;
            margin-top: 20px;
        }

        .fighter-item {
            cursor: move;
            padding: 8px;
            margin: 4px 0;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .fighter-item:hover {
            background-color: #f8f9fa;
        }

        /* Connectors */
        .match::after {
            content: '';
            position: absolute;
            right: -20px;
            top: 50%;
            width: 20px;
            height: 2px;
            background-color: #ccc;
        }

        .match::before {
            content: '';
            position: absolute;
            right: -20px;
            height: 100%;
            width: 2px;
            background-color: #ccc;
        }

        .match:last-child::before {
            display: none;
        }

        .bracket-final .match::after,
        .bracket-final .match::before {
            display: none;
        }
    </style>

    <script>
        $(document).ready(function() {
            // Make fighters draggable
            $('.fighter-item').on('dragstart', function(e) {
                $(this).addClass('dragging');
                e.originalEvent.dataTransfer.setData('text/plain', $(this).data('fighter-id'));
            });

            $('.fighter-item').on('dragend', function() {
                $(this).removeClass('dragging');
            });

            // Make match boxes droppable
            $('.match-box').on('dragover', function(e) {
                e.preventDefault();
                $(this).addClass('dragover');
            });

            $('.match-box').on('dragleave', function() {
                $(this).removeClass('dragover');
            });

            $('.match-box').on('drop', function(e) {
                e.preventDefault();
                $(this).removeClass('dragover');
                
                var fighterId = e.originalEvent.dataTransfer.getData('text/plain');
                var fighter = $(`[data-fighter-id="${fighterId}"]`);
                
                $(this).empty().append(fighter.text());
                $(this).data('fighter-id', fighterId);
            });
        });
    </script>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="Default.aspx">Home</a></li>
            <li class="breadcrumb-item"><a href="TournamentDates.aspx">Tournaments</a></li>
            <li class="breadcrumb-item active">Tournament Stats</li>
        </ol>
    </nav>
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
                <asp:Button type="button" Text="Choose discipline" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-haspopup="true"
                    aria-expanded="false" runat="server" />
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
                <button type="button" class="btn btn-icon btn-primary" data-bs-toggle="modal" data-bs-target="#modalScrollable" id="btnPoolsQualification" runat="server"
                    title="Pool's Qualification" disabled>
                    <span class="tf-icons bx  bx-arrow-to-top bx-22px"></span>
                </button>
                <div class="modal fade" id="modalScrollable" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog modal-xl modal-dialog-scrollable" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="modalScrollableTitle">Pool's Qualification</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="table-responsive text-nowrap" id="divRankingTable" runat="server">
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>


                <%--<button type="button" class="btn btn-icon btn-primary" data-bs-toggle="modal" data-bs-target="#modalBracketScrollable" id="btnBracket" runat="server"
                    title="Pool's Bracket" disabled">
                    <span class="tf-icons bx bx bx-git-repo-forked bx-22px"></span>
                </button>--%>
                <div class="modal fade" id="modalBracketScrollable" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog modal-dialog modal-fullscreen modal-dialog-scrollable" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="modalBracketScrollableTitle">Pool's Bracket</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="table-responsive text-nowrap" id="divbracket" runat="server">
                                    <div class="tournament-bracket">
                <!-- Left Side -->
                <div class="bracket-half">
                    <!-- First Round - Left -->
                    <div class="round">
                        <div class="match">
                            <div class="match">
                                <div class="match-box droppable"><p>ciccio</p></div>
                                <div class="match-box droppable">pasticcio</div>
                            </div>
                            <div class="match">
                                <div class="match-box droppable"></div>
                                <div class="match-box droppable"></div>
                            </div>
                        </div>
                        <div class="match">
                            <div class="match">
                                <div class="match-box droppable"></div>
                                <div class="match-box droppable"></div>
                            </div>
                            <div class="match">
                                <div class="match-box droppable"></div>
                                <div class="match-box droppable"></div>
                            </div>
                        </div>
                    </div>

                    <!-- Second Round - Left -->
                    <div class="round">
                        <div class="match">
                            <div class="match">
                                <div class="match-box droppable"></div>
                                <div class="match-box droppable"></div>
                            </div>
                        </div>
                        <div class="match">
                            <div class="match">
                                <div class="match-box droppable"></div>
                                <div class="match-box droppable"></div>
                            </div>
                        </div>
                    </div>

                    <!-- Third Round - Left -->
                    <div class="round">
                        <div class="match">
                            <div class="match-box droppable"></div>
                            <div class="match-box droppable"></div>
                        </div>
                    </div>
                </div>

                <!-- Final -->
                <div class="bracket-final">
                    <div class="match">
                        <div class="match-box droppable"></div>
                        <div class="match-box droppable"></div>
                    </div>
                    <div class="trophy">
                        <i class="fas fa-trophy"></i>
                    </div>
                </div>

                <!-- Right Side -->
                <div class="bracket-half">
                    <!-- Third Round - Right -->
                    <div class="round">
                        <div class="match">
                            <div class="match-box droppable"></div>
                            <div class="match-box droppable"></div>
                        </div>
                    </div>

                    <!-- Second Round - Right -->
                    <div class="round">
                        <div class="match">
                            <div class="match">
                                <div class="match-box droppable"></div>
                                <div class="match-box droppable"></div>
                            </div>
                        </div>
                        <div class="match">
                            <div class="match">
                                <div class="match-box droppable"></div>
                                <div class="match-box droppable"></div>
                            </div>
                        </div>
                    </div>

                    <!-- First Round - Right -->
                    <div class="round">
                        <div class="match">
                            <div class="match">
                                <div class="match-box droppable"></div>
                                <div class="match-box droppable"></div>
                            </div>
                            <div class="match">
                                <div class="match-box droppable"></div>
                                <div class="match-box droppable"></div>
                            </div>
                        </div>
                        <div class="match">
                            <div class="match">
                                <div class="match-box droppable"></div>
                                <div class="match-box droppable"></div>
                            </div>
                            <div class="match">
                                <div class="match-box droppable"></div>
                                <div class="match-box droppable"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <div class="row my-6 responsive-iframe-container small-container">
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
                            data-bs-target="#navs-pills-justified-final"
                            aria-controls="navs-pills-justified-final"
                            aria-selected="false">
                            <span class="d-none d-sm-block"><i class="tf-icons bx bx-flag bx-sm me-1_5 align-text-bottom"></i>Final Phases</span><i class="bx bx-flag bx-sm d-sm-none"></i>
                        </button>
                    </li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane fade show active overflow-auto" id="navs-pills-justified-pools" role="tabpanel" style="max-width: 8000px; max-height: 700px;">

                        <div class="text-nowrap" id="divPoolsList" runat="server">
                        </div>

                    </div>
                    <div class="tab-pane fade overflow-auto" id="navs-pills-justified-matches" role="tabpanel" style="max-width: 8000px; max-height: 700px;">
                        <div class="text-nowrap" id="div1" runat="server">
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
                                        <span class="d-none d-sm-block"><i class="tf-icons bx bx-bar-chart bx-sm me-1_5 align-text-bottom"></i>Final</span><i class="bx bx-bar-chart bx-sm d-sm-none"></i>
                                    </button>
                                </li>
                            </ul>
                        </div>
                        <div class="tab-content">
                            <div class="tab-pane fade show active overflow-auto" id="navs-pills-justified-16th" role="tabpanel" style="max-width: 8000px; max-height: 700px;">
                                <div class="table-responsive text-nowrap" id="div16th" runat="server">
                                </div>
                            </div>
                            <div class="tab-pane fade show overflow-auto" id="navs-pills-justified-8th" role="tabpanel" style="max-width: 8000px; max-height: 700px;">
                                <div class="table-responsive text-nowrap" id="div8th" runat="server">
                                </div>
                            </div>
                            <div class="tab-pane fade show overflow-auto" id="navs-pills-justified-4th" role="tabpanel" style="max-width: 8000px; max-height: 700px;">
                                <div class="table-responsive text-nowrap" id="div4th" runat="server">
                                </div>
                            </div>
                            <div class="tab-pane fade show overflow-auto" id="navs-pills-justified-semifinal" role="tabpanel" style="max-width: 8000px; max-height: 700px;">
                                <div class="table-responsive text-nowrap" id="divSemifinal" runat="server">
                                </div>
                            </div>
                            <div class="tab-pane fade show overflow-auto" id="navs-pills-justified-finalResult" role="tabpanel" style="max-width: 8000px; max-height: 700px;">
                                <div class="table-responsive text-nowrap" id="divFinal" runat="server">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
