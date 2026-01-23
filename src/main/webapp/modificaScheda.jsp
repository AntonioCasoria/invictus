<%@ page import="DataAccessLayer.bean.Utente" %>
<%@ page import="DataAccessLayer.bean.Prenotazione" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DataAccessLayer.bean.PersonalTrainer" %>
<%@ page import="DataAccessLayer.sql.Connessione" %>
<%@ page import="DataAccessLayer.query.QuerySelect" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="DataAccessLayer.bean.ConsultareUtente" %>
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

    <title>Modifica Scheda</title>

    <!-- Custom fonts for this template-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <style>
        .exercise-col {
            position: relative; /* Necessario per il posizionamento assoluto dell'icona */
        }

        .delete-exercise-btn {
            position: absolute;
            top: -5px;
            right: 10px;
            font-size: 1.2rem;
            color: #e74a3b; /* Rosso Bootstrap */
            cursor: pointer;
            z-index: 10;
            transition: transform 0.2s;
            background: white;
            border-radius: 50%;
        }

        .delete-exercise-btn:hover {
            transform: scale(1.2);
            color: #be2617;
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

        /* Ogni utente appare ora come una card separata */
        .list-item {
            padding: 15px;
            border: 1px solid #e3e6f0; /* Bordo grigio chiaro intorno */
            border-radius: 12px;        /* Angoli molto smussati */
            margin-bottom: 12px;       /* Spazio (divisorio) tra gli utenti */
            background-color: #fff;
            cursor: pointer;
            transition: all 0.2s ease-in-out;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
        }

        /* Effetto al passaggio del mouse */
        .list-item:hover {
            border-color: #1e73be;
            background-color: #f8f9fc;
            transform: translateY(-2px); /* Leggero sollevamento */
            box-shadow: 0 4px 8px rgba(0,0,0,0.05);
        }

        /* Stile quando l'utente è selezionato */
        .list-item.selected {
            background-color: #eef5ff;
            border: 2px solid #1e73be !important; /* Bordo blu più spesso */
            color: #1e73be;
        }

        /* Contenitore per Lista Utenti e Lista Schede */
        .selection-container {
            height: 150px;      /* Altezza massima richiesta */
            overflow-y: auto;   /* Scroll verticale attivo */
            overflow-x: hidden;
            padding: 8px;
            border: 1px solid #e3e6f0;
            border-radius: 8px;
        }

        /* Box specifico per la Richiesta Utente */
        #boxRichieste {
            height: 150px;      /* Allineato agli altri due box */
            background-color: #fff;
            overflow-y: auto;   /* Permette di leggere richieste lunghe in poco spazio */
            font-size: 0.9rem;  /* Testo leggermente più piccolo per la leggibilità */
        }

        /* Ottimizzazione card interne per spazio ridotto */
        .selection-container .list-item {
            margin-bottom: 6px; /* Meno spazio tra le card */
        }

        .selection-container .list-item i {
            font-size: 1.2rem;  /* Icone ridimensionate */
            margin-bottom: 4px;
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
            <div class="container-fluid">

                <div class="mb-4">
                    <h1 class="h4 text-gray-900 font-weight-bold">Modifica Scheda</h1>
                </div>

                <div class="row mb-4">

                    <div class="col-md-4">
                        <div class="card shadow border-0 h-100">
                            <div class="card-body">
                                <h6 class="font-weight-bold text-primary mb-3">Cerca Utente</h6>
                                <div class="position-relative mb-3">
                                    <i class="fas fa-search search-icon-inside"></i>
                                    <input type="text" class="form-control search-input-padding"
                                           id="searchUtenteModifica" placeholder="Nome utente..." onkeyup="filtraUtentiModifica()">
                                </div>
                                <div id="containerUtentiModifica" class="selection-container">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="card shadow border-0 h-100">
                            <div class="card-body">
                                <h6 class="font-weight-bold text-primary mb-3">Cerca Scheda</h6>
                                <div class="position-relative mb-3">
                                    <i class="fas fa-search search-icon-inside"></i>
                                    <input type="text" class="form-control search-input-padding"
                                           id="searchSchedaUtente" placeholder="Nome scheda..." onkeyup="filtraSchedeUtente()">
                                </div>
                                <div id="containerSchedeUtente" class="selection-container">
                                    <div class="p-3 text-center small text-muted">Seleziona prima un utente</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="card shadow border-0 h-100">
                            <div class="card-body d-flex flex-column">
                                <h6 class="font-weight-bold text-primary mb-3">Richiesta Utente</h6>
                                <div id="boxRichieste" class="flex-grow-1" style="overflow-y: auto; max-height: 450px;">
                                    <span class="text-muted italic">Seleziona un utente per visualizzare la sua richiesta...</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card shadow border-0 mb-5" id="sezioneModifica" style="display: none;">
                    <div class="card-body p-4">
                        <h5 class="font-weight-bold text-dark mb-4">Esercizi in Scheda</h5>

                        <ul class="nav nav-pills mb-4" id="pills-tabModifica" role="tablist">
                        </ul>

                        <div class="tab-content" id="pills-tabContentModifica">
                        </div>

                        <div class="text-center">
                            <hr style="background: #1e73be;">
                            <button type="button" onclick="salvaModificheFinali()" class="btn btn-our px-5 shadow">
                                <i class="fas fa-save mr-2"></i> Salva Modifiche
                            </button>
                        </div>
                    </div>
                </div>
                <input type="hidden" id="currentSlotId" value="">

                <div class="modal fade" id="modalEsercizi" tabindex="-1" role="dialog" aria-labelledby="modalEserciziLabel">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header bg-primary text-white">
                                <h5 class="modal-title">Seleziona Esercizio</h5>
                                <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
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

                <div class="modal fade" id="successModal" tabindex="-1" role="dialog" aria-labelledby="successModalLabel">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content border-left-success shadow">
                            <div class="modal-header">
                                <h5 class="modal-title text-success font-weight-bold" id="successModalLabel">
                                    <i class="fas fa-check-circle mr-2"></i> Operazione Completata
                                </h5>
                                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">×</span>
                                </button>
                            </div>
                            <div class="modal-body text-gray-900">
                                La scheda allenamento è stata aggiornata con successo nel sistema.
                            </div>
                            <div class="modal-footer">
                                <button class="btn btn-success" type="button" onclick="window.location.reload()">OK</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal fade" id="errorModal" tabindex="-1" role="dialog" aria-labelledby="errorModalLabel">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content border-left-danger shadow">
                            <div class="modal-header">
                                <h5 class="modal-title text-danger font-weight-bold" id="errorModalLabel">
                                    <i class="fas fa-exclamation-triangle mr-2"></i> Errore
                                </h5>
                                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">×</span>
                                </button>
                            </div>
                            <div class="modal-body text-gray-900">
                                Si è verificato un problema durante il salvataggio della scheda. Riprova più tardi o contatta l'amministratore.
                            </div>
                            <div class="modal-footer">
                                <button class="btn btn-secondary" type="button" data-dismiss="modal">Chiudi</button>
                            </div>
                        </div>
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

<div class="modal fade" id="deleteConfirmModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-labelledby="deleteModalLabel">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title font-weight-bold text-gray-800" id="exampleModalLabel">Sei sicuro?</h5>
                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                L'esercizio verrà rimosso da questo giorno di allenamento. Questa azione non è reversibile finché non annulli le modifiche generali.
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" type="button" data-dismiss="modal">Annulla</button>
                <button class="btn btn-danger" type="button" id="btnConfirmDelete">Elimina</button>
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
    let utentiModifica = [];
    let schedeUtenteGlobal = [];

    $(document).ready(function() {
        // 1. Caricamento iniziale della lista utenti
        $.post('GetTuttiUtentiServlet', function(data) { //Modificare con GetUtentiUtenteServlet
            utentiModifica = data;
            mostraUtentiModifica(utentiModifica);
        });
    });

    // --- BOX 1: GESTIONE UTENTI ---

    function mostraUtentiModifica(lista) {
        const container = $('#containerUtentiModifica');
        container.empty();

        if (lista.length === 0) {
            container.append('<div class="p-3 text-center small text-muted">Nessun utente trovato.</div>');
            return;
        }

        lista.forEach(u => {
            container.append(`
            <div class="list-item shadow-sm text-center" onclick="caricaSchedaUtente(this, '` + u.idUtente + `')">
                <i class="fas fa-user-circle fa-lg mb-1" style="color: #d1d3e2;"></i>
                <div class="w-100">
                    <span class="d-block font-weight-bold small text-dark">` + u.nome + ` ` + u.cognome + `</span>
                </div>
            </div>
        `);
        });
    }

    function filtraUtentiModifica() {
        const query = $('#searchUtenteModifica').val().toLowerCase();
        const filtrate = utentiModifica.filter(u =>
            (u.nome + " " + u.cognome).toLowerCase().includes(query)
        );
        mostraUtentiModifica(filtrate);
    }

    // --- LOGICA DI TRANSIZIONE (CLICK UTENTE) ---

    function caricaSchedaUtente(element, idUtente) {
        idSchedaSelezionata = null; // Resetta l'ID quando cambi utente

        $('.list-item').removeClass('selected');
        $(element).addClass('selected');

        // Reset degli stati successivi
        $('#containerSchedeUtente').html('<div class="p-4 text-center small">Caricamento...</div>');
        $('#boxRichieste').html('<span class="small">Caricamento...</span>');
        $('#sezioneModifica').hide();

        // 2. Carica Richiesta (Box 3)
        $.post('GetRichiestaUtenteServlet', { idUtente: idUtente }, function(data) {
            const contenuto = (data && data.Richiesta)
                ? '<b>Richiesta:</b><br>' + data.Richiesta
                : '<span class="text-muted">Nessuna richiesta trovata.</span>';
            $('#boxRichieste').html(contenuto);
        });

        // 3. Carica Elenco Schede (Box 2)
        $.post('GetSchedeAssegnateUtenteServlet', { idUtente: idUtente }, function(data) {
            schedeUtenteGlobal = data;
            mostraListaSchede(data);
        });
    }

    // --- BOX 2: GESTIONE SCHEDE ---

    function mostraListaSchede(lista) {
        const container = $('#containerSchedeUtente');
        container.empty();

        if (lista.length === 0) {
            container.append('<div class="p-3 text-center small text-muted">Nessuna scheda assegnata.</div>');
            return;
        }

        lista.forEach(s => {
            container.append(`
            <div class="list-item shadow-sm text-center" onclick="caricaDettagliScheda(this, '` + s.IdScheda + `')">
                <i class="fas fa-file-alt text-primary mb-1"></i>
                <div class="w-100">
                    <span class="d-block font-weight-bold small">` + s.Nome + `</span>
                    <small class="text-muted" style="font-size: 0.7rem;">` + s.Obiettivo + `</small>
                </div>
            </div>
        `);
        });
    }

    function filtraSchedeUtente() {
        const query = $('#searchSchedaUtente').val().toLowerCase();
        const filtrate = schedeUtenteGlobal.filter(s => s.Nome.toLowerCase().includes(query));
        mostraListaSchede(filtrate);
    }

    // --- GRID FINALE: DETTAGLI ESERCIZI ---

    function caricaDettagliScheda(element, idScheda) {
        idSchedaSelezionata = idScheda;

        $('#containerSchedeUtente .list-item').removeClass('selected');
        $(element).addClass('selected');

        $.post('GetSchedaEserciziUtenteServlet', { idScheda: idScheda }, function(scheda) {
            costruisciInterfacciaModifica(scheda);
            $('#sezioneModifica').fadeIn();
        });
    }

    function costruisciInterfacciaModifica(scheda) {
        const tabs = $('#pills-tabModifica');
        const content = $('#pills-tabContentModifica');
        tabs.empty();
        content.empty();

        const giorni = raggruppaPerGiorno(scheda.esercizi);

        Object.keys(giorni).forEach((g, index) => {
            const active = index === 0 ? 'active' : '';
            const show = index === 0 ? 'show active' : '';

            tabs.append(`
            <li class="nav-item">
                <a class="nav-link ` + active + `" id="tab-g` + g + `" data-toggle="pill" href="#pane-g` + g + `">Giorno ` + g + `</a>
            </li>
        `);

            let htmlEsercizi = '';
            giorni[g].forEach((ex, i) => {
                const slotId = i + 1; // Definiamo il numero dell'esercizio (1, 2, 3...)

                // POPOLIAMO LA MAPPA: Questo evita che tu possa scegliere lo stesso esercizio due volte nello stesso giorno
                const giornoKey = 'pane-g' + g;
                if (!mappaAssegnazioni[giornoKey]) mappaAssegnazioni[giornoKey] = {};
                mappaAssegnazioni[giornoKey][slotId] = ex.nome;

                htmlEsercizi += `
                    <div class="col-md-6 exercise-col">
                        <i class="fas fa-times-circle delete-exercise-btn" onclick="eliminaEsercizio(this)"></i>

                        <span class="exercise-number-tag">Esercizio ` + slotId + `</span>
                        <div class="exercise-slot">
                            <input type="hidden" name="idEsercizio" class="id-esercizio-field" value="` + ex.idEsercizio + `">

                            <input type="hidden" name="giornoScheda" class="giorno-field" value="` + g + `">

                            <div class="slot-add" onclick="apriModalEsercizi(` + slotId + `)">
                                <img src="` + ex.immagine + `" style="width:100%; height:100%; object-fit:cover; border-radius:8px;">
                            </div>

                            <div class="slot-text">
                                <span class="label-tag-sm">` + ex.gruppo + `</span>
                                <strong class="d-block text-dark">` + ex.nome + `</strong>
                                <div class="mt-2 text-primary font-weight-bold">` + ex.serie + ` x ` + ex.ripetizioni + `</div>
                            </div>
                        </div>
                    </div>`;
            });

            // All'interno di costruisciInterfacciaModifica, dove generi il contenuto:
            content.append(`
                <div class="tab-pane fade ` + show + `" id="pane-g` + g + `">
                    <div class="row exercise-grid">` + htmlEsercizi + `</div>

                    <div class="add-row-container" onclick="aggiungiNuovoEsercizio()">
                        <i class="fas fa-plus-circle"></i> <b>Aggiungi esercizio</b>
                    </div>
                </div>
            `);
        });

        tabs.append(`<li class="nav-item"><a class="nav-link text-primary" href="javascript:void(0)" onclick="aggiungiGiorno()"><b>+</b></a></li>`);
    }

    // AGGIUNGI SINGOLO ESERCIZIO
    function aggiungiNuovoEsercizio() {
        // 1. Individua il pannello del giorno attualmente attivo (es: pane-g1)
        const activePane = $('#pills-tabContentModifica .tab-pane.active');
        const giornoId = activePane.attr('id');

        if (!giornoId) return;

        // 2. Estrae il numero del giorno (es: "1")
        const numeroGiorno = giornoId.replace('pane-g', '');

        // 3. Trova la griglia e conta gli esercizi esistenti per la numerazione
        const grid = activePane.find('.exercise-grid');
        let count = grid.find('.exercise-col').length;

        // 4. Incrementa di 1 (singolo inserimento)
        count++;

        // 5. Appende lo slot singolo
        grid.append(`
        <div class="col-md-6 exercise-col animated--fadeIn">
            <i class="fas fa-times-circle delete-exercise-btn" onclick="eliminaEsercizio(this)"></i>

            <span class="exercise-number-tag">Esercizio ` + count + `</span>
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

    function raggruppaPerGiorno(esercizi) {
        return esercizi.reduce((acc, ex) => {
            if (!acc[ex.giorno]) acc[ex.giorno] = [];
            acc[ex.giorno].push(ex);
            return acc;
        }, {});
    }

    //----------------------------------------------------------------

    // Mappa per evitare duplicati nello stesso giorno
    let mappaAssegnazioni = {};

    // --- APERTURA MODAL ---
    function apriModalEsercizi(slotId) {
        // Salviamo l'ID dello slot (es. 1, 2, 3...) per sapere quale aggiornare dopo
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

    // --- VISUALIZZAZIONE E FILTRO ---
    function mostraEsercizi(lista) {
        const container = $('#listaEserciziContainer');
        const slotId = $('#currentSlotId').val();

        // Otteniamo l'ID del tab attivo (es. pane-g1)
        const giornoId = $('#pills-tabContentModifica .tab-pane.active').attr('id');
        container.empty();

        // Logica per non mostrare esercizi già scelti per quel giorno
        const occupatiGiorno = mappaAssegnazioni[giornoId] || {};
        const nomiOccupati = Object.keys(occupatiGiorno)
            .filter(id => id !== slotId)
            .map(id => occupatiGiorno[id]);

        const filtrati = lista.filter(ex => !nomiOccupati.includes(ex.nome));

        filtrati.forEach(ex => {
            container.append(`
            <div class="esercizio-item d-flex align-items-center"
                 style="cursor:pointer"
                 onclick="selezionaEsercizio('` + ex.nome + `', '` + ex.contenutoMultimediale + `', '` + ex.gruppoMuscolare + `', '` + ex.idEsercizio + `', '` + ex.serie + `', '` + ex.ripetizione + `')">
                <img src="` + ex.contenutoMultimediale + `" style="width: 100px; height: 100px; object-fit: cover; border-radius: 8px;">
                <div>
                    <b class="d-block">` + ex.nome + `</b>
                    <small class="text-muted">` + ex.gruppoMuscolare + ` | ` + ex.serie + `x` + ex.ripetizione + `</small>
                </div>
            </div>
        `);
        });
    }

    // --- SELEZIONE E AGGIORNAMENTO UI ---
    function selezionaEsercizio(nome, url, gruppo, idEs, serie, ripetizioni) {
        const slotId = $('#currentSlotId').val();
        const activePane = $('#pills-tabContentModifica .tab-pane.active');
        const giornoId = activePane.attr('id');

        // Aggiorniamo la mappa dei duplicati
        if (!mappaAssegnazioni[giornoId]) mappaAssegnazioni[giornoId] = {};
        mappaAssegnazioni[giornoId][slotId] = nome;

        // Troviamo lo slot specifico basandoci sul numero dell'esercizio
        const slot = activePane.find('.exercise-col').filter(function() {
            return $(this).find('.exercise-number-tag').text().trim() === 'Esercizio ' + slotId;
        });

        // 1. Inseriamo l'ID dell'esercizio nel campo hidden
        slot.find('.id-esercizio-field').val(idEs);

        // 2. Assicuriamoci che il campo giorno sia popolato
        const numeroGiorno = giornoId.replace('pane-g', '');
        slot.find('.giorno-field').val(numeroGiorno);

        // 3. Aggiornamento Visivo: Immagine
        slot.find('.slot-add').html('<img src="' + url + '" style="width:100%; height:100%; object-fit:cover; border-radius:8px;">');

        // 4. Aggiornamento Visivo: Testo
        slot.find('.slot-text').html(`
        <span class="label-tag-sm">` + gruppo + `</span>
        <strong class="text-dark d-block">` + nome + `</strong>
        <div class="mt-2 text-primary font-weight-bold">
            ` + serie + ` x ` + ripetizioni + `
        </div>
    `);

        $('#modalEsercizi').modal('hide');
    }

    function aggiungiGiorno() {
        const tabs = $('#pills-tabModifica');
        const content = $('#pills-tabContentModifica');

        // 1. Calcoliamo il numero del nuovo giorno
        // Contiamo quanti link di tab esistono già (escludendo il tasto +)
        const numeroGiorniAttuali = tabs.find('li.nav-item').length - 1;
        const nuovoGiorno = numeroGiorniAttuali + 1;

        // 2. Creiamo il nuovo Tab (il pulsante "Giorno X")
        // Lo inseriamo PRIMA dell'ultimo elemento (che è il tasto +)
        const nuovoTabHtml = `
        <li class="nav-item">
            <a class="nav-link" id="tab-g` + nuovoGiorno + `" data-toggle="pill"
               href="#pane-g` + nuovoGiorno + `" role="tab">
               Giorno ` + nuovoGiorno + `
            </a>
        </li>`;

        tabs.find('li:last-child').before(nuovoTabHtml);

        // 3. Creiamo il nuovo Pane (il contenitore degli esercizi)
        content.append(`
        <div class="tab-pane fade" id="pane-g` + nuovoGiorno + `" role="tabpanel">
            <div class="row exercise-grid"></div>

            <div class="add-row-container mt-3" onclick="aggiungiNuovoEsercizio()">
                <i class="fas fa-plus-circle"></i> <b>Aggiungi esercizio</b>
            </div>
        </div>
    `);

        // 4. Attiviamo automaticamente il nuovo giorno appena creato
        $('#tab-g' + nuovoGiorno).tab('show');
    }

    //--------------------------------------------
    // Variabile globale temporanea per memorizzare l'elemento da eliminare
    let elementoDaEliminare = null;

    // Parte 1: Chiamata dall'icona (X) sull'esercizio
    function eliminaEsercizio(btn) {
        // Salviamo il riferimento all'elemento (la colonna dell'esercizio)
        elementoDaEliminare = $(btn).closest('.exercise-col');

        // Mostriamo la modale di conferma
        $('#deleteConfirmModal').modal('show');
    }

    // Parte 2: Esecuzione effettiva (collegata al tasto "Elimina" della modal)
    $('#btnConfirmDelete').on('click', function() {
        if (elementoDaEliminare) {
            const pane = elementoDaEliminare.closest('.tab-pane');
            const giornoId = pane.attr('id');

            // 1. Pulizia della mappa assegnazioni (per permettere di ri-scegliere l'esercizio dopo)
            const slotId = elementoDaEliminare.find('.exercise-number-tag').text().replace('Esercizio ', '').trim();
            if (mappaAssegnazioni[giornoId]) {
                delete mappaAssegnazioni[giornoId][slotId];
            }

            // 2. Rimozione fisica dal DOM
            elementoDaEliminare.remove();

            // 3. Rinumerazione automatica dei rimanenti
            pane.find('.exercise-grid .exercise-col').each(function(index) {
                const nuovoNumero = index + 1;
                $(this).find('.exercise-number-tag').text('Esercizio ' + nuovoNumero);
                $(this).find('.slot-add').attr('onclick', 'apriModalEsercizi(' + nuovoNumero + ')');
            });

            // Chiudiamo la modale e resettiamo la variabile
            $('#deleteConfirmModal').modal('hide');
            elementoDaEliminare = null;
        }
    });

    // -----------------------
    let idSchedaSelezionata = null;

    function salvaModificheFinali() {
        // 1. Controlliamo se la variabile globale idSchedaSelezionata è piena
        if (!idSchedaSelezionata) {
            alert("Errore: Seleziona prima una scheda da modificare.");
            return;
        }

        // 2. Raccogliamo i dati dai campi input
        const formData = $('#sezioneModifica').find('input').serialize();

        // 3. Usiamo la variabile CORRETTA: idSchedaSelezionata
        const datiCompleti = formData + '&idSchedaModifica=' + idSchedaSelezionata;

        $.ajax({
            url: 'UpdateSchedaServlet',
            type: 'POST',
            data: datiCompleti,
            success: function() {
                $('#successModal').modal('show');
            },
            error: function() {
                $('#errorModal').modal('show');
            }
        });
    }
</script>

</body>
</html>
