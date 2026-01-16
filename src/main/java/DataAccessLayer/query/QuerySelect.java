package DataAccessLayer.query;

import DataAccessLayer.bean.*;
import DataAccessLayer.sql.SelectMYSQL;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class QuerySelect {
    private Connection conn;
    private SelectMYSQL select;

    public QuerySelect(Connection conn) {
        this.conn = conn;
        this.select = new SelectMYSQL(conn);
    }

    public ArchivioPrenotazioni selectArchivioPrenotazioniById(int id) throws SQLException {
        String query = "SELECT * FROM ArchivioPrenotazione WHERE IdArchivioPrenotazione = "  + id;
        ResultSet rs = select.select(query);
        ArchivioPrenotazioni ap = new ArchivioPrenotazioni();

        if(rs.next()){
            ap.setIdArchivioPrenotazione(rs.getInt(1));
            ap.setIdUtente(rs.getInt(2));
            ap.setIdPrenotazione(rs.getInt(3));
        }
        return ap;
    }

    public ArchivioSchedeAllenamento selectArchivioSchedeAllenamentoById(int id) throws SQLException {
        String query = "SELECT * FROM ArchivioSchedaAllenamento WHERE IdArchivioScheda = "  + id;
        ResultSet rs = select.select(query);
        ArchivioSchedeAllenamento asa = new ArchivioSchedeAllenamento();

        if(rs.next()){
            asa.setIdArchivioSchedaAllenamento(rs.getInt(1));
            asa.setIdUtente(rs.getInt(2));
            asa.setIdScheda(rs.getInt(3));
            asa.setIdPT(rs.getInt(4));
        }

        return asa;
    }

    public ArrayList<Comporre> selectComporre() throws SQLException {
        String query = "SELECT * FROM Comporre";
        ResultSet rs = select.select(query);
        ArrayList<Comporre> c = new ArrayList<>();

        while (rs.next()){
            Comporre c1 = new Comporre(rs.getInt(1),rs.getInt(2));
            c.add(c1);
        }

        return c;
    }

    public Esercizio selectEsercizioById(int id) throws SQLException {
        String query = "SELECT * FROM Esercizio WHERE IdEsercizio = "  + id;
        ResultSet rs = select.select(query);
        Esercizio e = new Esercizio();

        if(rs.next()){
            e.setIdEsercizio(rs.getInt(1));
            e.setNome(rs.getString(2));
            e.setDescrizione(rs.getString(3));
            e.setGruppoMuscolare(rs.getString(4));
            e.setSerie(rs.getInt(5));
            e.setRipetizione(rs.getInt(6));
            e.setTempoRecupero(rs.getInt(7));
            e.setContenutoMultimediale(rs.getString(8));
            e.setContenutoMultimediale2(rs.getString(9));
        }

        return e;
    }

    public ArrayList<Generare> selectGenerareById(int id) throws SQLException {
        String query = "SELECT * FROM Generare";
        ResultSet rs = select.select(query);
        ArrayList<Generare> g= new ArrayList<>();

        while (rs.next()){
            Generare g1 = new Generare(rs.getInt(1),rs.getInt(2));
            g.add(g1);
        }

        return g;
    }

    public Performance selectPerformanceById(int id) throws SQLException {
        String query = "SELECT * FROM Performance WHERE IdPerformance = "  + id;
        ResultSet rs = select.select(query);
        Performance p = new Performance();

        if(rs.next()){
            p.setIdPerformance(rs.getInt(1));
            p.setIdUtente(rs.getInt(2));
            p.setData(rs.getString(3));
            p.setFeedback(rs.getString(4));
            p.setCarico(rs.getInt(5));
            p.setRPE(rs.getInt(6));
            p.setSerieEffettive(rs.getInt(7));
            p.setRipetizioniEffettive(rs.getInt(8));
            p.setTempoRecuperoEffettivo(rs.getInt(9));
            p.setRPEeffettivo(rs.getInt(10));
        }

        return p;
    }

    public PersonalTrainer selectPersonalTrainerById(int id) throws SQLException {
        String query = "SELECT * FROM PersonalTrainer WHERE IdPersonalTrainer = "  + id;
        ResultSet rs = select.select(query);
        PersonalTrainer pt = new PersonalTrainer();

        if(rs.next()){
            pt.setIdPT(rs.getInt(1));
            pt.setNome(rs.getString(2));
            pt.setCognome(rs.getString(3));
            pt.setEmail(rs.getString(4));
            pt.setPassword(rs.getString(5));
            pt.setDataNascita(rs.getString(6));
        }

        return pt;
    }

    public Prenotazione selectPrenotazioneById(int id) throws SQLException {
        String query = "SELECT * FROM Prenotazione WHERE IdPrenotazione = "  + id;
        ResultSet rs = select.select(query);
        Prenotazione p = new Prenotazione();

        if(rs.next()){
            p.setIdPrenotazione(rs.getInt(1));
            p.setIdUtente(rs.getInt(2));
            p.setDataPrenotazione(rs.getDate(3).toLocalDate());
            p.setFasciaOraria(rs.getString(4));
            p.setStato(rs.getString(5));
        }

        return p;
    }

    public Prenotazione selectPrenotazioneByIdUtenteGiornoOra(int id, LocalDate data, String ora) throws SQLException {
        String query = "SELECT * FROM Prenotazione WHERE IdUtente = "  + id + " AND DataPrenotazione = '" + data + "' AND FasciaOraria = '" + ora + "'";
        ResultSet rs = select.select(query);
        Prenotazione p = new Prenotazione();

        if(rs.next()){
            p.setIdPrenotazione(rs.getInt(1));
            p.setIdUtente(rs.getInt(2));
            p.setDataPrenotazione(rs.getDate(3).toLocalDate());
            p.setFasciaOraria(rs.getString(4));
            p.setStato(rs.getString(5));
        }

        return p;
    }

    public Progressi selectProgressiById(int id) throws SQLException {
        String query = "SELECT * FROM Progressi WHERE IdProgressi = "  + id;
        ResultSet rs = select.select(query);
        Progressi p = new Progressi();

        if(rs.next()){
            p.setIdProgressi(rs.getInt(1));
            p.setIdProgressi(rs.getInt(2));
            p.setIdUtente(rs.getInt(3));
            p.setIdEsercizio(rs.getInt(4));

        }

        return p;
    }

    public SchedaAllenamento selectSchedaAllenamentoById(int id) throws SQLException {
        String query = "SELECT * FROM SchedaAllenamento WHERE IdScheda " + id;
        ResultSet rs = select.select(query);
        SchedaAllenamento sa = new SchedaAllenamento();

        if(rs.next()){
            sa.setIdScheda(rs.getInt(1));
            sa.setIdUtente(rs.getInt(2));
            sa.setIdPT(rs.getInt(3));
            sa.setDataCreazione(rs.getString(4));
            sa.setDurata(rs.getString(5));
            sa.setObiettivo(rs.getString(6));
        }

        return sa;
    }

    public Utente selectUtenteById(int id) throws SQLException {
        String query = "SELECT * FROM Utente WHERE IdUtente = "  + id;
        ResultSet rs = select.select(query);
        Utente u = new Utente();

        if(rs.next()){
            u.setIdUtente(rs.getInt(1));
            u.setNome(rs.getString(2));
            u.setCognome(rs.getString(3));
            u.setEmail(rs.getString(4));
            u.setPassword(rs.getString(5));
            u.setDataNascita(rs.getDate(6).toLocalDate());
            u.setIndirizzo(rs.getString(7));
            u.setRuolo(rs.getString(8));
            u.setEta(rs.getInt(9));
            u.setSesso(rs.getString(10));
            u.setAltezza(rs.getInt(11));
            u.setPeso(rs.getInt(12));
            u.setFitnessLevel(rs.getString(13));
            u.setAnniEsperienzaDichiarati(rs.getString(14));
            u.setAnniEsperienzaDichiarati(rs.getString(15));
            u.setDataIscrizione(rs.getDate(16).toLocalDate());
            u.setObiettivo(rs.getString(17));
        }

        return u;
    }

    public ArrayList<Utente> selectUtentiAll() throws SQLException {
        String query = "SELECT * FROM Utente";
        ResultSet rs = select.select(query);
        ArrayList<Utente> utenti = new ArrayList<>();

        while(rs.next()){
            Utente u = new Utente();
            u.setIdUtente(rs.getInt(1));
            u.setNome(rs.getString(2));
            u.setCognome(rs.getString(3));
            u.setEmail(rs.getString(4));
            u.setPassword(rs.getString(5));
            u.setDataNascita(rs.getDate(6).toLocalDate());
            u.setIndirizzo(rs.getString(7));
            u.setRuolo(rs.getString(8));
            u.setEta(rs.getInt(9));
            u.setSesso(rs.getString(10));
            u.setAltezza(rs.getInt(11));
            u.setPeso(rs.getInt(12));
            u.setFitnessLevel(rs.getString(13));
            u.setAnniEsperienzaDichiarati(rs.getString(14));
            u.setAnniEsperienzaDichiarati(rs.getString(15));
            u.setDataIscrizione(rs.getDate(16).toLocalDate());
            u.setObiettivo(rs.getString(17));

            utenti.add(u);
        }
        return utenti;
    }

    public List<String> getOrariByUtenteEData(int id, LocalDate data) throws SQLException {
        String query = "SELECT DISTINCT FasciaOraria FROM Prenotazione WHERE IdUtente = " + id + " AND DataPrenotazione = '" + data + "'";
        ResultSet rs = select.select(query);
        List<String> orari = new ArrayList<>();

        while (rs.next()){
            orari.add(rs.getString(1));
        }
        return orari;
    }

    public List<String> getOrariEsauritiByData(LocalDate data, int capienza) throws SQLException {
        String query = "SELECT FasciaOraria from Prenotazione where DataPrenotazione = '"+ data +"' group by FasciaOraria having count(IdUtente)>="+capienza;
        ResultSet rs = select.select(query);
        List<String> orari = new ArrayList<>();

        while (rs.next()){
            orari.add(rs.getString(1));
        }
        return orari;
    }
}
