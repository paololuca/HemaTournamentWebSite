using HemaTournamentWebSite.DAL;
using HemaTournamentWebSite.DAL.DAL.Entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using WebApplication2.Manager;

namespace HemaTournamentWebSite
{
    public partial class WebForm1Prova : System.Web.UI.Page
    {
        private int tournamentId;
        private int disciplineId;

        // Simulazione di dati recuperati dal database
        private List<string> disciplineList = new List<string> { "Spada e Pugnale", "Spada e Rotella", "Spada e Brocchiere", "Spada a due Mani" };
        private List<string> disciplineIdList = new List<string> { "2", "3", "4", "11" };


        SqlDalHema hemaEngine = new SqlDalHema();
        private List<Matches> matches;
        private bool debug;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Ricrea gli elementi dinamici sempre, anche durante i postback
            if (!Page.IsPostBack)
            {
            }

            debug = ConfigurationManager.AppSettings["Debug"].ToString() == "true";

            if (debug)
            {
                lblConnectionStatus.Text = hemaEngine.TestConmnection();
                lblConnectionStatus.Visible = true;
            }

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

                var tournamentEntity = hemaEngine.LoadTorunamentsDesc(tournamentId);

                if (tournamentEntity != null)
                    lblTournament.Text = tournamentEntity.Name;
            }

            if (!string.IsNullOrEmpty(discipline))
            {
                // Fai qualcosa con idDiscipline
                disciplineId = int.Parse(discipline);

                if(disciplineId >  0)
                    lblDiscipline.Text = disciplineList.ElementAt(disciplineIdList.IndexOf(discipline));
            }

            if(tournamentId != 0 && disciplineId != 0)
            {
                CreatePoolsTables();

                SetRanking();
            }
        }

        //private void LoadTournamentDropdownItems()
        //{
        //    // Cancella eventuali elementi esistenti (necessario per evitare duplicati durante i postback)
        //    dropdownTournamentMenu.Controls.Clear();

        //    // Simulazione di dati recuperati dal database
        //    var tournaments = hemaEngine.LoadTorunaments();

        //    if (tournaments == null || tournaments.Count == 0)
        //        return;

        //    int tempKey = 0;
        //    foreach (var tournament in tournaments)
        //    {
        //        // Creazione di un elemento <li>
        //        HtmlGenericControl li = new HtmlGenericControl("li");

        //        // Creazione del pulsante
        //        Button button = new Button
        //        {
        //            Text = tournament.Name,
        //            CssClass = "dropdown-item", // Stile Bootstrap
        //            CommandArgument = tournament.Name, // Imposta un valore identificativo
        //        };
        //        button.Attributes.Add("data-value", tournament.Id.ToString());

        //        button.Click += TournamentDropdownItem_Click; // Associa l'evento Click

        //        // Aggiungi il pulsante all'elemento <li>
        //        li.Controls.Add(button);

        //        // Aggiungi l'elemento <li> alla lista <ul>
        //        dropdownTournamentMenu.Controls.Add(li);

        //        tempKey++;
        //    }
        //}

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

        //protected void TournamentDropdownItem_Click(object sender, EventArgs e)
        //{
        //    // Recupera il pulsante cliccato
        //    Button clickedButton = sender as Button;
        //    if (clickedButton != null)
        //    {
        //        string selectedTournament = clickedButton.CommandArgument;
        //        string customValue = ((Button)sender).Attributes["data-value"];

        //        // Logica per gestire l'elemento selezionato
        //        System.Diagnostics.Debug.WriteLine($"Selected Tournament {selectedTournament} with id {customValue}");

        //        idTournament = Convert.ToInt32(customValue);
        //        lblIdTorneo.Text = customValue;
        //        idTournament = Convert.ToInt32(lblIdTorneo.Text);

        //        lblTournament.Text = selectedTournament;
        //        idDiscipline = 0;
        //        lblDiscipline.Text = "";
        //    }
        //}

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
                lblDiscipline.Text = selectedDicipline;

                Response.Redirect("TournamentStat.aspx?idTournament=" + tournamentId+"&idDiscipline="+ disciplineId);

            }
        }


        private void CreatePoolsTables()
        {
            if (debug)
            {
                lblConnectionStatus.Text = "lblIdTorneo = "+ tournamentId + " IdDisciplina = " + disciplineId;
                lblConnectionStatus.Visible = true;
            }
            
            if (tournamentId == 0 || disciplineId == 0)
                return;

            var tournament = hemaEngine.LoadTorunamentsDesc(tournamentId);

            matches = hemaEngine.LoadPoolsMatches(tournamentId, disciplineId);

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
                Table table = GenerateTable("Pool " + i, pool); // Metodo esistente per generare la tabella
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
        private Table GenerateTable(string poolName, List<Matches> pool)
        {
            Table table = new Table();
            table.CssClass = "table table-hover";

            // Crea l'intestazione della tabella con allineamento personalizzato
            TableHeaderRow headerRow = new TableHeaderRow();

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
                    "<span class='badge bg-label-danger me-1'>SI</span>" :
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

            var stats = hemaEngine.LoadStats(tournamentId, disciplineId);

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
    }
}