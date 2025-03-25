using HemaTournamentWebSiteBLL.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace WebApplication2
{
    public partial class Fighters : System.Web.UI.Page
    {
        private string SearchText
        {
            get 
            { 
                // Controlla prima la query string
                if (Request.QueryString["search"] != null)
                    return Request.QueryString["search"];
                return string.Empty;
            }
            set
            {
                // Il setter non fa nulla perché usiamo la query string
                // ma deve esistere per compatibilità con il codice esistente
            }
        }

        private int CurrentPage
        {
            get
            {
                if (Request.QueryString["page"] != null && int.TryParse(Request.QueryString["page"], out int page))
                    return page;
                return 1;
            }
        }

        private int PageSize
        {
            get { return 15; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Ripopola la textbox di ricerca con il valore dalla query string
                txtSearch.Text = SearchText;
                LoadAllAssociates();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            SearchText = txtSearch.Text.Trim();
            Response.Redirect($"Fighters.aspx?page=1&search={Server.UrlEncode(txtSearch.Text)}");
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = string.Empty;
            SearchText = string.Empty;
            Response.Redirect("Fighters.aspx?page=1");
        }

        private void LoadAllAssociates()
        {
            divAssociatesList.Controls.Clear();
            var fighters = SqlDal_Fighters.GetAllAnagraficaAtleti().OrderBy(a => a.Cognome).ToList();

            if (fighters == null || fighters.Count == 0)
            {
                divAssociatesList.InnerHtml = "<div class='alert alert-info'>No fighters found.</div>";
                lblTotalRecords.Text = "No records found";
                phPagination.Visible = false;
                return;
            }

            if (!string.IsNullOrEmpty(SearchText))
            {
                fighters = fighters.Where(f =>
                    f.FullName.ToLower().Contains(SearchText.ToLower()))
                    .ToList();
            }

            int totalRecords = fighters.Count;
            int totalPages = (int)Math.Ceiling((double)totalRecords / PageSize);
            int skip = (CurrentPage - 1) * PageSize;
            var pagedFighters = fighters.Skip(skip).Take(PageSize).ToList();

            lblTotalRecords.Text = $"Showing {skip + 1}-{Math.Min(skip + PageSize, totalRecords)} of {totalRecords} fighters";

            Table table = new Table();
            table.CssClass = "table table-hover table-striped";

            // Crea l'intestazione della tabella
            TableHeaderRow headerRow = new TableHeaderRow();
            headerRow.CssClass = "table-dark";
            headerRow.Cells.Add(new TableHeaderCell { Text = "Bio", HorizontalAlign = HorizontalAlign.Center, CssClass = "text-right", Width = Unit.Percentage(2) });
            headerRow.Cells.Add(new TableHeaderCell { Text = "Club", HorizontalAlign = HorizontalAlign.Center, CssClass = "text-right", Width = Unit.Percentage(2) });
            headerRow.Cells.Add(new TableHeaderCell { Text = "Name", HorizontalAlign = HorizontalAlign.Center, CssClass = "text-left", Width = Unit.Percentage(98) });
            table.Rows.Add(headerRow);

            // Genera dinamicamente i dati per la pagina corrente
            foreach (var fighter in pagedFighters)
            {
                TableRow row = new TableRow();

                TableCell profileCell = new TableCell { Text = $@"<a href=""Fighter.aspx?idFighter={fighter.IdAtleta}"" class=""btn btn-icon item-edit""><i class=""icon-base bx bxs-user-detail icon-sm""></i></a>" };
                row.Cells.Add(profileCell);

                TableCell clubCell = new TableCell { Text = $@"<a href=""Club.aspx?idClub={fighter.IdAsd}"" class=""btn btn-icon item-edit""><i class=""icon-base bx bxs-t-shirt icon-sm""></i></a>" };
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

                table.Rows.Add(row);
            }

            divAssociatesList.Controls.Add(table);
            GeneratePaginationControls(totalPages);
        }

        private void GeneratePaginationControls(int totalPages)
        {
            phPagination.Controls.Clear();
            if (totalPages <= 1)
            {
                phPagination.Visible = false;
                return;
            }

            phPagination.Visible = true;

            // Pulsante Previous
            if (CurrentPage > 1)
            {
                AddPaginationButton("«", CurrentPage - 1);
            }

            // Numeri di pagina con ellipsis
            const int maxVisiblePages = 5;
            int startPage = Math.Max(1, CurrentPage - (maxVisiblePages / 2));
            int endPage = Math.Min(totalPages, startPage + maxVisiblePages - 1);

            if (startPage > 1)
            {
                AddPaginationButton("1", 1);
                if (startPage > 2)
                {
                    AddEllipsis();
                }
            }

            for (int i = startPage; i <= endPage; i++)
            {
                AddPaginationButton(i.ToString(), i, i == CurrentPage);
            }

            if (endPage < totalPages)
            {
                if (endPage < totalPages - 1)
                {
                    AddEllipsis();
                }
                AddPaginationButton(totalPages.ToString(), totalPages);
            }

            // Pulsante Next
            if (CurrentPage < totalPages)
            {
                AddPaginationButton("»", CurrentPage + 1);
            }
        }

        private void AddPaginationButton(string text, int pageNumber, bool isActive = false)
        {
            var li = new HtmlGenericControl("li");
            li.Attributes["class"] = "page-item" + (isActive ? " active" : "");
            
            var link = new HtmlGenericControl("a");
            // Mantieni il parametro di ricerca nei link di paginazione
            string searchParam = !string.IsNullOrEmpty(SearchText) ? $"&search={Server.UrlEncode(SearchText)}" : "";
            link.Attributes["href"] = $"Fighters.aspx?page={pageNumber}{searchParam}";
            link.Attributes["class"] = "page-link";
            link.InnerText = text;
            
            li.Controls.Add(link);
            phPagination.Controls.Add(li);
        }

        private void AddEllipsis()
        {
            var li = new HtmlGenericControl("li");
            li.Attributes["class"] = "page-item disabled";
            var span = new HtmlGenericControl("span");
            span.Attributes["class"] = "page-link";
            span.InnerText = "...";
            li.Controls.Add(span);
            phPagination.Controls.Add(li);
        }
    }
}