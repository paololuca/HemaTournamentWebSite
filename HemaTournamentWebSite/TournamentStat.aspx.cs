using HemaTournamentWebSiteBLL.DAL;
using HemaTournamentWebSiteBLL.DAL.DAL.Entity;
using HemaTournamentWebSiteBLL.Manager;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using HemaTournamentWebSiteBLL.Manager;
using HemaTournamentWebSiteBLL.BusinessEntity.Entity;
using System.Runtime.Remoting.Messaging;
using System.Security.Policy;
using HemaTournamentWebSiteBLL.BusinessEntity.DAO;
using System.Drawing;
using System.Web.UI.WebControls.WebParts;

namespace HemaTournamentWebSite
{
    public partial class WebForm1Prova : System.Web.UI.Page
    {
        private int tournamentId;
        private int disciplineId;

        // Simulazione di dati recuperati dal database
        private List<string> disciplineList = new List<string> { "Spada e Pugnale", "Spada e Rotella", "Spada e Brocchiere", "Spada a due Mani" };
        private List<string> disciplineIdList = new List<string> { "2", "3", "4", "11" };


        SqlTournamentHema tournamentEngine = new SqlTournamentHema();
        SqlPoolsMatchestHema matchtsEngine = new SqlPoolsMatchestHema();
        SqlPoolsStatstHema statEngine = new SqlPoolsStatstHema();
        SqlTestConnectionHema testEngine = new SqlTestConnectionHema();

        private List<Matches> matches;
        private bool debug;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Ricrea gli elementi dinamici sempre, anche durante i postback
            if (!Page.IsPostBack)
            {
            }

            debug = ConfigurationManager.AppSettings["Debug"].ToString() == "true";

            ParseUrlId();

            //LoadTournamentDropdownItems();
            LoadDisciplineDropdownItems();

        }

        private void ParseUrlId()
        {
            // Controllo se i parametri esistono
            string tournament = Request.QueryString["idTournament"];
            string discipline = Request.QueryString["idDiscipline"];

            if (!string.IsNullOrEmpty(tournament))
            {
                // Fai qualcosa con idTournament
                tournamentId = int.Parse(tournament);

                var tournamentEntity = tournamentEngine.LoadTorunamentsDesc(tournamentId);

                if (tournamentEntity != null)
                    lblTournament.Text = tournamentEntity.Name;
            }

            if (!string.IsNullOrEmpty(discipline))
            {
                // Fai qualcosa con idDiscipline
                disciplineId = int.Parse(discipline);

                if (disciplineId > 0)
                {
                    lblDiscipline.Text = " - " + disciplineList.ElementAt(disciplineIdList.IndexOf(discipline));
                    btnPoolsIndicators.Disabled = false;
                }
            }

            if(tournamentId != 0 && disciplineId != 0)
            {
                CreatePoolsList();
                CreateMatchesList();
                SetRanking();
                SetFinalPhases();
            }
        }

