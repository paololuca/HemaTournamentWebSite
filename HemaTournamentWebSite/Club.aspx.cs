using HemaTournamentWebSiteBLL.BusinessEntity.Entity;
using HemaTournamentWebSiteBLL.DAL;
using HemaTournamentWebSiteBLL.DAL.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Emit;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2
{
    public partial class Club : System.Web.UI.Page
    {
        int idClub;
        Random random;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                idClub = Convert.ToInt32(Request.QueryString["idClub"]);
            }
            catch { idClub = 0; }

            random = new Random();

            if (idClub != 0)
            {
                SetAssociatesList(idClub);
            }
            else
                Response.Redirect("Clubs.aspx");
        }

        private void SetAssociatesList(int idClub)
        {
            
            var clubEntity = SqlDal_Associations.GetAllAsd(true).First(c => c.Id == idClub);

            this.Title = "Club - " + clubEntity.NomeAsd;
            lblClubName.Text = clubEntity.NomeAsd;
            lblClubPlace.Text = clubEntity.Place != "" && clubEntity.Place != null ? " - "+ clubEntity.Place : "";
            
            var fighters = SqlDal_Fighters.GetAllAnagraficaAtleti(clubEntity.Id);
            SetFIghtersList(fighters);
        }

        private void SetFIghtersList(List<AtletaEntity> fighters)
        {
            if (fighters.Count == 0)
                return;
            
            Table table = new Table();
            table.CssClass = "table table-hover table-striped";

            // Crea l'intestazione della tabella
            TableHeaderRow headerRow = new TableHeaderRow();
            headerRow.CssClass = "table-dark";
            headerRow.Cells.Add(new TableHeaderCell { Text = "Name", HorizontalAlign = HorizontalAlign.Center, CssClass = "text-left", Width = Unit.Percentage(70) });
            headerRow.Cells.Add(new TableHeaderCell { Text = "Active", HorizontalAlign = HorizontalAlign.Center, CssClass = "text-center", Width = Unit.Percentage(20) });
            headerRow.Cells.Add(new TableHeaderCell { Text = "", HorizontalAlign = HorizontalAlign.Center, CssClass = "text-right", Width = Unit.Percentage(10) });

            // Aggiungi l'intestazione alla tabella
            table.Rows.Add(headerRow);

            // Genera dinamicamente i dati
            int pos = 0;
            foreach (var fighter in fighters)
            {
                TableRow row = new TableRow();
                
                row.Cells.Add(new TableCell { Text = $@"
                                                <div class=""d-flex justify-content-start align-items-center user-name"">
                                                    <div class='avatar-wrapper'>
                                                        <div class='avatar me-2'>
                                                            <img src=""../../assets/img/avatars/fencing.png"" alt=""Avatar"" class=""rounded-circle"">
                                                        </div>
                                                    </div>
                                                    <div class=""d-flex flex-column"">
                                                      <span class=""emp_name text-truncate text-heading"">{fighter.FullName}</span>
                                                    </div>
                                                </div>" });


                TableCell activeCell = new TableCell { Text = fighter.IsEnabled ? $"<span class='badge bg-label-success'>YES</span>" :
                            $"<span class='badge bg-label-danger'>NO</span>"
                };
                activeCell.CssClass = "text-center";
                
                row.Cells.Add(activeCell);

                TableCell profileCell =  new TableCell { Text = $@"<a href = ""Fighter.aspx?idFighter={fighter.IdAtleta}"" class=""btn btn-icon item-edit""><i class=""icon-base bx bx-edit icon-sm""></i></a>"};

                row.Cells.Add(profileCell);

                table.Rows.Add(row);

                pos++;
            }

            // Aggiungi la tabella al div
            divAssociatesList.Controls.Add(table);

        }

        public string RandomBx()
        {
            List<string> list = new List<string>()
            {
                "bg-label-warning",
                "bg-label-danger",
                "bg-label-success"
            };


            // Estrai un indice casuale
            int randomIndex = random.Next(list.Count);

            // Ottieni il valore dalla lista usando l'indice casuale
            string randomValue = list[randomIndex];


            return randomValue;
        }
    }
}