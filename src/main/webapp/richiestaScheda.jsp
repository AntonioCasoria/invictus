<%@ page import="DataAccessLayer.bean.Utente" %>
<%@ page import="DataAccessLayer.bean.Prenotazione" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DataAccessLayer.bean.PersonalTrainer" %>
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

  <title>HomePage Utente Registrato</title>

  <!-- Custom fonts for this template-->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <!-- Custom styles for this template-->
  <link href="css/sb-admin-2.css" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

  <style>
    /* --- 1. CONTENITORE PRINCIPALE --- */
    .consultation-container {
      border: 2px solid #333;
      border-radius: 25px;
      background: white;
      padding: 40px;
      margin-bottom: 20px;
    }

    /* --- 2. SELEZIONE PT (SCROLL ORIZZONTALE) --- */
    .container-pt-orizzontale {
      overflow-x: auto;
      overflow-y: hidden;
      padding: 15px 5px;
      background-color: #f8f9fc;
      border: 1px solid #e3e6f0;
      border-radius: 15px;
      display: flex; /* Forza il layout flex */
      -webkit-overflow-scrolling: touch; /* Fluidità su mobile */
    }

    .pt-item-wrapper {
      flex: 0 0 auto; /* Impedisce alle card di restringersi */
      width: 220px;   /* Larghezza fissa per ogni card PT */
      margin-right: 15px;
    }

    .pt-card {
      border: 2px solid #e3e6f0;
      border-radius: 15px;
      padding: 20px;
      cursor: pointer;
      transition: all 0.2s ease-in-out;
      background: white;
      text-align: center;
    }

    .pt-card:hover {
      border-color: #1e73be;
      transform: translateY(-3px);
    }

    .pt-card.selected {
      border-color: #1e73be !important;
      background-color: #eef5ff;
      color: #1e73be;
    }

    .pt-card i { color: #d1d3e2; }
    .pt-card.selected i { color: #1e73be; }

    /* --- 3. SELEZIONE MOTIVO (CREA/MODIFICA) --- */
    .reason-box {
      border: 2px solid #e3e6f0;
      border-radius: 15px;
      padding: 25px;
      cursor: pointer;
      transition: all 0.3s ease;
      height: 100%;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      text-align: center;
    }

    .reason-box:hover {
      border-color: #1e73be;
      background-color: #f0f4f8;
    }

    .reason-box.selected {
      border: 2px solid #1e73be !important;
      background-color: #eef5ff;
    }

    .reason-box i {
      font-size: 2.8rem;
      color: #1e73be;
      margin-bottom: 15px;
    }

    /* --- 4. CAMPI DI TESTO E FORM --- */
    .form-control-custom {
      border: 2px solid #333;
      border-radius: 15px;
      padding: 15px;
      resize: none; /* Impedisce all'utente di ridimensionare la textarea */
    }

    /* --- 5. PERSONALIZZAZIONE SCROLLBAR --- */
    /* Barra orizzontale dei PT */
    .container-pt-orizzontale::-webkit-scrollbar {
      height: 8px;
    }
    .container-pt-orizzontale::-webkit-scrollbar-thumb {
      background-color: #d1d3e2;
      border-radius: 10px;
    }
    .container-pt-orizzontale::-webkit-scrollbar-track {
      background: #f1f1f1;
      border-radius: 10px;
    }

    /* --- 6. UTILITY COLORI --- */
    .text-our-blu { color: #1e73be; }
    .bg-our-blu { background-color: #1e73be; }

    /* --- 7. TASTO TORNA INDIETRO (SPLIT BUTTON) --- */
    .btn-icon-split .icon {
      background: rgba(0, 0, 0, 0.05);
      display: inline-block;
      padding: .375rem .75rem;
    }
    .btn-icon-split .text {
      display: inline-block;
      padding: .375rem .75rem;
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
        <span style="color: #1e73be;">Performance</span></a>
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
      <div class="container-fluid text-center">
        <div class="mb-4">
          <h1 class="h4 text-gray-900 font-weight-bold">Motivo della consultazione</h1>
        </div>

        <div class="row justify-content-center">

          <div class="col-lg-10">
            <div class="consultation-container shadow">

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
                <form id="formRichiesta" action="InviaRichiestaServlet" method="post">

                <input type="hidden" name="idPT" id="inputPT" value="">
                <input type="hidden" name="motivo" id="inputMotivo" value="">

                <h6 class="font-weight-bold text-primary mb-3">Seleziona il tuo Personal Trainer</h6>
                <div class="container-pt-orizzontale mb-4">
                  <div class="d-flex flex-row flex-nowrap" id="listaPTContainer">
                    <div class="p-3 text-muted">Caricamento Personal Trainer...</div>
                  </div>
                </div>

                <div class="row">
                  <div class="col-md-6 mb-3">
                    <div class="reason-box" id="boxCrea" onclick="selezionaMotivo('crea')">
                      <i class="fas fa-plus-circle"></i>
                      <h5 class="font-weight-bold">Crea nuova scheda</h5>
                      <p class="small text-muted">Inizia un nuovo percorso d'allenamento da zero</p>
                    </div>
                  </div>

                  <div class="col-md-6 mb-3">
                    <div class="reason-box" id="boxModifica" onclick="selezionaMotivo('modifica')">
                      <i class="fas fa-edit"></i>
                      <h5 class="font-weight-bold">Modifica scheda</h5>
                      <p class="small text-muted">Richiedi variazioni alla tua attuale scheda d'allenamento</p>
                    </div>
                  </div>
                </div>

                <div id="containerMessaggioCrea" class="animated--fade-in" style="display: none;">
                  <label class="font-weight-bold text-dark mt-4">Su cosa vorresti lavorare?</label>
                  <textarea name="messaggio" class="form-control form-control-custom"
                            rows="5" placeholder="Scrivi qui le tue necessità..."></textarea>
                </div>


                <div id="containerMessaggioModifica" class="animated--fade-in" style="display: none;">
                  <label class="font-weight-bold text-dark mt-4">Quali modifiche vorresti apportare?</label>
                  <textarea name="messaggio" class="form-control form-control-custom"
                            rows="5" placeholder="Scrivi qui le tue necessità..."></textarea>
                </div>

                <div id="containerSubmit" style="display: none;">
                  <button type="submit" class="btn btn-primary px-5 mt-5 shadow"
                          style="background-color: #1e73be; border: none; border-radius: 15px;">
                    Conferma e Invia al PT
                  </button>
                </div>
              </form>
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

</div>

<div class="modal fade" id="successModal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content border-left-success shadow">
      <div class="modal-header">
        <h5 class="modal-title text-success font-weight-bold">
          <i class="fas fa-check-circle mr-2"></i> Operazione Completata
        </h5>
        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">×</span>
        </button>
      </div>
      <div class="modal-body text-gray-900">
        La tua richiesta è stata inviata correttamente al Personal Trainer. Riceverai presto un feedback sulla tua scheda.
      </div>
      <div class="modal-footer">
        <button class="btn btn-success" type="button" data-dismiss="modal">Chiudi</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="errorModal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content border-left-danger shadow">
      <div class="modal-header">
        <h5 class="modal-title text-danger font-weight-bold">
          <i class="fas fa-exclamation-triangle mr-2"></i> Errore
        </h5>
        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">×</span>
        </button>
      </div>
      <div class="modal-body text-gray-900">
        Si è verificato un problema durante l'invio della richiesta. Riprova più tardi o contatta l'assistenza.
      </div>
      <div class="modal-footer">
        <button class="btn btn-secondary" type="button" data-dismiss="modal">Chiudi</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="warningConsultatoModal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content border-left-warning shadow">
      <div class="modal-header">
        <h5 class="modal-title text-warning font-weight-bold">
          <i class="fas fa-exclamation-circle mr-2"></i> Richiesta in Corso
        </h5>
        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">×</span>
        </button>
      </div>
      <div class="modal-body text-gray-900">
        Esiste già una richiesta per questo Personal Trainer con stato <b>"Consultato"</b>.
        Attendere la risposta del PT per poter procedere con una nuova richiesta.
      </div>
      <div class="modal-footer">
        <button class="btn btn-warning text-white" type="button" data-dismiss="modal">Ho capito</button>
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

  $(document).ready(function() {
    // Chiamata AJAX al caricamento della pagina
    caricaListaPT();
  });

  function caricaListaPT() {
    $.ajax({
      url: 'GetTuttiPTServlet', // L'URL della tua Servlet
      type: 'POST',
      dataType: 'json',
      success: function(data) {
        const container = $('#listaPTContainer');
        container.empty(); // Puliamo il messaggio di caricamento

        if (data.length === 0) {
          container.append('<div class="p-3 text-muted">Nessun trainer disponibile.</div>');
          return;
        }

        console.log(data);
        // Cicliamo sui dati ricevuti dal database
        data.forEach(function(pt) {
          // Costruiamo la card dinamicamente
          const cardHtml = `
            <div class="pt-item-wrapper">
                <div class="pt-card shadow-sm" onclick="selezionaPT(this, '` + pt.idPT + `')">
                    <i class="fas fa-user-tie fa-2x mb-2"></i>
                    <span class="d-block font-weight-bold">` + pt.nome + " " + pt.cognome + `</span>
                </div>
            </div>
        `;
          container.append(cardHtml);
        });
      },
      error: function() {
        $('#listaPTContainer').html('<div class="p-3 text-danger">Errore nel caricamento dei trainer.</div>');
      }
    });
  }

  // Funzione per selezionare il PT
  function selezionaPT(elemento, id) {
    $('.pt-card').removeClass('selected');
    $(elemento).addClass('selected');
    $('#inputPT').val(id);
    $('#sezioneMotivi').stop(true, true).fadeIn(300);
  }

  // Funzione per selezionare il motivo (quella di prima, integrata)
  function selezionaMotivo(tipo) {
    // 1. Reset visivo e impostazione del motivo
    $('.reason-box').removeClass('selected');
    $('#inputMotivo').val(tipo);
    $('#containerSubmit').stop(true, true).fadeIn(200);

    // 2. CAMBIO DINAMICO DELLA SERVLET
    if (tipo === 'crea') {
      $('#boxCrea').addClass('selected');

      // Impostiamo la servlet per l'inserimento
      $('#formRichiesta').attr('action', 'InserisciRichiestaServlet');

      $('#containerMessaggioModifica').hide().find('textarea').prop('disabled', true);
      $('#containerMessaggioCrea').stop(true, true).fadeIn(200).find('textarea').prop('disabled', false);

    } else if (tipo === 'modifica') {
      $('#boxModifica').addClass('selected');

      // Impostiamo la servlet per la modifica/aggiornamento stato
      $('#formRichiesta').attr('action', 'AggiornaRichiestaServlet');

      $('#containerMessaggioCrea').hide().find('textarea').prop('disabled', true);
      $('#containerMessaggioModifica').stop(true, true).fadeIn(200).find('textarea').prop('disabled', false);
    }
  }

  $(document).ready(function() {
    // Validazione prima dell'invio
    $('#formRichiesta').submit(function(e) {
      const idPT = $('#inputPT').val();
      const messaggio = $('.form-control-custom:enabled').val().trim();

      if (!idPT) {
        e.preventDefault();
        alert('Seleziona un Personal Trainer prima di inviare.');
      } else if (messaggio === '') {
        e.preventDefault();
        alert('Il messaggio non può essere vuoto.');
      }
    });
  });

  $(document).ready(function() {
    // Validazione finale
    $('#formRichiesta').submit(function(e) {
      const pt = $('#inputPT').val();
      const messaggio = $('.form-control-custom:enabled').val().trim();

      if (!pt) {
        e.preventDefault();
        alert('Seleziona un Personal Trainer prima di continuare.');
      } else if (messaggio === '') {
        e.preventDefault();
        alert('Inserisci un messaggio per il tuo PT.');
      }
    });
  });
</script>

<script>
  $(document).ready(function() {
    const urlParams = new URLSearchParams(window.location.search);

    // 1. Gestione Successo
    if (urlParams.has('success')) {
      $('#successModal').modal('show');
      window.history.replaceState({}, document.title, window.location.pathname);
    }

    // 2. Gestione Errore Generico
    if (urlParams.has('error')) {
      $('#errorModal').modal('show');
      window.history.replaceState({}, document.title, window.location.pathname);
    }

    // 3. NUOVO: Gestione Avviso Giallo (Richiesta già esistente)
    if (urlParams.get('status') === 'alreadyConsulted') {
      $('#warningConsultatoModal').modal('show');
      window.history.replaceState({}, document.title, window.location.pathname);
    }
  });
</script>
</body>
</html>