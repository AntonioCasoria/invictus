package BusinessLogicLayer;

import DataAccessLayer.bean.Utente;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
@WebServlet(name = "GetFormModificaServlet", value = "/GetFormModificaServlet")
public class GetFormModificaServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Utente u = (Utente) session.getAttribute("utente");

        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        if (u == null) {
            out.print("<div class='alert alert-danger'>Sessione scaduta. Effettua nuovamente il login.</div>");
            return;
        }

        out.print("<form id='formModificaDati' class='animated--fade-in p-2'>");
        out.print("  <div class='row'>");

        // --- COLONNA SINISTRA ---
        out.print("    <div class='col-md-6 border-right'>");
        out.print("      <div class='form-group mb-3'>");
        out.print("        <label class='label-profilo'>Nome</label>");
        out.print("        <input type='text' class='form-control' name='nome' value='" + u.getNome() + "'>");
        out.print("      </div>");
        out.print("      <div class='form-group mb-3'>");
        out.print("        <label class='label-profilo'>Cognome</label>");
        out.print("        <input type='text' class='form-control' name='cognome' value='" + u.getCognome() + "'>");
        out.print("      </div>");
        out.print("      <div class='form-group mb-3'>");
        out.print("        <label class='label-profilo'>Residenza (Indirizzo)</label>");
        out.print("        <input type='text' class='form-control' name='indirizzo' value='" + (u.getIndirizzo() != null ? u.getIndirizzo() : "") + "'>");
        out.print("      </div>");
        out.print("      <div class='form-group mb-3'>");
        out.print("        <label class='label-profilo'>Data di Nascita</label>");
        out.print("        <input type='date' class='form-control' name='dataNascita' value='" + u.getDataNascita() + "'>");
        out.print("      </div>");
        out.print("      <div class='form-group mb-3'>");
        out.print("        <label class='label-profilo'>Indirizzo Email (Sola Lettura)</label>");
        out.print("        <input type='email' class='form-control bg-light' value='" + u.getEmail() + "' readonly>");
        out.print("      </div>");
        out.print("    </div>");

        // --- COLONNA DESTRA ---
        out.print("    <div class='col-md-6 pl-md-4'>");
        out.print("      <div class='form-group mb-3'>");
        out.print("        <label class='label-profilo'>Data di Iscrizione</label>");
        out.print("        <input type='text' class='form-control bg-light' value='" + (u.getDataIscrizione() != null ? u.getDataIscrizione() : "---") + "' readonly>");
        out.print("      </div>");
        out.print("      <div class='form-group mb-3'>");
        out.print("        <label class='label-profilo'>Altezza (cm)</label>");
        out.print("        <input type='number' step='0.1' class='form-control' name='altezza' value='" + u.getAltezza() + "'>");
        out.print("      </div>");
        out.print("      <div class='form-group mb-3'>");
        out.print("        <label class='label-profilo'>Peso (kg)</label>");
        out.print("        <input type='number' step='0.1' class='form-control' name='peso' value='" + u.getPeso() + "'>");
        out.print("      </div>");
        out.print("      <div class='form-group mb-3'>");
        out.print("        <label class='label-profilo'>Obiettivo Fitness</label>");
        out.print("        <input type='text' class='form-control' name='obiettivo' value='" + u.getObiettivo() + "'>");
        out.print("      </div>");
        out.print("      <div class='form-group mb-3'>");
        out.print("        <label class='label-profilo text-primary'>Cambia Password</label>");
        out.print("        <input type='password' class='form-control' name='password' placeholder='Lascia vuoto per non cambiare'>");
        out.print("      </div>");
        out.print("    </div>");
        out.print("  </div>");

        out.print("  <hr class='my-4' style=\"background: #1e73be;\">");
        out.print("  <div class='text-center'>");
        out.print("    <button type='button' class='btn btn-secondary mr-2' onclick='caricaDatiAnagrafici()'>Annulla</button>");
        out.print("    <button type='button' class='btn btn-primary shadow-sm' onclick='salvaModifiche()'>");
        out.print("      Salva Modifiche");
        out.print("    </button>");
        out.print("  </div>");
        out.print("</form>");
    }
}