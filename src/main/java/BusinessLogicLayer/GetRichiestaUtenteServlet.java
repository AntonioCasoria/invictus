package BusinessLogicLayer;

import DataAccessLayer.bean.Consultare;
import DataAccessLayer.bean.PersonalTrainer;
import DataAccessLayer.bean.Utente;
import DataAccessLayer.query.QuerySelect;
import DataAccessLayer.sql.Connessione;
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

@WebServlet(name = "GetRichiestaUtenteServlet", value = "/GetRichiestaUtenteServlet")
public class GetRichiestaUtenteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //Istanziamo la connessione
        Connessione c = new Connessione();
        Connection conn = c.connessione();
        QuerySelect querySelect = new QuerySelect(conn);
        List<Utente> listaUtenti = new ArrayList<>();

        int idUtente = Integer.parseInt(req.getParameter("idUtente"));
        // Recuperiamo il PT dalla sessione per sicurezza
        PersonalTrainer pt = (PersonalTrainer) req.getSession().getAttribute("personalTrainer");

        String testoRichiesta = "";

        //Prendere tutti gli utenti da consultare
        List<Consultare> listaConsultare = new ArrayList<>();

        try {
            listaConsultare = querySelect.selectConsultareAll();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        for(Consultare consultare : listaConsultare){
            if(consultare.getIdUtente() == idUtente && consultare.getIdPT() == pt.getIdPT()){
                testoRichiesta = consultare.getRichiesta();
            }
        }

        // Restituiamo un piccolo JSON
        resp.setContentType("application/json");
        resp.getWriter().write("{\"Richiesta\": \"" + testoRichiesta + "\"}");
    }
}
