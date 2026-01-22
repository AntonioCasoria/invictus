package BusinessLogicLayer;

import DataAccessLayer.bean.PersonalTrainer;
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
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet(name = "GetTuttiPTServlet", value = "/GetTuttiPTServlet")
public class GetTuttiPTServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //Istanziamo la connessione
        Connessione c = new Connessione();
        Connection conn = c.connessione();
        QuerySelect querySelect = new QuerySelect(conn);

        // l'uso di una classe DAO per l'accesso ai dati
        ArrayList<PersonalTrainer> listaPT = new ArrayList<>();
        try {
            listaPT = querySelect.selectPersonalTrainerAll();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        // Convertiamo la lista in JSON (usando la libreria Gson o scrivendo manualmente)
        String json = new Gson().toJson(listaPT);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }
}
