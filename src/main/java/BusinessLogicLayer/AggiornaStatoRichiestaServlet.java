package BusinessLogicLayer;

import DataAccessLayer.bean.PersonalTrainer;
import DataAccessLayer.query.QueryUpdate;
import DataAccessLayer.sql.Connessione;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;

@WebServlet(name = "AggiornaStatoRichiestaServlet", value = "/AggiornaStatoRichiestaServlet")
public class AggiornaStatoRichiestaServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        PersonalTrainer pt = (PersonalTrainer) session.getAttribute("personalTrainer");

        int idUtente = Integer.parseInt(req.getParameter("idUtente"));
        int idRichiesta = Integer.parseInt(req.getParameter("idRichiesta"));

        Connessione c = new Connessione();
        Connection conn = c.connessione();
        QueryUpdate queryUpdate = new QueryUpdate(conn);

        queryUpdate.updateConsultare2(idUtente, pt.getIdPT(), idRichiesta);

        resp.sendRedirect("homePagePT.jsp");
    }
}
