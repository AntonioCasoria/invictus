<%@ page import="java.util.ArrayList" %>
<%@ page import="DataAccessLayer.sql.Connessione" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="DataAccessLayer.query.QueryInsert" %>
<%@ page import="DataAccessLayer.query.QuerySelect" %>
<%@ page import="DataAccessLayer.bean.*" %>
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

    //ArrayList<String> prenotazioni = (ArrayList<String>) session.getAttribute("prenotazioni");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Area Personale Personal Trainer</title>

    <!-- Custom fonts for this template-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <style>
        /* --- Navigazione Tab PT (Mockup INV_MU_15) --- */
        #areaPTTab .nav-link {
            border-radius: 0;
            border: none;
            color: #4e73df;
            font-weight: bold;
            padding: 1rem;
            background-color: #f8f9fc;
            border-right: 1px solid #e3e6f0;
            transition: all 0.2s ease;
        }

        #areaPTTab .nav-link:hover {
            background-color: #eaecf4;
        }

        /* Lo stato active riflette il grigio del mockup [cite: 2026-01-20] */
        #areaPTTab .nav-link.active {
            background-color: #d1d3e2 !important;
            color: #3a3b45 !important;
            border-bottom: 3px solid #4e73df;
        }

        /* --- Container Scroll Orizzontale (Stile richiestaPt) --- */
        .container-schede-scroll {
            display: flex;
            overflow-x: auto; /* Abilita lo scorrimento orizzontale [cite: 2026-01-20] */
            gap: 1.25rem;
            padding: 1rem 0.5rem;
            scrollbar-width: thin;
            scrollbar-color: #4e73df #f8f9fc;
        }

        /* Personalizzazione scrollbar per browser Webkit (Chrome, Safari, Edge) */
        .container-schede-scroll::-webkit-scrollbar {
            height: 8px;
        }
        .container-schede-scroll::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 10px;
        }
        .container-schede-scroll::-webkit-scrollbar-thumb {
            background: #4e73df;
            border-radius: 10px;
        }

        /* --- Mini Cards delle Schede --- */
        .card-scheda-mini {
            flex: 0 0 180px; /* Dimensione fissa per permettere lo scroll [cite: 2026-01-20] */
            background: white;
            border: 1px solid #e3e6f0;
            border-radius: 12px;
            padding: 1.25rem;
            text-align: center;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s, border-color 0.2s;
        }

        .card-scheda-mini:hover {
            transform: translateY(-4px);
            border-color: #4e73df;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .card-scheda-mini i {
            font-size: 1.8rem;
            margin-bottom: 0.5rem;
        }

        .nome-scheda {
            font-weight: 700;
            color: #3a3b45;
            font-size: 0.85rem;
            line-height: 1.2;
        }

        .data-scheda {
            font-size: 0.75rem;
            color: #858796;
            margin-top: 0.25rem;
        }

        /* --- Lista Atleti (Colonna Sinistra) --- */
        #listaAtletiPT .list-group-item {
            transition: background-color 0.2s;
            border-radius: 8px !important;
            margin-bottom: 5px;
        }

        #listaAtletiPT .list-group-item:hover {
            background-color: #eaecf4 !important;
            color: #4e73df;
        }

        /* --- Utility e Animazioni --- */
        .animated--fade-in {
            animation: fadeIn 0.4s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Gestione errori e modali [cite: 2026-01-20] */
        .modal-error-text {
            color: #e74a3b;
            font-weight: bold;
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
            <div class="container-fluid">

                <div class="mb-4">
                    <h1 class="h4 text-gray-900 font-weight-bold text-center">Dashboard Personal Trainer</h1>
                </div>

                <div class="card shadow mb-4">
                    <div class="card-header p-0">
                        <ul class="nav nav-tabs nav-justified" id="areaPTTab" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" data-toggle="tab" href="#contentPT" onclick="caricaDashboardPT()">
                                    Dashboard
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" data-toggle="tab" href="#contentPT" onclick="caricaGestioneUtenti()">
                                    Gestione Utenti
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" data-toggle="tab" href="#contentPT" onclick="caricaArchivioSchedePT()">
                                    Archivio Schede
                                </a>
                            </li>
                        </ul>
                    </div>

                    <div class="card-body">
                        <div id="areaContenutoPT" class="p-2 animated--fade-in">
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
         * Inizializzazione al caricamento della pagina [cite: 2026-01-20]
         */
        $(document).ready(function() {
            caricaDashboardPT();
        });

        /**
         * 1. DASHBOARD PT - Layout a 2 Colonne (4/8) [cite: 2026-01-20]
         */
        function caricaDashboardPT() {
            var html = `
        <div class="row pt-2 animated--fade-in">
            <div class="col-lg-4">
                <div class="card bg-gray-100 border-0 h-100 shadow-sm">
                    <div class="card-body">
                        <div class="input-group mb-3 shadow-sm">
                            <input type="text" class="form-control border-0 small" placeholder="Cerca atleti...">
                        </div>
                        <h6 class="font-weight-bold text-gray-800 mb-3 border-bottom pb-2">I miei Atleti</h6>
                        <div id="listaAtletiPT" class="list-group list-group-flush rounded shadow-sm">
                            <div class="p-4 text-center text-muted small">Caricamento in corso...</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-8">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-header bg-white py-3 border-0 text-center">
                        <h6 id="titoloColonnaCentrale" class="m-0 font-weight-bold text-primary text-uppercase">Schede Assegnate</h6>
                    </div>
                    <div class="card-body">
                        <div id="feedAttivita" class="d-flex flex-column align-items-center justify-content-center h-100">
                            <i class="fas fa-user-check fa-3x mb-3 text-gray-200"></i>
                            <p class="text-muted small text-center">Seleziona un atleta a sinistra per visualizzare le sue schede attive.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>`;

            $('#areaContenutoPT').html(html);
            gestisciTabAttivoPT('Dashboard');
            popolaListaAtleti();
        }

        /**
         * Popola la lista atleti (GetTuttiUtentiServlet) [cite: 2026-01-21, 2026-01-22]
         */
        function popolaListaAtleti() {
            $.get('GetTuttiUtentiServlet', function(data) {
                var htmlAtleti = '';
                if (data && data.length > 0) {
                    data.forEach(function(atleta) {
                        var nomeCompleto = atleta.nome + ' ' + atleta.cognome;
                        htmlAtleti += `
                    <button onclick="caricaSchedeAssegnate(` + atleta.idUtente + `, '` + nomeCompleto + `')"
                       class="list-group-item list-group-item-action border-0 small py-3 bg-transparent d-flex justify-content-between align-items-center">
                        <span><i class="fas fa-user-circle mr-2 text-primary"></i><strong>` + nomeCompleto + `</strong></span>
                        <i class="fas fa-chevron-right text-gray-400"></i>
                    </button>`;
                    });
                } else {
                    htmlAtleti = `<div class="p-3 text-center text-muted small">Nessun atleta associato trovato.</div>`;
                }
                $('#listaAtletiPT').html(htmlAtleti);
            });
        }

        /**
         * Carica le schede dell'atleta selezionato [cite: 2026-01-20, 2026-01-21]
         */
        function caricaSchedeAssegnate(idUtente, nomeAtleta) {
            $('#titoloColonnaCentrale').text('Schede di ' + nomeAtleta);
            $('#feedAttivita').html('<div class="text-center py-5"><i class="fas fa-spinner fa-spin fa-2x text-primary"></i></div>');

            $.get('GetSchedeAssegnateUtenteServlet', { idUtente: idUtente }, function(data) {
                var htmlSchede = '';
                if (data && data.length > 0) {
                    htmlSchede += `<div class="container-schede-scroll w-100">`;
                    data.forEach(function(scheda) {
                        htmlSchede += `
                    <div class="card-scheda-mini shadow-sm" onclick="caricaDettagliScheda(` + scheda.IdScheda + `)">
                        <i class="fas fa-file-invoice mb-2 text-primary"></i>
                        <div class="nome-scheda text-truncate">` + scheda.Nome + `</div>
                        <div class="data-scheda small">` + scheda.Obiettivo + `</div>
                    </div>`;
                    });
                    htmlSchede += `</div><div id="containerDettaglioScheda" class="mt-4 w-100 animated--fade-in"></div>`;
                } else {
                    htmlSchede = `<div class="text-muted small text-center py-5">L'atleta non ha schede assegnate.</div>`;
                }
                $('#feedAttivita').removeClass('justify-content-center').html(htmlSchede);
            });
        }

        /**
         * Carica tabella esercizi via JSON (GetSchedaEserciziUtenteServlet) [cite: 2026-01-21, 2026-01-22]
         */
        function caricaDettagliScheda(idScheda) {
            var detailContainer = $('#containerDettaglioScheda');
            detailContainer.html('<div class="text-center py-3"><i class="fas fa-sync fa-spin fa-2x text-primary"></i></div>');

            $.get('GetSchedaEserciziUtenteServlet', { idScheda: idScheda }, function(response) {
                var esercizi = response.esercizi;
                var html = '';
                if (esercizi && esercizi.length > 0) {
                    html += `
                <div class="table-responsive mt-3">
                    <table class="table table-bordered table-hover shadow-sm bg-white">
                        <thead class="bg-primary text-white">
                            <tr><th class="text-center">Giorno</th><th>Esercizio</th><th>Gruppo</th><th class="text-center">Serie</th><th class="text-center">Reps</th></tr>
                        </thead>
                        <tbody>`;
                    esercizi.forEach(function(ex) {
                        html += `
                            <tr>
                                <td class="text-center font-weight-bold">` + ex.giorno + `</td>
                                <td class="font-weight-bold"><i class="fas fa-dumbbell mr-2 text-gray-300"></i>` + ex.nome + `</td>
                                <td><span class="badge badge-light border">` + ex.gruppo + `</span></td>
                                <td class="text-center text-primary font-weight-bold">` + ex.serie + `</td>
                                <td class="text-center">` + ex.ripetizioni + `</td>
                            </tr>`;
                    });
                    html += `</tbody></table></div>`;
                } else {
                    html = `<div class="alert alert-info text-center">Nessun esercizio presente in questa scheda.</div>`;
                }
                detailContainer.hide().html(html).fadeIn(400);
            });
        }

        /**
         * 2. GESTIONE UTENTI - Tabella Anagrafica [cite: 2026-01-20, 2026-01-22]
         */
        function caricaGestioneUtenti() {
            var htmlStruttura = `
            <div class="card border-0 shadow-sm p-4 animated--fade-in">
                <h5 class="font-weight-bold text-gray-800 mb-4 border-bottom pb-2">Gestione Clienti</h5>
                <div class="table-responsive">
                    <table class="table table-hover bg-white shadow-sm border rounded">
                        <thead class="bg-gray-200 text-gray-800">
                            <tr><th>Nome</th><th>Cognome</th><th class="text-center">Azioni</th></tr>
                        </thead>
                        <tbody id="corpoTabellaUtenti">
                            <tr><td colspan="3" class="text-center py-4"><i class="fas fa-spinner fa-spin text-primary"></i> Caricamento...</td></tr>
                        </tbody>
                    </table>
                </div>
            </div>`;

            $('#areaContenutoPT').html(htmlStruttura);
            gestisciTabAttivoPT('Gestione Utenti');

            $.get('GetTuttiUtentiServlet', function(data) {
                var htmlTab = '';
                data.forEach(function(u) {
                    var nomeComp = u.nome + ' ' + u.cognome;
                    htmlTab += `<tr><td>` + u.nome + `</td><td>` + u.cognome + `</td><td class="text-center">
                    <button class="btn btn-outline-primary btn-sm" onclick="caricaSchedeAssegnate(` + u.idUtente + `, '` + nomeComp + `')">
                    <i class="fas fa-search-plus"></i></button></td></tr>`;
                });
                $('#corpoTabellaUtenti').html(htmlTab);
            });
        }

        /**
         * 3. ARCHIVIO SCHEDE - Utilizza GetTutteSchedeServlet [cite: 2026-01-22]
         */
        function caricaArchivioSchedePT() {
            var htmlBase = `
            <div class="card border-0 shadow-sm p-4 animated--fade-in">
                <h5 class="font-weight-bold text-gray-800 mb-4 border-bottom pb-2">Archivio Modelli Schede</h5>
                <div id="contenitoreArchivioSchede" class="d-flex flex-column align-items-center">
                    <i class="fas fa-spinner fa-spin fa-2x text-primary py-5"></i>
                </div>
            </div>`;

            $('#areaContenutoPT').html(htmlBase);
            gestisciTabAttivoPT('Archivio Schede');

            // Utilizziamo la tua nuova servlet JSON [cite: 2026-01-22]
            $.get('GetTutteSchedeServlet', function(data) {
                var htmlContenuto = '';
                if (data && data.length > 0) {
                    htmlContenuto += `<div class="container-schede-scroll w-100">`;
                    data.forEach(function(s) {
                        // Mappatura campi dell'oggetto SchedaAllenamento
                        htmlContenuto += `
                    <div class="card-scheda-mini shadow-sm" onclick="caricaDettagliScheda(` + s.idScheda + `)">
                        <i class="fas fa-copy mb-2 text-info"></i>
                        <div class="nome-scheda text-truncate">` + s.nome + `</div>
                        <div class="data-scheda small">` + s.obiettivo + `</div>
                    </div>`;
                    });
                    htmlContenuto += `</div><div id="containerDettaglioScheda" class="mt-4 w-100"></div>`;
                } else {
                    htmlContenuto = `<div class="p-5 text-center text-muted">Non hai ancora creato modelli di scheda.</div>`;
                }
                $('#contenitoreArchivioSchede').html(htmlContenuto);
            });
        }

        /**
         * Utility per la navigazione [cite: 2026-01-20]
         */
        function gestisciTabAttivoPT(nomeTab) {
            $('#areaPTTab .nav-link').each(function() {
                if ($(this).text().trim() === nomeTab) {
                    $(this).addClass('active');
                } else {
                    $(this).removeClass('active');
                }
            });
        }
    </script>

</body>
</html>