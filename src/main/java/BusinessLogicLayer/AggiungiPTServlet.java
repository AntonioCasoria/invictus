package BusinessLogicLayer;

import DataAccessLayer.bean.PersonalTrainer;
import DataAccessLayer.query.QueryInsert;
import DataAccessLayer.sql.Connessione;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;

/**
 * Servlet per l'aggiunta di un PT utilizzando il metodo insertPersonalTrainer [cite: 2026-01-23]
 */
@WebServlet(name = "AggiungiPTServlet", value = "/AggiungiPTServlet")
public class AggiungiPTServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. Recupero parametri inviati dal form JavaScript [cite: 2026-01-23]
        String nome = req.getParameter("nome");
        String cognome = req.getParameter("cognome");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String dataNascita = req.getParameter("dataNascita");

        String esito = "error"; // Default in caso di fallimento [cite: 2026-01-23]

        try {
            // 2. Creazione dell'oggetto PersonalTrainer [cite: 2026-01-23]
            PersonalTrainer pt = new PersonalTrainer();
            pt.setNome(nome);
            pt.setCognome(cognome);
            pt.setEmail(email);
            pt.setPassword(password);
            pt.setDataNascita(dataNascita);

            // 3. Connessione e chiamata al tuo metodo DAO [cite: 2026-01-23]
            Connessione c = new Connessione();
            Connection conn = c.connessione();
            QueryInsert queryInsert = new QueryInsert(conn);

            // Utilizzo del tuo metodo void [cite: 2026-01-23]
            queryInsert.insertPersonalTrainer(pt);

            // Se non vengono sollevate eccezioni, l'inserimento è considerato riuscito [cite: 2026-01-23]
            esito = "success";

            if (conn != null) conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            esito = "error";
        }

        // 4. Risposta al client [cite: 2026-01-23]
        resp.setContentType("text/plain");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(esito);
    }
}