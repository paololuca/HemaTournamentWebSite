using HemaTournamentWebSiteBLL.BusinessEntity.Entity;
using HemaTournamentWebSiteBLL.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2
{
    public partial class Fighter : System.Web.UI.Page
    {
        private int idFighter;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                idFighter = Convert.ToInt32(Request.QueryString["idFighter"]);
            }
            catch { idFighter = 0; }


            if (idFighter != 0)
            {
                //GO

                var fighter = SqlDal_Fighters.GetAtletaById(idFighter);

                if (idFighter == 32)
                {
                    WIP.Visible = false;
                    dashboardDiv.Visible = true;
                }

                SetFighterInformatzion(fighter);

            }
            else
                Response.Redirect("Default.aspx");
        }

        private void SetFighterInformatzion(AtletaEntity fighter)
        {
            this.Title = $"Fighter - {fighter.Cognome} {fighter.Nome}";
        }
    }
}