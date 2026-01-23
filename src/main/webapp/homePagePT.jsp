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

    <title>HomePage Personal Trainer</title>

    <!-- Custom fonts for this template-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
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

                <div class="row justify-content-center  ">
                    <div class="col-xl-8 col-lg-7">
                        <div class="card shadow mb-4">
                            <!-- Slideshow container -->
                            <div class="slideshow-container">
                                <div class="mySlides">
                                    <img src="img/Gym-Floor-13535.png" style="width:100%">
                                </div>

                                <div class="mySlides">
                                    <img src="img/personal-trainer.jpg" style="width:100%">
                                </div>

                            </div>

                            <!-- Left and right controls -->

                            <a class="prev" onclick="prevSlide()">&#10094;</a>
                            <a class="next" onclick="nextSlide()">&#10095;</a>

                            <!-- end slideshow -->
                        </div>
                    </div>
                </div>

                <div class="row">

                    <div class="col-lg-4">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-our-blu">Mario Rossi</h6>
                            </div>
                            <div class="card-body" style="text-align: center">
                                <img src="img/Mario.png">
                                <hr>
                                <p><strong>Specializzazione:</strong> Dimagrimento, Tonificazione, Allenamento funzionale, Ricomposizione corporea</p>
                                <p><strong>Stile di allenamento:</strong> Metodo e costanza, allenamenti strutturati e progressivi</p>
                                <p><strong>Ideale per te se:</strong> Vuoi risultati concreti, disciplina e costanza</p>
                                <p><strong>Carattere:</strong> Determinato, preciso e focalizzato sul risultato</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-4">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-our-blu">Emma Marrone</h6>
                            </div>
                            <div class="card-body" style="text-align: center">
                                <img src="img/Emma.png">
                                <hr>
                                <p><strong>Specializzazione:</strong> HIIT, Tonificazione femminile, Fitness musicale, Benessere e autostima</p>
                                <p><strong>Stile di allenamento:</strong> Dinamico, coinvolgente e motivante</p>
                                <p><strong>Ideale per te se:</strong> Vuoi allenarti divertendoti e avere motivazione costante</p>
                                <p><strong>Carattere:</strong> Solare, carismatica ed empatica</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-4">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-our-blu">Federico Verdi</h6>
                            </div>
                            <div class="card-body" style="text-align: center">
                                <img src="img/Federico.png">
                                <hr>
                                <p><strong>Specializzazione:</strong> Forza e definizione muscolare, Mobilità, Allenamento personalizzato, Prevenzione infortuni</p>
                                <p><strong>Stile di allenamento:</strong> Attento alla tecnica, personalizzato e sicuro</p>
                                <p><strong>Ideale per te se:</strong> Vuoi allenarti in modo intelligente e sicuro, con percorso su misura</p>
                                <p><strong>Carattere:</strong> Calmo, professionale e attento</p>

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
        let slideIndex = 0;
        let slides = document.getElementsByClassName("mySlides");
        let slideInterval;

        function showSlides(index) {
            if (!slides.length) return;

            for (let i = 0; i < slides.length; i++) {
                slides[i].style.display = "none";
            }

            if (index >= slides.length) slideIndex = 0;
            else if (index < 0) slideIndex = slides.length - 1;
            else slideIndex = index;

            slides[slideIndex].style.display = "block";
        }

        function nextSlide() {
            showSlides(slideIndex + 1);
            resetInterval();
        }

        function prevSlide() {
            showSlides(slideIndex - 1);
            resetInterval();
        }

        function resetInterval() {
            clearInterval(slideInterval);
            slideInterval = setInterval(() => showSlides(slideIndex + 1), 5000);
        }

        window.onload = function () {
            showSlides(slideIndex);
            slideInterval = setInterval(() => showSlides(slideIndex + 1), 5000);
        }
    </script>

</body>
</html>