<%@ Page Title="Fighters" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Fighters.aspx.cs" Inherits="WebApplication2.Fighters" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="Default.aspx">Home</a></li>
            <li class="breadcrumb-item"><a href="Clubs.aspx">Clubs</a></li>
            <li class="breadcrumb-item active">Associates</li>
        </ol>
    </nav>

    <h2>Associates</h2>
    <div class="card">
        <div class="card-body">
            <div class="row mb-3">
                <div class="col-md-6">
                    <div class="input-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search by name..." />
                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btnSearch_Click" />
                        <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-outline-secondary" OnClick="btnReset_Click" />
                    </div>
                </div>
            </div>

            <div class="table-responsive">
                <div id="divAssociatesList" runat="server">
                    <!-- Table content -->
                </div>
            </div>

            <div class="row mt-3">
                <div class="col-md-6">
                    <asp:Label ID="lblTotalRecords" runat="server" CssClass="text-muted" />
                </div>
                <div class="col-md-6">
                    <asp:Panel ID="pnlPagination" runat="server" CssClass="pagination-container float-end">
                        <ul class="pagination mb-0">
                            <asp:PlaceHolder ID="phPagination" runat="server" />
                        </ul>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
