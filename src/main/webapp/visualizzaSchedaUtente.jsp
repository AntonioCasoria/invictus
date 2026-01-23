<%@ page import="DataAccessLayer.bean.Utente" %>
<%@ page import="DataAccessLayer.bean.Prenotazione" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
  Utente utente = (Utente) session.getAttribute("utente");

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

  <title>Visualizza Scheda Allenamento</title>

  <!-- Custom fonts for this template-->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <!-- Custom styles for this template-->
  <link href="css/sb-admin-2.css" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

  <style>
    /* --- 1. CONTENITORE PRINCIPALE E SELEZIONE SCHEDE --- */
    .view-scheda-container {
      border: 2px solid #333;
      border-radius: 25px;
      background: white;
      padding: 30px;
      margin-bottom: 25px;
    }

    /* Scrollbar Orizzontale Superiore */
    .container-schede-orizzontale {
      display: flex;
      flex-wrap: nowrap;
      overflow-x: auto;
      padding: 15px 5px;
      background-color: #f8f9fc;
      border: 1px solid #e3e6f0;
      border-radius: 15px;
      -webkit-overflow-scrolling: touch;
    }

    .scheda-item-wrapper {
      flex: 0 0 auto;
      width: 220px;
      margin-right: 15px;
    }

    .scheda-card {
      border: 2px solid #e3e6f0;
      border-radius: 15px;
      padding: 15px;
      cursor: pointer;
      transition: all 0.2s ease-in-out;
      background: white;
      text-align: center;
    }

    .scheda-card:hover {
      border-color: #1e73be;
      transform: translateY(-3px);
    }

    .scheda-card.selected {
      border-color: #1e73be !important;
      background-color: #eef5ff;
      color: #1e73be;
    }

    /* --- 2. LAYOUT SCHEDA (DAL MOCKUP) --- */

    /* Navigazione Giorni (Tab orizzontali) */
    .giorno-nav-container {
      display: flex;
      border: 1px solid #d1d3e2;
      border-radius: 8px;
      overflow: hidden;
      margin-bottom: 25px;
    }

    .giorno-tab {
      flex: 1;
      text-align: center;
      padding: 12px 10px;
      background-color: #f8f9fc;
      border-right: 1px solid #d1d3e2;
      cursor: pointer;
      font-weight: bold;
      color: #5a5c69;
      transition: all 0.2s;
    }

    .giorno-tab:last-child {
      border-right: none;
    }

    .giorno-tab.active {
      background-color: #1e73be; /* Grigio come nel mockup */
      color: #ffffff;
    }

    /* Righe Esercizi */
    .esercizio-row {
      display: flex;
      align-items: center;
      border: 1px solid #d1d3e2;
      border-radius: 8px;
      margin-bottom: 12px;
      padding: 15px;
      background-color: #fff;
      transition: background-color 0.2s;
    }

    /* Sezioni della riga esercizio */
    .ex-part {
      flex: 1;
      text-align: center;
      border-right: 1px solid #e3e6f0;
      padding: 0 10px;
      display: flex;
      align-items: center;
      justify-content: center;
      min-height: 50px;
    }

    .ex-part:last-child {
      border-right: none;
    }

    /* Icona Esercizio */
    .ex-icon {
      max-width: 80px;
      flex: 0 0 80px;
    }

    .ex-icon i, .ex-icon img {
      font-size: 2rem;
      color: #858796;
    }

    /* Testo e Valori */
    .ex-name {
      font-weight: bold;
      color: #333;
    }

    .ex-value {
      color: #5a5c69;
    }

    /* --- 3. PERSONALIZZAZIONE SCROLLBAR --- */
    .container-schede-orizzontale::-webkit-scrollbar {
      height: 8px;
    }
    .container-schede-orizzontale::-webkit-scrollbar-thumb {
      background-color: #d1d3e2;
      border-radius: 10px;
    }
    .container-schede-orizzontale::-webkit-scrollbar-track {
      background: #f1f1f1;
      border-radius: 10px;
    }

    /* Utility per l'animazione di comparsa */
    #areaDettagliScheda {
      animation: fadeIn 0.4s ease-in-out;
    }

    .btn-icon-split .icon {
      background: rgba(0, 0, 0, 0.05);
      display: inline-block;
      padding: .375rem .75rem;
    }
    .btn-icon-split .text {
      display: inline-block;
      padding: .375rem .75rem;
    }

    /* Nuova colonna performance */
    .ex-performance {
      flex: 0 0 180px;
      color: #00796b;
      cursor: pointer;
      transition: color 0.2s;
    }
    .ex-performance:hover {
      color: #00b8a9;
    }

    /* Impediamo che il click sulla colonna attivi il click della riga intera (video) */
    .ex-performance-btn {
      display: flex;
      align-items: center;
      justify-content: center;
      width: 100%;
      height: 100%;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(10px); }
      to { opacity: 1; transform: translateY(0); }
    }
  </style>

