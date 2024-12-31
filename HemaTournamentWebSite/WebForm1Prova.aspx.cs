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

            LoadDropdownItems();
        }

        private void LoadDropdownItems()
        {
            // Cancella eventuali elementi esistenti (necessario per evitare duplicati durante i postback)
            dropdownMenu.Controls.Clear();

            // Simulazione di dati recuperati dal database
            var tournaments = new List<string> { "Action", "Another action", "Something else here" };

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
                dropdownMenu.Controls.Add(li);

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
    }
}