        private void LoadDisciplineDropdownItems()
        {
            // Cancella eventuali elementi esistenti (necessario per evitare duplicati durante i postback)
            dropdownDisciplineMenu.Controls.Clear();

            
            int tempKey = 0;
            foreach (var tournament in disciplineList)
            {
                // Creazione di un elemento <li>
                HtmlGenericControl li = new HtmlGenericControl("li");

                // Creazione del pulsante
                Button button = new Button
                {
                    Text = tournament,
                    CssClass = "dropdown-item", // Stile Bootstrap
                    CommandArgument = tournament, // Imposta un valore identificativo
                };
                button.Attributes.Add("data-value", disciplineIdList[tempKey].ToString()); //is the key

                button.Click += DisciplineDropdownItem_Click; // Associa l'evento Click

                // Aggiungi il pulsante all'elemento <li>
                li.Controls.Add(button);

                // Aggiungi l'elemento <li> alla lista <ul>
                dropdownDisciplineMenu.Controls.Add(li);

                tempKey++;
            }
        }
        protected void DisciplineDropdownItem_Click(object sender, EventArgs e)
        {
            // Recupera il pulsante cliccato
            Button clickedButton = sender as Button;
            if (clickedButton != null)
            {
                string selectedDicipline = clickedButton.CommandArgument;
                string customValue = ((Button)sender).Attributes["data-value"];

                // Logica per gestire l'elemento selezionato
                System.Diagnostics.Debug.WriteLine($"Selected discipline {selectedDicipline} with id {customValue}");

                disciplineId = Convert.ToInt32(customValue);
                lblDiscipline.Text = " - " + selectedDicipline;

                Response.Redirect("TournamentStat.aspx?idTournament=" + tournamentId+"&idDiscipline="+ disciplineId);

            }
        }
        private void CreatePoolsList()
        {
            var numeroGironi = SqlDal_Pools.GetNumeroGironiByTorneoDisciplina(tournamentId, disciplineId);

            if (numeroGironi != 0)
            {
                var gironi = new List<List<AtletaEntity>>();
                gironi = SqlDal_Pools.GetGironiSalvati(tournamentId, disciplineId);

                var numeroAtletiTorneoDisciplina = gironi.SelectMany(list => list).Distinct().Count();

                var gironiIncontri = new List<List<MatchEntity>>();

                var poolIndex = 1;

                foreach (List<AtletaEntity> poolList in gironi)
                {

                    // Crea il div della card
                    var cardDiv = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
                    cardDiv.Attributes["class"] = "card";

                    // Crea l'header della card
                    var cardHeader = new System.Web.UI.HtmlControls.HtmlGenericControl("h5");
                    cardHeader.Attributes["class"] = "card-header";
                    cardHeader.InnerText = "Pool " + (poolIndex);
                    cardDiv.Controls.Add(cardHeader);

                    // Crea il div per la tabella
                    var tableDiv = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
                    tableDiv.Attributes["class"] = "table-responsive text-nowrap";

                    // Crea la tabella
                    Table table = PoolTable("Pool " + poolIndex, poolList); // Metodo esistente per generare la tabella
                    tableDiv.Controls.Add(table);

                    // Aggiungi il div della tabella alla card
                    cardDiv.Controls.Add(tableDiv);

                    // Aggiungi un HR sotto la card
                    var hr = new System.Web.UI.HtmlControls.HtmlGenericControl("hr");
                    hr.Attributes["class"] = "my-12";

                    // Aggiungi tutto al div principale
                    var mainDiv = FindControl("navs-pills-justified-home") as System.Web.UI.HtmlControls.HtmlGenericControl;
                    divPoolsList.Controls.Add(cardDiv);
                    divPoolsList.Controls.Add(hr);

                    poolIndex++;

                }
            }

        }
        private Table PoolTable(string poolTitle, List<AtletaEntity> poolList)
        {
            Table table = new Table();
            table.CssClass = "table table-hover table-striped";

            // Crea l'intestazione della tabella con allineamento personalizzato
            TableHeaderRow headerRow = new TableHeaderRow();
            headerRow.CssClass = "table-dark";
            TableHeaderCell redFighterHeader = new TableHeaderCell { Text = "Name", Width = Unit.Percentage(40) };
            redFighterHeader.CssClass = "text-start"; // Allinea l'intestazione a sinistra
            headerRow.Cells.Add(redFighterHeader);

            TableHeaderCell pointHeader = new TableHeaderCell { Text = "Club", Width = Unit.Percentage(60) };
            pointHeader.CssClass = "text-start"; // Centra l'intestazione
            headerRow.Cells.Add(pointHeader);

            table.Rows.Add(headerRow);

            // Aggiungi alcune righe alla tabella (come prima)
            foreach (var p in poolList)
            {
                TableRow row = new TableRow();

                // Colonna allineata a sinistra
                TableCell nameCell = new TableCell { Text = p.FullName };

                nameCell.CssClass = "text-start";
                row.Cells.Add(nameCell);

                // Colonna allineata al centro
                TableCell clubCell = new TableCell { Text = p.Asd };
                clubCell.CssClass = "text-start";
                row.Cells.Add(clubCell);

                table.Rows.Add(row);
            }

            return table;
        }
        private void CreateMatchesList()
        {
            if (tournamentId == 0 || disciplineId == 0)
                return;

            var tournament = tournamentEngine.LoadTorunamentsDesc(tournamentId);

            matches = matchtsEngine.LoadPoolsMatches(tournamentId, disciplineId);

            if (tournament == null || matches == null || matches.Count == 0)
                return;

            int poolsNumber = matches.Max(m => m.Pool);

            // Cicla attraverso i pool e crea un accordion per ognuno
            for (int i = 0; i< poolsNumber; i++)
            {
                var pool = matches.Where(x => x.Pool == i + 1).ToList();

                // Crea il div della card
                var cardDiv = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
                cardDiv.Attributes["class"] = "card";

                // Crea l'header della card
                var cardHeader = new System.Web.UI.HtmlControls.HtmlGenericControl("h5");
                cardHeader.Attributes["class"] = "card-header";
                cardHeader.InnerText = "Pool " + (i + 1);
                cardDiv.Controls.Add(cardHeader);

                // Crea il div per la tabella
                var tableDiv = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
                tableDiv.Attributes["class"] = "table-responsive text-nowrap";

                // Crea la tabella
                Table table = MatchTable("Pool " + i, pool); // Metodo esistente per generare la tabella
                tableDiv.Controls.Add(table);

                // Aggiungi il div della tabella alla card
                cardDiv.Controls.Add(tableDiv);

                // Aggiungi un HR sotto la card
                var hr = new System.Web.UI.HtmlControls.HtmlGenericControl("hr");
                hr.Attributes["class"] = "my-12";

                // Aggiungi tutto al div principale
                var mainDiv = FindControl("navs-pills-justified-home") as System.Web.UI.HtmlControls.HtmlGenericControl;
                div1.Controls.Add(cardDiv);
                div1.Controls.Add(hr);

            }
        }
        // Funzione che genera la tabella dinamica
        private Table MatchTable(string poolName, List<Matches> pool)
        {
            Table table = new Table();
            table.CssClass = "table table-hover";

            // Crea l'intestazione della tabella con allineamento personalizzato
            TableHeaderRow headerRow = new TableHeaderRow();
            headerRow.CssClass = "table-dark";
            TableHeaderCell redFighterHeader = new TableHeaderCell { Text = "Red Fighter" };
            redFighterHeader.CssClass = "text-start"; // Allinea l'intestazione a sinistra
            headerRow.Cells.Add(redFighterHeader);

            TableHeaderCell pointHeader = new TableHeaderCell { Text = "Point" };
            pointHeader.CssClass = "text-center"; // Centra l'intestazione
            headerRow.Cells.Add(pointHeader);

            TableHeaderCell doubleDeathHeader = new TableHeaderCell { Text = "Double Death" };
            doubleDeathHeader.CssClass = "text-center"; // Centra l'intestazione
            headerRow.Cells.Add(doubleDeathHeader);

            TableHeaderCell pointBluHeader = new TableHeaderCell { Text = "Point" };
            pointBluHeader.CssClass = "text-center"; // Centra l'intestazione
            headerRow.Cells.Add(pointBluHeader);

            TableHeaderCell bluFighterHeader = new TableHeaderCell { Text = "Blu Fighter" };
            bluFighterHeader.CssClass = "text-end"; // Allinea l'intestazione a destra
            headerRow.Cells.Add(bluFighterHeader);

            table.Rows.Add(headerRow);

            // Aggiungi alcune righe alla tabella (come prima)
            foreach(var p in pool)
            {
                TableRow row = new TableRow();

                // Colonna allineata a sinistra
                TableCell redFighterCell = new TableCell { Text = p.Fighter1 };

                redFighterCell.CssClass = "text-start";
                row.Cells.Add(redFighterCell);

                // Colonna allineata al centro
                TableCell redPointCell = new TableCell { Text = p.Fighter1_Hit.ToString() };
                redPointCell.CssClass = "text-center";
                SetPointColour(p.Double, p.Fighter1_Hit, p.Fighter2_Hit, redPointCell);
                row.Cells.Add(redPointCell);

                // Colonna con badge
                TableCell doubleDeathCell = new TableCell
                {
                    Text =
                    p.Double ?
                    "<span class='badge bg-label-danger me-1'>YES</span>" :
                    "<span class='badge bg-label-success me-1'>NO</span>"
                };
                doubleDeathCell.CssClass = "text-center";
                doubleDeathCell.Text = Server.HtmlDecode(doubleDeathCell.Text);
                row.Cells.Add(doubleDeathCell);

                // Colonna allineata al centro
                TableCell pointBluCell = new TableCell { Text = p.Fighter2_Hit.ToString() };
                pointBluCell.CssClass = "text-center";
                SetPointColour(p.Double, p.Fighter2_Hit, p.Fighter1_Hit, pointBluCell);
                row.Cells.Add(pointBluCell);

                // Colonna allineata a destra
                TableCell bluFighterCell = new TableCell { Text = p.Fighter2 };
                bluFighterCell.CssClass = "text-end";
                row.Cells.Add(bluFighterCell);

                table.Rows.Add(row);
            }

            return table;

        }
        private void SetRanking()
        {
            if (disciplineId == 0 || tournamentId == 0)
                return;

            var stats = statEngine.LoadStats(tournamentId, disciplineId);

            int countDeltaNotZero = stats.Where(s => s.Delta > 0).Count();

            var atletiAmmessiEliminatorie = stats.Count >= 54 ? 32 :
                         stats.Count >= 24 ? 16 :
                         stats.Count >= 12 ? 8 : 4;

            Table table = new Table();
            table.CssClass = "table table-hover";

            // Crea l'intestazione della tabella
            TableHeaderRow headerRow = new TableHeaderRow();
            headerRow.Cells.Add(new TableHeaderCell { Text = "#", HorizontalAlign = HorizontalAlign.Center, CssClass = "text-center" });
            headerRow.Cells.Add(new TableHeaderCell { Text = "Qualified" });
            headerRow.Cells.Add(new TableHeaderCell { Text = "Surname" });
            headerRow.Cells.Add(new TableHeaderCell { Text = "Name" });
            headerRow.Cells.Add(new TableHeaderCell { Text = "Victory", HorizontalAlign = HorizontalAlign.Center, CssClass = "text-center" });
            headerRow.Cells.Add(new TableHeaderCell { Text = "Loss", HorizontalAlign = HorizontalAlign.Center, CssClass = "text-center" });
            headerRow.Cells.Add(new TableHeaderCell { Text = "Hit", HorizontalAlign = HorizontalAlign.Center, CssClass = "text-center" });
            headerRow.Cells.Add(new TableHeaderCell { Text = "Hitted", HorizontalAlign = HorizontalAlign.Center, CssClass = "text-center" });
            headerRow.Cells.Add(new TableHeaderCell { Text = "Delta", HorizontalAlign = HorizontalAlign.Center, CssClass = "text-center" });
            headerRow.Cells.Add(new TableHeaderCell { Text = "Ranking", HorizontalAlign = HorizontalAlign.Center, CssClass = "text-center" });

            // Aggiungi l'intestazione alla tabella
            table.Rows.Add(headerRow);

            // Genera dinamicamente i dati
            int pos = 0;
            foreach(var s in stats)
            {
                TableRow row = new TableRow();
                row.Cells.Add(new TableCell { Text = (pos + 1).ToString(), HorizontalAlign = HorizontalAlign.Center, CssClass = "text-center" });

                row.Cells.Add(new TableCell
                {
                    Text =
                    countDeltaNotZero > atletiAmmessiEliminatorie / 2 ?
                        pos < atletiAmmessiEliminatorie ?
                            $"<span class='badge bg-label-success'>YES</span>" :
                            $"<span class='badge bg-label-danger'>NO</span>" :
                        $"<span></span>"
                }); ;
                row.Cells.Add(new TableCell { Text = s.Surname });
                row.Cells.Add(new TableCell { Text = s.Name });
                row.Cells.Add(new TableCell { Text = s.Victory.ToString(), HorizontalAlign = HorizontalAlign.Center, CssClass = "text-center" });
                row.Cells.Add(new TableCell { Text = s.Loss.ToString(), HorizontalAlign = HorizontalAlign.Center, CssClass = "text-center" });
                row.Cells.Add(new TableCell { Text = s.Hit.ToString(), HorizontalAlign = HorizontalAlign.Center, CssClass = "text-center" });
                row.Cells.Add(new TableCell { Text = s.Hitted.ToString(), HorizontalAlign = HorizontalAlign.Center, CssClass = "text-center" });
                row.Cells.Add(new TableCell { Text = s.Delta.ToString(), HorizontalAlign = HorizontalAlign.Center, CssClass = "text-center" });
                row.Cells.Add(new TableCell { Text = s.Ranking.ToString(), HorizontalAlign = HorizontalAlign.Center, CssClass = "text-center" });

                table.Rows.Add(row);

                pos++;
            }

            // Aggiungi la tabella al div
            divRankingTable.Controls.Add(table);

            SetStats(stats, countDeltaNotZero, atletiAmmessiEliminatorie);
        }
        private void SetStats(List<Stats> stats, int countDeltaNotZero, int atletiAmmessiEliminatorie)
        {
            if(stats != null && stats.Count > 0)
            {
                kpiDiv.Visible = true;

                var kpi = new StatsKpiCalculator(stats);

                lblBestDelta.Text = $"{kpi.bestDelta?.Delta:F2}";
                lblMostWins.Text = $"{kpi.mostVictories?.Victory}";
                lblPointEfficiency.Text = $"{kpi.efficiency:F2}%";
                lblMostPointScored.Text = $"{kpi.mostPointsHit?.Hit}";
                lblFewestPointsTaken.Text = $"{kpi.leastPointsHitted?.Hitted}";
                lblBestranking.Text = countDeltaNotZero > atletiAmmessiEliminatorie ? $"{kpi.bestRanking?.Ranking:F2}" : "0";
                lblAverageDelta.Text = $"{kpi.avgDelta:F2}";
                lblBestWinLossRatio.Text = $"{kpi.winLossRatio:F2}";
                
            }
        }
        private static void SetPointColour(bool doubleDeath, int pointA, int pointB, TableCell pointCell)
        {
            pointCell.BackColor = doubleDeath ? System.Drawing.Color.LightPink :
                pointA == pointB ? System.Drawing.Color.LightGray :
                pointA > pointB ? System.Drawing.Color.LightGreen : System.Drawing.Color.LightGray;
        }

