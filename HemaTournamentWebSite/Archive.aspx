<%@ Page Title="Archive" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Archive.aspx.cs" Inherits="WebApplication2.Documents" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="col-12">
      <div class="card">
        <h5 class="card-header">Document's Archive</h5>
        <div class="card-body">
          <div class="table-responsive">
            <table class="table ">
              <thead>
                <tr>
                  <th class="border-top-0">Name</th>
                  <th class="border-top-0">Download</th>
                </tr>
              </thead>
              <tbody>
                
                <tr>
                  <td><i class="icon-base fab fa-vuejs icon-md text-success me-4"></i>Regolamento 2025</td>
                  <td>
                      <a class="jstree-anchor" href="Documents/Regolamento 2025.pdf" tabindex="-1" role="treeitem" aria-selected="false" aria-level="1" id="j1_13_anchor">
                          <i class="jstree-icon jstree-themeicon icon-base bx  bxs-file-pdf jstree-themeicon-custom" role="presentation"></i>Regolamento 2025.pdf</a>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
</asp:Content>
