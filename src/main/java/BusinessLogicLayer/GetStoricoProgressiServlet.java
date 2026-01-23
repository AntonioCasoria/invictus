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
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "GetStoricoProgressiServlet", value = "/GetStoricoProgressiServlet")
public class GetStoricoProgressiServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Utente utente = (Utente) session.getAttribute("utente");
        String gruppoMuscolare = req.getParameter("gruppoMuscolare");

        if (utente == null || gruppoMuscolare == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Sessione o parametri mancanti");
            return;
        }

        try {
            // Chiamata al metodo interno alla servlet
            Map<String, List<Object>> datiProgressi = selectStoricoCarichi(utente.getIdUtente(), gruppoMuscolare);

            Gson gson = new GsonBuilder()
                    .registerTypeAdapter(LocalDate.class, new LocalDateAdapter())
                    .create();

            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(gson.toJson(datiProgressi));

        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Errore Database: " + e.getMessage());
        }
    }

    /**
     * Metodo integrato direttamente nella Servlet per recuperare i dati dei progressi
     */
    private Map<String, List<Object>> selectStoricoCarichi(int idUtente, String gruppo) throws SQLException {
        List<Object> labels = new ArrayList<>();
        List<Object> dataset = new ArrayList<>();

        // Query: Calcola la media per data per il gruppo muscolare selezionato
        String sql = "SELECT p.Data, AVG(p.Carico) as MediaCarico " +
                "FROM performance p " +
                "JOIN generare g ON p.idPerformance = g.idPerformance " +
                "JOIN esercizio e ON g.IdEsercizio = e.IdEsercizio " +
                "WHERE p.IdUtente = ? AND e.GruppoMuscolare = ? " +
                "GROUP BY p.Data ORDER BY p.Data ASC";

        Connessione c = new Connessione();
        try (Connection conn = c.connessione();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idUtente);
            ps.setString(2, gruppo);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    // Data per l'asse X
                    labels.add(rs.getDate("Data").toString());
                    // Media carico per l'asse Y (getFloat per mantenere il .5)
                    dataset.add(rs.getFloat("MediaCarico"));
                }
            }
        }

        Map<String, List<Object>> result = new HashMap<>();
        result.put("labels", labels);
        result.put("dataset", dataset);
        return result;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}
