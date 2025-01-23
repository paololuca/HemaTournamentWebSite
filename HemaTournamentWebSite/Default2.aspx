<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default2.aspx.cs" Inherits="HemaTournamentWebSite._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <%--<h1>
            <asp:Image ID="Image1" runat="server"  ImageUrl="~/assets/img/swords.png" width="5%"/>
            HEMA Chronicles</h1>--%>
        <div id="carouselExample" class="carousel slide pointer-event" data-bs-ride="carousel">
      <div class="carousel-indicators">
        <button type="button" data-bs-target="#carouselExample" data-bs-slide-to="0" aria-label="Slide 1" class="active" ></button>
        <button type="button" data-bs-target="#carouselExample" data-bs-slide-to="1" aria-label="Slide 2" class=""></button>
        <button type="button" data-bs-target="#carouselExample" data-bs-slide-to="2" aria-label="Slide 3" class=""></button>
        <button type="button" data-bs-target="#carouselExample" data-bs-slide-to="3" aria-label="Slide 4" class=""></button>
        <button type="button" data-bs-target="#carouselExample" data-bs-slide-to="4" aria-label="Slide 5" class=""></button>
      </div>
      <div class="carousel-inner">
        <div class="carousel-item active">
          <img class="d-block w-100" src="assets/img/elements/Banner/banner.png" alt="First slide">
          <%--<div class="carousel-caption d-none d-md-block">
            <h3>First slide</h3>
            <p>Eos mutat malis maluisset et, agam ancillae quo te, in vim congue pertinacia.</p>
          </div>--%>
        </div>
        <div class="carousel-item">
          <img class="d-block w-100" src="assets/img/elements/Banner/banner2.png" alt="Second slide">
          <%--<div class="carousel-caption d-none d-md-block">
            <h3>Second slide</h3>
            <p>In numquam omittam sea.</p>
          </div>--%>
        </div>
        <div class="carousel-item">
          <img class="d-block w-100" src="assets/img/elements/Banner/banner3.png" alt="Third slide">
         <%-- <div class="carousel-caption d-none d-md-block">
            <h3>Third slide</h3>
            <p>Lorem ipsum dolor sit amet, virtute consequat ea qui, minim graeco mel no.</p>
          </div>--%>
        </div>
        <div class="carousel-item">
                <img class="d-block w-100" src="assets/img/elements/Banner/banner4.png" alt="Fourth slide">
            </div>
        <div class="carousel-item">
        <img class="d-block w-100" src="assets/img/elements/Banner/banner5.png" alt="Fifth slide">
    </div>
</div>
      <a class="carousel-control-prev" href="#carouselExample" role="button" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
      </a>
      <a class="carousel-control-next" href="#carouselExample" role="button" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
      </a>
    </div>
        <br />
        <br />
        <p>

    Welcome to the world of <strong>HEMA</strong> (Historical European Martial Arts) Chronicles, where history meets sport, and passion meets competition.
  </p>
  <p>
    Our organization is the driving force behind one of the most prestigious <strong>competitive circuits</strong> in Italy, designed to challenge and inspire. 
    </p>
        <p>
      The tournamentìs system includes:
  </p>
  <ul>
    <li><strong>Qualification Rounds</strong>, hosted across the country, where athletes demonstrate their skills to secure a spot in the finals.</li>
    <li><strong>The National Championships</strong>, where the best of the best face off in a battle of precision, strategy, and historical technique.</li>
  </ul>
  <p>
    Our mission is to provide an environment where sportsmanship, skill development, and historical authenticity thrive. We are committed to growing the sport, connecting practitioners across Italy, and showcasing the brilliance of HEMA as both an art and a sport.
  </p>
  <p>
    Whether you’re an experienced athlete, a curious beginner, or simply a fan of history and competition, we welcome you to join us in preserving the legacy of historical European martial arts while pushing the boundaries of modern sport.
  </p>
        <p>
            Come and earn your rewards and achievmente in out world !!
        </p>
        <p></p>
    </div>


</asp:Content>
