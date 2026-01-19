package BusinessLogicLayer;

import DataAccessLayer.bean.PersonalTrainer;
import DataAccessLayer.bean.SchedaAllenamento;
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

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "GetTutteSchedeServlet", value = "/GetTutteSchedeServlet")
public class GetTutteSchedeServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        //Istanziamo la connessione
        Connessione c = new Connessione();
        Connection conn = c.connessione();
        QuerySelect querySelect = new QuerySelect(conn);
        List<SchedaAllenamento> listaSchede = new ArrayList<>();

        //Recuperiamo tutte le schede allenamento dal DB
        try {
            listaSchede = querySelect.getSchedaAllenamentoAll();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        // Filtriamo prendendo solo quelle relative al PT loggato
        PersonalTrainer personalTrainer = (PersonalTrainer) req.getSession().getAttribute("personalTrainer");
        List<SchedaAllenamento> listaEffettiveSchede = new ArrayList<>();
        for(SchedaAllenamento s : listaSchede){
            if(s.getIdPT() == personalTrainer.getIdPT()){
                listaEffettiveSchede.add(s);
            }
        }

        // Convertiamo la lista in formato JSON usando la libreria Gson e inviamo la risposta al client (JavaScript)
        try {
            Gson gson = new GsonBuilder()
                    .registerTypeAdapter(LocalDate.class, new LocalDateAdapter())
                    .create();

            String json = gson.toJson(listaEffettiveSchede);
            resp.getWriter().write(json);
        } catch (Exception e) {
            e.printStackTrace(); // Questo scriverà l'errore nella console di IntelliJ
            resp.sendError(500, e.getMessage());
        }
    }
}
