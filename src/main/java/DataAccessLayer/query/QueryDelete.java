package DataAccessLayer.query;

import DataAccessLayer.bean.*;
import DataAccessLayer.sql.DeleteMYSQL;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

public class QueryDelete {
    private Connection conn;

    public QueryDelete(java.sql.Connection conn) {
        this.conn = conn;
    }

    public ArchivioPrenotazioni deleteArchivioPrenotazioni(int id) throws SQLException {
        QuerySelect qs = new QuerySelect(conn);
        ArchivioPrenotazioni archivioPrenotazioni = qs.selectArchivioPrenotazioniById(id);

        String query = "DELETE FROM ArchivioPrenotazione WHERE IdArchivioPrenotazione = " + id;
        DeleteMYSQL delete = new DeleteMYSQL(conn);
        delete.delete(query);
        return archivioPrenotazioni;
    }

    public ArchivioSchedeAllenamento deleteArchivioSchedeAllenamento(int id) throws SQLException {
        QuerySelect qs = new QuerySelect(conn);
        ArchivioSchedeAllenamento asa = qs.selectArchivioSchedeAllenamentoById(id);

        String query = "DELETE FROM ArchivioSchedaAllenamento WHERE IdArchivioScheda = " + id;
        DeleteMYSQL delete = new DeleteMYSQL(conn);
        delete.delete(query);
        return asa;
    }

    public Comporre deleteComporre(int idEsercizio, int idScheda) throws SQLException {
        QuerySelect qs = new QuerySelect(conn);
        ArrayList<Comporre> c = qs.selectComporre();
        Comporre c1 = new Comporre();

        for (Comporre comporre : c) {
            if(comporre.getIdEsercizio() == idEsercizio && comporre.getIdScheda() == idScheda){
                c1.setIdEsercizio(comporre.getIdEsercizio());
                c1.setIdScheda(comporre.getIdScheda());

            }
        }

        String query = "DELETE FROM Comporre WHERE IdEsercizio = " + idEsercizio + " AND IdScheda = " + idScheda;
        DeleteMYSQL delete = new DeleteMYSQL(conn);
        delete.delete(query);
        return c1;
    }

    public Esercizio deleteEsercizio(int id) throws SQLException {
        QuerySelect qs = new QuerySelect(conn);
        Esercizio e = qs.selectEsercizioById(id);

        String query = "DELETE FROM Esercizio WHERE IdEsercizio = " + id;
        DeleteMYSQL delete = new DeleteMYSQL(conn);
        delete.delete(query);
        return e;
    }

    public Generare deleteGenerare(int idEsercizio, int idPerfomance) throws SQLException {
        QuerySelect qs = new QuerySelect(conn);
        ArrayList<Generare> g = qs.selectGenerareById(idEsercizio);
        Generare g1 = new Generare(idEsercizio, idPerfomance);

        for (Generare generare : g) {
            if(generare.getIdEsercizio() == idEsercizio && generare.getIdPerfomance() == idPerfomance){
                g1.setIdEsercizio(generare.getIdEsercizio());
                g1.setIdPerfomance(generare.getIdPerfomance());
            }
        }

        String query = "DELETE FROM Generare WHERE IdEsercizio = " + idEsercizio + " AND IdPerfomance = " + idPerfomance;
        DeleteMYSQL delete = new DeleteMYSQL(conn);
        delete.delete(query);

        return g1;
    }

    public Performance deletePerformance(int id) throws SQLException {
        QuerySelect qs = new QuerySelect(conn);
        Performance p = qs.selectPerformanceById(id);

        String query = "DELETE FROM Performance WHERE IdPerformance = " + id;
        DeleteMYSQL delete = new DeleteMYSQL(conn);
        delete.delete(query);
        return p;
    }

    public PersonalTrainer deletePersonalTrainer(int id) throws SQLException {
        QuerySelect qs = new QuerySelect(conn);
        PersonalTrainer pt = qs.selectPersonalTrainerById(id);

        String query = "DELETE FROM PersonalTrainer WHERE IdPT = " + id;
        DeleteMYSQL delete = new DeleteMYSQL(conn);
        delete.delete(query);
        return pt;
    }

    public Prenotazione deletePrenotazione(int id) throws SQLException {
        QuerySelect qs = new QuerySelect(conn);
        Prenotazione p = qs.selectPrenotazioneById(id);

        String query = "DELETE FROM Prenotazione WHERE IdPrenotazione = " + id;
        DeleteMYSQL delete = new DeleteMYSQL(conn);
        delete.delete(query);
        return p;
    }

    public Progressi deleteProgressi(int id) throws SQLException {
        QuerySelect qs = new QuerySelect(conn);
        Progressi p = qs.selectProgressiById(id);

        String query = "DELETE FROM Progressi WHERE IdProgressi = " + id;
        DeleteMYSQL delete = new DeleteMYSQL(conn);
        delete.delete(query);
        return p;
    }

    public SchedaAllenamento deleteSchedaAllenamento(int id) throws SQLException {
        QuerySelect qs = new QuerySelect(conn);
        SchedaAllenamento sa = qs.selectSchedaAllenamentoById(id);

        String query = "DELETE FROM SchedaAllenamento WHERE IdScheda = " + id;
        DeleteMYSQL delete = new DeleteMYSQL(conn);
        delete.delete(query);
        return sa;
    }

    public Utente deleteUtente(int id) throws SQLException {
        QuerySelect qs = new QuerySelect(conn);
        Utente u = qs.selectUtenteById(id);

        String query = "DELETE FROM Utente WHERE IdUtente = " + id;
        DeleteMYSQL delete = new DeleteMYSQL(conn);
        delete.delete(query);
        return u;
    }


}