        private void SetFinalPhases()
        {
            Set16th();
            Set8th();
            Set4th();
            SetSemifinal();
            SetFinal();
        }

        #region 16th

        private void Set16th()
        {
            List<AtletaEliminatorie> allAtleti = SqlDal_Pools.GetSedicesimi(tournamentId, disciplineId);

            if (allAtleti == null || allAtleti.Count == 0)
                return;

            GetBranch16th(1, allAtleti.ElementAt(0), allAtleti.ElementAt(31),
                            allAtleti.ElementAt(15), allAtleti.ElementAt(16),
                            allAtleti.ElementAt(8), allAtleti.ElementAt(23),
                            allAtleti.ElementAt(7), allAtleti.ElementAt(24));

            GetBranch16th(2, allAtleti.ElementAt(1), allAtleti.ElementAt(30),
                            allAtleti.ElementAt(14), allAtleti.ElementAt(17),
                            allAtleti.ElementAt(9), allAtleti.ElementAt(22),
                            allAtleti.ElementAt(6), allAtleti.ElementAt(25));

            GetBranch16th(3, allAtleti.ElementAt(5), allAtleti.ElementAt(26),
                            allAtleti.ElementAt(10), allAtleti.ElementAt(21),
                            allAtleti.ElementAt(13), allAtleti.ElementAt(18),
                            allAtleti.ElementAt(2), allAtleti.ElementAt(29));

            GetBranch16th(4, allAtleti.ElementAt(4), allAtleti.ElementAt(27),
                            allAtleti.ElementAt(11), allAtleti.ElementAt(20),
                            allAtleti.ElementAt(12), allAtleti.ElementAt(19),
                            allAtleti.ElementAt(3), allAtleti.ElementAt(28));

        }

