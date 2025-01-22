using HemaTournamentWebSiteBLL.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2
{
    public partial class Fighters : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadAllAssociates();
        }

        private void LoadAllAssociates()
        {
            //
            var fighters = SqlDal_Fighters.GetAllAnagraficaAtleti().OrderBy(a => a.Cognome).ToList();


            if (fighters.Count == 0)
                return;

            Table table = new Table();
            table.CssClass = "table table-hover table-striped";

            // Crea l'intestazione della tabella
            TableHeaderRow headerRow = new TableHeaderRow();
            headerRow.CssClass = "table-dark";
            //headerRow.Cells.Add(new TableHeaderCell { Text = "Active", HorizontalAlign = HorizontalAlign.Center, CssClass = "text-center", Width = Unit.Percentage(20) });
            headerRow.Cells.Add(new TableHeaderCell { Text = "Profile", HorizontalAlign = HorizontalAlign.Center, CssClass = "text-right", Width = Unit.Percentage(2) });
            headerRow.Cells.Add(new TableHeaderCell { Text = "Club", HorizontalAlign = HorizontalAlign.Center, CssClass = "text-right", Width = Unit.Percentage(2) });
            headerRow.Cells.Add(new TableHeaderCell { Text = "Name", HorizontalAlign = HorizontalAlign.Center, CssClass = "text-left", Width = Unit.Percentage(98) });
            
            

            // Aggiungi l'intestazione alla tabella
            table.Rows.Add(headerRow);

            // Genera dinamicamente i dati
            int pos = 0;
            foreach (var fighter in fighters)
            {
                TableRow row = new TableRow();

                TableCell profileCell = new TableCell { Text = $@"<a href = ""Fighter.aspx?idFighter={fighter.IdAtleta}"" class=""btn btn-icon item-edit""><i class=""icon-base bx bx-edit icon-sm""></i></a>" };

                row.Cells.Add(profileCell);

                TableCell clubCell = new TableCell { Text = $@"<a href = ""Club.aspx?idClub={fighter.IdAsd}"" class=""btn btn-icon item-edit""><i class=""icon-base bx bxs-t-shirt icon-sm""></i></a>" };

                row.Cells.Add(clubCell);

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


                //TableCell activeCell = new TableCell
                //{
                //    Text = fighter.IsEnabled ? $"<span class='badge bg-label-success'>YES</span>" :
                //            $"<span class='badge bg-label-danger'>NO</span>"
                //};
                //activeCell.CssClass = "text-center";

                //row.Cells.Add(activeCell);

                

                table.Rows.Add(row);

                pos++;
            }

            // Aggiungi la tabella al div
            divAssociatesList.Controls.Add(table);
        }
    }
}