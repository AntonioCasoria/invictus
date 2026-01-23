package BusinessLogicLayer;

import DataAccessLayer.bean.PersonalTrainer;
import DataAccessLayer.bean.Utente;
import DataAccessLayer.query.QueryDelete;
import DataAccessLayer.sql.Connessione;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "EliminaPersonalTrainerServlet", value = "/EliminaPersonalTrainerServlet")
public class EliminaPersonalTrainerServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("idUtente");
        resp.setContentType("application/json");

        if (idParam != null) {
            try {
                Connessione c = new Connessione();
                // Assumiamo che il metodo deleteUtente sia nel tuo DAO dedicato
                QueryDelete qd = new QueryDelete(c.connessione());

                // Utilizzo della tua query [cite: 2026-01-23]
                PersonalTrainer utenteEliminato = qd.deletePersonalTrainer(Integer.parseInt(idParam));

                if (utenteEliminato != null) {
                    resp.getWriter().write("{\"status\": \"success\", \"nome\": \"" + utenteEliminato.getNome() + "\"}");
                } else {
                    resp.getWriter().write("{\"status\": \"error\"}");
                }
            } catch (Exception e) {
                e.printStackTrace();
                resp.getWriter().write("{\"status\": \"error\"}");
            }
        }
    }
}