        private void GetBranch16th(int branch, AtletaEliminatorie atleta1, AtletaEliminatorie atleta2, AtletaEliminatorie atleta3, AtletaEliminatorie atleta4,
            AtletaEliminatorie atleta5, AtletaEliminatorie atleta6, AtletaEliminatorie atleta7, AtletaEliminatorie atleta8)
        {
            // Crea il div della card
            var cardDiv = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
            cardDiv.Attributes["class"] = "card";

            // Crea l'header della card
            var cardHeader = new System.Web.UI.HtmlControls.HtmlGenericControl("h5");
            cardHeader.Attributes["class"] = "card-header";
            cardHeader.InnerText = $"Branch {branch}";
            cardDiv.Controls.Add(cardHeader);

            // Crea il div per la tabella
            var tableDiv = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
            tableDiv.Attributes["class"] = "table-responsive text-nowrap";

            // Crea la tabella
            Table table1 = Branch16thTable(atleta1, atleta2, atleta3,  atleta4, atleta5, atleta6, atleta7, atleta8);

            tableDiv.Controls.Add(table1);

            // Aggiungi il div della tabella alla card
            cardDiv.Controls.Add(tableDiv);

            // Aggiungi un HR sotto la card
            var hr = new System.Web.UI.HtmlControls.HtmlGenericControl("hr");
            hr.Attributes["class"] = "my-12";

            // Aggiungi tutto al div principale
            var mainDiv = FindControl("navs-pills-justified-home") as System.Web.UI.HtmlControls.HtmlGenericControl;
            div16th.Controls.Add(cardDiv);
            div16th.Controls.Add(hr);
        }

        private Table Branch16thTable(AtletaEliminatorie atletaEliminatorie1, AtletaEliminatorie atletaEliminatorie2,
            AtletaEliminatorie atletaEliminatorie3, AtletaEliminatorie atletaEliminatorie4,
            AtletaEliminatorie atletaEliminatorie5, AtletaEliminatorie atletaEliminatorie6,
            AtletaEliminatorie atletaEliminatorie7, AtletaEliminatorie atletaEliminatorie8)
        {
            Table table = new Table();
            table.CssClass = "table table-hover";

            // Crea l'intestazione della tabella con allineamento personalizzato
            TableHeaderRow headerRow = new TableHeaderRow();
            headerRow.CssClass = "table-dark";

            TableHeaderCell matchIdHeader = new TableHeaderCell { Text = "#", Width = Unit.Percentage(10) };
            matchIdHeader.CssClass = "text-center"; // Allinea l'intestazione a sinistra
            headerRow.Cells.Add(matchIdHeader);

            TableHeaderCell redFighterHeader = new TableHeaderCell { Text = "Fighter", Width = Unit.Percentage(80) };
            redFighterHeader.CssClass = "text-start"; // Allinea l'intestazione a sinistra
            headerRow.Cells.Add(redFighterHeader);

            TableHeaderCell pointHeader = new TableHeaderCell { Text = "Hit", Width = Unit.Percentage(10) };
            pointHeader.CssClass = "text-center"; // Centra l'intestazione
            headerRow.Cells.Add(pointHeader);

            table.Rows.Add(headerRow);

            AddDirectElimination(1, atletaEliminatorie1, atletaEliminatorie2, table, Color.Azure);
            AddDirectElimination(2, atletaEliminatorie3, atletaEliminatorie4, table, Color.White);
            AddDirectElimination(3, atletaEliminatorie5, atletaEliminatorie6, table, Color.Azure);
            AddDirectElimination(4, atletaEliminatorie7, atletaEliminatorie8, table, Color.White);

            return table;
        }

