package BusinessLogicLayer;

import DataAccessLayer.bean.SchedaAllenamento;
import DataAccessLayer.bean.Utente;
import DataAccessLayer.query.QuerySelect;
import DataAccessLayer.query.QueryUpdate;
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
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "GetSchedeUtenteServlet", value = "/GetSchedeUtenteServlet")
public class GetSchedeUtenteServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connessione c = new Connessione();
        Connection conn = c.connessione();
        QuerySelect querySelect = new QuerySelect(conn);

        //riprendiamo l'id utente dalla sessione
        HttpSession session = req.getSession();
        Utente utente = (Utente) session.getAttribute("utente");

        String jsonResponse = "[]";
        List<SchedaAllenamento> listaSchede = new ArrayList<>();
        try {
            listaSchede = querySelect.getSchedeByUtente(utente.getIdUtente());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        // 3. Convertiamo la lista in formato JSON
        Gson gson = new GsonBuilder()
                .registerTypeAdapter(LocalDate.class, new LocalDateAdapter())
                .create();
        jsonResponse = gson.toJson(listaSchede);

        // 4. Configurazione della risposta come JSON
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(jsonResponse);
    }

}
