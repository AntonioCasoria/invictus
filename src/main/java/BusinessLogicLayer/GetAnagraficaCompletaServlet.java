package BusinessLogicLayer;

import DataAccessLayer.bean.Utente;
import DataAccessLayer.query.QuerySelect;
import DataAccessLayer.sql.Connessione;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet per il recupero dell'anagrafica completa degli utenti (Admin Area) [cite: 2026-01-23]
 */
@WebServlet(name = "GetAnagraficaCompletaServlet", value = "/GetAnagraficaCompletaServlet")
public class GetAnagraficaCompletaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        // 1. Inizializzazione connessione e DAO [cite: 2026-01-23]
        Connessione c = new Connessione();
        List<Utente> listaUtenti = new ArrayList<>();

        try (Connection conn = c.connessione()) {
            QuerySelect querySelect = new QuerySelect(conn);

            // 2. Recupero di tutti gli utenti presenti nel database [cite: 2026-01-23]
            // Nota: Assicurati che il metodo selectUtentiAll() esista nel tuo QuerySelect
            listaUtenti = querySelect.selectUtentiAll();

            // 3. Conversione in JSON tramite Gson [cite: 2026-01-22]
            Gson gson = new GsonBuilder()
                    .registerTypeAdapter(LocalDate.class, new LocalDateAdapter())
                    .create();

            String json = gson.toJson(listaUtenti);

            // 4. Invio della risposta al client [cite: 2026-01-23]
            resp.getWriter().write(json);

        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Errore SQL nel recupero anagrafica.");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Errore generico nel sistema.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}