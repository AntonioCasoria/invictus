package BusinessLogicLayer;

import DataAccessLayer.query.QueryInsert;
import DataAccessLayer.query.QuerySelect;
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
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "GetSchedeGiaAssegnateServlet", value = "/GetSchedeGiaAssegnateServlet")
public class GetSchedeGiaAssegnateServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //Istanziamo la connessione
        Connessione c = new Connessione();
        Connection conn = c.connessione();
        QuerySelect querySelect = new QuerySelect(conn);

        String idUtente = req.getParameter("idUtente");
        List<Integer> idsAssegnati = new ArrayList<>();

        try {
            idsAssegnati = querySelect.selectSchedeAssegnateUtente(Integer.parseInt(idUtente));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        // Converto la lista in formato JSON usando la libreria Gson
        String json = new Gson().toJson(idsAssegnati);

        // Imposto il tipo di contenuto della risposta come JSON
        resp.setContentType("application/json");

        // Invio la stringa JSON al client (JavaScript)
        resp.getWriter().write(json);
    }
}