        #endregion

        #region 8th
        private void Set8th()
        {
            List<AtletaEliminatorie> allAtleti = SqlDal_Pools.GetOttavi(tournamentId, disciplineId);

            if (allAtleti == null || allAtleti.Count == 0)
                return;

            if (allAtleti.Where(x => x.Campo > 0).ToList().Count() == 0)
            {
                //ottavi come prima fase
                GetBranch8th(1, allAtleti.ElementAt(0), allAtleti.ElementAt(15),
                                            allAtleti.ElementAt(7), allAtleti.ElementAt(8));
                GetBranch8th(2, allAtleti.ElementAt(1), allAtleti.ElementAt(14),
                                            allAtleti.ElementAt(6), allAtleti.ElementAt(9));
                GetBranch8th(3, allAtleti.ElementAt(5), allAtleti.ElementAt(10),
                                            allAtleti.ElementAt(2), allAtleti.ElementAt(13));
                GetBranch8th(4, allAtleti.ElementAt(4), allAtleti.ElementAt(11),
                                            allAtleti.ElementAt(3), allAtleti.ElementAt(12));
            }
            else
            {
                var poolOne = SqlDal_Pools.GetOttavi(tournamentId, disciplineId, 1);
                var poolTwo = SqlDal_Pools.GetOttavi(tournamentId, disciplineId, 2);
                var poolThree = SqlDal_Pools.GetOttavi(tournamentId, disciplineId, 3);
                var poolFour = SqlDal_Pools.GetOttavi(tournamentId, disciplineId, 4);

                if (poolOne == null || poolTwo == null || poolThree == null || poolFour == null)
                    return;

                GetBranch8th(1, poolOne[0], poolOne[1], poolOne[2], poolOne[3]);
                GetBranch8th(2, poolTwo[0], poolTwo[1], poolTwo[2], poolTwo[3]);
                GetBranch8th(3, poolThree[0], poolThree[1], poolThree[2], poolThree[3]);
                GetBranch8th(4, poolFour[0], poolFour[1], poolFour[2], poolFour[3]);

            }
        }

        private void GetBranch8th(int branch, AtletaEliminatorie atleta1, AtletaEliminatorie atleta2, AtletaEliminatorie atleta3, AtletaEliminatorie atleta4)
        {
            // Crea il div della card
            var cardDiv = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
            cardDiv.Attributes["class"] = "card";

            // Crea l'header della card
            var cardHeader = new System.Web.UI.HtmlControls.HtmlGenericControl("h5");
            cardHeader.Attributes["class"] = "card-header";
            cardHeader.InnerText = $"Branch {branch}";
            cardDiv.Controls.Add(cardHeader);

            // Crea il div per la tabella
            var tableDiv = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
            tableDiv.Attributes["class"] = "table-responsive text-nowrap";

            // Crea la tabella
            Table table1 = Branch8thTable(atleta1, atleta2, atleta3, atleta4);

            tableDiv.Controls.Add(table1);

            // Aggiungi il div della tabella alla card
            cardDiv.Controls.Add(tableDiv);

            // Aggiungi un HR sotto la card
            var hr = new System.Web.UI.HtmlControls.HtmlGenericControl("hr");
            hr.Attributes["class"] = "my-12";

            // Aggiungi tutto al div principale
            var mainDiv = FindControl("navs-pills-justified-home") as System.Web.UI.HtmlControls.HtmlGenericControl;
            div8th.Controls.Add(cardDiv);
            div8th.Controls.Add(hr);
        }

        private Table Branch8thTable(AtletaEliminatorie atletaEliminatorie1, AtletaEliminatorie atletaEliminatorie2, AtletaEliminatorie atletaEliminatorie3, AtletaEliminatorie atletaEliminatorie4)
        {
            Table table = new Table();
            table.CssClass = "table table-hover";

            // Crea l'intestazione della tabella con allineamento personalizzato
            TableHeaderRow headerRow = new TableHeaderRow();
            headerRow.CssClass = "table-dark";

            TableHeaderCell matchIdHeader = new TableHeaderCell { Text = "#", Width = Unit.Percentage(10) };
            matchIdHeader.CssClass = "text-center"; // Allinea l'intestazione a sinistra
            headerRow.Cells.Add(matchIdHeader);

            TableHeaderCell redFighterHeader = new TableHeaderCell { Text = "Fighter", Width = Unit.Percentage(80) };
            redFighterHeader.CssClass = "text-start"; // Allinea l'intestazione a sinistra
            headerRow.Cells.Add(redFighterHeader);

            TableHeaderCell pointHeader = new TableHeaderCell { Text = "Hit", Width = Unit.Percentage(10) };
            pointHeader.CssClass = "text-center"; // Centra l'intestazione
            headerRow.Cells.Add(pointHeader);

            table.Rows.Add(headerRow);

            AddDirectElimination(1, atletaEliminatorie1, atletaEliminatorie2, table, Color.Azure);
            AddDirectElimination(2, atletaEliminatorie3, atletaEliminatorie4, table, Color.White);

            return table;
        }
        #endregion

        #region 4th

        private void Set4th()
        {
            var allAtleti = SqlDal_Pools.GetQuarti(tournamentId, disciplineId);

            if (allAtleti == null || allAtleti.Count == 0)
                return;

            if (allAtleti.Where(x => x.Campo > 0).ToList().Count() == 0)
            {
                GetBranch4th(1, allAtleti.ElementAt(0), allAtleti.ElementAt(7));
                GetBranch4th(2, allAtleti.ElementAt(1), allAtleti.ElementAt(6));
                GetBranch4th(3, allAtleti.ElementAt(2), allAtleti.ElementAt(5));
                GetBranch4th(4, allAtleti.ElementAt(3), allAtleti.ElementAt(4));
            }
            else
            {
                var poolOne = SqlDal_Pools.GetQuarti(tournamentId, disciplineId, 1);
                var poolTwo = SqlDal_Pools.GetQuarti(tournamentId, disciplineId, 2);
                var poolThree = SqlDal_Pools.GetQuarti(tournamentId, disciplineId, 3);
                var poolFour = SqlDal_Pools.GetQuarti(tournamentId, disciplineId, 4);

                GetBranch4th(1, poolOne[0], poolOne[1]);
                GetBranch4th(2, poolTwo[0], poolTwo[1]);
                GetBranch4th(3, poolThree[0], poolThree[1]);
                GetBranch4th(4, poolFour[0], poolFour[1]);
            }

        }

