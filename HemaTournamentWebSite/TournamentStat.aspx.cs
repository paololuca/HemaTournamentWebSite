using HemaTournamentWebSite.DAL;
using HemaTournamentWebSite.DAL.DAL.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace HemaTournamentWebSite
{
    public partial class WebForm1Prova : System.Web.UI.Page
    {
        private int idTournament;
        private int idDiscipline;

        SqlDalHema hemaEngine = new SqlDalHema();
        private List<Matches> matches;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Ricrea gli elementi dinamici sempre, anche durante i postback
            if (!Page.IsPostBack)
            {
                idTournament = 0;
                idDiscipline = 0;
            }

            LoadTournamentDropdownItems();
            LoadDisciplineDropdownItems();

            matches = hemaEngine.LoadPoolsMatches(30);

            GenerateAccordionItems();

            SetRanking();
        }

        private void LoadTournamentDropdownItems()
        {
            // Cancella eventuali elementi esistenti (necessario per evitare duplicati durante i postback)
            dropdownTournamentMenu.Controls.Clear();

            // Simulazione di dati recuperati dal database
            var tournaments = new List<string> { "Tournament A - Maschile", "Tournament A - Femminile" };

            int tempKey = 0;
            foreach (var tournament in tournaments)
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
                button.Attributes.Add("data-value", tempKey.ToString());

                button.Click += TournamentDropdownItem_Click; // Associa l'evento Click

                // Aggiungi il pulsante all'elemento <li>
                li.Controls.Add(button);

                // Aggiungi l'elemento <li> alla lista <ul>
                dropdownTournamentMenu.Controls.Add(li);

                tempKey++;
            }
        }

        private void LoadDisciplineDropdownItems()
        {
            // Cancella eventuali elementi esistenti (necessario per evitare duplicati durante i postback)
            dropdownDisciplineMenu.Controls.Clear();

            // Simulazione di dati recuperati dal database
            var tournaments = new List<string> { "Spada e Pugnale", "Spada e Rotella", "Spada e brocchiere", "Spada a due mani" };

            int tempKey = 0;
            foreach (var tournament in tournaments)
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
                button.Attributes.Add("data-value", tempKey.ToString()); //is the key

                button.Click += DisciplineDropdownItem_Click; // Associa l'evento Click

                // Aggiungi il pulsante all'elemento <li>
                li.Controls.Add(button);

                // Aggiungi l'elemento <li> alla lista <ul>
                dropdownDisciplineMenu.Controls.Add(li);

                tempKey++;
            }
        }

        protected void TournamentDropdownItem_Click(object sender, EventArgs e)
        {
            // Recupera il pulsante cliccato
            Button clickedButton = sender as Button;
            if (clickedButton != null)
            {
                string selectedTournament = clickedButton.CommandArgument;
                string customValue = ((Button)sender).Attributes["data-value"];

                // Logica per gestire l'elemento selezionato
                System.Diagnostics.Debug.WriteLine($"Selected Tournament {selectedTournament} with id {customValue}");

                lblTournament.Text = selectedTournament;
                lblDiscipline.Text = "";
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

                lblDiscipline.Text = " - " + selectedDicipline;
            }
        }


        private void GenerateAccordionItems()
        {
            // Supponiamo di avere una lista di pool (ad esempio "Pool 1", "Pool 2", "Pool 3", etc.)

            var tournament = hemaEngine.LoadTorunamentsDesc(30);

            if (tournament == null || matches == null)
                return;

            // Cicla attraverso i pool e crea un accordion per ognuno
            for (int i = 0; i< tournament.Pools; i++)
            {
                var pool = matches.Where(x => x.Pool == i + 1).ToList();

                // Creazione del div "card accordion-item"
                var cardDiv = new HtmlGenericControl("div");
                cardDiv.Attributes["class"] = "card accordion-item";

                // Creazione del "h2" header
                var headerH2 = new HtmlGenericControl("h2");
                headerH2.Attributes["class"] = "accordion-header";
                headerH2.Attributes["id"] = $"headingPool{i}";

                // Creazione del bottone
                var button = new HtmlGenericControl("button");
                button.Attributes["type"] = "button";
                button.Attributes["class"] = "accordion-button collapsed";
                button.Attributes["data-bs-toggle"] = "collapse";
                button.Attributes["data-bs-target"] = $"#collapsePool{i}";
                button.Attributes["aria-expanded"] = "false";
                button.Attributes["aria-controls"] = $"collapsePool{i}";
                button.InnerText = $"Pool {i}";

                // Aggiunta del bottone all'header
                headerH2.Controls.Add(button);

                // Creazione del div "collapse"
                var collapseDiv = new HtmlGenericControl("div");
                collapseDiv.Attributes["id"] = $"collapsePool{i}";
                collapseDiv.Attributes["class"] = "accordion-collapse collapse";
                collapseDiv.Attributes["data-bs-parent"] = "#collapsibleSection";

                // Creazione del div "accordion-body"
                var bodyDiv = new HtmlGenericControl("div");
                bodyDiv.Attributes["class"] = "accordion-body";
                
                // Crea la tabella da aggiungere all'interno del body dell'accordion
                var table = GenerateTable("Pool "+i, pool); // Crea la tabella dinamica
                bodyDiv.Controls.Add(table);

                // Aggiunta del body al collapse
                collapseDiv.Controls.Add(bodyDiv);

                // Aggiunta dell'header e del collapse al card
                cardDiv.Controls.Add(headerH2);
                cardDiv.Controls.Add(collapseDiv);

                // Aggiunta del card al contenitore principale
                collapsibleSection.Controls.Add(cardDiv);

                
            }
        }

        // Funzione che genera la tabella dinamica
        private Table GenerateTable(string poolName, List<Matches> pool)
        {
            Table table = new Table();
            table.CssClass = "table table-bordered";

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
                    "<span class='badge bg-label-warning me-1'>SI</span>" :
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
            var stats = hemaEngine.LoadStats(30);

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

                row.Cells.Add(new TableCell { Text = pos < atletiAmmessiEliminatorie ?  
                    $"<span class='badge bg-label-success'>YES</span>" :
                    $"<span class='badge bg-label-warning'>NO</span>"
                });
                row.Cells.Add(new TableCell { Text = s.Surname });
                row.Cells.Add(new TableCell { Text = s.Name });
                row.Cells.Add(new TableCell { Text = s.Victory.ToString(), HorizontalAlign = HorizontalAlign.Center, CssClass = "text-center" });
                row.Cells.Add(new TableCell { Text = s.Hit.ToString(), HorizontalAlign = HorizontalAlign.Center, CssClass = "text-center" });
                row.Cells.Add(new TableCell { Text = s.Hitted.ToString(), HorizontalAlign = HorizontalAlign.Center, CssClass = "text-center" });
                row.Cells.Add(new TableCell { Text = s.Delta.ToString(), HorizontalAlign = HorizontalAlign.Center, CssClass = "text-center" });
                row.Cells.Add(new TableCell { Text = s.Ranking.ToString(), HorizontalAlign = HorizontalAlign.Center, CssClass = "text-center" });

                table.Rows.Add(row);

                pos++;
            }

            // Aggiungi la tabella al div
            divRankingTable.Controls.Add(table);
        }

        private static void SetPointColour(bool doubleDeath, int pointA, int pointB, TableCell pointCell)
        {
            pointCell.BackColor = doubleDeath ? System.Drawing.Color.OrangeRed :
                pointA == pointB ? System.Drawing.Color.LightGray :
                pointA > pointB ? System.Drawing.Color.LightGreen : System.Drawing.Color.Orange;
        }
    }
}