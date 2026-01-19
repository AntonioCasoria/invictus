package BusinessLogicLayer;

import DataAccessLayer.sql.Connessione;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "UpdateSchedaServlet", value = "/UpdateSchedaServlet")
public class UpdateSchedaServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Recupero dei parametri
        String idSchedaStr = req.getParameter("idSchedaModifica");
        String[] idEsArray = req.getParameterValues("idEsercizio");
        String[] giorniArray = req.getParameterValues("giornoScheda");

        if (idSchedaStr == null || idEsArray == null || giorniArray == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Dati mancanti");
            return;
        }

        int idScheda = Integer.parseInt(idSchedaStr);
        Connessione c = new Connessione();
        Connection conn = c.connessione();;

        try {
            conn.setAutoCommit(false);
            // CANCELLAZIONE vecchia composizione
            String deleteSql = "DELETE FROM comporre WHERE IdScheda = ?";
            try (PreparedStatement psDelete = conn.prepareStatement(deleteSql)) {
                psDelete.setInt(1, idScheda);
                psDelete.executeUpdate();
            }

            // INSERIMENTO nuova composizione
            String insertSql = "INSERT INTO comporre (IdScheda, IdEsercizio, Giorno) VALUES (?, ?, ?)";
            try (PreparedStatement psInsert = conn.prepareStatement(insertSql)) {
                for (int i = 0; i < idEsArray.length; i++) {
                    // Verifichiamo che l'ID esercizio non sia vuoto (es. slot non compilati)
                    if (idEsArray[i] != null && !idEsArray[i].isEmpty()) {
                        psInsert.setInt(1, idScheda);
                        psInsert.setInt(2, Integer.parseInt(idEsArray[i]));
                        psInsert.setInt(3, Integer.parseInt(giorniArray[i]));
                        psInsert.addBatch(); // Usiamo il batch per performance migliori
                    }
                }
                psInsert.executeBatch();
            }

            // COMMIT della transazione
            conn.commit();
            resp.setStatus(HttpServletResponse.SC_OK);

        } catch (SQLException e) {
            // In caso di errore, annulliamo tutto (Rollback)
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Errore nel database");
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }


    }
}
