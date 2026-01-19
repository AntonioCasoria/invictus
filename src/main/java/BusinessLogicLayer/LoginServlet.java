package BusinessLogicLayer;

import DataAccessLayer.bean.PersonalTrainer;
import DataAccessLayer.bean.Utente;
import DataAccessLayer.query.QueryInsert;
import DataAccessLayer.query.QuerySelect;
import DataAccessLayer.sql.Connessione;
import com.mysql.cj.Session;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {

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

        //Recuperiamo i parametri dalla form
        String email = req.getParameter("Email");
        String password = req.getParameter("Password");

        ArrayList<Utente> utenti = new ArrayList<>();
        try {
            utenti = querySelect.selectUtentiAll();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        ArrayList<PersonalTrainer> pt = new ArrayList<>();
        try {
            pt = querySelect.selectPersonalTrainerAll();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        //controllo utente e password
        String address = "";
        for (Utente utente : utenti) {
            //user presente nel db
            if (utente.getEmail().equals(email) && utente.getPassword().equals(password) && utente.getRuolo().equals("user")) {
                HttpSession session = req.getSession(true);
                session.setAttribute("utente", utente);
                session.setAttribute("prenotazioni", new ArrayList<>());
                address = "./homePageUser.jsp";
                break;
            } else if (utente.getEmail().equals(email) && utente.getPassword().equals(password) && utente.getRuolo().equals("admin")) {
                //admin presente nel db
                HttpSession session = req.getSession(true);
                session.setAttribute("admin", utente);
                address = "./homePageAdmin.jsp";
                break;
            }
        }

        for(PersonalTrainer personalTrainer : pt){
            if(personalTrainer.getEmail().equals(email) && personalTrainer.getPassword().equals(password)){
                HttpSession session = req.getSession(true);
                session.setAttribute("personalTrainer", personalTrainer);
                //session.setAttribute("prenotazioni", new ArrayList<>());
                address = "./homePagePT.jsp";
                break;
            }
        }

        RequestDispatcher dispatcher = req.getRequestDispatcher(address);
        dispatcher.forward(req, resp);

    }
}
