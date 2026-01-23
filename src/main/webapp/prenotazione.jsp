<%@ page import="DataAccessLayer.bean.Utente" %>
<%@ page import="java.util.ArrayList" %>
<%
    Utente utente = (Utente) session.getAttribute("utente");

    ArrayList<String> prenotazioni = (ArrayList<String>) session.getAttribute("prenotazioni");
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Prenotazione - Invictus</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="css/sb-admin-2.css" rel="stylesheet">

    <style>
        .booking-grid-container {
            border: 2px solid #333;
            border-radius: 25px;
            overflow: hidden;
            background: white;
            margin-bottom: 20px;
            min-height: 380px;
        }
        .grid-header {
            background-color: #fff;
            padding: 12px;
            font-weight: bold;
            border-bottom: 1px solid #333;
            text-align: center;
        }
        .grid-body { display: grid; background-color: #fff; }

        /* Griglia Giorni: 7 colonne */
        .grid-days { grid-template-columns: repeat(7, 1fr); }

        /* Griglia Fasce Orarie: 3 colonne */
        .grid-hours { grid-template-columns: repeat(3, 1fr); }

        .cell {
            border: 0.5px solid #ddd;
            height: 48px;
            transition: all 0.2s;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.85rem;
        }

        /* Stile per le date passate o non selezionabili */
        .cell.disabled {
            color: #ccc !important;
            background-color: #f9f9f9 !important;
            cursor: not-allowed !important;
            pointer-events: none; /* Impedisce il click a livello CSS */
        }

        .cell:hover:not(.empty, .day-name) { background-color: #f0f4f8; }
        .cell.selected { background-color: #1e73be !important; color: white; font-weight: bold; }
        .cell.empty { cursor: default; background-color: #fafafa; }

        /* Stile per i nomi dei giorni (L, M, M...) */
        .day-name {
            font-size: 0.7rem;
            font-weight: bold;
            color: #888;
            background: #f8f9fc;
            cursor: default;
            border-bottom: 1px solid #eee;
        }

        .nav-arrow { cursor: pointer; color: #1e73be; padding: 0 10px; }
        .nav-arrow:hover { color: #333; }

        .separator {
            font-size: 2rem;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #333;
        }

        /* Stile per slot già prenotati da ME */
        .cell.my-booking {
            background-color: #d1ecf1 !important; /* Blu chiaro */
            color: #00b8a9 !important;
            text-decoration: line-through;
            cursor: not-allowed;
            pointer-events: none;
            opacity: 0.7;
        }

        /* Stile per slot che hanno raggiunto la capienza massima (15 persone) */
        .cell.full {
            background-color: #f8d7da !important; /* Rosso chiaro */
            color: #721c24 !important;
            text-decoration: line-through;
            cursor: not-allowed;
            pointer-events: none;
            opacity: 0.7;
        }
    </style>
</head>

<body id="page-top">

<div id="wrapper">

    <ul class="navbar-nav bg-sidebar sidebar sidebar-dark accordion" id="accordionSidebar">
        <a class="sidebar-brand d-flex align-items-center justify-content-center" href="homePageUser.jsp">
            <div class="sidebar-brand-icon">
                <img src="img/logoInvictus.png" alt="logo" style="height: 50px;">
            </div>
        </a>

        <!-- divider -->
        <hr class="sidebar-divider my-0" style="background: #1e73be;">

        <!-- SideBar Nav: Prenotazione -->
        <li class="nav-item active">
            <a class="nav-link" href="prenotazione.jsp"><i class="fa-solid fa-calendar" style="color: #1e73be;"></i><span style="color: #1e73be;">Prenotazione</span></a>
        </li>

        <!-- divider -->
        <hr class="sidebar-divider my-0" style="background: #1e73be;">

        <!-- Sidebar Nav: Allenamento -->
        <li class="nav-item">
            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo" style="color: #1e73be;">
                <i class="fa-solid fa-dumbbell" style="color: #1e73be;"></i><span style="color: #1e73be;">Allenamento</span>
            </a>
            <div id="collapseTwo" class="collapse" data-parent="#accordionSidebar">
                <div class="bg-gray-200 py-2 collapse-inner rounded">
                    <a class="collapse-item" href="schedaAllenamento.jsp">Scheda di Allenamento</a>
                    <a class="collapse-item" href="performance.jsp">Visualizza Performance</a>
                </div>
            </div>
        </li>

        <!-- divider -->
        <hr class="sidebar-divider my-0" style="background: #1e73be;">

        <!-- SideBar Nav: Progressi -->
        <li class="nav-item">
            <a class="nav-link" href="progressi.jsp"><i class="fas fa-fw fa-chart-area" style="color: #1e73be;"></i><span style="color: #1e73be;">Progressi</span></a>
        </li>

        <!-- divider -->
        <hr class="sidebar-divider my-0" style="background: #1e73be;">
    </ul>

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


            <div class="container-fluid text-center">
                <div class="mb-4">
                    <h1 class="h4 text-gray-900 font-weight-bold">Prenota il tuo posto in palestra</h1>
                </div>

                <div class="card shadow mb-4">
                    <div class="card-body">
                        <form id="formPrenotazione" action="PrenotazioneServlet" method="post">
                            <input type="hidden" name="giorno" id="giorno">
                            <input type="hidden" name="ora" id="ora">

                            <div class="row justify-content-center align-items-center">

                                <div class="col-md-5">
                                    <div class="booking-grid-container">
                                        <div class="grid-header d-flex justify-content-between align-items-center">
                                            <i class="fas fa-chevron-left nav-arrow" onclick="changeMonth(-1)"></i>
                                            <span id="monthTitle">Gennaio 2026</span>
                                            <i class="fas fa-chevron-right nav-arrow" onclick="changeMonth(1)"></i>
                                        </div>
                                        <div id="gridGiorno" class="grid-body grid-days">
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-1 separator"><span>—</span></div>

                                <div class="col-md-5">
                                    <div class="booking-grid-container">
                                        <div class="grid-header">Fascia oraria</div>
                                        <div id="gridOra" class="grid-body grid-hours">
                                        </div>
                                    </div>
                                </div>

                            </div>

                            <button type="submit" class="btn btn-primary px-5 mt-4 shadow-sm" style="background-color: #1e73be; border: none;">
                                Conferma Prenotazione
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <footer class="sticky-footer bg-white">
            <div class="container my-auto text-center">
                <span>Copyright &copy; Invictus 2026</span>
            </div>
        </footer>
    </div>
</div>

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

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Inizializziamo al 1 Gennaio 2026
    let currentViewDate = new Date(2026, 0, 1);

    function renderCalendar() {
        const grid = document.getElementById('gridGiorno');
        const title = document.getElementById('monthTitle');
        grid.innerHTML = '';

        const year = currentViewDate.getFullYear();
        const month = currentViewDate.getMonth();

        const today = new Date();
        today.setHours(0, 0, 0, 0);

        // Titolo
        const monthNames = ["Gennaio", "Febbraio", "Marzo", "Aprile", "Maggio", "Giugno", "Luglio", "Agosto", "Settembre", "Ottobre", "Novembre", "Dicembre"];
        title.innerText = monthNames[month] + " " + year;

        // Header giorni
        const daysLabel = ['L', 'M', 'M', 'G', 'V', 'S', 'D'];
        daysLabel.forEach(d => grid.innerHTML += `<div class="cell day-name">` + d + `</div>`);

        // Calcolo primo giorno (1 Gen 2026 è Giovedì -> index 3 se Lun=0)
        let firstDay = new Date(year, month, 1).getDay();
        firstDay = (firstDay === 0) ? 6 : firstDay - 1; // Correzione per far partire Lunedì

        const daysInMonth = new Date(year, month + 1, 0).getDate();

        // Celle vuote iniziali
        for (let i = 0; i < firstDay; i++) {
            grid.innerHTML += `<div class="cell empty"></div>`;
        }


        // Giorni del mese
        for (let d = 1; d <= daysInMonth; d++) {
            // Creiamo la data della cella corrente
            const cellDate = new Date(year, month, d);

            // Se la data della cella è precedente a oggi, aggiungiamo la classe 'disabled'
            if (cellDate < today) {
                grid.innerHTML += `<div class="cell disabled">`+ d + `</div>`;
            } else {
                if ((month+1)<10) {
                    if (d < 10) {
                        grid.innerHTML += `<div class="cell day-cell" data-val="` + year + "-" + "0" + (month + 1) + "-" + "0" + d + `">` +  d + `</div>`;
                    }else{
                        grid.innerHTML += `<div class="cell day-cell" data-val="` + year + "-" + "0" + (month + 1) + "-" + d + `">` + d + `</div>`;
                    }
                }else{
                    if (d < 10) {
                        grid.innerHTML += `<div class="cell day-cell" data-val="` + year + "-" + (month + 1) + "-" + "0" + d + `">` +  d + `</div>`;
                    }else{
                        grid.innerHTML += `<div class="cell day-cell" data-val="` + year + "-" + (month + 1) + "-" + d + `">` + d + `</div>`;
                    }

                }
            }
        }

        // Pareggio griglia finale (opzionale, per estetica)
        let totalCells = firstDay + daysInMonth;
        while(totalCells % 7 !== 0) {
            grid.innerHTML += `<div class="cell empty"></div>`;
            totalCells++;
        }

        // Il listener del click rimane lo stesso, ma funzionerà solo su '.day-cell'
        // ignorando automaticamente le celle '.disabled'
        $('.day-cell').click(function() {
            $('.day-cell').removeClass('selected');
            $(this).addClass('selected');

            let dataSelezionata = $(this).data('val');
            $('#giorno').val(dataSelezionata);

            // sia i tuoi slot che quelli pieni (15 persone)
            caricaStatoSlot(dataSelezionata);
        });
    }

    function caricaStatoSlot(dataSelezionata) {
        $.ajax({
            url: 'GetStatoPrenotazioniServlet', // Cambiamo nome per chiarezza
            type: 'GET',
            data: { data: dataSelezionata },
            success: function(risposta) {
                // Ci aspettiamo un oggetto tipo:
                // { "mieiOrari": ["07:00"], "orariPieni": ["10:00", "13:00"] }
                let dati = (typeof risposta === 'string') ? JSON.parse(risposta) : risposta;
                renderSlots(dati.mieiOrari, dati.orariPieni);
            },
            error: function() {
                renderSlots([], []);
            }
        });
    }

    function renderSlots(mieiOrari = [],orariPieni = []) {
        const grid = document.getElementById('gridOra');
        grid.innerHTML = '';

        // Slot ogni 90 minuti (1h) dalle 07:00
        let startMin = 7 * 60; // 07:00 in minuti
        let endMin = 24 * 60;  // 00:00

        while(startMin < endMin) {
            let h = Math.floor(startMin / 60);
            let m = startMin % 60;
            let timeStr = (h < 10 ? '0' : '') + h + ":" + (m === 0 ? '00' : m);

            if(mieiOrari.includes(timeStr)) {
                grid.innerHTML += `<div class="cell my-booking">` + timeStr + `</div>`;
            }else if(orariPieni.includes(timeStr)) {
                // Slot pieno (15 persone), indipendentemente dall'utente
                grid.innerHTML += `<div class="cell full">` + timeStr + `</div>`;
            }else{
                //slot libero e cliccabile
                grid.innerHTML += `<div class="cell hour-cell" data-val="` + timeStr + `">` + timeStr + `</div>`;
            }

            startMin += 60;
        }

        // Riaggancia l'evento click
        $('.hour-cell').click(function() {
            $('.hour-cell').removeClass('selected');
            $(this).addClass('selected');
            $('#ora').val($(this).data('val'));
        });
    }

    function changeMonth(dir) {
        currentViewDate.setMonth(currentViewDate.getMonth() + dir);
        renderCalendar();
        $('#giorno').val(''); // Reset selezione
        renderSlots([],[]);
    }

    $(document).ready(function() {
        renderCalendar();
        renderSlots([],[]);

        $('#formPrenotazione').submit(function(e) {
            if (!$('#giorno').val() || !$('#ora').val()) {
                e.preventDefault();
                alert("Attenzione: seleziona sia il giorno che l'orario desiderato.");
            }
        });
    });
</script>
</body>
</html>