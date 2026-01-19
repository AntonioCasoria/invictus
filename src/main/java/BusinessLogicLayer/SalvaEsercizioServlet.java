package BusinessLogicLayer;

import DataAccessLayer.bean.Esercizio;
import DataAccessLayer.query.QueryInsert;
import DataAccessLayer.query.QuerySelect;
import DataAccessLayer.sql.Connessione;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;

@WebServlet(name = "SalvaEsercizioServlet", value = "/SalvaEsercizioServlet")
public class SalvaEsercizioServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //Riprendiamo i parametri dalla form
        String nomeEsercizio = req.getParameter("Nome");
        String descrizioneEsercizio = req.getParameter("Descrizione");
        String gruppoMuscolare = req.getParameter("GruppoMuscolare");
        int serie = Integer.parseInt(req.getParameter("Serie"));
        int ripetizioni = Integer.parseInt(req.getParameter("Ripetizioni"));
        int tempoRecupero = Integer.parseInt(req.getParameter("TempoRecupero"));
        String contenutoMultimediale1 = req.getParameter("ContenutoMultimediale1");
        String contenutoMultimediale2 = req.getParameter("ContenutoMultimediale2");

        //Istanziamo la connessione
        Connessione c = new Connessione();
        Connection conn = c.connessione();
        QueryInsert queryInsert = new QueryInsert(conn);

        //Creiamo l'esercizio e lo inseriamo nel database
        Esercizio esercizio = new Esercizio(nomeEsercizio,descrizioneEsercizio,gruppoMuscolare,serie,ripetizioni,tempoRecupero,contenutoMultimediale1,contenutoMultimediale2);
        System.out.println(esercizio.toString());
        queryInsert.insertEsercizio(esercizio);

        RequestDispatcher dispatcher = req.getRequestDispatcher("homePagePT.jsp");
        dispatcher.forward(req, resp);
    }
}
