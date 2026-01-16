package BusinessLogicLayer;

import DataAccessLayer.bean.ArchivioPrenotazioni;
import DataAccessLayer.bean.Prenotazione;
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
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.IdentityHashMap;

@WebServlet(name = "PrenotazioneServlet", value = "/PrenotazioneServlet")
public class PrenotazioneServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //riprendiamo i campi della form
        LocalDate dataPrenotazione = LocalDate.parse(req.getParameter("giorno"));
        String ora = req.getParameter("ora");

        //riprendiamo l'id utente dalla sessione
        HttpSession session = req.getSession();
        Utente utente = (Utente) session.getAttribute("utente");

        //Creiamo la prenotazione
        Prenotazione prenotazione = new Prenotazione(utente.getIdUtente(),dataPrenotazione,ora,"Confermato");

        //inseriamo la prenotazione nel databasepersonaltrainer
        Connessione c = new Connessione();
        Connection conn = c.connessione();
        QueryInsert queryInsert = new QueryInsert(conn);
        QuerySelect qs = new QuerySelect(conn);

        queryInsert.insertPrenotazione(prenotazione);

        //Recuperiamo dal prenotazione
        Prenotazione prenotazione1 = new Prenotazione();
        try {
            prenotazione1 = qs.selectPrenotazioneByIdUtenteGiornoOra(prenotazione.getIdUtente(), dataPrenotazione,ora);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        ArchivioPrenotazioni archivioPrenotazioni = new ArchivioPrenotazioni(utente.getIdUtente(), prenotazione1.getIdPrenotazione());
        queryInsert.insertArchivioPrenotazioni(archivioPrenotazioni);

        //Salviamo in sessione la prenotazione per visualizzarla nella campanella
        ArrayList<String> prenotazioniSessione = new ArrayList<>();
        prenotazioniSessione = (ArrayList<String>) session.getAttribute("prenotazioni");

        ArrayList<String> prenotazioni = new ArrayList<>();
        if(prenotazioniSessione != null) {
            for (String s : prenotazioniSessione) {
                prenotazioni.add(s);
            }
        }

        prenotazioni.add("Prenotazione del giorno " + prenotazione.getDataPrenotazione().toString() + " - " + prenotazione.getFasciaOraria() + " effettuata con successo!");
        session.setAttribute("prenotazioni", prenotazioni);

        RequestDispatcher dispatcher = req.getRequestDispatcher("homePageUser.jsp");
        dispatcher.forward(req, resp);

    }
}