        private void GetBranch4th(int branch, AtletaEliminatorie atleta1, AtletaEliminatorie atleta2)
        {
            // Crea il div della card
            var cardDiv = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
            cardDiv.Attributes["class"] = "card";

            // Crea l'header della card
            var cardHeader = new System.Web.UI.HtmlControls.HtmlGenericControl("h5");
            cardHeader.Attributes["class"] = "card-header";
            cardHeader.InnerText = $"Branch {branch}";
            cardDiv.Controls.Add(cardHeader);

            // Crea il div per la tabella
            var tableDiv = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
            tableDiv.Attributes["class"] = "table-responsive text-nowrap";

            // Crea la tabella
            Table table1 = Branch4thTable(atleta1, atleta2);

            tableDiv.Controls.Add(table1);

            // Aggiungi il div della tabella alla card
            cardDiv.Controls.Add(tableDiv);

            // Aggiungi un HR sotto la card
            var hr = new System.Web.UI.HtmlControls.HtmlGenericControl("hr");
            hr.Attributes["class"] = "my-12";

            // Aggiungi tutto al div principale
            var mainDiv = FindControl("navs-pills-justified-home") as System.Web.UI.HtmlControls.HtmlGenericControl;
            div4th.Controls.Add(cardDiv);
            div4th.Controls.Add(hr);
        }

        private Table Branch4thTable(AtletaEliminatorie atletaEliminatorie1, AtletaEliminatorie atletaEliminatorie2)
        {
            Table table = new Table();
            table.CssClass = "table table-hover";

            // Crea l'intestazione della tabella con allineamento personalizzato
            TableHeaderRow headerRow = new TableHeaderRow();
            headerRow.CssClass = "table-dark";

            TableHeaderCell matchIdHeader = new TableHeaderCell { Text = "#", Width = Unit.Percentage(10) };
            matchIdHeader.CssClass = "text-center"; // Allinea l'intestazione a sinistra
            headerRow.Cells.Add(matchIdHeader);

            TableHeaderCell redFighterHeader = new TableHeaderCell { Text = "Fighter", Width = Unit.Percentage(80) };
            redFighterHeader.CssClass = "text-start"; // Allinea l'intestazione a sinistra
            headerRow.Cells.Add(redFighterHeader);

            TableHeaderCell pointHeader = new TableHeaderCell { Text = "Hit", Width = Unit.Percentage(10) };
            pointHeader.CssClass = "text-center"; // Centra l'intestazione
            headerRow.Cells.Add(pointHeader);

            table.Rows.Add(headerRow);

            AddDirectElimination(1, atletaEliminatorie1, atletaEliminatorie2, table, Color.White);

            return table;
        }

        #endregion

        #region Semifinal
        private void SetSemifinal()
        {
            var allAtleti = SqlDal_Pools.GetSemifinali(tournamentId, disciplineId);

            if (allAtleti == null || allAtleti.Count == 0)
                return;

            if (allAtleti.Where(x => x.Campo > 0).ToList().Count() == 0)
            {
                GetBranchSemifinal(1, allAtleti.ElementAt(0), allAtleti.ElementAt(3));
                GetBranchSemifinal(2, allAtleti.ElementAt(1), allAtleti.ElementAt(2));
            }
            else
            {
                var poolOne = SqlDal_Pools.GetSemifinali(tournamentId, disciplineId, 1);
                var poolTwo = SqlDal_Pools.GetSemifinali(tournamentId, disciplineId, 2);

                GetBranchSemifinal(1, poolOne[0], poolOne[1]);
                GetBranchSemifinal(2, poolTwo[0], poolTwo[1]);
            }
        }

        private void GetBranchSemifinal(int semifinalfinal, AtletaEliminatorie atleta1, AtletaEliminatorie atleta2)
        {
            // Crea il div della card
            var cardDiv = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
            cardDiv.Attributes["class"] = "card";

            // Crea l'header della card
            var cardHeader = new System.Web.UI.HtmlControls.HtmlGenericControl("h5");
            cardHeader.Attributes["class"] = "card-header";
            cardHeader.InnerText = $"Semifinalinal {semifinalfinal}";
            cardDiv.Controls.Add(cardHeader);

            // Crea il div per la tabella
            var tableDiv = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
            tableDiv.Attributes["class"] = "table-responsive text-nowrap";

            // Crea la tabella
            Table table1 = BranchSemifinalTable(atleta1, atleta2);

            tableDiv.Controls.Add(table1);

            // Aggiungi il div della tabella alla card
            cardDiv.Controls.Add(tableDiv);

            // Aggiungi un HR sotto la card
            var hr = new System.Web.UI.HtmlControls.HtmlGenericControl("hr");
            hr.Attributes["class"] = "my-12";

            // Aggiungi tutto al div principale
            var mainDiv = FindControl("navs-pills-justified-home") as System.Web.UI.HtmlControls.HtmlGenericControl;
            divSemifinal.Controls.Add(cardDiv);
            divSemifinal.Controls.Add(hr);
        }

