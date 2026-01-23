package BusinessLogicLayer;

import DataAccessLayer.bean.Prenotazione;
import DataAccessLayer.bean.Utente;
import DataAccessLayer.query.QuerySelect;
import DataAccessLayer.sql.Connessione;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "GetPrenotazioniAttiveServlet", value = "/GetPrenotazioniAttiveServlet")
public class GetPrenotazioniAttiveServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Utente u = (Utente) session.getAttribute("utente");

        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        if (u == null) {
            out.print("<div class='alert alert-danger'>Sessione scaduta.</div>");
            return;
        }

        Connessione c = new Connessione();
        Connection conn = c.connessione();
        QuerySelect qs = new QuerySelect(conn);

        List<Prenotazione> lista = new ArrayList<>();
        try {
            // Recuperiamo la lista delle prenotazioni future
            lista = qs.selectPrenotazioniAttive(u.getIdUtente());

            if (lista.isEmpty()) {
                out.print("<div class='text-center py-5'>");
                out.print("  <i class='fas fa-calendar-times fa-3x text-gray-300 mb-3'></i>");
                out.print("  <p class='text-gray-500'>Non hai prenotazioni attive al momento.</p>");
                out.print("  <a href='prenotazione.jsp' class='btn btn-primary btn-sm'>Prenota ora</a>");
                out.print("</div>");
            } else {
                out.print("<div class='table-responsive animated--fade-in'>");
                out.print("  <table class='table table-hover'>");
                out.print("    <thead class='thead-light'>");
                out.print("      <tr><th>Data</th><th>Fascia Oraria</th><th>Stato</th></tr>");
                out.print("    </thead>");
                out.print("    <tbody>");
                for (Prenotazione p : lista) {
                    out.print("      <tr>");
                    out.print("        <td class='font-weight-bold'>" + p.getDataPrenotazione() + "</td>");
                    out.print("        <td>" + p.getFasciaOraria() + "</td>");
                    out.print("        <td><span class='badge badge-success'>Confermata</span></td>");
                    out.print("      </tr>");
                }
                out.print("    </tbody></table></div>");
            }
        } catch (Exception e) {
            out.print("<div class='alert alert-danger'>Errore nel recupero dei dati.</div>");
        }
    }
}
