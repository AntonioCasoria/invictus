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

  <title>Visualizza Performance</title>

  <!-- Custom fonts for this template-->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <!-- Custom styles for this template-->
  <link href="css/sb-admin-2.css" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>

<style>
  /* --- 1. SCROLLBAR ORIZZONTALE SCHEDE (TOP) --- */
  .scheda-scrollbar {
    display: flex;
    overflow-x: auto;
    padding: 15px 5px;
    gap: 20px;
    scrollbar-width: thin;
    scrollbar-color: #4e73df #f8f9fc;
  }

  /* Personalizzazione scrollbar per Chrome/Safari */
  .scheda-scrollbar::-webkit-scrollbar {
    height: 8px;
  }

  .scheda-scrollbar::-webkit-scrollbar-thumb {
    background: #4e73df;
    border-radius: 10px;
  }

  .scheda-item-wrapper {
    flex: 0 0 180px; /* Larghezza fissa per ogni card nello scrollbar [cite: 2026-01-20] */
  }

  .scheda-card {
    background: white;
    border: 2px solid transparent;
    border-radius: 12px;
    padding: 15px;
    text-align: center;
    cursor: pointer;
    transition: all 0.3s ease;
  }

  .scheda-card:hover {
    transform: translateY(-5px);
    border-color: #4e73df;
  }

  .scheda-card.selected {
    border-color: #4e73df;
    background-color: #f0f4ff; /* Colore evidenziato per la scheda attiva [cite: 2026-01-20] */
  }

  /* --- 2. NAVIGAZIONE GIORNI (TAB) --- */
  .giorno-tab {
    padding: 12px 25px;
    cursor: pointer;
    font-weight: bold;
    color: #858796;
    border-bottom: 3px solid transparent;
    transition: all 0.2s;
    text-align: center;
  }

  .giorno-tab:hover {
    color: #4e73df;
    background-color: #f8f9fc;
  }

  .giorno-tab.active {
    color: #4e73df;
    border-bottom-color: #4e73df; /* Tab evidenziato per il giorno selezionato [cite: 2026-01-20] */
  }

  /* --- 3. LAYOUT PERFORMANCE (RIGA ORIZZONTALE CENTRATA) --- */
  .perf-row-full {
    display: flex;
    align-items: center;
    min-height: 120px;
    border-bottom: 1px solid #e3e6f0;
    background: white;
    transition: background 0.2s;
  }

  .perf-row-full:hover {
    background-color: #fafbfc;
  }

  /* Struttura a 3 colonne con allineamento centrale [cite: 2026-01-21] */
  .perf-col-ex, .perf-col-stats, .perf-col-feedback {
    display: flex;
    flex-direction: column;
    justify-content: center;
    text-align: center; /* Allineamento centrale di tutti i contenuti [cite: 2026-01-21] */
  }

  /* COLONNA 1: Esercizio */
  .perf-col-ex {
    flex: 1.5; /* Circa 20-25% dello spazio */
    padding: 20px;
    font-weight: 700;
    color: #4e73df;
  }

  /* COLONNA 2: Performance (Centrale, Ingrandita e Protagonista) */
  .perf-col-stats {
    flex: 3; /* Spazio triplo rispetto alla colonna base per massima visibilità [cite: 2026-01-21] */
    padding: 25px;
    border-left: 2px solid #eaecf4; /* Divisore verticale sinistro [cite: 2026-01-21] */
    border-right: 2px solid #eaecf4; /* Divisore verticale destro [cite: 2026-01-21] */
    background-color: #f8f9fc; /* Sfondo grigio chiaro per risaltare (Mockup 1.0) [cite: 2026-01-21] */
  }

  /* COLONNA 3: Feedback (Text) */
  .perf-col-feedback {
    flex: 2; /* Circa 30% dello spazio */
    padding: 20px;
  }

  /* --- 4. TIPOGRAFIA E ETICHETTE --- */
  .perf-label {
    display: block;
    font-size: 0.85rem;
    text-transform: uppercase;
    letter-spacing: 1px;
    color: #5a5c69;
    margin-bottom: 8px;
    font-weight: 600;
    text-align: center; /* Centratura delle etichette (Esercizio, Performance, Feedback) [cite: 2026-01-21] */
  }

  .perf-value {
    color: #4e73df;
    font-weight: 900;
    font-size: 1.7rem; /* Font aumentato per i risultati numerici [cite: 2026-01-21] */
    display: block;
    line-height: 1.2;
  }

  .perf-details {
    font-size: 0.95rem;
    color: #858796;
    margin-top: 5px;
  }

  .feedback-content {
    font-style: italic;
    color: #6e707e;
    font-size: 0.95rem;
    margin: 0 auto;
    max-width: 90%; /* Evita che il testo tocchi i bordi */
  }

  /* Animazione per l'apparizione delle righe */
  .animated--fade-in {
    animation: fadeIn 0.4s ease-in-out;
  }

  @keyframes fadeIn {
    from { opacity: 0; transform: translateY(5px); }
    to { opacity: 1; transform: translateY(0); }
  }
