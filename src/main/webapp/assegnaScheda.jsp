<%@ page import="DataAccessLayer.bean.Utente" %>
<%@ page import="DataAccessLayer.bean.Prenotazione" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DataAccessLayer.bean.PersonalTrainer" %>
<%@ page import="DataAccessLayer.sql.Connessione" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="DataAccessLayer.query.QuerySelect" %>
<%@ page import="DataAccessLayer.bean.ConsultareUtente" %>
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

    <title>Assegna Scheda</title>

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

        /* Contenitori per le liste */
        .selection-container {
            height: 400px;
            overflow-y: auto;
            border: 1px solid #dcdcdc;
            border-radius: 8px;
            background-color: #fff;
        }

        /* Elementi della lista */
        .list-item {
            padding: 15px;
            border-bottom: 1px solid #eee;
            cursor: pointer;
            transition: 0.2s;
            display: flex;
            flex-direction: column; /* Dispone icona e testo in verticale */
            align-items: center;    /* Centra orizzontalmente gli elementi */
            justify-content: center;/* Centra verticalmente */
            text-align: center;      /* Centra il testo */
        }

        .list-item i {
            font-size: 1.5rem;      /* Icona un po' più grande sopra il nome */
            margin-bottom: 8px;
            margin-right: 0 !important; /* Rimuoviamo il margine laterale */
        }

        .list-item:hover {
            background-color: #f8f9fc;
        }

        /* Stile per l'elemento selezionato */
        .list-item.selected {
            background-color: #eef5ff;
            border-left: 5px solid #1e73be;
            color: #1e73be;
            font-weight: bold;
        }

        /* Icona di ricerca negli input */
        .search-icon-inside {
            position: absolute;
            left: 25px;
            top: 50%;
            transform: translateY(-50%);
            color: #1e73be;
        }

        .search-input-padding {
            padding-left: 45px !important;
            border-radius: 20px !important;
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
                    <h1 class="h4 text-gray-900 font-weight-bold">Assegna Scheda</h1>
                </div>

                <form action="AssegnaSchedaServlet" method="POST" id="formAssegna">
                    <input type="hidden" name="IdUtente" id="IdUtente" value="" required>
                    <input type="hidden" name="IdScheda" id="IdScheda" value="" required>

                    <div class="row">
                        <div class="col-md-6 mb-4">
                            <div class="card shadow border-0">
                                <div class="card-body">
                                    <div class="position-relative mb-3">
                                        <i class="fas fa-search search-icon-inside"></i>
                                        <input type="text" class="form-control search-input-padding"
                                               id="searchUtente" placeholder="Cerca Utente..." onkeyup="filtraUtenti()">
                                    </div>
                                    <h6 class="font-weight-bold text-our-blu mb-2">Lista Utenti</h6>
                                    <div id="containerUtenti" class="selection-container">
                                        <p class="text-center p-4">Caricamento utenti...</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6 mb-4">
                            <div class="card shadow border-0">
                                <div class="card-body">
                                    <div class="position-relative mb-3">
                                        <i class="fas fa-search search-icon-inside"></i>
                                        <input type="text" class="form-control search-input-padding"
                                               id="searchScheda" placeholder="Cerca Scheda..." onkeyup="filtraSchede()">
                                    </div>
                                    <h6 class="font-weight-bold text-our-blu mb-2">Lista Schede</h6>
                                    <div id="containerSchede" class="selection-container">
                                        <p class="text-center p-4">Caricamento schede...</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-4 offset-md-4">
                            <button type="submit" class="btn btn-our btn-block shadow font-weight-bold">
                                Assegna
                            </button>
                        </div>
                    </div>
                </form>
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
        let utentiGlobal = [];
        let schedeGlobal = [];

        $(document).ready(function() {
            caricaDatiAssegnazione();
        });

        function caricaDatiAssegnazione() {
            // 1. Carica Utenti
            $.post('GetTuttiUtentiServlet', function(data) {
                utentiGlobal = data;
                mostraUtenti(utentiGlobal);
            });

            // 2. Carica Schede
            $.get('GetTutteSchedeServlet', function(data) {
                schedeGlobal = data;
                mostraSchede(schedeGlobal);
            });
        }

        // Visualizzazione Utenti
        function mostraUtenti(lista) {
            const container = $('#containerUtenti');
            container.empty();

            // Se la lista è vuota dopo il filtro, mostriamo un messaggio
            if (lista.length === 0) {
                container.append(`
            <div class="p-4 text-center text-muted">
                Non ci sono utenti che hanno richiesto il servizio.
            </div>
        `);
                return;
            }

            lista.forEach(u => {
                container.append(`
            <div class="list-item" onclick="selezionaUtente(this, '` + u.idUtente + `')">
                <i class="fas fa-user-circle mr-3"></i>
                <div>
                    ` + u.nome + ` ` + u.cognome + `
                    <br><small class="text-muted">` + u.email + `</small>
                </div>
            </div>
        `);
            });
        }

        // Visualizzazione Schede
        function mostraSchede(lista) {
            const container = $('#containerSchede');
            container.empty();

            // Se la lista è vuota dopo il filtro, mostriamo un messaggio
            if (lista.length === 0) {
                container.append(`
            <div class="p-4 text-center text-muted">
                Tutte le schede sono già state assegnate a questo utente.
            </div>
        `);
                return;
            }

            lista.forEach(s => {
                container.append(`
            <div class="list-item" onclick="selezionaScheda(this, '` + s.idScheda + `')">
                <i class="fas fa-file-invoice"></i>
                <div class="w-100">
                    <span class="d-block font-weight-bold">` + s.nome + `</span>
                    <small class="text-muted">Obiettivo: ` + s.obiettivo + `</small>
                </div>
            </div>
        `);
            });
        }

        // Gestione selezione Utente
        function selezionaUtente(element, id) {
            // Gestione estetica della selezione utente
            $('#containerUtenti .list-item').removeClass('selected');
            $(element).addClass('selected');
            $('#IdUtente').val(id);

            // Chiamata AJAX per recuperare gli ID delle schede già assegnate a questo utente
            $.post('GetSchedeGiaAssegnateServlet?idUtente=' + id, function(idsGiaAssegnati) {

                // Filtriamo la lista globale delle schede (schedeGlobal)
                // Teniamo solo quelle il cui IdScheda NON è presente nell'array ricevuto
                const schedeDisponibili = schedeGlobal.filter(function(scheda) {
                    // Se l'id della scheda non è contenuto nella lista di quelle già assegnate
                    return !idsGiaAssegnati.includes(scheda.idScheda);
                });

                // Ricarichiamo la lista visiva delle schede con quelle filtrate
                mostraSchede(schedeDisponibili);

                // Resettiamo l'eventuale selezione precedente della scheda
                $('#IdScheda').val('');
            });
        }

        // Gestione selezione Scheda
        function selezionaScheda(element, id) {
            // Rimuove la classe 'selected' da tutte le schede e la aggiunge a quella cliccata
            $('#containerSchede .list-item').removeClass('selected');
            $(element).addClass('selected');

            // Inserisce l'ID nell'input hidden del form
            $('#IdScheda').val(id);
        }

        // Filtri di ricerca
        function filtraUtenti() {
            const query = $('#searchUtente').val().toLowerCase();
            const filtrati = utentiGlobal.filter(u =>
                (u.nome + " " + u.cognome).toLowerCase().includes(query)
            );
            mostraUtenti(filtrati);
        }

        function filtraSchede() {
            const query = $('#searchScheda').val().toLowerCase();
            const filtrati = schedeGlobal.filter(s =>
                s.nome.toLowerCase().includes(query)
            );
            mostraSchede(filtrati);
        }
    </script>
</div>
</body>
</html>