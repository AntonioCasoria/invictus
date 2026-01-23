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

  <title>Progressi</title>

  <!-- Custom fonts for this template-->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <!-- Custom styles for this template-->
  <link href="css/sb-admin-2.css" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

  <style>
    /* --- Layout Generale Area Progressi --- */

    /* Contenitore del grafico: fondamentale per Chart.js [cite: 2026-01-22] */
    .chart-area {
      position: relative;
      height: 25rem; /* Altezza ottimale per la visualizzazione desktop */
      width: 100%;
    }

    /* Stile delle Card (coerente con il mockup) */
    .card {
      border: none;
      border-radius: 0.85rem;
      background-color: #ffffff;
      box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
    }

    .card-header {
      background-color: #f8f9fc;
      border-bottom: 1px solid #e3e6f0;
      padding: 1rem 1.25rem;
      border-top-left-radius: 0.85rem !important;
      border-top-right-radius: 0.85rem !important;
    }

    /* --- Lista Selezione Gruppi Muscolari (Destra) --- */

    #listaGruppiMuscolari {
      border-radius: 0.5rem;
      overflow: hidden;
    }

    #listaGruppiMuscolari .list-group-item {
      border: none;
      margin-bottom: 8px;
      border-radius: 0.5rem !important;
      background-color: #f8f9fc;
      color: #4e73df; /* Colore primario del progetto [cite: 2026-01-21] */
      font-weight: 600;
      transition: all 0.25s ease-in-out;
      cursor: pointer;
      display: flex;
      align-items: center;
      justify-content: space-between;
    }

    /* Effetto Hover: leggero spostamento a destra [cite: 2026-01-20] */
    #listaGruppiMuscolari .list-group-item:hover {
      background-color: #eaecf4;
      color: #2e59d9;
      padding-left: 1.75rem;
    }

    /* Stato Attivo: evidenzia il gruppo selezionato */
    #listaGruppiMuscolari .list-group-item.active {
      background-color: #4e73df;
      color: #ffffff;
      box-shadow: 0 4px 12px rgba(78, 115, 223, 0.25);
      z-index: 2;
    }

    /* --- Elementi Testuali --- */

    .font-weight-bold {
      font-weight: 700 !important;
    }

    #titoloGrafico {
      font-size: 0.95rem;
      text-transform: uppercase;
      letter-spacing: 0.05em;
    }

    /* --- Responsive Design --- */

    /* Ottimizzazione per Tablet e Smartphone */
    @media (max-width: 991px) {
      .chart-area {
        height: 18rem; /* Riduce l'altezza per schermi piccoli */
      }

      /* Trasforma la lista verticale in uno scrollbar orizzontale su mobile */
      #listaGruppiMuscolari {
        display: flex;
        flex-direction: row;
        overflow-x: auto;
        white-space: nowrap;
        padding-bottom: 10px;
        border-radius: 0;
      }

      #listaGruppiMuscolari .list-group-item {
        margin-right: 10px;
        margin-bottom: 0;
        padding: 0.5rem 1.25rem;
      }

      #listaGruppiMuscolari .list-group-item:hover {
        padding-left: 1.25rem; /* Rimuove lo spostamento laterale su mobile */
      }
    }

    /* Animazione Fade-In per il grafico */
    .animated--fade-in {
      animation: fadeIn 0.5s ease-in-out;
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
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
          <h1 class="h3 mb-0 text-gray-800 font-weight-bold">I tuoi progressi</h1>
        </div>

        <div class="row">
          <div class="col-xl-8 col-lg-7">
            <div class="card shadow mb-4">
              <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                <h6 class="m-0 font-weight-bold text-primary" id="titoloGrafico">Carico nel tempo (kg)</h6>
              </div>
              <div class="card-body">
                <div class="chart-area" style="position: relative; height:40vh; width:100%">
                  <canvas id="myProgressChart"></canvas>
                </div>
                <hr>
                <div class="small text-muted">
                  Il grafico mostra la media del carico sollevato per il gruppo selezionato.
                </div>
              </div>
            </div>
          </div>

          <div class="col-xl-4 col-lg-5">
            <div class="card shadow mb-4">
              <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">Seleziona Gruppo</h6>
              </div>
              <div class="card-body">
                <div class="list-group list-group-flush" id="listaGruppiMuscolari">
                  <button type="button" class="list-group-item list-group-item-action active" onclick="caricaDatiProgresso('Petto', this)">Petto</button>
                  <button type="button" class="list-group-item list-group-item-action" onclick="caricaDatiProgresso('Dorsali', this)">Schiena</button>
                  <button type="button" class="list-group-item list-group-item-action" onclick="caricaDatiProgresso('Femorali', this)">Femorali</button>
                  <button type="button" class="list-group-item list-group-item-action " onclick="caricaDatiProgresso('Quadricipiti', this)">Quadricipiti</button>
                  <button type="button" class="list-group-item list-group-item-action " onclick="caricaDatiProgresso('Spalle', this)">Spalle</button>
                  <button type="button" class="list-group-item list-group-item-action" onclick="caricaDatiProgresso('Bicipiti', this)">Bicipiti</button>
                  <button type="button" class="list-group-item list-group-item-action" onclick="caricaDatiProgresso('Tricipiti', this)">Tricipiti</button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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


  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

  <script>
    // Istanza globale del grafico per poterlo distruggere e ricreare [cite: 2026-01-22]
    let myChart = null;

    $(document).ready(function() {
      /**
       * 1. GESTIONE CLICK BOTTONI (Selezione Gruppi Muscolari)
       * Usiamo la delegazione degli eventi per gestire i bottoni nella sidebar destra [cite: 2026-01-21]
       */
      $('#listaGruppiMuscolari').on('click', '.list-group-item', function(e) {
        e.preventDefault();

        // Rimuove la classe 'active' da tutti i bottoni e la aggiunge a quello cliccato
        $('#listaGruppiMuscolari .list-group-item').removeClass('active');
        $(this).addClass('active');

        // Recupera il nome del gruppo muscolare dal testo del bottone
        const gruppoSelezionato = $(this).text().trim();

        // Aggiorna il titolo visivo
        $('#titoloGrafico').text('Andamento Carichi: ' + gruppoSelezionato);

        // Avvia il caricamento dei dati per il gruppo selezionato [cite: 2026-01-21]
        caricaDatiProgresso(gruppoSelezionato);
      });

      // 2. CARICAMENTO INIZIALE
      // Simula il click sul primo bottone della lista al caricamento della pagina
      const primoBottone = $('#listaGruppiMuscolari .list-group-item').first();
      if (primoBottone.length > 0) {
        primoBottone.click();
      }
    });

    /**
     * Recupera i dati storici tramite AJAX [cite: 2026-01-21]
     */
    function caricaDatiProgresso(gruppo) {
      $.ajax({
        url: 'GetStoricoProgressiServlet',
        type: 'POST',
        data: { gruppoMuscolare: gruppo },
        dataType: 'json',
        success: function(response) {
          console.log("Dati recuperati per " + gruppo + ": ", response);

          // Verifica che la response contenga i dati necessari [cite: 2026-01-22]
          if (response.labels && response.dataset) {
            disegnaGrafico(response.labels, response.dataset);
          }
        },
        error: function(xhr) {
          console.error("Errore nel recupero dati per " + gruppo + ": ", xhr.responseText);
        }
      });
    }

    /**
     * Inizializza o aggiorna l'area del grafico [cite: 2026-01-22]
     */
    function disegnaGrafico(labels, dataPoints) {
      const ctx = document.getElementById('myProgressChart').getContext('2d');

      // Se esiste un grafico precedente, lo distruggiamo per evitare sovrapposizioni [cite: 2026-01-22]
      if (myChart) {
        myChart.destroy();
      }

      // Configurazione estetica del grafico a linee [cite: 2026-01-21, 2026-01-22]
      myChart = new Chart(ctx, {
        type: 'line',
        data: {
          labels: labels,
          datasets: [{
            label: 'Carico (kg)',
            data: dataPoints,
            fill: true,
            backgroundColor: 'rgba(78, 115, 223, 0.1)',
            borderColor: 'rgba(78, 115, 223, 1)',
            pointRadius: 5,
            pointBackgroundColor: 'rgba(78, 115, 223, 1)',
            pointBorderColor: '#fff',
            tension: 0.3
          }]
        },
        options: {
          maintainAspectRatio: false,
          plugins: {
            legend: { display: false },
            tooltip: {
              callbacks: {
                // Gestione decimali (3.5 kg) nel tooltip [cite: 2026-01-22]
                label: function(context) {
                  return 'Peso: ' + parseFloat(context.parsed.y).toFixed(1) + ' kg';
                }
              }
            }
          },
          scales: {
            x: { grid: { display: false } },
            y: {
              ticks: {
                // Gestione decimali nell'asse Y [cite: 2026-01-22]
                callback: function(value) { return value.toFixed(1) + ' kg'; }
              }
            }
          }
        }
      });
    }
  </script>

</body>
</html>