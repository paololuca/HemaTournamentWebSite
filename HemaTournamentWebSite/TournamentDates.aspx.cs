using HemaTournamentWebSiteBLL.DAL;
using HemaTournamentWebSiteBLL.DAL.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace WebApplication2
{
    public partial class TournamentDates : System.Web.UI.Page
    {
        SqlTournamentHema hemaEngine = new SqlTournamentHema();

        protected void Page_Load(object sender, EventArgs e)
        {
            var tournaments = hemaEngine.LoadTorunaments().OrderBy(t => t.EndDate);

            if (tournaments != null)
            {
                AddCardsToActiveTournament(tournaments.Where(t => t.EndDate.AddDays(1) >= DateTime.Now).ToList());
                AddCardsToClosedTournament(tournaments.Where(t => t.EndDate.AddDays(1) < DateTime.Now).OrderByDescending(t => t.EndDate).ToList());
            }
        }

        private void AddCardsToActiveTournament(List<Tournament> openTournaments)
        {

            if (openTournaments == null || openTournaments.Count == 0)
            {
                divTba.Visible = true;
                return;
            }

            divTba.Visible = false;

            foreach (var t in openTournaments) // Per aggiungere 3 elementi
            {
                HtmlGenericControl colDiv = GetTournamentCard(t);

                // Aggiunta del col div al contenitore principale
                activeTournament.Controls.Add(colDiv);
            }
        }

        private void AddCardsToClosedTournament(List<Tournament> closedTournaments)
        {
            if (closedTournaments == null || closedTournaments.Count == 0)
                return;

            foreach (var t in closedTournaments) // Per aggiungere 3 elementi
            {
                HtmlGenericControl colDiv = GetTournamentCard(t);

                // Aggiunta del col div al contenitore principale
                closedTournament.Controls.Add(colDiv);
            }
        }

        private static HtmlGenericControl GetTournamentCard(Tournament t)
        {
            // Creazione del div principale
            HtmlGenericControl colDiv = new HtmlGenericControl("div");
            colDiv.Attributes["class"] = "col-md-6 col-lg-4";

            // Creazione del div card
            HtmlGenericControl cardDiv = new HtmlGenericControl("div");
            cardDiv.Attributes["class"] = "card h-100";

            // Creazione del card body
            HtmlGenericControl cardBody1 = new HtmlGenericControl("div");
            cardBody1.Attributes["class"] = "card-body";

            HtmlGenericControl cardTitle = new HtmlGenericControl("h5");
            cardTitle.Attributes["class"] = "card-title";
            cardTitle.InnerText = $"{t.Name}"; // Testo dinamico

            HtmlGenericControl cardSubtitle = new HtmlGenericControl("h6");
            cardSubtitle.Attributes["class"] = "card-subtitle";
            cardSubtitle.InnerText = $"{t.Place}, {t.StartDate.ToString("dd/MM/yyy")} - {t.EndDate.ToString("dd/MM/yyy")} "; // Testo dinamico

            cardBody1.Controls.Add(cardTitle);
            cardBody1.Controls.Add(cardSubtitle);

            // Aggiunta immagine
            HtmlGenericControl img = new HtmlGenericControl("img");
            img.Attributes["class"] = "img-fluid";
            img.Attributes["src"] = "../../assets/img/elements/TournamentCard/" + t.Name.Replace(" ","") + ".png";
            img.Attributes["alt"] = "Card image cap";

            // Creazione del secondo card body
            HtmlGenericControl cardBody2 = new HtmlGenericControl("div");
            cardBody2.Attributes["class"] = "card-body";

            HtmlGenericControl cardText = new HtmlGenericControl("p");
            cardText.Attributes["class"] = "card-text";
            cardText.InnerText = "4 Disciplines";

            string baseUrl = "TournamentStat.aspx";
            HtmlGenericControl cardLink1 = new HtmlGenericControl("a");
            cardLink1.Attributes["class"] = "btn btn-primary";
            cardLink1.Attributes["href"] = $"{baseUrl}?idTournament={t.Id}&idDiscipline={0}";
            cardLink1.InnerText = "Go to matches and result";

            //HtmlGenericControl cardLink2 = new HtmlGenericControl("a");
            //cardLink2.Attributes["class"] = "card-link";
            //cardLink2.Attributes["href"] = "javascript:void(0);";
            //cardLink2.InnerText = "Another link";

            cardBody2.Controls.Add(cardText);
            cardBody2.Controls.Add(cardLink1);
            //cardBody2.Controls.Add(cardLink2);

            // Aggiunta dei componenti al card div
            cardDiv.Controls.Add(cardBody1);
            cardDiv.Controls.Add(img);
            cardDiv.Controls.Add(cardBody2);

            // Aggiunta del card div al col div
            colDiv.Controls.Add(cardDiv);
            return colDiv;
        }

        
    }
}