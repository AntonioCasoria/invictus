package BusinessLogicLayer;

import DataAccessLayer.bean.Utente;
import DataAccessLayer.query.QueryInsert;
import DataAccessLayer.query.QuerySelect;
import DataAccessLayer.sql.Connessione;
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
import java.time.LocalDate;
import java.util.ArrayList;

@WebServlet(name = "RegisterServlet", value = "/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //Riprendo i paramentri dalla form
        String nome = req.getParameter("Nome");
        String cognome = req.getParameter("Cognome");
        LocalDate dataNascita = LocalDate.parse(req.getParameter("Data"));
        String indirizzo = req.getParameter("Indirizzo");
        int eta = Integer.parseInt(req.getParameter("Eta"));
        String sesso = req.getParameter("Sesso");
        int altezza = Integer.parseInt(req.getParameter("Altezza"));
        float peso = Float.parseFloat(req.getParameter("Peso"));
        String fit = req.getParameter("FitnessLevel");
        String obiettivo = req.getParameter("Obiettivo");
        String anniExp = req.getParameter("AnniExp");
        int freqSett = Integer.parseInt(req.getParameter("FreqSett"));
        LocalDate dataIscrizione = LocalDate.now();
        String email = req.getParameter("Email");
        String password = req.getParameter("Password");

        Utente u = new Utente(nome,cognome,email,password,dataNascita,indirizzo,"user",eta,sesso,altezza,peso,fit,anniExp,freqSett,dataIscrizione,obiettivo);


        //Istanziamo la connessione
        Connessione c = new Connessione();
        Connection conn = c.connessione();
        QuerySelect querySelect = new QuerySelect(conn);
        QueryInsert queryInsert = new QueryInsert(conn);

        //Aggiungiamo l'utente solo quando non è gia presente nel database
        ArrayList<Utente> utenti = new ArrayList<>();
        try {
            utenti = querySelect.selectUtentiAll();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        String address = "";
        boolean flag = true;
        for(Utente utente : utenti){
            if(email.equals(utente.getEmail())){
                address = "./login.jsp";
                flag = false;
                break;
            }else{
                address = "./homePageUser.jsp";
            }
        }

        if(flag){
            queryInsert.insertUtente(u);
            ArrayList<Utente> utenti1 = new ArrayList<>();
            try {
                utenti1 = querySelect.selectUtentiAll();
                for (Utente utente1 : utenti1) {
                    if (utente1.getEmail().equals(email)) {
                        u = utente1;
                    }
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            HttpSession session = req.getSession(true);
            session.setAttribute("utente", u);
            session.setAttribute("prenotazioni", new ArrayList<>());
        }

        RequestDispatcher dispatcher = req.getRequestDispatcher(address);
        dispatcher.forward(req, resp);

    }
}
