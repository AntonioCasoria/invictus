package BusinessLogicLayer;

import DataAccessLayer.bean.Consultare;
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
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "InserisciRichiestaServlet", value = "/InserisciRichiestaServlet")
public class InserisciRichiestaServlet extends HttpServlet {
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
        QuerySelect querySelect = new QuerySelect(conn);

        // 1. Recupero dei parametri inviati dal form
        int idPTStr = Integer.parseInt(req.getParameter("idPT"));
        String messaggio = req.getParameter("messaggio");

        // 2. Recupero dell'utente dalla sessione
        HttpSession session = req.getSession();
        Utente utente = (Utente) session.getAttribute("utente");

        List<Consultare> listaConsultare = new ArrayList<>();
        try {
            listaConsultare = querySelect.selectConsultareAll();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        boolean flag = true;
        for(Consultare consultare : listaConsultare){
            //Presente una richiesta
            if(consultare.getIdUtente() == utente.getIdUtente() && consultare.getIdPT() == idPTStr){
                //Se la richiesta ha stato 'Consultato'
                if(consultare.getStato().equals("Consultato")){
                    flag = false;
                    break;
                }
            }
        }

        if(flag){
            Consultare consultare = new Consultare(utente.getIdUtente(),idPTStr,messaggio,"Consultato");
            queryInsert.insertConsultare(consultare);
            resp.sendRedirect("richiestaScheda.jsp?success=true");
        }else{
            resp.sendRedirect("richiestaScheda.jsp?status=alreadyConsulted");
        }

    }
}
