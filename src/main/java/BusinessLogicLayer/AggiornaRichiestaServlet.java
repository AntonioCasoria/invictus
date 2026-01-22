package BusinessLogicLayer;

import DataAccessLayer.bean.Consultare;
import DataAccessLayer.bean.Utente;
import DataAccessLayer.query.QueryInsert;
import DataAccessLayer.query.QuerySelect;
import DataAccessLayer.query.QueryUpdate;
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

@WebServlet(name = "AggiornaRichiestaServlet", value = "/AggiornaRichiestaServlet")
public class AggiornaRichiestaServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connessione c = new Connessione();
        Connection conn = c.connessione();
        QueryUpdate queryUpdate = new QueryUpdate(conn);
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


        boolean flag = false;
        for(Consultare consultare : listaConsultare){
            if(consultare.getIdUtente() == utente.getIdUtente() && consultare.getIdPT() == idPTStr){
                if(consultare.getStato().equals("Consegnato")) {
                    queryUpdate.updateConsultare(utente.getIdUtente(), idPTStr, messaggio);
                    flag = true;
                    break;
                }
            }else{
                flag = false;
                break;
            }
        }

        if(flag){
            resp.sendRedirect("richiestaScheda.jsp?success=true");
        }else{
            resp.sendRedirect("richiestaScheda.jsp?error=true");
        }
    }
}
