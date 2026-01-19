package BusinessLogicLayer;

import DataAccessLayer.bean.ArchivioSchedeAllenamento;
import DataAccessLayer.bean.Assegnare;
import DataAccessLayer.bean.PersonalTrainer;
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

@WebServlet(name = "AssegnaSchedaServlet", value = "/AssegnaSchedaServlet")
public class AssegnaSchedaServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //Istanziamo la connessione
        Connessione c = new Connessione();
        Connection conn = c.connessione();
        QueryInsert queryInsert = new QueryInsert(conn);

        //Riprendiamo gli id dalla form
        int idUtente = Integer.parseInt(req.getParameter("IdUtente"));
        int idScheda = Integer.parseInt(req.getParameter("IdScheda"));

        //Inseriamo l'assegnazione nel db
        Assegnare assegnare = new Assegnare(idScheda, idUtente);
        queryInsert.insertAssegnare(assegnare);

        //Inseriamo in archivio schede allenamento
        HttpSession session = req.getSession();
        PersonalTrainer pt = (PersonalTrainer) session.getAttribute("personalTrainer");

        ArchivioSchedeAllenamento archivioSchedeAllenamento = new ArchivioSchedeAllenamento(idUtente, idScheda, pt.getIdPT());
        queryInsert.insertArchivioSchedeAllenamento(archivioSchedeAllenamento);

        RequestDispatcher dispatcher = req.getRequestDispatcher("./homePagePT.jsp");
        dispatcher.forward(req, resp);

    }
}
