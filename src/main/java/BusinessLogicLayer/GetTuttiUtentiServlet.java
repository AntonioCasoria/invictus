package BusinessLogicLayer;

import DataAccessLayer.bean.Consultare;
import DataAccessLayer.bean.PersonalTrainer;
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

@WebServlet(name = "GetTuttiUtentiServlet", value = "/GetTuttiUtentiServlet")
public class GetTuttiUtentiServlet extends HttpServlet {

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
        List<Utente> listaUtenti = new ArrayList<>();

        try {
            listaUtenti = querySelect.selectUtentiAll();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        List<Utente> listaEffettivaUtenti = new ArrayList<>();
        for(Utente u : listaUtenti){
            if(u.getRuolo().equals("user")){
                listaEffettivaUtenti.add(u);
            }
        }

        //Prendere tutti gli utenti da consultare
        PersonalTrainer personalTrainer = (PersonalTrainer) req.getSession().getAttribute("personalTrainer");
        List<Consultare> listaConsultare = new ArrayList<>();

        try {
            listaConsultare = querySelect.selectConsultareAll();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


        List<Utente> listaDaRestituire = new ArrayList<>();
        for(Utente u : listaEffettivaUtenti){
            for(Consultare consultare : listaConsultare){
                if(consultare.getIdUtente() == u.getIdUtente() && consultare.getIdPT() == personalTrainer.getIdPT()){
                    listaDaRestituire.add(u);
                }
            }
        }

        try {
            Gson gson = new GsonBuilder()
                    .registerTypeAdapter(LocalDate.class, new LocalDateAdapter())
                    .create();

            String json = gson.toJson(listaDaRestituire);
            resp.getWriter().write(json);
        } catch (Exception e) {
            e.printStackTrace(); // Questo scriverà l'errore nella console di IntelliJ
            resp.sendError(500, e.getMessage());
        }
    }
}
