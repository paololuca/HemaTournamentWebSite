<%@ Page Title="Archive" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Archive.aspx.cs" Inherits="WebApplication2.Documents" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="col-12">
        <div class="card">
            <h5 class="card-header">Document's Archive</h5>

        </div>
    </div>
    <div class="nav-align-top nav-tabs-shadow mb-6">
        <ul class="nav nav-tabs nav-fill" role="tablist">
            <li class="nav-item" role="presentation">
                <button type="button" class="nav-link active" role="tab" data-bs-toggle="tab" data-bs-target="#navs-justified-tech" aria-controls="navs-justified-tech" aria-selected="true">
                    <span class="d-none d-sm-block"><i class="tf-icons bx bxs-file-pdf bx-sm me-1_5 align-text-bottom"></i>Tech Doc 
                  <span class="badge rounded-pill badge-center h-px-20 w-px-20 bg-label-danger ms-1_5 pt-50">1</span>
                    </span>
                    <i class="bx bxs-file-pdf bx-sm d-sm-none"></i>

                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button type="button" class="nav-link" role="tab" data-bs-toggle="tab" data-bs-target="#navs-justified-profile" aria-controls="navs-justified-profile" aria-selected="false" tabindex="-1">
                    <span class="d-none d-sm-block"><i class="tf-icons bx bx-sort bx-sm me-1_5 align-text-bottom"></i>Ranking
                  <span class="badge rounded-pill badge-center h-px-20 w-px-20 bg-label-danger ms-1_5 pt-50">1</span>
                    </span>
                    <i class="bx bx-sort bx-sm d-sm-none"></i>

                </button>
            </li>
        </ul>
        <div class="tab-content">
            <div class="tab-pane fade active show" id="navs-justified-tech" role="tabpanel">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table ">
                            <thead>
                                <tr>
                                    <th class="border-top-0">Name</th>
                                    <th class="border-top-0">Version</th>
                                    <th class="border-top-0">Date</th>
                                    <th class="border-top-0">Download</th>
                                </tr>
                            </thead>
                            <tbody>

                                <tr>
                                    <td><i class="icon-base fab fa-vuejs icon-md text-success me-4"></i>Regulation 2025</td>
                                    <td><i class="icon-base fab fa-vuejs icon-md text-success me-4"></i>2.03</td>
                                    <td><i class="icon-base fab fa-vuejs icon-md text-success me-4"></i>22/01/2025</td>
                                    <td>
                                        <a class="jstree-anchor" href="Documents/Regolamento Campionato Scherma Storica ASC_2.03.pdf" tabindex="-1" target="_blank" role="treeitem" aria-selected="false" aria-level="1" id="j1_13_anchor">
                                            <i class="jstree-icon jstree-themeicon icon-base bx  bxs-file-pdf jstree-themeicon-custom" role="presentation"></i>Regolamento 2025.pdf</a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="tab-pane fade" id="navs-justified-profile" role="tabpanel">
                <div class="card-body">
    <div class="table-responsive">
        <table class="table ">
            <thead>
                <tr>
                    <th class="border-top-0">Name</th>
                    <th class="border-top-0">Date</th>
                    <th class="border-top-0">Download</th>
                </tr>
            </thead>
            <tbody>

                <tr>
                    <td><i class="icon-base fab fa-vuejs icon-md text-success me-4"></i>Ranking after Imola 2025</td>
                    <td><i class="icon-base fab fa-vuejs icon-md text-success me-4"></i>04/02/2025</td>
                    <td>
                        <a class="jstree-anchor" href="Documents/Ranking/Ranking 20251601.pdf" tabindex="-1" target="_blank" role="treeitem" aria-selected="false" aria-level="1" id="r1">
                            <i class="jstree-icon jstree-themeicon icon-base bx  bxs-file-pdf jstree-themeicon-custom" role="presentation"></i>Ranking 2025 16 01 2025.pdf</a>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</div>
            </div>
        </div>
    </div>
</asp:Content>
