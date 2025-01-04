using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace HemaTournamentWebSite
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
            }

            string currentPage = Path.GetFileName(Request.Url.AbsolutePath);

            switch (currentPage.ToLower())
            {
                case "fighters":
                    SetActiveMenu("fightersMenu");
                    break;
                case "about":
                    SetActiveMenu("aboutMenu");
                    break;
                case "contact":
                    SetActiveMenu("contactUsMenu");
                    break;
                case "dashboard":
                    SetActiveMenu("dashboardMenu");
                    break;
                case "tournamentdates":
                    SetActiveMenu("datesMenu");
                    break;
                case "clubs":
                    SetActiveMenu("clubsMenu");
                    break;
                case "awards":
                    SetActiveMenu("awardsMenu");
                    break;
                    //clubsMenu, datesMenu
            }
        }

        private void SetActiveMenu(string activeMenuId)
        {
            // Ottieni una lista di tutti gli elementi `<li>` del menu
            List<HtmlGenericControl> menuItems = new List<HtmlGenericControl>
                {
                    //dashboardMenu,
                    datesMenu,
                    fightersMenu,
                    clubsMenu,
                    awardsMenu,
                    aboutMenu,
                    contactUsMenu
                };

            // Itera su tutti gli elementi e aggiorna la classe
            foreach (var menuItem in menuItems)
            {
                if (menuItem.ID == activeMenuId)
                {
                    menuItem.Attributes["class"] = "menu-item active"; // Imposta attivo
                }
                else
                {
                    menuItem.Attributes["class"] = "menu-item"; // Ripristina normale
                }
            }
        }
    }
}