<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="HemaTournamentWebSite.About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="Default.aspx">Home</a></li>
            <li class="breadcrumb-item active">About</li>
        </ol>
    </nav>

    <section class="py-5">
	<div class="container">
		<div class="row gx-4 align-items-center justify-content-between">
			<div class="col-md-5 order-2 order-md-1">
				<div class="mt-5 mt-md-0">
					<h2 class="display-5 fw-bold">About Us</h2>
					<p class="lead">For years, we have proudly represented one of the Italian HEMA community, offering a platform where athletes and enthusiasts can come together to celebrate this unique and captivating discipline.</p>
					<p class="lead">Each year, <strong>hundreds of athletes</strong> and <strong>dozens of sports associations</strong> participate, making our circuit a cornerstone of the Italian HEMA community. We bring together competitors from diverse backgrounds who share the same passion: the art of historical fencing in a modern, athletic framework.
  </p></p>
				</div>
			</div>
			<div class="col-md-6 offset-md-1 order-1 order-md-2">
				<div class="row gx-2 gx-lg-3">
					<div class="col-6">
						<div class="mb-2"><img class="img-fluid rounded-3" id="img1" runat="server" src="#"/></div>
					</div>
					<div class="col-6">
						<div class="mb-2"><img class="img-fluid rounded-3" id="img2" runat="server" src="#"/></div>
					</div>
					<div class="col-6">
						<div class="mb-2"><img class="img-fluid rounded-3" id="img3" runat="server" src="#"/></div>
					</div>
					<div class="col-6">
						<div class="mb-2"><img class="img-fluid rounded-3" id="img4" runat="server" src="#"/></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
   
</asp:Content>
