package BusinessLogicLayer;

import DataAccessLayer.bean.SchedaAllenamento;
import DataAccessLayer.bean.Utente;
import DataAccessLayer.query.QuerySelect;
import DataAccessLayer.sql.Connessione;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "GetStoricoSchedeServlet", value = "/GetStoricoSchedeServlet")
public class GetStoricoSchedeServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Utente u = (Utente) session.getAttribute("utente");
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        try {
            QuerySelect qs = new QuerySelect(new Connessione().connessione());
            List<SchedaAllenamento> schede = qs.getSchedeByUtente(u.getIdUtente());

            if (schede.isEmpty()) {
                out.print("<div class='text-center py-5'><p class='text-muted'>Nessuna scheda presente in archivio.</p></div>");
            } else {
                // Generazione del contenitore a scorrimento orizzontale [cite: 2026-01-20]
                out.print("<div class='schede-scroll-wrapper py-3'>");
                for (SchedaAllenamento s : schede) {
                    out.print("<div class='scheda-card shadow-sm'>");
                    out.print("  <div class='scheda-icon'><i class='fas fa-clipboard-list'></i></div>");
                    out.print("  <div class='scheda-title'>" + s.getNome() + "</div>");
                    out.print("  <div class='scheda-date mt-2'>");
                    out.print("    <span>Dal: " + s.getDataCreazione() + "</span><br>");
                    out.print("  </div>");
                    out.print("</div>");
                }
                out.print("</div>");
            }
        } catch (Exception e) { e.printStackTrace(); }
    }
}