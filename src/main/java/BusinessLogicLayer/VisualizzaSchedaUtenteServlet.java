package BusinessLogicLayer;

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

@WebServlet(name = "VisualizzaSchedaUtenteServlet", value = "/VisualizzaSchedaUtenteServlet")
public class VisualizzaSchedaUtenteServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Gestisce la chiamata $.post dal tuo script
        String idSchedaStr = req.getParameter("idScheda");

        Map<String, Object> jsonResponse = new HashMap<>();
        List<Map<String, Object>> listaEsercizi = new ArrayList<>();

        if (idSchedaStr != null && !idSchedaStr.isEmpty()) {
            Connessione c = new Connessione();
            try (Connection conn = c.connessione()) {
                // Query: Uniamo la tabella 'comporre' con 'esercizio' filtrando per IdScheda
                String sql = "SELECT c.Giorno, e.IdEsercizio, e.Nome, e.GruppoMuscolare, " +
                        "e.ContenutoMultimediale, e.contenutoMultimediale2, e.Serie, e.Ripetizioni, e.TempoRecupero, e.Descrizione," +
                        "s.Nome, s.Obiettivo, s.DataCreazione, s.Durata " +
                        "FROM comporre c " +
                        "JOIN esercizio e ON c.IdEsercizio = e.IdEsercizio " +
                        "INNER JOIN schedaallenamento s ON c.IdScheda = s.IdScheda " +
                        "WHERE c.IdScheda = ? " +
                        "ORDER BY c.Giorno ASC";

                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setInt(1, Integer.parseInt(idSchedaStr));

                    try (ResultSet rs = ps.executeQuery()) {
                        while (rs.next()) {
                            Map<String, Object> ex = new HashMap<>();
                            ex.put("giorno", rs.getInt("Giorno"));
                            ex.put("idEsercizio", rs.getInt("IdEsercizio"));
                            ex.put("nomeEsercizio", rs.getString("e.Nome"));
                            ex.put("gruppo", rs.getString("GruppoMuscolare"));
                            ex.put("immagine", rs.getString("ContenutoMultimediale"));
                            ex.put("video", rs.getString("contenutoMultimediale2"));
                            ex.put("serie", rs.getInt("Serie"));
                            ex.put("ripetizioni", rs.getString("Ripetizioni"));
                            ex.put("tempoRecupero", rs.getInt("TempoRecupero"));
                            ex.put("descrizione", rs.getString("Descrizione"));
                            ex.put("nomeScheda", rs.getString("s.Nome"));
                            ex.put("obiettivo", rs.getString("Obiettivo"));
                            ex.put("dataCreazione", rs.getDate("DataCreazione"));
                            ex.put("durata", rs.getInt("Durata"));
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
