package DataAccessLayer.query;

import DataAccessLayer.bean.*;
import DataAccessLayer.sql.InsertMYSQL;

import java.sql.Connection;

public class QueryInsert {
    private Connection conn;

    public QueryInsert(Connection conn) {
        this.conn = conn;
    }

    public void insertArchivioPrenotazioni(ArchivioPrenotazioni ap){
        InsertMYSQL insert = new InsertMYSQL(conn);
        String query = "insert into ArchivioPrenotazione(IdUtente,IdPrenotazione) values " +
                "(" + ap.getIdUtente() + "," + ap.getIdPrenotazione() + ")";
        insert.insert(query);
    }

    public void insertArchivioSchedeAllenamento(ArchivioSchedeAllenamento asa){
        InsertMYSQL insert = new InsertMYSQL(conn);
        String query = "insert into ArchivioSchedaAllenamento(IdUtente,IdScheda,IdPT) values " +
                "(" + asa.getIdUtente() + "," + asa.getIdScheda() + "," + asa.getIdPT() + ")";
        insert.insert(query);
    }

    public void insertComporre(Comporre c) {
        InsertMYSQL insert = new InsertMYSQL(conn);
        String query = "insert into Comporre(IdEsercizio,IdScheda) values" +
                "(" + c.getIdEsercizio() + "," + c.getIdScheda() + ")";
        insert.insert(query);
    }

    public void insertEsercizio(Esercizio e){
        InsertMYSQL insert = new InsertMYSQL(conn);
        String query = "insert into Esercizio(Nome,Descrizione,GruppoMuscolare,Serie,Ripetizione,TempoRecupero,ContenutoMultimediale,ContenutoMultimediale2) values" +
                "('" + e.getNome() + "','" + e.getDescrizione() + "','" + e.getGruppoMuscolare() + "', " + e.getSerie() + ", " + e.getRipetizione() + ", " + e.getTempoRecupero() + " ,'" + e.getContenutoMultimediale() + "','" + e.getContenutoMultimediale2() + "')";
        insert.insert(query);
    }

    public void insertGenerare(Generare g){
        InsertMYSQL insert = new InsertMYSQL(conn);
        String query = "insert into Generare(IdEsercizio,IdPerfomance) values" +
                "(" + g.getIdEsercizio() + "," + g.getIdPerfomance() + ")";
        insert.insert(query);
    }

    public void insertPerformance(Performance p){
        InsertMYSQL insert = new InsertMYSQL(conn);
        String query = "insert into Performance(IdUtente,Data,Feedback,Carico,RPE,SerieEffettive,RipetizioniEffettive,TempoRecuperoEffettive,RPEEffettivo) values" +
                "(" + p.getIdUtente() + ", '" + p.getData() + "', '" + p.getFeedback() + "', " + p.getCarico() + ", " + p.getRPE() + ", " + p.getSerieEffettive() + ", " + p.getRipetizioniEffettive() + ", " + p.getTempoRecuperoEffettivo() + ", " + p.getRPEeffettivo() + ")";
        insert.insert(query);
    }

    public void insertPersonalTrainer(PersonalTrainer pt){
        InsertMYSQL insert = new InsertMYSQL(conn);
        String query = "insert into PersonalTrainer(Nome,Cognome,Email,Password,DataNascita) values" +
                "('" + pt.getNome() + "','" + pt.getCognome() + "','" + pt.getEmail() + "','" + pt.getPassword() + "', '" + pt.getDataNascita() + "')";
        insert.insert(query);
    }

    public void insertPrenotazione(Prenotazione p){
        InsertMYSQL insert = new InsertMYSQL(conn);
        String query = "insert into Prenotazione(IdUtente,DataPrenotazione,FasciaOraria,Stato) values" +
                "(" + p.getIdUtente() + ", '" + p.getDataPrenotazione() + "', '" + p.getFasciaOraria() + "', '" + p.getStato() + "')";
        insert.insert(query);
    }

    public void insertProgressi(Progressi p){
        InsertMYSQL insert = new InsertMYSQL(conn);
        String query = "insert into Progressi(IdPerformance,IdUtente,IdEsercizio) values" +
                "(" + p.getIdPerfomance() + ", " + p.getIdUtente() + ", " + p.getIdEsercizio() + ")";
        insert.insert(query);
    }

    public void insertSchedaAllenamento(SchedaAllenamento sa){
        InsertMYSQL insert = new InsertMYSQL(conn);
        String query = "insert into SchedaAllenamento(IdUtente,IdPT,DataCreazione,Durata,Obiettivo) values" +
                "(" + sa.getIdUtente() + ", " + sa.getIdPT() + ", '" + sa.getDataCreazione() + "', " + sa.getDurata() + ", '" + sa.getObiettivo() + "')";
        insert.insert(query);
    }

    public void insertUtente(Utente u){
        InsertMYSQL insert = new InsertMYSQL(conn);
        String query = "insert into Utente(Nome,Cognome,Email,Password,DataNascita,Indirizzo,Ruolo,Eta,Sesso,Altezza,Peso,FitnessLevel,AnniEsperienzaDichiarati,FrequenzaSettimanale,DataIscrizione,Obiettivo) values" +
                "('" + u.getNome() + "','" + u.getCognome() + "','" + u.getEmail() + "','" + u.getPassword() + "', '" + u.getDataNascita() + "', '" + u.getIndirizzo() + "', '" + u.getRuolo() + "', " + u.getEta() + ", '" + u.getSesso() + "', " + u.getAltezza() + ", " + u.getPeso() + ", '" + u.getFitnessLevel() + "', " + u.getAnniEsperienzaDichiarati() + ", " + u.getFrequenzaSettimanale() + ", '" + u.getDataIscrizione() + "', '" + u.getObiettivo() + "')";
        insert.insert(query);
    }

}
