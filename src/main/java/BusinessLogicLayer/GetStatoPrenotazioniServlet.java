package BusinessLogicLayer;

import DataAccessLayer.bean.Utente;
import DataAccessLayer.query.QuerySelect;
import DataAccessLayer.sql.Connessione;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.xml.namespace.QName;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name ="GetStatoPrenotazioniServlet", value = "/GetStatoPrenotazioniServlet")
public class GetStatoPrenotazioniServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        LocalDate dataStr = LocalDate.parse(request.getParameter("data"));
        Utente u = (Utente) request.getSession().getAttribute("utente");

        //connessione
        Connessione c = new Connessione();
        Connection conn = c.connessione();
        QuerySelect querySelect = new QuerySelect(conn);

        // Recupero liste dal DAO
        List<String> miei = new ArrayList<>();
        try {
            miei = querySelect.getOrariByUtenteEData(u.getIdUtente(), dataStr);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        List<String> pieni = null;
        try {
            pieni = querySelect.getOrariEsauritiByData(dataStr, 15);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        // Creiamo una struttura dati per Gson
        Map<String, List<String>> result = new HashMap<>();
        result.put("mieiOrari", miei);
        result.put("orariPieni", pieni);

        response.setContentType("application/json");
        response.getWriter().write(new Gson().toJson(result));
    }
}