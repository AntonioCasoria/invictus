<%@ page import="DataAccessLayer.bean.Utente" %>
<%@ page import="DataAccessLayer.bean.Prenotazione" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DataAccessLayer.bean.PersonalTrainer" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
  PersonalTrainer pt = (PersonalTrainer) session.getAttribute("personalTrainer");

  ArrayList<String> prenotazioni = (ArrayList<String>) session.getAttribute("prenotazioni");
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Crea Esercizio</title>

  <!-- Custom fonts for this template-->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <!-- Custom styles for this template-->
  <link href="css/sb-admin-2.css" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

  <style>

    .box-immagine i {
      font-size: 4rem;
      color: #333;
    }


    .link-container label {
      margin: 0 10px 0 0;
      font-weight: bold;
    }
    .link-container input {
      background: transparent;
      border: none;
      flex: 1;
      outline: none;
    }

    /* I tuoi colori personalizzati */
    .btn-our {
      color: #fff;
      background-color: #1e73be;
      border-color: #1e73be;
    }
    .btn-our:hover {
      color: #fff;
      background-color: #0b3c6e;
      border-color: #0b3c6e;
    }

    /* Stile Wireframe */
    .image-upload-box {
      border: 2px solid #333;
      aspect-ratio: 1/1;
      display: flex;
      align-items: center;
      justify-content: center;
      background-color: #fff;
      border-radius: 10px;

      /* CAMBIO QUI: il cursore non cambia più in manina */
      cursor: default;

      /* Rimuoviamo anche eventuali effetti hover per coerenza */
      transition: none;
    }

    /* Assicuriamoci che anche l'immagine dentro non attivi la manina */
    .image-upload-box img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      border-radius: 8px;
      display: none;
      cursor: default;
    }

    .image-upload-box i { font-size: 3rem; color: #333; }

    .label-tag {
      color: #1e73be;
      font-weight: bold;
      display: inline-block;
      margin-bottom: 8px;
      font-size: 0.85rem;
    }

    .input-grey-user {
      background-color: #f8f9fc !important;
      border-radius: 12px !important;
      color: #333 !important;
    }

    .back-nav {
      font-size: 1.5rem;
      color: #b0b0b0;
      cursor: pointer;
      transition: 0.3s;
    }
    .back-nav:hover { color: #1e73be; }

    /* Opzionale: stile se l'immagine non viene caricata correttamente */
    .image-upload-box.error {
      border-color: #e74a3b;
    }
  </style>
</head>
<body id="page-top">

<!-- Page Wrapper -->
<div id="wrapper">

  <!-- Sidebar -->
  <ul class="navbar-nav bg-sidebar sidebar sidebar-dark accordion" id="accordionSidebar">

    <!-- Sidebar - Brand -->
    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="homePagePT.jsp">
      <div class="sidebar-brand-icon">
        <img src="img/logoInvictus.png" alt="logo" style="width: auto; height: 50px;">
      </div>
    </a>

    <!-- Divider -->
    <hr class="sidebar-divider my-0" style="background: #1e73be;">

    <!-- Nav Item - Allenamento Collapse Menu -->
    <li class="nav-item">
      <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo"
         aria-expanded="true" aria-controls="collapseTwo" style="color: #1e73be;">
        <i class="fa-solid fa-dumbbell" style="color: #1e73be;"></i>
        <span style="color: #1e73be;">Allenamento</span>
      </a>
      <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
        <div class="bg-gray-200 py-2 collapse-inner rounded">
          <a class="collapse-item" href="creaScheda.jsp">Crea Scheda</a>
          <a class="collapse-item" href="modificaScheda.jsp">Modifica Scheda</a>
          <a class="collapse-item" href="assegnaScheda.jsp">Assegna Scheda</a>
        </div>
      </div>
    </li>

    <!-- Divider -->
    <hr class="sidebar-divider my-0" style="background: #1e73be;">

    <!-- Nav Item - Esercizio -->
    <li class="nav-item">
      <a class="nav-link" href="esercizio.jsp">
        <i class="fa-solid fa-weight-hanging " style="color: #1e73be;"></i>
        <span style="color: #1e73be;">Esercizio</span></a>
    </li>

    <!-- Divider -->
    <hr class="sidebar-divider my-0" style="background: #1e73be;">

  </ul>
  <!-- End of Sidebar -->

  <!-- Content Wrapper -->
  <div id="content-wrapper" class="d-flex flex-column">

    <!-- Main Content -->
    <div id="content">

      <!-- Topbar -->
      <nav class="navbar navbar-expand navbar-light bg-our-blu topbar mb-4 static-top shadow">

        <!-- Sidebar Toggle (Topbar) -->
        <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
          <i class="fa fa-bars" ></i>
        </button>

        <!-- Topbar Navbar -->
        <ul class="navbar-nav ml-auto">

          <!-- Nav Item - Search Dropdown (Visible Only XS) -->
          <li class="nav-item dropdown no-arrow d-sm-none">
            <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button"
               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              <i class="fas fa-search fa-fw"></i>
            </a>
            <!-- Dropdown - Messages -->
            <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
                 aria-labelledby="searchDropdown">
              <form class="form-inline mr-auto w-100 navbar-search">
                <div class="input-group">
                  <input type="text" class="form-control bg-light border-0 small"
                         placeholder="Search for..." aria-label="Search"
                         aria-describedby="basic-addon2">
                  <div class="input-group-append">
                    <button class="btn btn-primary" type="button">
                      <i class="fas fa-search fa-sm"></i>
                    </button>
                  </div>
                </div>
              </form>
            </div>
          </li>

          <!-- Nav Item - Alerts -->
          <li class="nav-item dropdown no-arrow mx-1">
            <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button"
               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              <i class="fas fa-bell fa-fw" style="color: white"></i>
              <!-- Counter - Alerts -->
              <span class="badge badge-danger badge-counter"></span>
            </a>
            <!-- Dropdown - Alerts -->
            <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                 aria-labelledby="alertsDropdown">
              <h6 class="dropdown-header">
                Alerts Center
              </h6>
              <%
                //  if(!(prenotazioni.isEmpty())){
                //    for(String s : prenotazioni){
              %>
              <!--
              <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="mr-3">
                      <div class="icon-circle bg-success">
                          <i class="fa-solid fa-circle-check text-white"></i>
                      </div>
                  </div>
                  <div>
                     <div class="small text-gray-500">December 7, 2019</div>
                  </div>
              </a>
              -->
              <%
                // }
                //}
              %>
              <!--
              <a class="dropdown-item text-center small text-gray-500" href="#">Show All Alerts</a>
          -->
            </div>
          </li>

          <!-- Nav Item - Messages -->
          <li class="nav-item dropdown no-arrow mx-1">
            <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button"
               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              <i class="fas fa-envelope fa-fw" style="color: white"></i>
              <!-- Counter - Messages -->
              <span class="badge badge-danger badge-counter"></span>
            </a>
            <!-- Dropdown - Messages -->
            <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                 aria-labelledby="messagesDropdown">
              <h6 class="dropdown-header">
                Message Center
              </h6>
              <!--<a class="dropdown-item d-flex align-items-center" href="#"></a>-->
              <!--
              <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="dropdown-list-image mr-3">
                      <img class="rounded-circle" src="img/undraw_profile_2.svg"
                           alt="...">
                      <div class="status-indicator"></div>
                  </div>
                  <div>
                      <div class="text-truncate">I have the photos that you ordered last month, how
                          would you like them sent to you?
                      </div>
                      <div class="small text-gray-500">Jae Chun · 1d</div>
                  </div>
              </a>
              -->
            </div>
          </li>

          <div class="topbar-divider d-none d-sm-block"></div>

          <!-- Nav Item - User Information -->
          <li class="nav-item dropdown no-arrow">
            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              <span class="mr-2 d-none d-lg-inline text-white small"><%=pt.getNome() + " " + pt.getCognome()%></span>
              <i class="fa-solid fa-user" style="color: white" ></i>
              <i class="fa-regular fa-clipboard" style="color: white; font-size: 12px; margin-bottom: -5px"></i>
            </a>
            <!-- Dropdown - User Information -->
            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                 aria-labelledby="userDropdown">
              <a class="dropdown-item" href="login.jsp">
                <i class="fa-solid fa-circle-user fa-sm fa-fw mr-2 text-our-blu"></i>
                Area Personale
              </a>
              <div class="dropdown-divider"></div>
              <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-our-blu"></i>
                Logout
              </a>
            </div>
          </li>

        </ul>

      </nav>
      <!-- End of Topbar -->

      <!-- Begin Page Content -->
      <div class="container-fluid text-center">
        <div class="mb-4">
          <h1 class="h4 text-gray-900 font-weight-bold">Crea Esercizio</h1>
        </div>
        <div class="card shadow mb-4">
          <div class="card-body">
            <form class="user" action="SalvaEsercizioServlet" method="post">
              <div class="row px-5 pb-4">

                <div class="col-lg-5 pr-lg-5">
                  <span class="label-tag">Anteprima Immagine</span>
                  <div class="image-upload-box mb-3" id="previewBox">
                    <i class="far fa-image" id="placeholderIcon"></i>
                    <img id="urlPreview" src="" alt="Anteprima">
                  </div>

                  <div class="form-group">
                    <span class="label-tag">Link Immagine</span>
                    <input type="text" class="form-control form-control-user input-grey-user"
                           id="ContenutoMultimediale1" name="ContenutoMultimediale1"
                           placeholder="URL dell'immagine" required
                           oninput="updatePreview(this.value)">
                  </div>

                  <span class="label-tag">Risorsa Esterna</span>
                  <div class="form-group d-flex align-items-center bg-gray-100 p-2" style="border-radius: 12px;">
                    <label class="mb-0 ml-2 font-weight-bold mr-2 text-dark">Link:</label>
                    <input type="text" class="form-control border-0 bg-transparent" name="ContenutoMultimediale2" id="ContenutoMultimediale2" placeholder="URL video o altro" required>
                  </div>
                </div>

                <div class="col-lg-7">
                  <div class="form-group">
                    <span class="label-tag">Nome Esercizio</span>
                    <input type="text" class="form-control bg-gray-100 form-control-user"
                           style="border-radius: 12px !important; color: black"
                           name="Nome" id="Nome" required>
                  </div>

                  <div class="form-group">
                    <span class="label-tag">Gruppo Muscolare</span>
                    <input type="text" class="form-control form-control-user input-grey-user" name="GruppoMuscolare" id="GruppoMuscolare" required>
                  </div>

                  <div class="form-group row">
                    <div class="col-sm-4 mb-3 mb-sm-0">
                      <span class="label-tag">Serie</span>
                      <input type="number" class="form-control form-control-user input-grey-user" name="Serie" id="Serie" min="1" required>
                    </div>
                    <div class="col-sm-4">
                      <span class="label-tag">Ripetizioni</span>
                      <input type="text" class="form-control form-control-user input-grey-user" name="Ripetizioni" id="Ripetizioni" required>
                    </div>
                    <div class="col-sm-4">
                      <span class="label-tag">Recupero (Secondi)</span>
                      <input type="text" class="form-control form-control-user input-grey-user" name="TempoRecupero" id="TempoRecupero" required>
                    </div>
                  </div>

                  <div class="form-group">
                    <span class="label-tag">Descrizione</span>
                    <textarea class="form-control form-control-user input-grey-user" name="Descrizione" id="Descrizione" rows="12" required></textarea>
                  </div>
                </div>
              </div>

              <hr class="sidebar-divider my-0" style="background: #1e73be;">

              <div class="row">
                <div class="col-md-4 offset-md-4">
                  <button type="submit" class="btn btn-our btn-block shadow font-weight-bold mt-4" style="padding: 0.75rem 1rem;">Salva</button>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
      <!-- End of Main Content -->
    </div>
    <!-- End of Content Wrapper -->

    <div class="sticky-footer bg-white">
      <div class="container my-auto">
        <div class="copyright text-center my-auto p-sm-4">
          <span>Copyright &copy; Invictus 2026</span>
        </div>
      </div>
    </div>
  </div>
  <!-- End of Page Wrapper -->

  <!-- Scroll to Top Button-->
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

  <!-- Logout Modal-->
  <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
       aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Sei sicuro?</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">Cliccando "Logout" verrai disconnesso.</div>
        <div class="modal-footer">
          <button class="btn btn-secondary" type="button" data-dismiss="modal">Annulla</button>
          <a class="btn btn-danger" href="logout">Logout</a>
        </div>
      </div>
    </div>
  </div>


  <!-- jQuery (OBBLIGATORIO) -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  <!-- Bootstrap Bundle (include Popper.js) -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

  <!-- jQuery Easing (necessario per easeInOutExpo) -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="js/sidebar.js"></script>


  <script>
    let slideIndex = 0;
    let slides = document.getElementsByClassName("mySlides");
    let slideInterval;

    function showSlides(index) {
      if (!slides.length) return;

      for (let i = 0; i < slides.length; i++) {
        slides[i].style.display = "none";
      }

      if (index >= slides.length) slideIndex = 0;
      else if (index < 0) slideIndex = slides.length - 1;
      else slideIndex = index;

      slides[slideIndex].style.display = "block";
    }

    function nextSlide() {
      showSlides(slideIndex + 1);
      resetInterval();
    }

    function prevSlide() {
      showSlides(slideIndex - 1);
      resetInterval();
    }

    function resetInterval() {
      clearInterval(slideInterval);
      slideInterval = setInterval(() => showSlides(slideIndex + 1), 5000);
    }

    window.onload = function () {
      showSlides(slideIndex);
      slideInterval = setInterval(() => showSlides(slideIndex + 1), 5000);
    }

    function updatePreview(url) {
      const previewImg = document.getElementById('urlPreview');
      const icon = document.getElementById('placeholderIcon');
      const previewBox = document.getElementById('previewBox');

      if (url && url.trim() !== "") {
        previewImg.src = url;

        // Quando l'immagine viene caricata con successo
        previewImg.onload = function() {
          previewImg.style.display = 'block';
          icon.style.display = 'none';
          previewBox.classList.remove('error');
        };

        // Se il link non è un'immagine valida o è rotto
        previewImg.onerror = function() {
          previewImg.style.display = 'none';
          icon.style.display = 'block';
          previewBox.classList.add('error');
        };
      } else {
        // Campo vuoto: ripristina lo stato iniziale
        previewImg.style.display = 'none';
        icon.style.display = 'block';
        previewBox.classList.remove('error');
      }
    }
  </script>
</div>
</body>
</html>