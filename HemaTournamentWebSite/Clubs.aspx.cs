using HemaTournamentWebSiteBLL.BusinessEntity.Entity;
using HemaTournamentWebSiteBLL.DAL;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace WebApplication2
{
    public partial class Clubs : System.Web.UI.Page
    {
        string pathClubsImages = "~/assets/img/Clubs/";
        string pathHrefClubsImages = "../../assets/img/Clubs/";
        private string absolutePath;

        protected void Page_Load(object sender, EventArgs e)
        {
            var clubs = SqlDal_Associations.GetAllAsdWithMembersNumber();
            absolutePath = Server.MapPath(pathClubsImages);

            if (clubs != null)
            {
                SetClubsCards(clubs);
            }
        }

        private void SetClubsCards(List<AsdEntity> clubs)
        {
            int i = 0;
            foreach (var c in clubs) // Per aggiungere 3 elementi
            {
                i++;

                HtmlGenericControl colDiv = GetClubsCard(c);

                // Aggiunta del col div al contenitore principale
                activeClubs.Controls.Add(colDiv);       
            }
        }

        private HtmlGenericControl GetClubsCard(AsdEntity club)
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
            cardTitle.InnerText = $"{club.NomeAsd}"; // Testo dinamico

            HtmlGenericControl cardAssociates = new HtmlGenericControl("h6");
            cardAssociates.Attributes["class"] = "card-subtitle";
            cardAssociates.InnerText = $"{club.AtletiAssociativi} Associates"; // Testo dinamico

            HtmlGenericControl cardPlace = new HtmlGenericControl("p");
            cardPlace.Attributes["class"] = "card-text";
            cardPlace.InnerText = club.Place != "" ? $"Place: {club.Place}" : "";

            cardBody1.Controls.Add(cardTitle);
            cardBody1.Controls.Add(cardPlace);
            cardBody1.Controls.Add(cardAssociates);

            // Aggiunta immagine
            HtmlGenericControl img = new HtmlGenericControl("img");
            img.Attributes["class"] = "img-fluid";
            img.Attributes["src"] = pathHrefClubsImages + GetImage(club.NomeAsd);
            img.Attributes["alt"] = "Card image cap";

            // Creazione del secondo card body
            HtmlGenericControl cardBody2 = new HtmlGenericControl("div");
            cardBody2.Attributes["class"] = "card-body";

            string baseUrl = "Club.aspx";
            HtmlGenericControl cardLink1 = new HtmlGenericControl("a");
            cardLink1.Attributes["class"] = "btn btn-primary";
            cardLink1.Attributes["href"] = $"{baseUrl}?idClub={club.Id}";
            cardLink1.InnerText = "Go to details";

            //HtmlGenericControl cardLink2 = new HtmlGenericControl("a");
            //cardLink2.Attributes["class"] = "card-link";
            //cardLink2.Attributes["href"] = "javascript:void(0);";
            //cardLink2.InnerText = "Another link";

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

        private string GetImage(string nomeAsd)
        {
            var name = Regex.Replace(nomeAsd, @"[^a-zA-Z]", "");

            if (File.Exists(absolutePath + name + ".png"))
                return name + ".png";
            else
                return "generic_club.png";
        }
    }
}