<%@ page import="DataAccessLayer.bean.Utente" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
  Utente admin = (Utente) session.getAttribute("admin");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Area Personale Admin</title>

  <!-- Custom fonts for this template-->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <!-- Custom styles for this template-->
  <link href="css/sb-admin-2.css" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <style>
    #areaAdminTab .nav-link {
      background-color: #f8f9fc;
      color: #4e73df;
      font-weight: bold;
      border: none;
      border-right: 1px solid #e3e6f0;
    }

    #areaAdminTab .nav-link.active {
      background-color: #d1d3e2 !important; /* Grigio del mockup */
      color: #3a3b45 !important;
      border-bottom: 3px solid #4e73df;
    }

       /* Styling Grafico Trend */
     .chart-bar-wrapper {
       display: flex;
       justify-content: space-around;
       align-items: flex-end;
       height: 180px;
       border-bottom: 2px solid #e3e6f0;
       padding-bottom: 5px;
     }

    .bar-group {
      display: flex;
      flex-column: column;
      align-items: center;
      width: 40%;
    }

    .bar {
      width: 40px;
      background-color: #4e73df;
      border-radius: 5px 5px 0 0;
      position: relative;
      transition: height 1s ease-in-out;
    }

    .jan-bar { background-color: #1cc88a; } /* Colore diverso per Gennaio */

    .bar-value {
      position: absolute;
      top: -25px;
      width: 100%;
      text-align: center;
      font-weight: bold;
      font-size: 0.85rem;
      color: #5a5c69;
    }

    .bar-label {
      margin-top: 10px;
      font-weight: bold;
      color: #858796;
      font-size: 0.8rem;
    }
  </style>
</head>
<body id="page-top">

<!-- Page Wrapper -->
<div id="wrapper">

  <!-- Sidebar -->
  <ul class="navbar-nav bg-sidebar sidebar sidebar-dark accordion" id="accordionSidebar">

    <!-- Sidebar - Brand -->
    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="#">
      <div class="sidebar-brand-icon">
        <img src="img/logoInvictus.png" alt="logo" style="width: auto; height: 50px;">
      </div>
    </a>

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
              <a class="dropdown-item d-flex align-items-center" href="#"></a>
              <!--
              <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="mr-3">
                      <div class="icon-circle bg-success">
                          <i class="fas fa-donate text-white"></i>
                      </div>
                  </div>
                  <div>
                      <div class="small text-gray-500">December 7, 2019</div>
                      $290.29 has been deposited into your account!
                  </div>
              </a>
              <a class="dropdown-item text-center small text-gray-500" href="#">Show All Alerts</a>
          </div>
          -->
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
              <span class="mr-2 d-none d-lg-inline text-white small"><%=admin.getNome()%></span>
              <i class="fa-solid fa-user-gear" style="color: white" ></i>
            </a>
            <!-- Dropdown - User Information -->
            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                 aria-labelledby="userDropdown">
              <a class="dropdown-item" href="areaPersonaleAdmin.jsp">
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
          <h1 class="h4 text-gray-900 font-weight-bold text-center">Dashboard Admin</h1>
        </div>

        <div class="card shadow mb-4">
          <div class="card-header p-0">
            <ul class="nav nav-tabs nav-justified" id="areaAdminTab" role="tablist">
              <li class="nav-item">
                <a class="nav-link active" data-toggle="tab" href="#contentAdmin" onclick="caricaDashboardAdmin()">
                  Dashboard
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#contentAdmin" onclick="caricaGestioneUtentiAdmin()">
                  Gestione Utenti
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#contentAdmin" onclick="caricaGestionePTAdmin()">
                  Gestione Personal Trainer
                </a>
              </li>
            </ul>
          </div>

          <div class="card-body">
            <div id="areaContenutoAdmin" class="p-2 animated--fade-in">
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
    $(document).ready(function() {
      caricaDashboardAdmin();
    });

    /**
     * DASHBOARD ADMIN - Layout a 3 Colonne (KPI | Attività | Trend)
     */
    function caricaDashboardAdmin() {
      var html = `
        <div class="row pt-2 animated--fade-in">
            <div class="col-lg-3">
                <div class="card bg-gray-100 border-0 h-100 shadow-sm p-3">
                    <h6 class="font-weight-bold text-gray-800 border-bottom pb-2">KPI Principali</h6>
                    <div id="containerKPI" class="mt-3">
                        <div class="mb-3 p-3 bg-white rounded shadow-sm border-left-primary">
                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Utenti Totali</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800" id="numUtentiAdmin">--</div>
                        </div>
                        <div class="mb-3 p-3 bg-white rounded shadow-sm border-left-success">
                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">PT Attivi</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800" id="numPTAdmin">--</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-header bg-white py-3 border-0 text-center">
                        <h6 class="m-0 font-weight-bold text-primary text-uppercase">Attività Recenti</h6>
                    </div>
                    <div class="card-body">
                        <div class="d-flex flex-column align-items-center">
                            <div class="py-3 border-bottom w-75 text-center text-gray-600 font-italic">L'utente Diego Maradona si è registrata in data 21/01/2026  </div>
                            <div class="py-3 border-bottom w-75 text-center text-gray-600 font-italic">L'utente Noa Lang ha chiesto una consulenza al Personal Trainer Federico Verdi</div>
                            <div class="py-3 border-bottom w-75 text-center text-gray-600 font-italic">Il Personal Trainer Mario Rossi ha creato una nuova scheda</div>
                            <div class="py-3 border-bottom w-75 text-center text-gray-600 font-italic">L'admin ha inserito un nuovo Personal Trainer </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-3">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-header bg-white py-3 border-0 text-center">
                        <h6 class="m-0 font-weight-bold text-gray-800 text-uppercase">Trend Iscrizioni</h6>
                    </div>
                    <div class="card-body">
                        <div class="trend-chart-container mt-4">
                            <div class="chart-bar-wrapper">
                                <div class="bar-group">
                                    <div class="bar dec-bar" style="height: 25%;">
                                        <span class="bar-value">4</span>
                                    </div>
                                    <div class="bar-label">Dic</div>
                                </div>
                                <div class="bar-group">
                                    <div class="bar jan-bar" style="height: 90%;">
                                        <span class="bar-value">15</span>
                                    </div>
                                    <div class="bar-label">Gen</div>
                                </div>
                            </div>
                            <p class="text-center small text-gray-500 mt-4">Incremento utenti registrati</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>`;

      $('#areaContenutoAdmin').html(html);
      gestisciTabAttivoAdmin('Dashboard');

      // Chiamata dinamica per i KPI [cite: 2026-01-22]
      popolaKPIAdmin();
    }

    /**
     * Funzioni per gli altri Tab
     */
    /**
     * GESTIONE UTENTI ADMIN - Visualizzazione e Eliminazione [cite: 2026-01-23]
     */
    function caricaGestioneUtentiAdmin() {
      var htmlStruttura = `
        <div class="card border-0 shadow-sm p-4 animated--fade-in">
            <h5 class="font-weight-bold text-gray-800 mb-4 border-bottom pb-2">Anagrafica Utenti Sistema</h5>
            <div class="table-responsive">
                <table class="table table-hover bg-white shadow-sm border rounded">
                    <thead class="bg-gray-200 text-gray-800">
                        <tr>
                            <th>Nome</th>
                            <th>Cognome</th>
                            <th>Ruolo</th>
                            <th class="text-center">Azioni</th>
                        </tr>
                    </thead>
                    <tbody id="corpoTabellaAdminUtenti">
                        <tr><td colspan="4" class="text-center py-4"><i class="fas fa-spinner fa-spin text-primary"></i> Recupero dati...</td></tr>
                    </tbody>
                </table>
            </div>
        </div>`;

      $('#areaContenutoAdmin').html(htmlStruttura);
      gestisciTabAttivoAdmin('Gestione Utenti');

      // Caricamento dati da GetAnagraficaCompletaServlet
      $.get('GetAnagraficaCompletaServlet', function(data) {
        var htmlTabella = '';
        if (data && data.length > 0) {
          data.forEach(function(u) {
            // Escludiamo l'admin stesso dalla lista per sicurezza
            if(u.ruolo !== 'admin') {
              htmlTabella += `
                    <tr>
                        <td class="align-middle">` + u.nome + `</td>
                        <td class="align-middle">` + u.cognome + `</td>
                        <td class="align-middle"><span class="badge badge-info">` + u.ruolo + `</span></td>
                        <td class="text-center">
                            <button class="btn btn-danger btn-sm shadow-sm" onclick="confermaEliminaUtente(` + u.idUtente + `, '` + u.nome + ` ` + u.cognome + `')">
                                <i class="fas fa-trash-alt mr-1"></i> Elimina
                            </button>
                        </td>
                    </tr>`;
            }
          });
        } else {
          htmlTabella = `<tr><td colspan="4" class="text-center text-muted py-4">Nessun utente trovato.</td></tr>`;
        }
        $('#corpoTabellaAdminUtenti').html(htmlTabella);
      });
    }

    /**
     * Logica di eliminazione con feedback dinamico [cite: 2026-01-23]
     */
    function confermaEliminaUtente(id, nomeCompleto) {
      if (confirm('Sei sicuro di voler eliminare definitivamente ' + nomeCompleto + '?')) {
        $.post('EliminaUtenteServlet', { idUtente: id }, function(response) {
          if (response.status === 'success') {
            // Notifica di successo con il nome restituito dalla tua query [cite: 2026-01-23]
            alert('Utente ' + nomeCompleto + ' rimosso correttamente dal sistema.');
            caricaGestioneUtentiAdmin();
          } else {
            alert('Errore: impossibile eliminare l\'utente selezionato.');
          }
        }, 'json');
      }
    }

    function caricaGestionePTAdmin() {
      var html = `
    <div class="animated--fade-in">
        <div class="card border-0 shadow-sm p-4 mb-4">
            <h5 class="font-weight-bold text-gray-800 mb-4 border-bottom pb-2">Staff Personal Trainer</h5>
            <div class="table-responsive">
                <table class="table table-hover bg-white border rounded">
                    <thead class="bg-gray-200 text-gray-800">
                        <tr>
                            <th>Nome</th>
                            <th>Cognome</th>
                            <th>Email</th>
                            <th class="text-center">Azioni</th>
                        </tr>
                    </thead>
                    <tbody id="corpoTabellaAdminPT">
                        <tr><td colspan="4" class="text-center py-4"><i class="fas fa-sync fa-spin"></i> Caricamento...</td></tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="card border-0 shadow-sm p-4">
            <h5 class="font-weight-bold text-primary mb-4 border-bottom pb-2">Aggiungi Nuovo Personal Trainer</h5>
            <form id="formAggiungiPT" onsubmit="event.preventDefault(); inserisciNuovoPT();">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="small font-weight-bold">Nome</label>
                        <input type="text" id="nomePT" class="form-control" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="small font-weight-bold">Cognome</label>
                        <input type="text" id="cognomePT" class="form-control" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="small font-weight-bold">Email</label>
                        <input type="email" id="emailPT" class="form-control" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="small font-weight-bold">Password Temporanea</label>
                        <input type="password" id="passPT" class="form-control" required>
                    </div>
                </div>
                <div class="text-right">
                    <button type="submit" class="btn btn-primary shadow-sm">
                        <i class="fas fa-user-plus mr-1"></i> Registra Personal Trainer
                    </button>
                </div>
            </form>
        </div>
    </div>`;

      $('#areaContenutoAdmin').html(html);
      gestisciTabAttivoAdmin('Gestione Personal Trainer');
      popolaTabellaPT();
    }

    /**
     * Recupera solo gli utenti con ruolo 'pt' [cite: 2026-01-23]
     */
    /**
     * 3. GESTIONE PT - Visualizzazione e Inserimento (Senza controllo ruolo) [cite: 2026-01-23]
     */
    function caricaGestionePTAdmin() {
      var html = `
    <div class="animated--fade-in">
        <div class="card border-0 shadow-sm p-4 mb-4">
            <h5 class="font-weight-bold text-gray-800 mb-4 border-bottom pb-2">Staff Personal Trainer</h5>
            <div class="table-responsive">
                <table class="table table-hover bg-white border rounded">
                    <thead class="bg-gray-200 text-gray-800">
                        <tr>
                            <th>Nome</th>
                            <th>Cognome</th>
                            <th>Email</th>
                            <th>Data Nascita</th>
                            <th class="text-center">Azioni</th>
                        </tr>
                    </thead>
                    <tbody id="corpoTabellaAdminPT">
                        <tr><td colspan="5" class="text-center py-4"><i class="fas fa-sync fa-spin text-primary"></i> Caricamento staff...</td></tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="card border-0 shadow-sm p-4">
            <h5 class="font-weight-bold text-primary mb-4 border-bottom pb-2">Registra Nuovo Personal Trainer</h5>
            <form id="formAggiungiPT" onsubmit="event.preventDefault(); inserisciNuovoPT();">
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label class="small font-weight-bold">Nome</label>
                        <input type="text" id="nomePT" class="form-control" required>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="small font-weight-bold">Cognome</label>
                        <input type="text" id="cognomePT" class="form-control" required>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="small font-weight-bold">Data di Nascita</label>
                        <input type="date" id="dataNascitaPT" class="form-control" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="small font-weight-bold">Email</label>
                        <input type="email" id="emailPT" class="form-control" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="small font-weight-bold">Password</label>
                        <input type="password" id="passPT" class="form-control" required>
                    </div>
                </div>
                <div class="text-center">
                    <button type="submit" class="btn  shadow-sm" style="background-color: #4e73df; color: white">
                        <i class="fas fa-user-plus mr-1"></i> Aggiungi allo Staff
                    </button>
                </div>
            </form>
        </div>
    </div>`;

      $('#areaContenutoAdmin').html(html);
      gestisciTabAttivoAdmin('Gestione Personal Trainer');

      // Popolamento tabella tramite la servlet specifica per i PT [cite: 2026-01-23]
      popolaTabellaPT();
    }

    /**
     * Utilizza GetTuttiPTServlet (Mapping diretto campi Bean) [cite: 2026-01-23]
     */
    function popolaTabellaPT() {
      $.get('GetTuttiPTServlet', function(data) {
        var htmlTab = '';
        if (data && data.length > 0) {
          data.forEach(function(pt) {
            var nomeCompleto = pt.nome + ' ' + pt.cognome;


            htmlTab += `
                <tr>
                    <td class="align-middle">` + pt.nome + `</td>
                    <td class="align-middle">` + pt.cognome + `</td>
                    <td class="align-middle">` + pt.email + `</td>
                    <td class="align-middle">` + (pt.dataNascita || '--') + `</td>
                    <td class="text-center">
                        <button class="btn btn-danger btn-sm" onclick="confermaEliminaPT(` + pt.idPT + `, '` + nomeCompleto + `')">
                            <i class="fas fa-trash-alt"></i> Elimina
                        </button>
                    </td>
                </tr>`;
          });
        } else {
          htmlTab = `<tr><td colspan="5" class="text-center text-muted py-4">Nessun Personal Trainer trovato.</td></tr>`;
        }
        $('#corpoTabellaAdminPT').html(htmlTab);
      });
    }

    /**
     * Inserimento con nuovo campo DataNascita [cite: 2026-01-23]
     */
    function inserisciNuovoPT() {
      var dati = {
        nome: $('#nomePT').val(),
        cognome: $('#cognomePT').val(),
        email: $('#emailPT').val(),
        password: $('#passPT').val(),
        dataNascita: $('#dataNascitaPT').val()
      };

      $.post('AggiungiPTServlet', dati, function(res) {
        if (res === 'success') {
          alert('Personal Trainer registrato con successo!');
          caricaGestionePTAdmin();
        } else {
          alert('Errore durante l\'inserimento. Verificare i dati.');
        }
      });
    }

    function confermaEliminaPT(id, nomeCompleto) {
      if (confirm('Sei sicuro di voler rimuovere ' + nomeCompleto + ' dallo staff?')) {
        // Inviamo l'ID alla servlet che esegue la tua query deleteUtente(id) [cite: 2026-01-23]
        $.post('EliminaPersonalTrainerServlet', {idUtente: id}, function (response) {

          // La servlet restituisce l'oggetto eliminato come JSON [cite: 2026-01-22, 2026-01-23]
          if (response && !response.error) {
            alert('Il Personal Trainer ' + response.nome + ' ' + response.cognome + ' è stato eliminato con successo.');

            // Ricarichiamo la tabella specifica [cite: 2026-01-20]
            popolaTabellaPT();
          } else {
            alert('Errore: ' + (response.error || 'Impossibile completare l\'operazione.'));
          }
        }, 'json');
      }
    }

    /**
     * Utility: Stato attivo Tab
     */
    function gestisciTabAttivoAdmin(nomeTab) {
      $('#areaAdminTab .nav-link').each(function() {
        if ($(this).text().trim() === nomeTab) {
          $(this).addClass('active');
        } else {
          $(this).removeClass('active');
        }
      });
    }

    /**
     * Esempio caricamento dati KPI
     */
    function popolaKPIAdmin() {
      $.get('GetAdminKPIServlet', function(data) {
        $('#numUtentiAdmin').text(data.totUtenti);
        $('#numPTAdmin').text(data.totPT);
      });
    }
  </script>

</body>
</html>