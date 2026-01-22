package BusinessLogicLayer;

import DataAccessLayer.bean.Generare;
import DataAccessLayer.bean.Performance;
import DataAccessLayer.bean.Utente;
import DataAccessLayer.query.QueryInsert;
import DataAccessLayer.query.QuerySelect;
import DataAccessLayer.sql.Connessione;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;

@WebServlet(name = "SalvaPerformanceServlet", value = "/SalvaPerformanceServlet")
public class SalvaPerformanceServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. Recupero parametri dal form della modale
        int idEsercizio = Integer.parseInt(req.getParameter("idEsercizio"));
        int idScheda = Integer.parseInt(req.getParameter("idScheda"));
        int giorno = Integer.parseInt(req.getParameter("giorno"));
        LocalDate data = LocalDate.parse(req.getParameter("data"));
        int rpe = Integer.parseInt(req.getParameter("rpe"));
        float carico = Float.parseFloat(req.getParameter("carico"));
        int serie = Integer.parseInt(req.getParameter("serie"));
        int ripetizioni = Integer.parseInt(req.getParameter("ripetizioni"));
        int recupero = Integer.parseInt(req.getParameter("recupero"));
        String feedback = req.getParameter("feedback");

        // 2. Recupero utente dalla sessione
        HttpSession session = req.getSession();
        Utente utente = (Utente) session.getAttribute("utente");

        // 3. Recuperiamo la connessione
        Connessione c = new Connessione();
        Connection conn = c.connessione();
        QueryInsert queryInsert = new QueryInsert(conn);
        QuerySelect querySelect = new QuerySelect(conn);

        //Creaiamo la performance e la salviamo nel db
        Performance performance = new Performance(utente.getIdUtente(), data, feedback, carico, rpe, serie, ripetizioni, recupero,rpe);
        System.out.println(performance.toString());
        queryInsert.insertPerformance(performance);

        //Recuperiamo l ultima performance dal database
        Performance ultmimaPerformance = null;
        try {
            ultmimaPerformance = querySelect.selectUltimaPerformance(utente.getIdUtente());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


        //aggiungiamo nella tabella generare
        Generare generare = new Generare(idEsercizio,ultmimaPerformance.getIdPerformance());
        queryInsert.insertGenerare(generare);

        resp.sendRedirect("visualizzaSchedaUtente.jsp?idScheda=" + idScheda + "&giorno=" + giorno);

    }
}
