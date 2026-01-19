package BusinessLogicLayer;

import DataAccessLayer.bean.Comporre;
import DataAccessLayer.bean.PersonalTrainer;
import DataAccessLayer.bean.SchedaAllenamento;
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
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "SalvaSchedaServlet", value = "/SalvaSchedaServlet")
public class SalvaSchedaServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Recupero dati generali della scheda
        String nomeScheda = req.getParameter("Nome");
        String obiettivo = req.getParameter("Obiettivo");
        String durata = req.getParameter("Durata");
        PersonalTrainer personalTrainer = (PersonalTrainer) req.getSession().getAttribute("personalTrainer");

        // Recupero gli array degli esercizi e dei giorni
        String[] arrayIdEsercizi = req.getParameterValues("idEsercizio");
        String[] arrayGiorni = req.getParameterValues("giornoScheda");

        // Logica di salvataggio
        //Istanziamo la connessione
        Connessione c = new Connessione();
        Connection conn = c.connessione();
        QuerySelect querySelect = new QuerySelect(conn);
        QueryInsert queryInsert = new QueryInsert(conn);

        //Salvare la scheda solo se i campi non sono vuoti
        if(nomeScheda != null && obiettivo != null && durata != null) {
            SchedaAllenamento schedaAllenamento = new SchedaAllenamento(personalTrainer.getIdPT(), LocalDate.now(), durata, obiettivo, nomeScheda);

            //Inserisco la scheda allenamento nel database
            queryInsert.insertSchedaAllenamento(schedaAllenamento);
            List<SchedaAllenamento> lista = new ArrayList<>();
            try {
                lista = querySelect.getSchedaAllenamentoAll();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            for(SchedaAllenamento s : lista){
                if(s.getNome().equals(nomeScheda) && s.getIdPT() == personalTrainer.getIdPT()){
                    schedaAllenamento.setIdScheda(s.getIdScheda());
                }
            }

            //Inserisco il contenuto della scheda allenamento nel database
            if(arrayIdEsercizi != null && arrayGiorni != null) {
                for (int i = 0; i < arrayIdEsercizi.length; i++) {
                    String idEs = arrayIdEsercizi[i];
                    String giorno = arrayGiorni[i];


                    // Salva solo se il pt ha effettivamente scelto un esercizio (id non vuoto)
                    if (idEs != null && !idEs.isEmpty()) {
                        int idEffettivo = Integer.parseInt(idEs);
                        int giornoEffettivo = Integer.parseInt(giorno);

                        Comporre comporre = new Comporre(idEffettivo, schedaAllenamento.getIdScheda(), giornoEffettivo);
                        queryInsert.insertComporre(comporre);
                    }
                }
            }
        }

        RequestDispatcher dispatcher = req.getRequestDispatcher("homePagePT.jsp");
        dispatcher.forward(req, resp);

    }


}