</head>
<body id="page-top">

<!-- Page Wrapper -->
<div id="wrapper">

  <!-- Sidebar -->
  <ul class="navbar-nav bg-sidebar sidebar sidebar-dark accordion" id="accordionSidebar">

    <!-- Sidebar - Brand -->
    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="homePageUser.jsp">
      <div class="sidebar-brand-icon">
        <img src="img/logoInvictus.png" alt="logo" style="width: auto; height: 50px;">
      </div>
    </a>

    <!-- Divider -->
    <hr class="sidebar-divider my-0" style="background: #1e73be;">

    <!-- Nav Item - Prenotazione -->
    <li class="nav-item">
      <a class="nav-link" href="prenotazione.jsp">
        <i class="fa-solid fa-calendar" style="color: #1e73be;"></i>
        <span style="color: #1e73be;">Prenotazione</span></a>
    </li>

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
          <a class="collapse-item" href="schedaAllenamento.jsp">Scheda di Allenamento</a>
          <a class="collapse-item" href="performance.jsp">Visualizza Performance</a>
        </div>
      </div>
    </li>

    <!-- Divider -->
    <hr class="sidebar-divider my-0" style="background: #1e73be;">

    <!-- Nav Item - Performance -->
    <li class="nav-item">
      <a class="nav-link" href="progressi.jsp">
        <i class="fas fa-fw fa-chart-area" style="color: #1e73be;"></i>
        <span style="color: #1e73be;">Progressi</span></a>
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
              <%
                if(!prenotazioni.isEmpty()) {
              %>
              <span class="badge badge-danger badge-counter"><%=prenotazioni.size()%><i class="fa-solid fa-circle-plus"></i></span>
              <%
              } else if(prenotazioni.isEmpty()) {
              %>
              <span class="badge badge-danger badge-counter"></span>
              <%
                }
              %>
            </a>
            <!-- Dropdown - Alerts -->
            <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                 aria-labelledby="alertsDropdown">
              <h6 class="dropdown-header">
                Alerts Center
              </h6>
              <%
                if(!(prenotazioni.isEmpty())){
                  for(String s : prenotazioni){
              %>
              <a class="dropdown-item d-flex align-items-center" href="#">
                <div class="mr-3">
                  <div class="icon-circle bg-success">
                    <i class="fa-solid fa-circle-check text-white"></i>
                  </div>
                </div>
                <div>
                  <!--<div class="small text-gray-500">December 7, 2019</div>-->
                  <%=s%>
                </div>
              </a><%
                }
              }
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
              <a class="dropdown-item d-flex align-items-center" href="#"></a>
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
              <span class="mr-2 d-none d-lg-inline text-white small"><%=utente.getNome() + " " + utente.getCognome()%></span>
              <i class="fa-solid fa-user" style="color: white" ></i>
            </a>
            <!-- Dropdown - User Information -->
            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                 aria-labelledby="userDropdown">
              <a class="dropdown-item" href="areaPersonaleUser.jsp">
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
      <div class="container-fluid">
        <div class="mb-4">
          <h1 class="h4 text-gray-900 font-weight-bold text-center">Le mie schede allenamento</h1>
        </div>

        <div class="view-scheda-container shadow mb-4">
          <div class="row mb-3">
            <div class="col-lg-10 text-left">
              <a href="schedaAllenamento.jsp" class="btn btn-light btn-icon-split shadow-sm border">
                <span class="icon text-gray-600">
                    <i class="fas fa-arrow-left"></i>
                </span>
                <span class="text font-weight-bold text-dark"></span>
              </a>
            </div>
          </div>
          <h6 class="font-weight-bold text-primary mb-3 text-center">Le tue schede</h6>
          <div class="container-schede-orizzontale">
            <div class="d-flex flex-row flex-nowrap" id="listaSchedeContainer">
              <div class="p-3 text-muted">Caricamento schede...</div>
            </div>
          </div>
        </div>

        <div id="areaDettagliScheda" class="card shadow mb-4" style="display: none;">
          <div class="card-header py-3">
            <h6 id="titoloSchedaSelezionata" class="m-0 font-weight-bold text-primary">La tua scheda</h6>
          </div>
          <div class="card-body">
            <div class="row no-gutters mb-4 border rounded shadow-sm overflow-hidden" id="navigazioneGiorni">
            </div>

            <div id="containerEsercizi">
              <div class="text-center p-5 text-muted">Seleziona un giorno per vedere gli esercizi</div>
            </div>
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

  <!-- Modal Video -->
  <div class="modal fade" id="videoModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
      <div class="modal-content border-left-primary shadow">
        <div class="modal-header">
          <h5 class="modal-title font-weight-bold text-primary" id="videoModalTitle">Video Esercizio</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body text-center">
          <div class="embed-responsive embed-responsive-16by9 mb-3" id="videoContainer">
          </div>
          <hr>
          <p id="videoDescrizione" class="text-dark font-italic"></p>
        </div>
      </div>
    </div>
  </div>

  <!--Modal di aggiungi performance -->

  <div class="modal fade" id="performanceModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
      <div class="modal-content border-left-success shadow">
        <div class="modal-header">
          <h5 class="modal-title font-weight-bold text-success">
            <i class="fas fa-chart-line mr-2"></i> Aggiungi Performance: <span id="perfNomeEsercizio"></span>
          </h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <form id="formPerformance" action="SalvaPerformanceServlet" method="POST">
          <div class="modal-body">
            <input type="hidden" name="idEsercizio" id="perfIdEsercizio">
            <input type="hidden" name="idScheda" id="perfIdScheda">
            <input type="hidden" name="giorno" id="perfGiorno">


            <div class="row">
              <div class="col-md-6 mb-3">
                <label class="font-weight-bold text-dark">Data Allenamento</label>
                <input type="text" name="data" id="perfDataOggi" class="form-control bg-white" readonly>
              </div>
              <div class="col-md-6 mb-3">
                <label class="font-weight-bold text-dark">RPE (1-10)</label>
                <input type="number" name="rpe" class="form-control" min="1" max="10" placeholder="Sforzo">
              </div>
            </div>

            <div class="row">
              <div class="col-md-4 mb-3">
                <label class="font-weight-bold text-dark">Carico (kg)</label>
                <input type="number" name="carico" class="form-control" step="0.5" required>
              </div>
              <div class="col-md-4 mb-3">
                <label class="font-weight-bold text-dark">Serie</label>
                <input type="number" name="serie" class="form-control" required>
              </div>
              <div class="col-md-4 mb-3">
                <label class="font-weight-bold text-dark">Ripetizioni</label>
                <input type="text" name="ripetizioni" class="form-control" required>
              </div>
            </div>

            <div class="mb-3">
              <label class="font-weight-bold text-dark">Tempo Recupero (sec)</label>
              <input type="number" name="recupero" class="form-control">
            </div>

            <div class="mb-3">
              <label class="font-weight-bold text-dark">Feedback sull'esecuzione</label>
              <textarea name="feedback" class="form-control" rows="3" placeholder="Com'è andata?"></textarea>
            </div>
          </div>
          <div class="modal-footer">
            <button class="btn btn-secondary" type="button" data-dismiss="modal">Annulla</button>
            <button class="btn btn-success" type="submit">Salva Performance</button>
          </div>
        </form>
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
    // Variabili globali per salvare lo stato corrente
    let schedaCorrente = null;
    let idSchedaAttiva = null;
    let giornoSelezionato = null;
    let eserciziPerGiorno = {};

    $(document).ready(function() {
      caricaSchede();

      /**
       * Intercetta la chiusura della modale video per fermare l'audio
       */
      $('#videoModal').on('hidden.bs.modal', function () {
        $('#videoContainer').empty();
        $('#videoModalTitle').text('Video Esercizio');
        $('#videoDescrizione').empty();
      });
    });

    /**
     * Carica lo scrollbar orizzontale delle schede e gestisce l'auto-click dall'URL
     */
    function caricaSchede() {
      const urlParams = new URLSearchParams(window.location.search);
      const idSchedaDaAprire = urlParams.get('idScheda');

      $.ajax({
        url: 'GetSchedeUtenteServlet',
        type: 'POST',
        dataType: 'json',
        success: function(data) {
          const container = $('#listaSchedeContainer');
          container.empty();

          if (data.length === 0) {
            container.append('<div class="text-center ml-4">Non hai ancora nessuna scheda.</div>');
          }

          data.forEach(function(scheda) {
            const cardHtml = `
                    <div class="scheda-item-wrapper" id="card-scheda-` + scheda.idScheda + `">
                        <div class="scheda-card shadow-sm" onclick="selezionaScheda(this, '` + scheda.idScheda + `')">
                            <i class="fas fa-clipboard-list fa-2x mb-2 text-primary"></i>
                            <span class="d-block font-weight-bold">` + scheda.nome + `</span>
                            <small class="text-muted">` + scheda.obiettivo + `</small>
                        </div>
                    </div>
                `;
            container.append(cardHtml);
          });

          // 1. Se l'ID scheda è nell'URL, simuliamo il click sulla card
          if (idSchedaDaAprire && idSchedaDaAprire !== "undefined") {
            const targetCard = $('#card-scheda-' + idSchedaDaAprire + ' .scheda-card');
            if (targetCard.length > 0) {
              targetCard.click();
              targetCard[0].scrollIntoView({ behavior: 'smooth', block: 'nearest', inline: 'center' });
            }
          }
        }
      });
    }

    /**
     * Seleziona una scheda, carica gli esercizi e gestisce l'auto-click del giorno
     */
    function selezionaScheda(elemento, idScheda) {
      idSchedaAttiva = idScheda;
      $('.scheda-card').removeClass('selected');
      $(elemento).addClass('selected');

      $('#containerEsercizi').html('<div class="text-center p-5"><i class="fas fa-spinner fa-spin fa-2x"></i></div>');

      $.ajax({
        url: 'VisualizzaSchedaUtenteServlet?idScheda=' + idScheda,
        type: 'POST',
        dataType: 'json',
        success: function(data) {
          eserciziPerGiorno = {};
          if (data.esercizi && data.esercizi.length > 0) {
            $('#titoloSchedaSelezionata').text(data.esercizi[0].nomeScheda);

            data.esercizi.forEach(function(ex) {
              const g = ex.giorno;
              if (!eserciziPerGiorno[g]) {
                eserciziPerGiorno[g] = [];
              }
              eserciziPerGiorno[g].push(ex);
            });

            $('#areaDettagliScheda').fadeIn(300);
            costruisciNavigazioneGiorni(eserciziPerGiorno);

            // 2. LOGICA AGGIUNTA: Se il giorno è nell'URL, simuliamo il click sul tab del giorno
            const urlParams = new URLSearchParams(window.location.search);
            const giornoDaAprire = urlParams.get('giorno');

            if (giornoDaAprire) {
              const targetTab = $('.giorno-tab').filter(function() {
                return $(this).text().trim() === 'Giorno ' + giornoDaAprire;
              });

              if (targetTab.length > 0) {
                targetTab.click();
              }

              // Puliamo l'URL per evitare che al refresh manuale riparta l'automazione
              window.history.replaceState({}, document.title, window.location.pathname);
            }
          } else {
            $('#areaDettagliScheda').fadeOut();
          }
        }
      });
    }

    function costruisciNavigazioneGiorni(giorni) {
      const nav = $('#navigazioneGiorni');
      nav.empty();
      const chiaviGiorni = Object.keys(giorni).sort((a, b) => a - b);

      chiaviGiorni.forEach(function(giornoKey, index) {
        const activeClass = (index === 0) ? 'active' : '';
        const tabHtml = `
                <div class="giorno-tab ` + activeClass + `" onclick="mostraGiorno('` + giornoKey + `', this)">
                    Giorno ` + giornoKey + `
                </div>
            `;
        nav.append(tabHtml);
      });

      if (chiaviGiorni.length > 0) {
        mostraGiorno(chiaviGiorni[0], $('.giorno-tab').first());
      }
    }

    function mostraGiorno(giornoKey, elemento) {
      giornoSelezionato = giornoKey;
      $('.giorno-tab').removeClass('active');
      $(elemento).addClass('active');
      const container = $('#containerEsercizi');
      container.empty();
      const eserciziDelGiorno = eserciziPerGiorno[giornoKey];

      eserciziDelGiorno.forEach(function(ex) {
        const imgPath = ex.immagine ? ex.immagine : 'img/default-ex.png';
        const rigaHtml = `
            <div class="esercizio-row shadow-sm animated--fade-in"
                 onclick="apriModalVideo('` + ex.video + `', '` + ex.nomeEsercizio.replace(/'/g, "\\'") + `', '` + ex.descrizione.replace(/'/g, "\\'") + `')">
                <div class="ex-part ex-icon">
                    <img src="` + imgPath + `" class="img-fluid rounded" style="max-height: 50px;">
                </div>
                <div class="ex-part ex-name text-left">
                    <span class="text-dark font-weight-bold">` + ex.nomeEsercizio + `</span>
                </div>
                <div class="ex-part ex-name text-left">
                    <span class="text-muted">` + ex.gruppo + `</span>
                </div>
                <div class="ex-part ex-value font-weight-bold">
                    ` + ex.serie + ` x ` + ex.ripetizioni + `
                </div>
                <div class="ex-part ex-value text-muted">
                    <i class="fas fa-stopwatch mr-1 text-our-blu"></i> ` + ex.tempoRecupero + `"
                </div>
                <div class="ex-part ex-performance" onclick="apriModalPerformance(event, '` + ex.idEsercizio + `', '` + ex.nomeEsercizio.replace(/'/g, "\\'") + `', '` + idSchedaAttiva + `', '` + giornoSelezionato + `')">
                    <div class="ex-performance-btn">
                         Aggiungi Performance <i class="fas fa-plus-circle mr-1"></i>
                    </div>
                </div>
            </div>
        `;
        container.append(rigaHtml);
      });
    }

    function apriModalPerformance(event, idEx, nomeEx, idSch, gio) {
      event.stopPropagation();
      $('#perfIdEsercizio').val(idEx);
      $('#perfIdScheda').val(idSch);
      $('#perfGiorno').val(gio);
      $('#perfNomeEsercizio').text(nomeEx);

      $('#formPerformance')[0].reset();

      const oggi = new Date();
      const giorno = String(oggi.getDate()).padStart(2, '0');
      const mese = String(oggi.getMonth() + 1).padStart(2, '0');
      const anno = oggi.getFullYear();
      const dataFormattata = anno + `-` + mese + `-` + giorno;
      $('#perfDataOggi').val(dataFormattata);

      $('#performanceModal').modal('show');
    }

    function apriModalVideo(urlVideo, nome, descrizione) {
      $('#videoModalTitle').text(nome);
      $('#videoDescrizione').text(descrizione || 'Nessuna descrizione disponibile.');
      const container = $('#videoContainer');
      container.empty();

      if (urlVideo && urlVideo !== 'null' && urlVideo !== '') {
        let embedUrl = urlVideo;
        if (urlVideo.includes('youtube.com/watch?v=')) {
          const videoId = urlVideo.split('v=')[1].split('&')[0];
          embedUrl = 'https://www.youtube.com/embed/' + videoId;
        } else if (urlVideo.includes('youtu.be/')) {
          const videoId = urlVideo.split('youtu.be/')[1].split('?')[0];
          embedUrl = 'https://www.youtube.com/embed/' + videoId;
        }

        const iframeHtml = `
            <iframe class="embed-responsive-item" src="` + embedUrl + `" allowfullscreen></iframe>`;
        container.append(iframeHtml);
      } else {
        container.append('<div class="p-5 bg-light text-muted">Video non disponibile.</div>');
      }
      $('#videoModal').modal('show');
    }
  </script>
</body>
</html>