        private Table BranchSemifinalTable(AtletaEliminatorie atletaEliminatorie1, AtletaEliminatorie atletaEliminatorie2)
        {
            Table table = new Table();
            table.CssClass = "table table-hover";

            // Crea l'intestazione della tabella con allineamento personalizzato
            TableHeaderRow headerRow = new TableHeaderRow();
            headerRow.CssClass = "table-dark";

            TableHeaderCell matchIdHeader = new TableHeaderCell { Text = "#", Width = Unit.Percentage(10) };
            matchIdHeader.CssClass = "text-center"; // Allinea l'intestazione a sinistra
            headerRow.Cells.Add(matchIdHeader);

            TableHeaderCell redFighterHeader = new TableHeaderCell { Text = "Fighter", Width = Unit.Percentage(80) };
            redFighterHeader.CssClass = "text-start"; // Allinea l'intestazione a sinistra
            headerRow.Cells.Add(redFighterHeader);

            TableHeaderCell pointHeader = new TableHeaderCell { Text = "Hit", Width = Unit.Percentage(10) };
            pointHeader.CssClass = "text-center"; // Centra l'intestazione
            headerRow.Cells.Add(pointHeader);

            table.Rows.Add(headerRow);

            AddDirectElimination(1, atletaEliminatorie1, atletaEliminatorie2, table, Color.White);

            return table;
        }
        #endregion

        #region Final
        private void SetFinal()
        {
            var poolOne = SqlDal_Pools.GetFinali(tournamentId, disciplineId, 1);
            var poolTwo = SqlDal_Pools.GetFinali(tournamentId, disciplineId, 2);

            if (poolOne == null || poolTwo == null || poolOne.Count == 0 || poolTwo.Count == 0)
                return;

            // Crea il div della card
            var cardDiv = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
            cardDiv.Attributes["class"] = "card";

            // Crea l'header della card
            var cardHeader = new System.Web.UI.HtmlControls.HtmlGenericControl("h5");
            cardHeader.Attributes["class"] = "card-header";
            cardHeader.InnerText = $"Finals";
            cardDiv.Controls.Add(cardHeader);

            // Crea il div per la tabella
            var tableDiv = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
            tableDiv.Attributes["class"] = "table-responsive text-nowrap";

            // Crea la tabella
            Table table1 = FinalTable(poolOne, poolTwo);

            tableDiv.Controls.Add(table1);

            // Aggiungi il div della tabella alla card
            cardDiv.Controls.Add(tableDiv);

            // Aggiungi un HR sotto la card
            var hr = new System.Web.UI.HtmlControls.HtmlGenericControl("hr");
            hr.Attributes["class"] = "my-12";

            // Aggiungi tutto al div principale
            var mainDiv = FindControl("navs-pills-justified-home") as System.Web.UI.HtmlControls.HtmlGenericControl;
            divFinal.Controls.Add(cardDiv);
            divFinal.Controls.Add(hr);

        }

