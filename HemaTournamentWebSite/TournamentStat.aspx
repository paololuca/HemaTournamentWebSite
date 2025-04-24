<%@ Page Title="Tournament Stats" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="TournamentStat.aspx.cs" Inherits="HemaTournamentWebSite.WebForm1Prova" %>

<asp:Content ID="head" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .tournament-bracket {
            display: flex;
            justify-content: space-around;
            padding: 20px;
            font-family: 'Segoe UI', Arial, sans-serif;
        
            color: #333;
        }

        .round {
            display: flex;
            flex-direction: column;
            justify-content: space-around;
            margin: 0 15px;
        }

        .match {
            display: flex;
            flex-direction: column;
            margin: 8px 0;
            position: relative;
        }

        .match-box {
            width: 160px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin: 2px 0;
            padding: 4px;
            background: linear-gradient(to bottom, #696CFF, #34495e);
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            position: relative;
            transition: transform 0.2s ease;
        }

        .match-box-winner {
            width: 160px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin: 2px 0;
            padding: 4px;
            background: linear-gradient(to bottom, #ffd700, #fffa00);
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            position: relative;
            transition: transform 0.2s ease;
            text-align:center;
        }

        .match-box-silver {
            width: 160px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin: 2px 0;
            padding: 4px;
            background: linear-gradient(to bottom, #efecec, #c4c4c4);
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            position: relative;
            transition: transform 0.2s ease;
            text-align:center;
        }

        .match-box:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
        }

        .player {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 6px 8px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            font-size: 0.9em;
            color: #fff;
        }

        .player-winner {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 6px 8px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            font-size: 0.9em;
            color: #000;
        }
        .player-winner-silver {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 6px 8px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            font-size: 0.9em;
            color: #000;
        }

        .player:last-child {
            border-bottom: none;
        }

        .score {
            margin-left: 8px;
            font-weight: bold;
            color: #ffd700;
            background: rgba(0,0,0,0.2);
            padding: 2px 6px;
            border-radius: 3px;
            min-width: 24px;
            text-align: center;
        }
     
    #modalBracketScrollable .modal-content {
        background-color: black;
        color: white;
    }
        /*.connector-right {
            position: absolute;
            right: -15px;
            top: 50%;
            width: 15px;
            height: 2px;
            background-color: #95a5a6;
        }

        .connector-right::after {
            content: '';
            position: absolute;
            right: 0;
            top: -25px;
            width: 2px;
            height: 50px;
            background-color: #95a5a6;
        }

        .connector-left {
            position: absolute;
            left: -15px;
            top: 50%;
            width: 15px;
            height: 2px;
            background-color: #95a5a6;
        }

        .connector-left::after {
            content: '';
            position: absolute;
            left: 0;
            top: -25px;
            width: 2px;
            height: 50px;
            background-color: #95a5a6;
        }*/
    </style>

    <script>
        $(document).ready(function () {
            // Make fighters draggable
            $('.fighter-item').on('dragstart', function (e) {
                $(this).addClass('dragging');
                e.originalEvent.dataTransfer.setData('text/plain', $(this).data('fighter-id'));
            });

            $('.fighter-item').on('dragend', function () {
                $(this).removeClass('dragging');
            });

            // Make match boxes droppable
            $('.match-box').on('dragover', function (e) {
                e.preventDefault();
                $(this).addClass('dragover');
            });

            $('.match-box').on('dragleave', function () {
                $(this).removeClass('dragover');
            });

            $('.match-box').on('drop', function (e) {
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

        <div class="col-lg-4 col-md-6">
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


                <button type="button" class="btn btn-icon btn-primary" data-bs-toggle="modal" data-bs-target="#modalBracketScrollable" id="btnBracketFinalPhases" runat="server"
                    title="Pool's Bracket" disabled>
                    <span class="tf-icons bx bx bx-git-repo-forked bx-22px"></span>
                </button>
                <div class="modal fade" id="modalBracketScrollable" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog modal-dialog modal-fullscreen modal-dialog-scrollable" role="document">
                        <div class="modal-content">

                            <div class="modal-body">
                                <div class="table-responsive text-nowrap" id="divbracket" runat="server" style="overflow-x:auto; white-space:nowrap;">
                                    <div class="tournament-bracket" id="tournamentBracket16th"  runat="server">
                                        <!-- Round 1 - Left Side -->
                                        <div class="round" id="LeftZone16th" runat="server">
                                            <div class="match">
                                                <div class="match-box">
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket16th1_1"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket16th1_1Score"></asp:Label></span></div>
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket16th1_2"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket16th1_2Score"></asp:Label></span></div>
                                                </div>
                                                <div class="connector-right"></div>
                                            </div>
                                            <div class="match">
                                                <div class="match-box">
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket16th1_3"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket16th1_3Score"></asp:Label></span></div>
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket16th1_4"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket16th1_4Score"></asp:Label></span></div>
                                                </div>
                                                <div class="connector-right"></div>
                                            </div>
                                            <div class="match">
                                                <div class="match-box">
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket16th1_5"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket16th1_5Score"></asp:Label></span></div>
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket16th1_6"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket16th1_6Score"></asp:Label></span></div>
                                                </div>
                                                <div class="connector-right"></div>
                                            </div>
                                            <div class="match">
                                                <div class="match-box">
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket16th1_7"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket16th1_7Score"></asp:Label></span></div>
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket16th1_8"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket16th1_8Score"></asp:Label></span></div>
                                                </div>
                                                <div class="connector-right"></div>
                                            </div>
                                            <div class="match">
                                                <div class="match-box">
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket16th4_1"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket16th4_1Score"></asp:Label></span></div>
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket16th4_2"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket16th4_2Score"></asp:Label></span></div>
                                                </div>
                                                <div class="connector-right"></div>
                                            </div>
                                            <div class="match">
                                                <div class="match-box">
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket16th4_3"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket16th4_3Score"></asp:Label></span></div>
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket16th4_4"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket16th4_4Score"></asp:Label></span></div>
                                                </div>
                                                <div class="connector-right"></div>
                                            </div>
                                            <div class="match">
                                                <div class="match-box">
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket16th4_5"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket16th4_5Score"></asp:Label></span></div>
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket16th4_6"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket16th4_6Score"></asp:Label></span></div>
                                                </div>
                                                <div class="connector-right"></div>
                                            </div>
                                            <div class="match">
                                                <div class="match-box">
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket16th4_7"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket16th4_7Score"></asp:Label></span></div>
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket16th4_8"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket16th4_8Score"></asp:Label></span></div>
                                                </div>
                                                <div class="connector-right"></div>
                                            </div>
                                            <!-- Add more matches for Round 1 left side -->
                                        </div>

                                        <!-- Round 2 - Left Side -->
                                        <div class="round" id="LeftZone8th" runat="server">
                                            <div class="match">
                                                <div class="match-box">
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket8th1_1"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket8th1_1Score"></asp:Label></span></div>
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket8th1_2"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket8th1_2Score"></asp:Label></span></div>
                                                </div>
                                                <div class="connector-right"></div>
                                            </div>
                                            <div class="match">
                                                <div class="match-box">
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket8th1_3"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket8th1_3Score"></asp:Label></span></div>
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket8th1_4"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket8th1_4Score"></asp:Label></span></div>
                                                </div>
                                                <div class="connector-right"></div>
                                            </div>
                                            <div class="match">
                                                <div class="match-box">
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket8th4_1"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket8th4_1Score"></asp:Label></span></div>
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket8th4_2"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket8th4_2Score"></asp:Label></span></div>
                                                </div>
                                                <div class="connector-right"></div>
                                            </div>
                                            <div class="match">
                                                <div class="match-box">
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket8th4_3"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket8th4_3Score"></asp:Label></span></div>
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket8th4_4"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket8th4_4Score"></asp:Label></span></div>
                                                </div>
                                                <div class="connector-right"></div>
                                            </div>
                                            <!-- Add more matches for Round 2 left side -->
                                        </div>

                                        <!-- Round 3 - Left Side -->
                                        <div class="round">
                                            <div class="match">
                                                <div class="match-box">
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket4th1_1"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket4th1_1Score"></asp:Label></span></div>
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket4th1_2"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket4th1_2Score"></asp:Label></span></div>
                                                </div>
                                                <div class="connector-right"></div>
                                            </div>
                                            <div class="match">
                                                <div class="match-box">
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket4th4_1"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket4th4_1Score"></asp:Label></span></div>
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket4th4_2"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket4th4_2Score"></asp:Label></span></div>
                                                </div>
                                                <div class="connector-right"></div>
                                            </div>
                                        </div>

                                        <!-- Final Round -->
                                        <div class="round">
                                            <div class="match">
                                                <div class="match-box">
                                                    <div class="player"><asp:Label runat="server" ID="lblBracketSth1_1"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracketSth1_1Score"></asp:Label></span></div>
                                                    <div class="player"><asp:Label runat="server" ID="lblBracketSth1_2"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracketSth1_2Score"></asp:Label></span></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="round">
                                            <div class="match">
                                                <br><br><br><br><br><br><br><br><br>                                                
                                                <div class="match-box-winner">
                                                    <div class="player-winner" style="align-content:center"><asp:Label runat="server" ID="lblBracketWinner"></asp:Label></div>                                                    
                                                </div>
                                                <div class="match-box-silver">
                                                    <div class="player-winner-silver" style="align-content:center"><asp:Label runat="server" ID="lblBracketSilver"></asp:Label></div>                                                    
                                                </div>
                                            </div>
                                        </div>
                                        <div class="round">
                                            <div class="match">
                                                <div class="match-box">
                                                    <div class="player"><asp:Label runat="server" ID="lblBracketSth2_1"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracketSth2_1Score"></asp:Label></span></div>
                                                    <div class="player"><asp:Label runat="server" ID="lblBracketSth2_2"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracketSth2_2Score"></asp:Label></span></div>
                                                </div>
                                            </div>
                                        </div>


                                        <!-- Round 3 - Right Side -->
                                        <div class="round">
                                            <div class="match">
                                                <div class="match-box">
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket4th2_1"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket4th2_1Score"></asp:Label></span></div>
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket4th2_2"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket4th2_2Score"></asp:Label></span></div>
                                                </div>
                                                <div class="connector-right"></div>
                                            </div>
                                            <div class="match">
                                                <div class="match-box">
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket4th3_1"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket4th3_1Score"></asp:Label></span></div>
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket4th3_2"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket4th3_2Score"></asp:Label></span></div>
                                                </div>
                                                <div class="connector-right"></div>
                                            </div>
                                        </div>

                                        <!-- Round 2 - Right Side -->
                                        <div class="round" id="RightZone8th" runat="server">
                                            
                                            <div class="match">
                                                <div class="match-box">
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket8th2_1"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket8th2_1Score"></asp:Label></span></div>
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket8th2_2"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket8th2_2Score"></asp:Label></span></div>
                                                </div>
                                                <div class="connector-right"></div>
                                            </div>
                                            <div class="match">
                                                <div class="match-box">
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket8th2_3"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket8th2_3Score"></asp:Label></span></div>
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket8th2_4"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket8th2_4Score"></asp:Label></span></div>
                                                </div>
                                                <div class="connector-right"></div>
                                            </div>
                                            <div class="match">
                                                <div class="match-box">
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket8th3_1"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket8th3_1Score"></asp:Label></span></div>
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket8th3_2"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket8th3_2Score"></asp:Label></span></div>
                                                </div>
                                                <div class="connector-right"></div>
                                            </div>
                                            <div class="match">
                                                <div class="match-box">
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket8th3_3"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket8th3_3Score"></asp:Label></span></div>
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket8th3_4"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket8th3_4Score"></asp:Label></span></div>
                                                </div>
                                                <div class="connector-right"></div>
                                            </div>
                                            <!-- Add more matches for Round 2 left side -->
                                        </div>


                                        <!-- Round 1 - Right Side -->
                                        <div class="round" id="RightZone16th" runat="server">
                                            <div class="match">
                                                <div class="match-box">
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket16th2_1"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket16th2_1Score"></asp:Label></span></div>
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket16th2_2"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket16th2_2Score"></asp:Label></span></div>
                                                </div>
                                                <div class="connector-left"></div>
                                            </div>
                                            <div class="match">
                                                <div class="match-box">
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket16th2_3"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket16th2_3Score"></asp:Label></span></div>
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket16th2_4"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket16th2_4Score"></asp:Label></span></div>
                                                </div>
                                                <div class="connector-left"></div>
                                            </div>
                                            <div class="match">
                                                <div class="match-box">
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket16th2_5"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket16th2_5Score"></asp:Label></span></div>
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket16th2_6"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket16th2_6Score"></asp:Label></span></div>
                                                </div>
                                                <div class="connector-left"></div>
                                            </div>
                                            <div class="match">
                                                <div class="match-box">
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket16th2_7"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket16th2_7Score"></asp:Label></span></div>
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket16th2_8"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket16th2_8Score"></asp:Label></span></div>
                                                </div>
                                                <div class="connector-left"></div>
                                            </div>
                                            <div class="match">
                                                <div class="match-box">
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket16th3_1"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket16th3_1Score"></asp:Label></span></div>
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket16th3_2"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket16th3_2Score"></asp:Label></span></div>
                                                </div>
                                                <div class="connector-left"></div>
                                            </div>
                                            <div class="match">
                                                <div class="match-box">
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket16th3_3"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket16th3_3Score"></asp:Label></span></div>
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket16th3_4"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket16th3_4Score"></asp:Label></span></div>
                                                </div>
                                                <div class="connector-left"></div>
                                            </div>
                                            <div class="match">
                                                <div class="match-box">
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket16th3_5"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket16th3_5Score"></asp:Label></span></div>
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket16th3_6"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket16th3_6Score"></asp:Label></span></div>
                                                </div>
                                                <div class="connector-left"></div>
                                            </div>
                                            <div class="match">
                                                <div class="match-box">
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket16th3_7"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket16th3_7Score"></asp:Label></span></div>
                                                    <div class="player"><asp:Label runat="server" ID="lblBracket16th3_8"></asp:Label> <span class="score"><asp:Label runat="server" ID="lblBracket16th3_8Score"></asp:Label></span></div>
                                                </div>
                                                <div class="connector-left"></div>
                                            </div>
                                            <!-- Add more matches for Round 1 right side -->
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
