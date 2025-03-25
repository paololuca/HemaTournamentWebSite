<%@ Page Title="Archive" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Archive.aspx.cs" Inherits="WebApplication2.Documents" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="Default.aspx">Home</a></li>
            <li class="breadcrumb-item active">Archive</li>
        </ol>
    </nav>    

<div class="col-12">

        <h5 class="card-header">Document's Archive</h5>

<br />  
    </div>
    <div class="nav-align-top mb-6">
        <ul class="nav nav-pills mb-4 nav-fill" role="tablist">
            <li class="nav-item mb-1 mb-sm-0" role="presentation">
                <button type="button" class="nav-link active" role="tab" data-bs-toggle="tab" data-bs-target="#navs-pills-justified-home"
                    aria-controls="navs-pills-justified-home" aria-selected="true">
                    <span class="d-none d-sm-block">
                        <i class="tf-icons bx  bxs-file-pdf bx-sm me-1_5 align-text-bottom"></i>Tech Doc <span class="badge rounded-pill badge-center h-px-20 w-px-20 bg-danger ms-1_5 pt-50">1</span></span><i class="bx  bxs-file-pdf bx-sm d-sm-none"></i></button>
            </li>
            <li class="nav-item mb-1 mb-sm-0" role="presentation">
                <button type="button" class="nav-link" role="tab" data-bs-toggle="tab" data-bs-target="#navs-pills-justified-profile"
                    aria-controls="navs-pills-justified-profile" aria-selected="false" tabindex="-1">
                    <span class="d-none d-sm-block">
                        <i class="tf-icons bx bx-sort bx-s me-1_5 align-text-bottom"></i>Ranking <span class="badge rounded-pill badge-center h-px-20 w-px-20 bg-danger ms-1_5 pt-50">2</span></span><i class="bx bx-sort bx-s d-sm-none"></i></button>
            </li>

        </ul>
        <div class="tab-content">
            <div class="tab-pane fade show active" id="navs-pills-justified-home" role="tabpanel">
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
            <div class="tab-pane fade" id="navs-pills-justified-profile" role="tabpanel">
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
                            <tr>
                                <td><i class="icon-base fab fa-vuejs icon-md text-success me-4"></i>Qualification Ranking 2025</td>
                                <td><i class="icon-base fab fa-vuejs icon-md text-success me-4"></i>07/03/2025</td>
                                <td>
                                    <a class="jstree-anchor" href="Documents/Ranking/Ranking - Qualificati 2024 2025.pdf" tabindex="-1" target="_blank" role="treeitem" aria-selected="false" aria-level="1" id="r1">
                                        <i class="jstree-icon jstree-themeicon icon-base bx  bxs-file-pdf jstree-themeicon-custom" role="presentation"></i>Qualification Ranking 2025.pdf</a>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </div>

</asp:Content>
