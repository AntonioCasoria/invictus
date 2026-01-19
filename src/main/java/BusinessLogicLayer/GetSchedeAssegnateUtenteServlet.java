package BusinessLogicLayer;

import DataAccessLayer.sql.Connessione;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "GetSchedeAssegnateUtenteServlet", value = "/GetSchedeAssegnateUtenteServlet")
public class GetSchedeAssegnateUtenteServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idUtenteStr = req.getParameter("idUtente");
        List<Map<String, Object>> listaSchede = new ArrayList<>();

        if (idUtenteStr != null && !idUtenteStr.isEmpty()) {
            Connessione c = new Connessione();
            try (Connection conn = c.connessione()) {
                // Query: Seleziona i dettagli delle schede associate all'utente X
                String sql = "SELECT s.IdScheda, s.Nome, s.Obiettivo " +
                        "FROM assegnare a " +
                        "JOIN schedaallenamento s ON a.IdScheda = s.IdScheda " +
                        "WHERE a.IdUtente = ?";

                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setInt(1, Integer.parseInt(idUtenteStr));

                    try (ResultSet rs = ps.executeQuery()) {
                        while (rs.next()) {
                            // Usiamo una Map per creare al volo l'oggetto JSON
                            Map<String, Object> scheda = new HashMap<>();
                            scheda.put("IdScheda", rs.getInt("IdScheda"));
                            scheda.put("Nome", rs.getString("Nome"));
                            scheda.put("Obiettivo", rs.getString("Obiettivo"));
                            listaSchede.add(scheda);
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        }

        // Trasformazione in formato JSON
        String json = new Gson().toJson(listaSchede);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(json);

    }
}