</style>

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
      <div id="content">
        <div class="container-fluid">

          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800 font-weight-bold">Performance dell'allenamento</h1>
          </div>

          <div id="listaSchedeContainer" class="scheda-scrollbar mb-4">
          </div>

          <hr class="sidebar-divider">

          <div id="areaDettagliPerformance" style="display: none;">

            <div id="navigazioneGiorni" class="d-flex mb-3 border-bottom pb-2">
            </div>

            <div class="card shadow mb-4">
              <div class="card-body p-0">
                <div id="containerPerformanceGiorno" class="performance-container">
                </div>
              </div>
            </div>

          </div> </div>
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
    // Variabili globali per lo stato della pagina [cite: 2026-01-20]
    let idSchedaAttiva = null;
    let eserciziPerGiorno = {};
    let mappaUltimePerformance = {}; // Mappa popolata dalla servlet con Gson [cite: 2026-01-21]

    $(document).ready(function() {
      // Caricamento iniziale dello scrollbar delle schede [cite: 2026-01-20]
      caricaSchede();
    });

    /**
     * Recupera le schede utente e gestisce l'auto-selezione se l'ID è nell'URL
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

          data.forEach(function(scheda) {
            const cardHtml = `
                        <div class="scheda-item-wrapper" id="card-scheda-` + scheda.idScheda + `">
                            <div class="scheda-card shadow-sm" onclick="selezionaScheda(this, '` + scheda.idScheda + `')">
                                <i class="fas fa-chart-line fa-2x mb-2 text-primary"></i>
                                <span class="d-block font-weight-bold">` + scheda.nome + `</span>
                                <small class="text-muted">` + scheda.obiettivo + `</small>
                            </div>
                        </div>
                    `;
            container.append(cardHtml);
          });

          // Auto-click se presente un ID specifico nell'URL [cite: 2026-01-20]
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
     * Carica i dati storici e la struttura della scheda selezionata [cite: 2026-01-21]
     */
    function selezionaScheda(elemento, idScheda) {
      idSchedaAttiva = idScheda;
      $('.scheda-card').removeClass('selected');
      $(elemento).addClass('selected');

      $('#areaDettagliPerformance').fadeIn(300);
      $('#containerPerformanceGiorno').html('<div class="p-5 text-center"><i class="fas fa-spinner fa-spin fa-2x"></i></div>');

      // 1. Chiamata per recuperare la mappa delle performance storiche (Key: ID Esercizio) [cite: 2026-01-21]
      $.ajax({
        url: 'GetUltimePerformanceServlet',
        type: 'POST',
        dataType: 'json',
        success: function(performancesMap) {
          mappaUltimePerformance = performancesMap;

          // 2. Chiamata per recuperare gli esercizi della scheda [cite: 2026-01-20]
          $.ajax({
            url: 'VisualizzaSchedaUtentePerformanceServlet?idScheda=' + idScheda,
            type: 'POST',
            dataType: 'json',
            success: function(data) {
              eserciziPerGiorno = {};

              if (data.esercizi && data.esercizi.length > 0) {
                data.esercizi.forEach(function(ex) {
                  const g = ex.giorno;
                  if (!eserciziPerGiorno[g]) eserciziPerGiorno[g] = [];
                  eserciziPerGiorno[g].push(ex);
                });

                costruisciNavigazioneGiorni(eserciziPerGiorno);

                // Gestione automatica del giorno post-salvataggio [cite: 2026-01-20]
                const urlParams = new URLSearchParams(window.location.search);
                const giornoDaAprire = urlParams.get('giorno');
                if (giornoDaAprire) {
                  const targetTab = $('.giorno-tab').filter(function() {
                    return $(this).text().trim() === 'Giorno ' + giornoDaAprire;
                  });
                  if (targetTab.length > 0) targetTab.click();
                  window.history.replaceState({}, document.title, window.location.pathname);
                }
              }
            }
          });
        }
      });
    }

    /**
     * Genera i tab orizzontali per i giorni di allenamento [cite: 2026-01-20]
     */
    function costruisciNavigazioneGiorni(giorni) {
      const nav = $('#navigazioneGiorni');
      nav.empty();
      const chiavi = Object.keys(giorni).sort((a, b) => a - b);

      chiavi.forEach(function(gKey, index) {
        const activeClass = (index === 0) ? 'active' : '';
        const tabHtml = `
                <div class="giorno-tab ` + activeClass + `" onclick="mostraGiorno('` + gKey + `', this)">
                    Giorno ` + gKey + `
                </div>
            `;
        nav.append(tabHtml);
      });

      if (chiavi.length > 0) {
        mostraGiorno(chiavi[0], $('.giorno-tab').first());
      }
    }

    /**
     * Rendering delle performance con layout centrato a 3 sezioni [cite: 2026-01-21]
     */
    function mostraGiorno(giornoKey, elemento) {
      $('.giorno-tab').removeClass('active');
      $(elemento).addClass('active');

      const container = $('#containerPerformanceGiorno');
      container.empty();

      const esercizi = eserciziPerGiorno[giornoKey];

      esercizi.forEach(function(ex) {
        // Accoppiamento dati tramite ID esercizio dalla mappa ricevuta [cite: 2026-01-21]
        const p = mappaUltimePerformance[ex.idEsercizio];

        const rigaHtml = `
                <div class="perf-row-full animated--fade-in">
                    <div class="perf-col-ex">
                        <span class="perf-label">Esercizio</span>
                        <span class="d-block font-weight-bold">` + ex.nomeEsercizio + `</span>
                        <small class="text-muted">` + ex.gruppo + `</small>
                    </div>

                    <div class="perf-col-stats">
                        <span class="perf-label">Ultima Performance</span>
                        <span class="perf-value">
                        ` + (p && p.carico !== undefined ? parseFloat(p.carico).toFixed(2) + ' kg' : '---') + `                        </span>
                        <div class="perf-details">
                        ` + (ex.rpe !== undefined ? ex.serieEffettive + ' Serie x ' + ex.ripetizioniEffettive + ' Rip | RPE ' + ex.rpe : 'Nessun dato registrato') + `                        </div>
                        <small class="text-muted mt-2 d-block">
                            ` + (p ? 'Eseguito il: ' + p.data : '') + `
                        </small>
                    </div>

                    <div class="perf-col-feedback">
                        <span class="perf-label">Feedback</span>
                        <p class="feedback-content">
                            ` + (p && p.feedback ? p.feedback : 'Nessun feedback presente per questo esercizio.') + `
                        </p>
                    </div>
                </div>
            `;
        container.append(rigaHtml);
      });
    }
  </script>

</body>
</html>