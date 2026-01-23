package BusinessLogicLayer;

import DataAccessLayer.bean.Utente;
import DataAccessLayer.query.QueryUpdate;
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
import java.time.LocalDate;

@WebServlet(name = "UpdateDatiUtenteServlet", value = "/UpdateDatiUtenteServlet")
public class UpdateDatiUtenteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Utente u = (Utente) session.getAttribute("utente");

        String nome = req.getParameter("nome");
        String cognome = req.getParameter("cognome");
        String indirizzo = req.getParameter("indirizzo");
        LocalDate dataNascita = LocalDate.parse(req.getParameter("dataNascita"));
        int altezza = Integer.parseInt(req.getParameter("altezza"));
        float peso = Float.parseFloat(req.getParameter("peso"));
        String obiettivo = req.getParameter("obiettivo");
        String password = req.getParameter("password");

        Connessione c = new Connessione();
        Connection conn = c.connessione();
        QueryUpdate qu = new QueryUpdate(conn);

        Utente utente = new Utente();
        // Se la password è vuota, manteniamo quella vecchia nel DB
        utente = qu.updateProfiloUtente(u.getIdUtente(), nome, cognome, indirizzo, dataNascita, altezza, peso, obiettivo, password);
        session.setAttribute("utente", utente);
        resp.getWriter().write("success");

    }
}
