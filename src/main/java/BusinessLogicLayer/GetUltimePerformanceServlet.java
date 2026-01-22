package BusinessLogicLayer;

import DataAccessLayer.bean.Performance;
import DataAccessLayer.bean.PerformanceGenerare;
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
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "GetUltimePerformanceServlet", value = "/GetUltimePerformanceServlet")
public class GetUltimePerformanceServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. Recupero utente dalla sessione
        HttpSession session = req.getSession();
        Utente utente = (Utente) session.getAttribute("utente");

        // 2. Connessione al database e inizializzazione DAO
        Connessione c = new Connessione();
        QuerySelect querySelect = new QuerySelect(c.connessione());

        try {
            // 3. Recupero della lista delle ultime performance per ogni esercizio dell'utente [cite: 2026-01-21]
            ArrayList<PerformanceGenerare> listaUltimePerf = querySelect.selectUltimePerformance(utente.getIdUtente());

            // 4. Trasformazione della lista in una Mappa (Key: ID Esercizio, Value: Oggetto Performance) [cite: 2026-01-21]
            // Questo passaggio è fondamentale per permettere al JS di trovare i dati tramite mappaUltimePerformance[id]
            Map<String, PerformanceGenerare> mappaDaRestituire = new HashMap<>();
            for (PerformanceGenerare p : listaUltimePerf) {
                // Utilizziamo l'ID dell'esercizio come chiave della mappa [cite: 2026-01-21]
                mappaDaRestituire.put(String.valueOf(p.getIdEsercizio()), p);
            }

            // 5. Serializzazione in JSON con GSON e gestione LocalDate [cite: 2026-01-20]
            Gson gson = new GsonBuilder()
                    .registerTypeAdapter(LocalDate.class, new LocalDateAdapter())
                    .create();

            String json = gson.toJson(mappaDaRestituire);

            // 6. Invio della risposta al client
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(json);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500, "Errore nel recupero delle performance: " + e.getMessage());
        }
    }

}
