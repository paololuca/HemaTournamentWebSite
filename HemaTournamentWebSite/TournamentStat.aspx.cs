using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace WebApplication2
{
    public partial class WebForm1Prova : System.Web.UI.Page
    {
        private int idTournament;
        private int idDiscipline;

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

            GenerateAccordionItems(); // Genera 10 elementi
        }

        private void LoadTournamentDropdownItems()
        {
            // Cancella eventuali elementi esistenti (necessario per evitare duplicati durante i postback)
            dropdownTournamentMenu.Controls.Clear();

            // Simulazione di dati recuperati dal database
            var tournaments = new List<string> { "Tournament A - Mascile", "Tournament A - Femminile" };

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

                button.Click += DropdownItem_Click; // Associa l'evento Click

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
                button.Attributes.Add("data-value", tempKey.ToString());

                button.Click += DropdownItem_Click; // Associa l'evento Click

                // Aggiungi il pulsante all'elemento <li>
                li.Controls.Add(button);

                // Aggiungi l'elemento <li> alla lista <ul>
                dropdownDisciplineMenu.Controls.Add(li);

                tempKey++;
            }
        }

        protected void DropdownItem_Click(object sender, EventArgs e)
        {
            // Recupera il pulsante cliccato
            Button clickedButton = sender as Button;
            if (clickedButton != null)
            {
                string selectedTournament = clickedButton.CommandArgument;
                string customValue = ((Button)sender).Attributes["data-value"];

                // Logica per gestire l'elemento selezionato
                System.Diagnostics.Debug.WriteLine($"Selected Tournament {selectedTournament} with id {customValue}");
            }
        }


        private void GenerateAccordionItems()
        {
            // Supponiamo di avere una lista di pool (ad esempio "Pool 1", "Pool 2", "Pool 3", etc.)
            List<string> pools = new List<string> { "Pool 1", "Pool 2", "Pool 3", "Pool 4", "Pool 5", "Pool 6", "Pool 7", "Pool 8", "Pool 9", "Pool 10" };

            // Cicla attraverso i pool e crea un accordion per ognuno
            for (int i = 0; i< 10; i++)
            {
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
                var table = GenerateTable("Pool "+i); // Crea la tabella dinamica
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
        private Table GenerateTable(string poolName)
        {
            Table table = new Table();
            table.CssClass = "table table-bordered";

            // Crea l'intestazione della tabella
            TableHeaderRow headerRow = new TableHeaderRow();
            headerRow.Cells.Add(new TableHeaderCell { Text = "Red Fighter" });
            headerRow.Cells.Add(new TableHeaderCell { Text = "Point" });
            headerRow.Cells.Add(new TableHeaderCell { Text = "Double Death" });
            headerRow.Cells.Add(new TableHeaderCell { Text = "Point" });
            headerRow.Cells.Add(new TableHeaderCell { Text = "Blu Fighter" });
            table.Rows.Add(headerRow);

            // Aggiungi alcune righe alla tabella (dati di esempio, personalizzabili)
            for (int i = 0; i < 4; i++)
            {
                TableRow row = new TableRow();
                row.Cells.Add(new TableCell { Text = "Pinco Pallo" });
                row.Cells.Add(new TableCell { Text = "4" });
                row.Cells.Add(new TableCell { Text = "<span class='badge bg-label-success me-1'>NO</span>" });
                row.Cells.Add(new TableCell { Text = "5" });
                row.Cells.Add(new TableCell { Text = "Panco Pinco" });
                table.Rows.Add(row);
            }

            return table;
        }

    }
}