        private Table FinalTable(List<AtletaEliminatorie> poolOne, List<AtletaEliminatorie> poolTwo)
        {
            Tuple<string, string> firstAndSecondPlace = GetFirstAndSecondPlace(poolOne);

            var thirdPlace1 = SqlDal_Fighters.GetAtletaById(poolTwo[0].IdAtleta).Asd + "#" + poolTwo[0].Cognome + " " + poolTwo[0].Nome;
            var thirdPlace2 = SqlDal_Fighters.GetAtletaById(poolTwo[3].IdAtleta).Asd + "#" + poolTwo[3].Cognome + " " + poolTwo[3].Nome;

            Table table = new Table();
            table.CssClass = "table table-hover";

            // Crea l'intestazione della tabella con allineamento personalizzato
            TableHeaderRow headerRow = new TableHeaderRow();
            headerRow.CssClass = "table-dark";

            TableHeaderCell matchIdHeader = new TableHeaderCell { Text = "#", Width = Unit.Percentage(10) };
            matchIdHeader.CssClass = "text-center"; // Allinea l'intestazione a sinistra
            headerRow.Cells.Add(matchIdHeader);

            TableHeaderCell redFighterHeader = new TableHeaderCell { Text = "Fighter", Width = Unit.Percentage(60) };
            redFighterHeader.CssClass = "text-start"; // Allinea l'intestazione a sinistra
            headerRow.Cells.Add(redFighterHeader);

            TableHeaderCell clubHeader = new TableHeaderCell { Text = "Club", Width = Unit.Percentage(30) };
            clubHeader.CssClass = "text-start"; // Allinea l'intestazione a sinistra
            headerRow.Cells.Add(clubHeader);

            TableHeaderCell medalHeader = new TableHeaderCell { Text = "", Width = Unit.Percentage(10) };
            medalHeader.CssClass = "text-center"; // Centra l'intestazione
            headerRow.Cells.Add(medalHeader);

            table.Rows.Add(headerRow);

            TableRow row = new TableRow();
            row.BackColor = Color.White;

            TableCell positionCell = new TableCell { Text = $@"
                                                <div class=""d-flex justify-content-center align-items-center user-name"">
                                                    <div class='avatar-wrapper'>
                                                        <div class='avatar me-2'>
                                                            <img src=""../../assets/img/medals/gold.png"" alt=""Avatar"" class=""rounded-circle"">
                                                        </div>
                                                    </div>
                                                </div>"  };
            positionCell.CssClass = "text-center";
            row.Cells.Add(positionCell);

            TableCell fighter = new TableCell { Text = $"{firstAndSecondPlace.Item1.Split('#')[1]}" };
            fighter.CssClass = "text-start";
            row.Cells.Add(fighter);

            TableCell clubCell = new TableCell { Text = $"{firstAndSecondPlace.Item1.Split('#')[0]}" };
            clubCell.CssClass = "text-start";
            row.Cells.Add(clubCell);

            table.Rows.Add(row);

            row = new TableRow();
            row.BackColor = Color.White;

            positionCell = new TableCell { Text = $@"
                                                <div class=""d-flex justify-content-center align-items-center user-name"">
                                                    <div class='avatar-wrapper'>
                                                        <div class='avatar me-2'>
                                                            <img src=""../../assets/img/medals/silver.png"" alt=""Avatar"" class=""rounded-circle"">
                                                        </div>
                                                    </div>
                                                </div>" };
            positionCell.CssClass = "text-center";
            row.Cells.Add(positionCell);

            fighter = new TableCell { Text = $"{firstAndSecondPlace.Item2.Split('#')[1]}" };
            fighter.CssClass = "text-start";
            row.Cells.Add(fighter);

            clubCell = new TableCell { Text = $"{firstAndSecondPlace.Item2.Split('#')[0]}" };
            clubCell.CssClass = "text-start";
            row.Cells.Add(clubCell);

            table.Rows.Add(row);

            row = new TableRow();
            row.BackColor = Color.White;

            positionCell = new TableCell { Text = $@"
                                                <div class=""d-flex justify-content-center align-items-center user-name"">
                                                    <div class='avatar-wrapper'>
                                                        <div class='avatar me-2'>
                                                            <img src=""../../assets/img/medals/bronze.png"" alt=""Avatar"" class=""rounded-circle"">
                                                        </div>
                                                    </div>
                                                </div>" };
            positionCell.CssClass = "text-center";
            row.Cells.Add(positionCell);

            fighter = new TableCell { Text = $"{thirdPlace1.Split('#')[1]}" };
            fighter.CssClass = "text-start";
            row.Cells.Add(fighter);

            clubCell = new TableCell { Text = $"{thirdPlace1.Split('#')[0]}" };
            clubCell.CssClass = "text-start";
            row.Cells.Add(clubCell);

            table.Rows.Add(row);

            row = new TableRow();
            row.BackColor = Color.White;

            positionCell = new TableCell { Text = $@"
                                                <div class=""d-flex justify-content-center align-items-center user-name"">
                                                    <div class='avatar-wrapper'>
                                                        <div class='avatar me-2'>
                                                            <img src=""../../assets/img/medals/bronze.png"" alt=""Avatar"" class=""rounded-circle"">
                                                        </div>
                                                    </div>
                                                </div>" };
            positionCell.CssClass = "text-center";
            row.Cells.Add(positionCell);

            clubCell = new TableCell { Text = $"{thirdPlace2.Split('#')[0]}" };

            clubCell.CssClass = "text-start";
            row.Cells.Add(clubCell);

            fighter = new TableCell { Text = $"{thirdPlace2.Split('#')[1]}" };

            fighter.CssClass = "text-start";
            row.Cells.Add(fighter);

            table.Rows.Add(row);

            return table;
        }

        private Tuple<string, string> GetFirstAndSecondPlace(List<AtletaEliminatorie> poolOne)
        {
            int round = 1;

            int vittorieRosso = 0;
            int vittorieBlu = 0;
            string winner = "";
            string looser = "";

            //first match
            if (poolOne[0].PuntiFatti > poolOne[3].PuntiFatti)
                vittorieRosso++;
            else if (poolOne[0].PuntiFatti < poolOne[1].PuntiFatti)
                vittorieBlu++;

            //second match
            if (poolOne[1].PuntiFatti > poolOne[4].PuntiFatti)
                vittorieRosso++;
            else if (poolOne[1].PuntiFatti < poolOne[4].PuntiFatti)
                vittorieBlu++;

            //third match
            if (poolOne[2].PuntiFatti > poolOne[5].PuntiFatti)
                vittorieRosso++;
            else if(poolOne[2].PuntiFatti < poolOne[5].PuntiFatti)
                vittorieBlu++;


            if (vittorieRosso > vittorieBlu)
                return new Tuple<string, string>(
                    SqlDal_Fighters.GetAtletaById(poolOne[0].IdAtleta).Asd + "#" + poolOne[0].Cognome + " " + poolOne[0].Nome,
                    SqlDal_Fighters.GetAtletaById(poolOne[3].IdAtleta).Asd + "#"  + poolOne[3].Cognome + " " + poolOne[3].Nome);
            else
                return new Tuple<string, string>(
                    SqlDal_Fighters.GetAtletaById(poolOne[3].IdAtleta).Asd + "#" + poolOne[3].Cognome + " " + poolOne[3].Nome,
                    SqlDal_Fighters.GetAtletaById(poolOne[0].IdAtleta).Asd + "#" + poolOne[0].Cognome + " " + poolOne[0].Nome);


        }
        #endregion

        private static void AddDirectElimination(int matchNumber, AtletaEliminatorie atletaEliminatorie1, AtletaEliminatorie atletaEliminatorie2, Table table, Color color)
        {
            TableRow row = new TableRow();
            row.BackColor = color;

            TableCell matchId = new TableCell { Text = matchNumber.ToString() };
            matchId.CssClass = "text-center";
            row.Cells.Add(matchId);

            TableCell fighter1 = new TableCell { Text = $"{atletaEliminatorie1.Cognome} {atletaEliminatorie1.Nome}" };

            fighter1.CssClass = "text-start";
            row.Cells.Add(fighter1);

            // Colonna allineata al centro
            ;
            TableCell pointCell1 = new TableCell { Text = atletaEliminatorie1.PuntiFatti.ToString() };
            pointCell1.CssClass = "text-center";
            SetPointColour(false, atletaEliminatorie1.PuntiFatti, atletaEliminatorie2.PuntiFatti, pointCell1);
            row.Cells.Add(pointCell1);

            table.Rows.Add(row);


            row = new TableRow();
            row.BackColor = color;
            matchId = new TableCell { Text = matchNumber.ToString() };
            matchId.CssClass = "text-center";
            row.Cells.Add(matchId);

            TableCell fighter2 = new TableCell { Text = $"{atletaEliminatorie2.Cognome} {atletaEliminatorie2.Nome}" };

            fighter2.CssClass = "text-start";
            row.Cells.Add(fighter2);

            // Colonna allineata al centro
            TableCell pointCell2 = new TableCell { Text = atletaEliminatorie2.PuntiFatti.ToString() };
            pointCell2.CssClass = "text-center";
            SetPointColour(false, atletaEliminatorie2.PuntiFatti, atletaEliminatorie1.PuntiFatti, pointCell2);
            row.Cells.Add(pointCell2);

            table.Rows.Add(row);
        }
    }
}