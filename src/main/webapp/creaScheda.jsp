<%@ page import="DataAccessLayer.bean.Utente" %>
<%@ page import="DataAccessLayer.bean.Prenotazione" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DataAccessLayer.bean.PersonalTrainer" %>
<%@ page import="DataAccessLayer.bean.ConsultareUtente" %>
<%@ page import="DataAccessLayer.sql.Connessione" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="DataAccessLayer.query.QuerySelect" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
  PersonalTrainer pt = (PersonalTrainer) session.getAttribute("personalTrainer");

  Connessione c = new Connessione();
  Connection conn = c.connessione();
  QuerySelect querySelect = new QuerySelect(conn);

  ArrayList<ConsultareUtente> richieste = new ArrayList<>();
  try {
    richieste  = querySelect.selectRichiestePT(pt.getIdPT());
  } catch (SQLException e) {
    throw new RuntimeException(e);
  }

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

  <title>Crea Scheda</title>

  <!-- Custom fonts for this template-->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <!-- Custom styles for this template-->
  <link href="css/sb-admin-2.css" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

  <style>
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

    /* Stile per le Tab dei Giorni */
    .nav-days .nav-link {
      background-color: #fff;
      border: 1px solid #333 !important;
      color: #333;
      border-radius: 0;
      margin-right: -1px;
      font-weight: bold;
      padding: 10px 40px;
    }

    .nav-days .nav-link.active {
      background-color: #1e73be !important; /* Grigio come nel mockup */
      color: #ffffff   !important;
    }

    /* Etichetta numerica sopra lo slot */
    .exercise-number-tag {
      color: #1e73be;
      font-weight: bold;
      display: flex;
      margin-bottom: 8px; /* Spazio tra il tag e il box dell'esercizio */
      font-size: 0.85rem;
    }

    /* Margine inferiore per separare le righe della griglia */
    .exercise-col {
      margin-bottom: 5px;
    }

    /* Griglia Esercizi */
    .exercise-slot {
      border: 1px solid #333;
      display: flex;
      min-height: 120px;
      background-color: #f8f9fc;
      margin-bottom: 20px;
      transition: 0.3s;
    }

    .slot-add {
      flex: 1;
      border-right: 1px solid #333;
      display: flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      font-size: 1.5rem;
      color: #333;
    }

    .slot-add:hover { background-color: #e2e6ea; }

    .slot-text {
      flex: 1;
      padding: 15px;
      display: flex;
      flex-direction: column;
      justify-content: center;
    }

    .label-tag-sm {
      color: #1e73be;
      font-weight: bold;
      display: inline-block;
      margin-bottom: 5px;
      font-size: 1.5rem;
    }

    .label-tag {
      color: #1e73be;
      font-weight: bold;
      display: inline-block;
      margin-bottom: 8px;
      font-size: 0.85rem;
    }

    /* Pulsante per aggiungere una nuova riga */
    .add-row-container {
      border: 2px dashed #dcdcdc;
      padding: 20px;
      text-align: center;
      cursor: pointer;
      transition: 0.3s;
      margin-bottom: 20px;
    }

    .add-row-container:hover {
      background-color: #f8f9fc;
      border-color: #1e73be;
      color: #1e73be;
    }

    .add-row-container i {
      font-size: 1.5rem;
      display: block;
      margin-bottom: 5px;
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
              <%
                if(richieste.isEmpty()){

              %>
              <span class="badge badge-danger badge-counter"></span>

              <%
              }else {
              %>
              <span class="badge badge-danger badge-counter"><%=richieste.size()%><i class="fa-solid fa-circle-plus"></i></span>
              <%
                }
              %>
            </a>
            <!-- Dropdown - Messages -->
            <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                 aria-labelledby="messagesDropdown">
              <h6 class="dropdown-header">
                Message Center
              </h6>
              <%
                if(!(richieste.isEmpty())){
                  for(ConsultareUtente s : richieste){
              %>

              <a class="dropdown-item d-flex align-items-center"
                 href="AggiornaStatoRichiestaServlet?idUtente=<%=s.getIdUtente()%>&idRichiesta=<%=s.getIdRichiesta()%>">
                <div class="mr-3">
                  <div class="icon-circle bg-success">
                    <i class="fa-solid fa-circle-check text-white"></i>
                  </div>
                </div>
                <div>
                  <%=s.getNome() + " " + s.getCognome() + " ha richiesto una tua consultazione su " + s.getObiettivo() + "."%>
                </div>
              </a>

              <%
                  }
                }
              %>
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
              <a class="dropdown-item" href="areaPersonalePT.jsp">
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
          <h1 class="h4 text-gray-900 font-weight-bold">Crea Scheda</h1>
        </div>

        <div class="card o-hidden border-0 shadow-lg mb-5">
          <div class="card-body">

            <form class="user" action="SalvaSchedaServlet" method="post">

              <div class="row mb-4">
                <div class="col-md-4">
                  <span class="label-tag">Nome Scheda</span>
                  <input type="text" class="form-control bg-gray-100 form-control-user" style="border-radius: 12px !important; color: black" name="Nome" id="Nome" placeholder="Es. Massa" required>
                </div>
                <div class="col-md-4">
                  <span class="label-tag">Obiettivo</span>
                  <input type="text" class="form-control bg-gray-100 form-control-user" style="border-radius: 12px !important; color: black" name="Obiettivo" id="Obiettivo" placeholder="Es. Ipertrofia" required>
                </div>
                <div class="col-md-4">
                  <span class="label-tag">Durata (Settimane)</span>
                  <input type="number" class="form-control bg-gray-100 form-control-user" style="border-radius: 12px !important; color: black" name="Durata" id="Durata" placeholder="Es. 6" required>
                </div>
              </div>

              <hr class="sidebar-divider my-4" style="background: #1e73be;">

              <ul class="nav nav-days mb-4" id="pills-tab" role="tablist">
                <li class="nav-item">
                  <a class="nav-link active" id="giorno1-tab" data-toggle="pill" href="#giorno1">Giorno 1</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" id="giorno2-tab" data-toggle="pill" href="#giorno2">Giorno 2</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" id="giorno3-tab" data-toggle="pill" href="#giorno3">Giorno 3</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="javascript:void(0)" onclick="aggiungiGiorno()" style="padding: 10px 20px;">+</a>
                </li>
              </ul>

              <div class="tab-content" id="pills-tabContent">

                <% for(int g=1; g<=3; g++) { %>
                <div class="tab-pane fade <%= (g==1) ? "show active" : "" %>" id="giorno<%=g%>">
                  <div class="row exercise-grid">
                    <div class="col-md-6 exercise-col">
                      <span class="exercise-number-tag">Esercizio 1</span>
                      <div class="exercise-slot">
                        <input type="hidden" name="idEsercizio" class="id-esercizio-field" value="">
                        <input type="hidden" name="giornoScheda" class="giorno-field" value="<%=g%>">                        <div class="slot-add" onclick="apriModalEsercizi(1)"><i class="fas fa-plus"></i></div>
                        <div class="slot-text">
                          <span class="label-tag-sm">Descrizione</span>
                          <small class="text-muted">Seleziona esercizio</small>
                        </div>
                      </div>
                    </div>
                    <div class="col-md-6 exercise-col">
                      <span class="exercise-number-tag">Esercizio 2</span>
                      <div class="exercise-slot">
                        <div class="slot-add" onclick="apriModalEsercizi(2)"><i class="fas fa-plus"></i></div>
                        <div class="slot-text">
                          <span class="label-tag-sm">Descrizione</span>
                          <small class="text-muted">Seleziona esercizio</small>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="add-row-container" onclick="aggiungiNuovaRiga()">
                    <i class="fas fa-plus-circle"></i> <b>Aggiungi riga esercizi</b>
                  </div>
                </div>
                <% } %>
                </div>

              <hr class="sidebar-divider my-0" style="background: #1e73be;">

              <div class="row">
                <div class="col-md-4 offset-md-4">
                  <button type="submit" class="btn btn-our btn-block shadow font-weight-bold mt-4" style="padding: 0.75rem 1rem;">Salva</button>
                </div>
              </div>

              <div class="modal fade" id="modalEsercizi" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                  <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                      <h5 class="modal-title" id="modalLabel">Seleziona Esercizio</h5>
                      <button class="close text-white" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                      </button>
                    </div>
                    <div class="modal-body">
                      <div id="listaEserciziContainer" style="max-height: 450px; overflow-y: auto;">
                      </div>
                    </div>
                    <div class="modal-footer">
                      <button class="btn btn-secondary" type="button" data-dismiss="modal">Annulla</button>
                    </div>
                  </div>
                </div>
              </div>

              <input type="hidden" id="currentSlotId">

            </form>
          </div>
        </div>
      </div>
      <!-- End of Main Content -->
    </div>
    <!-- End of Content Wrapper -->
  </div>
</div>
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

  <!-- jQuery (OBBLIGATORIO) -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  <!-- Bootstrap Bundle (include Popper.js) -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

  <!-- jQuery Easing (necessario per easeInOutExpo) -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="js/sidebar.js"></script>

<script>
  let dayCounter = 3;
  let mappaAssegnazioni = {}; // { "giorno1": {1: "NomeEx"}, "giorno2": {} }

  function getGiornoAttivo() {
    return $('.tab-pane.active').attr('id');
  }

  // APERTURA MODAL
  function apriModalEsercizi(slotId) {
    $('#currentSlotId').val(slotId);
    $('#modalEsercizi').modal('show');

    $.ajax({
      url: 'GetTuttiEserciziServlet',
      type: 'POST',
      success: function(data) {
        mostraEsercizi(data);
      }
    });
  }

  // VISUALIZZAZIONE E FILTRO (Per giorno)
  function mostraEsercizi(lista) {
    const container = $('#listaEserciziContainer');
    const slotId = $('#currentSlotId').val();
    const giornoId = getGiornoAttivo();
    container.empty();

    const occupatiGiorno = mappaAssegnazioni[giornoId] || {};
    const nomiOccupati = Object.keys(occupatiGiorno)
            .filter(id => id !== slotId)
            .map(id => occupatiGiorno[id]);

    const filtrati = lista.filter(ex => !nomiOccupati.includes(ex.nome));

    filtrati.forEach(ex => {
      container.append(`
        <div class="esercizio-item d-flex align-items-center"
            onclick="selezionaEsercizio('` + ex.nome + `', '` + ex.contenutoMultimediale + `', '` + ex.gruppoMuscolare + `', '` + ex.idEsercizio + `', '` + ex.serie + `', '` + ex.ripetizione + `')">
            <img src="`+ex.contenutoMultimediale+`">
            <div>
                <b>`+ex.nome+`</b><br>
                <small class="text-muted">`+ex.gruppoMuscolare+`</small>
                <br>
                <small class="font-weight-bold">` + ex.serie + ` x ` + ex.ripetizione + `</small>
            </div>
        </div>
    `);
    });
  }

  // SELEZIONE
  function selezionaEsercizio(nome, url, gruppo, idEs, serie, ripetizioni) {
    const slotId = $('#currentSlotId').val();
    const giornoId = getGiornoAttivo();

    if (!mappaAssegnazioni[giornoId]) mappaAssegnazioni[giornoId] = {};
    mappaAssegnazioni[giornoId][slotId] = nome;

    const slot = $('#' + giornoId).find('.exercise-col').filter(function() {
      return $(this).find('.exercise-number-tag').text() === 'Esercizio ' + slotId;
    });

    // 1. Popoliamo l'ID dell'esercizio nel campo hidden specifico
    slot.find('.id-esercizio-field').val(idEs);

    // Nota: Il campo '.giorno-field' è già popolato dal ciclo JSP
    // ma se hai creato lo slot dinamicamente con JS, assicurati di settarlo:
    if(slot.find('.giorno-field').val() === "") {
      slot.find('.giorno-field').val(giornoId.replace('giorno', ''));
    }

    // 2. Aggiorniamo l'aspetto visivo (Immagine)
    slot.find('.slot-add').html('<img src="' + url + '" style="width:100%; height:100%; object-fit:cover;">');

    // 3. Aggiorniamo il testo (Nome, Gruppo, Serie e Ripetizioni)
    slot.find('.slot-text').html(`
        <span class="label-tag-sm">` + gruppo + `</span>
        <strong class="text-dark d-block">` + nome + `</strong>
        <div class="mt-2">
            <span class="badge badge-light text-dark">` + serie + ` Serie</span>
            <span class="badge badge-light text-dark">` + ripetizioni + ` Ripetizioni</span>
        </div>
    `);

    $('#modalEsercizi').modal('hide');
  }

  // AGGIUNGI RIGA (2 nuovi esercizi)
  function aggiungiNuovaRiga() {
    const giornoId = getGiornoAttivo(); // Es. "giorno1"
    const numeroGiorno = giornoId.replace('giorno', ''); // Estrae solo il numero (es. "1")
    const grid = $('#' + giornoId).find('.exercise-grid');
    let count = grid.find('.exercise-col').length;

    for (let i = 0; i < 2; i++) {
      count++;
      grid.append(`
          <div class="col-md-6 exercise-col animated--fadeIn">
              <span class="exercise-number-tag">` + "Esercizio " + count + `</span>
              <div class="exercise-slot">

                  <input type="hidden" name="idEsercizio" class="id-esercizio-field" value="">

                  <input type="hidden" name="giornoScheda" class="giorno-field" value="` + numeroGiorno + `">

                  <div class="slot-add" onclick="apriModalEsercizi(` + count + `)">
                      <i class="fas fa-plus"></i>
                  </div>
                  <div class="slot-text">
                      <span class="label-tag-sm">Descrizione</span><br>
                      <small class="text-muted">Seleziona esercizio</small>
                  </div>
              </div>
          </div>
      `);
    }
  }

  // AGGIUNGI NUOVO GIORNO (Inizializzato con 1 riga da 2 esercizi)
  function aggiungiGiorno() {
    dayCounter++;
    const id = "giorno" + dayCounter;

    // 1. Aggiunge il nuovo Tab alla lista
    const nuovaTab = `
      <li class="nav-item">
          <a class="nav-link" id="` + id + `-tab" data-toggle="pill" href="#` + id + `">` + "Giorno " + dayCounter + `</a>
      </li>`;
    $(nuovaTab).insertBefore($('#pills-tab li:last-child'));

    // 2. Aggiunge il Pane di contenuto con i campi hidden necessari
    const nuovoContenuto = `
      <div class="tab-pane fade" id="` + id + `">
          <div class="row exercise-grid">

              <div class="col-md-6 exercise-col">
                  <span class="exercise-number-tag">Esercizio 1</span>
                  <div class="exercise-slot">
                      <input type="hidden" name="idEsercizio" class="id-esercizio-field" value="">
                      <input type="hidden" name="giornoScheda" class="giorno-field" value="` + dayCounter + `">

                      <div class="slot-add" onclick="apriModalEsercizi(1)">
                          <i class="fas fa-plus"></i>
                      </div>
                      <div class="slot-text">
                          <span class="label-tag-sm">Descrizione</span><br>
                          <small class="text-muted">Seleziona esercizio</small>
                      </div>
                  </div>
              </div>

              <div class="col-md-6 exercise-col">
                  <span class="exercise-number-tag">Esercizio 2</span>
                  <div class="exercise-slot">
                      <input type="hidden" name="idEsercizio" class="id-esercizio-field" value="">
                      <input type="hidden" name="giornoScheda" class="giorno-field" value="` + dayCounter + `">

                      <div class="slot-add" onclick="apriModalEsercizi(2)">
                          <i class="fas fa-plus"></i>
                      </div>
                      <div class="slot-text">
                          <span class="label-tag-sm">Descrizione</span><br>
                          <small class="text-muted">Seleziona esercizio</small>
                      </div>
                  </div>
              </div>

          </div>

          <div class="add-row-container" onclick="aggiungiNuovaRiga()">
              <i class="fas fa-plus-circle"></i> <b>Aggiungi riga esercizi</b>
          </div>
      </div>`;

    $('#pills-tabContent').append(nuovoContenuto);

    // 3. Attiva automaticamente il nuovo giorno appena creato
    $('#' + id + '-tab').tab('show');
  }
</script>

</body>
</html>
