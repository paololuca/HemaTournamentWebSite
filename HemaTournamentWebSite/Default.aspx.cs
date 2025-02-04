using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HemaTournamentWebSite
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Page.IsPostBack)
            {
                Session["idTournament"] = "0";
                Session["idDiscipline"] = "0";

                Session["TournamentName"] = "";
                Session["DisciplineName"] = "";

            }
        }
    }
}