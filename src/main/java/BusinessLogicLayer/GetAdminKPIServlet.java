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
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "GetAdminKPIServlet", value = "/GetAdminKPIServlet")
public class GetAdminKPIServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Map<String, Integer> kpis = new HashMap<>();
        Connessione c = new Connessione();

        try (Connection conn = c.connessione()) {
            // Conteggio Utenti standard
            String sqlUser = "SELECT COUNT(*) FROM Utente WHERE ruolo = 'user'";
            // Conteggio Personal Trainer
            String sqlPT = "SELECT COUNT(*) FROM PersonalTrainer";

            try (PreparedStatement ps = conn.prepareStatement(sqlUser);
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) kpis.put("totUtenti", rs.getInt(1));
            }
            try (PreparedStatement ps = conn.prepareStatement(sqlPT);
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) kpis.put("totPT", rs.getInt(1));
            }
        } catch (Exception e) { e.printStackTrace(); }

        resp.setContentType("application/json");
        resp.getWriter().write(new Gson().toJson(kpis));
    }
}