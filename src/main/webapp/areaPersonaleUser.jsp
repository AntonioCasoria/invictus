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

  <title>Area Personale Utente Registrato</title>

  <!-- Custom fonts for this template-->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <!-- Custom styles for this template-->
  <link href="css/sb-admin-2.css" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

  <style>
    /* --- Struttura della Card e dei Tab --- */

    .card {
      border: none;
      border-radius: 0.75rem;
    }

    /* Stile della navigazione superiore (Layout INV_MU_05) [cite: 2026-01-20] */
    .nav-tabs.nav-justified {
      border-bottom: 1px solid #e3e6f0;
      background-color: #f8f9fc;
      border-top-left-radius: 0.75rem;
      border-top-right-radius: 0.75rem;
      overflow: hidden;
    }

    .nav-tabs.nav-justified .nav-link {
      border: none;
      border-radius: 0;
      padding: 1.25rem 0.5rem;
      color: #4e73df;
      font-weight: 700;
      text-transform: uppercase;
      font-size: 0.8rem;
      letter-spacing: 0.05rem;
      transition: all 0.2s ease;
    }

    /* Tab Attivo: Barra blu inferiore e sfondo bianco [cite: 2026-01-20, 2026-01-21] */
    .nav-tabs.nav-justified .nav-link.active {
      background-color: #ffffff;
      color: #2e59d9;
      border-bottom: 4px solid #4e73df !important; /* Spessore marcato come da mockup */
    }

    .nav-tabs.nav-justified .nav-link:hover:not(.active) {
      background-color: #eaecf4;
      color: #2e59d9;
    }

    /* --- Tipografia Dati Anagrafici --- */

    /* Etichette piccole e grigie per i metadati [cite: 2026-01-21] */
    .label-profilo {
      display: block;
      font-size: 0.7rem;
      font-weight: 800;
      color: #b7b9cc;
      text-transform: uppercase;
      margin-bottom: 0.2rem;
      letter-spacing: 0.1rem;
    }

    /* Valori dei dati in evidenza [cite: 2026-01-21] */
    .valore-profilo {
      font-size: 1.15rem;
      color: #4e5159;
      font-weight: 600;
      margin-bottom: 1.5rem;
    }

    /* --- Elementi di UI e Animazioni --- */

    /* Badge per l'obiettivo fitness [cite: 2026-01-21] */
    .badge-primary {
      background-color: #4e73df;
      border-radius: 20px;
      font-weight: 600;
    }

    /* Alert con bordo laterale coordinato [cite: 2026-01-21] */
    .border-left-primary {
      border-left: 0.25rem solid #4e73df !important;
    }

    /* Supporto per l'animazione di ingresso dei contenuti [cite: 2026-01-21] */
    .animated--fade-in {
      animation: fadeIn 0.4s ease-in-out;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(5px); }
      to { opacity: 1; transform: translateY(0); }
    }

    /* --- Responsive --- */
    @media (max-width: 768px) {
      .nav-tabs.nav-justified .nav-link {
        font-size: 0.65rem; /* Riduce il font su mobile per evitare sovrapposizioni */
        padding: 1rem 0.2rem;
      }

      .border-right {
        border-right: none !important;
        border-bottom: 1px solid #e3e6f0;
        margin-bottom: 1.5rem;
      }
    }

    <style>
       /* Contenitore principale per lo scroll orizzontale [cite: 2026-01-20] */
     .schede-scroll-wrapper {
       display: flex;
       overflow-x: auto;
       gap: 1.25rem;
       padding-bottom: 1rem;
       scrollbar-width: thin;
       scrollbar-color: #4e73df #eaecf4;
     }

    /* Personalizzazione scrollbar per browser Webkit */
    .schede-scroll-wrapper::-webkit-scrollbar {
      height: 6px;
    }
    .schede-scroll-wrapper::-webkit-scrollbar-thumb {
      background: #4e73df;
      border-radius: 10px;
    }

    /* Stile della card singola [cite: 2026-01-20] */
    .scheda-card {
      flex: 0 0 200px;
      background: #fff;
      border: 1px solid #e3e6f0;
      border-radius: 15px;
      padding: 1.5rem;
      text-align: center;
      transition: transform 0.2s ease;
    }

    .scheda-card:hover {
      transform: scale(1.02);
      border-color: #4e73df;
    }

    .scheda-icon {
      font-size: 2.5rem;
      color: #4e73df;
      margin-bottom: 1rem;
    }

    .scheda-title {
      font-weight: 800;
      color: #3a3b45;
      font-size: 0.95rem;
      text-transform: uppercase;
    }

    .scheda-date {
      font-size: 0.8rem;
      color: #858796;
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
      <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">
          <div class="container-fluid">

            <div class="mb-4">
              <h1 class="h4 text-gray-900 font-weight-bold text-center">Area Riservata</h1>
            </div>

            <div class="card shadow mb-4">
              <div class="card-header p-0">
                <ul class="nav nav-tabs nav-justified" id="areaRiservataTab" role="tablist">
                  <li class="nav-item">
                    <a class="nav-link active" data-toggle="tab" href="#sezioneDinamica" onclick="caricaDatiAnagrafici()">
                      Dati Anagrafici
                    </a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#sezioneDinamica" onclick="caricaModificaDati()">
                      Modifica Dati
                    </a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#sezioneDinamica" onclick="caricaPrenotazioniAttive()">
                      Prenotazioni Attive
                    </a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#sezioneDinamica" onclick="caricaStoricoSchede()">
                      Storico Schede
                    </a>
                  </li>
                </ul>
              </div>

              <div class="card-body">
                <div id="areaContenutoDinamico" class="p-4 animated--fade-in">

                  <div id="sezioneDatiAnagrafici">
                    <div class="row">
                      <div class="col-md-6 border-right">
                        <div class="mb-4">
                          <label class="label-profilo">Nome e Cognome</label>
                          <div class="valore-profilo"><%= utente.getNome() %> <%= utente.getCognome() %></div>
                        </div>
                        <div class="mb-4">
                          <label class="label-profilo">Residenza</label>
                          <div class="valore-profilo"><%= utente.getIndirizzo() %></div>
                        </div>
                        <div class="mb-4">
                          <label class="label-profilo">Data di Nascita</label>
                          <div class="valore-profilo"><%= utente.getDataNascita() %></div>
                        </div>
                        <div class="mb-4">
                          <label class="label-profilo">Indirizzo Email</label>
                          <div class="valore-profilo"><%= utente.getEmail() %></div>
                        </div>
                      </div>

                      <div class="col-md-6 pl-md-4">
                        <div class="mb-4">
                          <label class="label-profilo">Data di Iscrizione</label>
                          <div class="valore-profilo">
                            <%= (utente.getDataIscrizione() != null) ? utente.getDataIscrizione() : "Non inserita" %>
                          </div>
                        </div>
                        <div class="mb-4">
                          <label class="label-profilo">Altezza</label>
                          <div class="valore-profilo"><%= utente.getAltezza() %></div>
                        </div>
                        <div class="mb-4">
                          <label class="label-profilo">Peso</label>
                          <div class="valore-profilo"><%= utente.getPeso() %></div>
                        </div>
                        <div class="mb-4">
                          <label class="label-profilo">Obiettivo Fitness</label>
                          <div class="valore-profilo">
                                            <span class="badge badge-primary px-3 py-2">
                                                <%= (utente.getObiettivo() != null) ? utente.getObiettivo() : "Nessun obiettivo" %>
                                            </span>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>

                  <div id="altreSezioniDinamiche" style="display: none;">
                  </div>

                </div>
              </div>
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


  <!-- jQuery (OBBLIGATORIO) -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  <!-- Bootstrap Bundle (include Popper.js) -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

  <!-- jQuery Easing (necessario per easeInOutExpo) -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="js/sidebar.js"></script>


  <script>
    /**
     * Gestisce la visualizzazione dei Dati Anagrafici (già presenti in sessione)
     */
    function caricaDatiAnagrafici() {
      // Mostra il div statico della sessione e nasconde quello dinamico
      $('#sezioneDatiAnagrafici').show();
      $('#altreSezioniDinamiche').hide();

      // Gestione feedback visivo sui tab
      gestisciTabAttivo('Dati Anagrafici');
    }

    /**
     * Carica il form per la modifica dei dati personali via AJAX
     */
    function caricaModificaDati() {
      preparaAreaDinamica();

      $.ajax({
        url: 'GetFormModificaServlet', // Servlet che restituisce il form HTML
        type: 'GET',
        success: function(response) {
          $('#altreSezioniDinamiche').html(response);
          gestisciTabAttivo('Modifica Dati');
        },
        error: function() {
          mostraErrore("Impossibile caricare il modulo di modifica.");
        }
      });
    }

    /**
     * Carica le prenotazioni future dell'utente
     */
    function caricaPrenotazioniAttive() {
      preparaAreaDinamica();

      $.ajax({
        url: 'GetPrenotazioniAttiveServlet',
        type: 'GET',
        success: function(response) {
          $('#altreSezioniDinamiche').html(response);
          gestisciTabAttivo('Prenotazioni Attive');
        },
        error: function() {
          mostraErrore("Errore nel recupero delle prenotazioni.");
        }
      });
    }

    /**
     * Carica l'archivio delle vecchie schede di allenamento
     */
    function caricaStoricoSchede() {
      preparaAreaDinamica();

      $.ajax({
        url: 'GetStoricoSchedeServlet',
        type: 'GET',
        success: function(response) {
          $('#altreSezioniDinamiche').html(response);
          gestisciTabAttivo('Storico Schede');
        },
        error: function() {
          mostraErrore("Impossibile caricare l'archivio schede.");
        }
      });
    }

    // --- FUNZIONI DI UTILITÀ ---

    /**
     * Prepara l'interfaccia nascondendo i dati statici e mostrando lo spinner
     */
    function preparaAreaDinamica() {
      $('#sezioneDatiAnagrafici').hide();
      $('#altreSezioniDinamiche').show().html(
              '<div class="text-center py-5"><i class="fas fa-spinner fa-spin fa-2x text-primary"></i><p class="mt-2">Caricamento...</p></div>'
      );
    }

    /**
     * Sincronizza lo stato 'active' dei tab basandosi sul testo del link
     */
    function gestisciTabAttivo(nomeTab) {
      $('#areaRiservataTab .nav-link').each(function() {
        if ($(this).text().trim() === nomeTab) {
          $(this).addClass('active');
        } else {
          $(this).removeClass('active');
        }
      });
    }

    /**
     * Inserisce un messaggio di errore nel contenitore dinamico
     */
    function mostraErrore(messaggio) {
      $('#altreSezioniDinamiche').html(
              '<div class="alert alert-danger mx-4"><i class="fas fa-exclamation-triangle mr-2"></i>' + messaggio + '</div>'
      );
    }

    /**
     * Invia i dati modificati alla Servlet e aggiorna la UI
     */
    function salvaModifiche() {
      const formData = $('#formModificaDati').serialize();

      $.ajax({
        url: 'UpdateDatiUtenteServlet',
        type: 'POST',
        data: formData,
        success: function(response) {

          if (response === 'success') {
            // Notifica di successo e ricaricamento dei dati anagrafici
            alert('Profilo aggiornato con successo!');
            caricaDatiAnagrafici(); // Torna alla visualizzazione dei dati

            // Aggiorna anche il nome nella navbar se necessario
            $('.nav-user-name').text($('#formModificaDati input[name="nome"]').val());
          } else {
            alert('Errore durante l\'aggiornamento.');
          }
        },
        error: function() {
          alert('Errore di connessione al server.');
        }
      });
    }

    function caricaDettagliScheda(idScheda) {
      const container = $('#containerDettaglioScheda');
      container.html('<div class="text-center"><i class="fas fa-spinner fa-spin fa-2x"></i></div>');

      $.ajax({
        url: 'GetDettagliSchedaServlet', // Crea questa servlet per restituire la tabella esercizi
        type: 'GET',
        data: { id: idScheda },
        success: function(response) {
          container.html(response);
        },
        error: function() {
          container.html('<div class="alert alert-danger">Errore nel caricamento dettagli.</div>');
        }
      });
    }
  </script>
</body>
</html>