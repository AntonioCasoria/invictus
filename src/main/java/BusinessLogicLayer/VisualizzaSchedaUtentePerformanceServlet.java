package BusinessLogicLayer;

import DataAccessLayer.bean.Utente;
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
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "VisualizzaSchedaUtentePerformanceServlet", value = "/VisualizzaSchedaUtentePerformanceServlet")
public class VisualizzaSchedaUtentePerformanceServlet extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Gestisce la chiamata $.post dal tuo script
        String idSchedaStr = req.getParameter("idScheda");

        Utente utente = (Utente) req.getSession().getAttribute("utente");

        Map<String, Object> jsonResponse = new HashMap<>();
        List<Map<String, Object>> listaEsercizi = new ArrayList<>();

        if (idSchedaStr != null && !idSchedaStr.isEmpty()) {
            Connessione c = new Connessione();
            try (Connection conn = c.connessione()) {
                // Query: Uniamo la tabella 'comporre' con 'esercizio' filtrando per IdScheda
                String sql = "SELECT DISTINCT c.Giorno, e.IdEsercizio, e.Nome, e.GruppoMuscolare, e.Serie AS SerieTeoriche, e.Ripetizioni AS RipTeoriche, s.Nome, p.* " +
                        "FROM comporre c JOIN esercizio e ON c.IdEsercizio = e.IdEsercizio " +
                        "INNER JOIN schedaallenamento s ON c.IdScheda = s.IdScheda " +
                        "INNER JOIN assegnare ac ON s.IdScheda = ac.IdScheda " +
                        "INNER JOIN generare g ON e.IdEsercizio = g.IdEsercizio " +
                        "INNER JOIN performance p ON g.idPerformance = p.idPerformance " +
                        "WHERE c.IdScheda = ? AND ac.IdUtente = ? " +
                        "AND p.idPerformance = (SELECT MAX(p2.idPerformance) FROM performance p2 " +
                        "JOIN generare g2 ON p2.idPerformance = g2.idPerformance " +
                        "WHERE p2.IdUtente = ? AND g2.IdEsercizio = e.IdEsercizio) " +
                        "ORDER BY c.Giorno ASC";

                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setInt(1, Integer.parseInt(idSchedaStr));
                    ps.setInt(2, utente.getIdUtente());
                    ps.setInt(3, utente.getIdUtente());

                    try (ResultSet rs = ps.executeQuery()) {
                        while (rs.next()) {
                            Map<String, Object> ex = new HashMap<>();
                            ex.put("giorno", rs.getInt("Giorno"));
                            ex.put("idEsercizio", rs.getInt("IdEsercizio"));
                            ex.put("nomeEsercizio", rs.getString("e.Nome"));
                            ex.put("gruppo", rs.getString("GruppoMuscolare"));
                            ex.put("serie", rs.getInt("SerieTeoriche"));
                            ex.put("ripetizioni", rs.getString("RipTeoriche"));
                            ex.put("nomeScheda", rs.getString("s.Nome"));
                            ex.put("idPerformance", rs.getInt("IdPerformance"));
                            ex.put("idUtente", rs.getInt("IdUtente"));
                            ex.put("data", rs.getDate("Data"));
                            ex.put("feedback", rs.getString("Feedback"));
                            ex.put("carico", rs.getFloat("Carico"));
                            ex.put("rpe", rs.getInt("RPE"));
                            ex.put("serieEffettive", rs.getInt("SerieEffettive"));
                            ex.put("ripetizioniEffettive", rs.getInt("RipetizioniEffettive"));
                            ex.put("tempoRecuperoEffettivo", rs.getInt("TempoRecuperoEffettive"));
                            ex.put("rpeEffivo", rs.getInt("RPEEffettivo"));
                            listaEsercizi.add(ex);
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        }

        // Strutturiamo la risposta per il JavaScript
        jsonResponse.put("idScheda", idSchedaStr);
        jsonResponse.put("esercizi", listaEsercizi);

        // Invio del JSON
        Gson gson = new GsonBuilder()
                .registerTypeAdapter(LocalDate.class, new LocalDateAdapter())
                .create();

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(gson.toJson(jsonResponse));
    }
}
