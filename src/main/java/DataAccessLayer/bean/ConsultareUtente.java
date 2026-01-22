package DataAccessLayer.bean;

import java.util.Objects;

public class ConsultareUtente {
    private int idRichiesta;
    private int idUtente;
    private int idPT;
    private String richiesta;
    private String stato;
    private String nome;
    private String cognome;
    private String obiettivo;

    public ConsultareUtente() {
    }

    public ConsultareUtente(int idRichiesta, int idUtente, int idPT, String richiesta, String stato, String nome, String cognome, String obiettivo) {
        this.idRichiesta = idRichiesta;
        this.idUtente = idUtente;
        this.idPT = idPT;
        this.richiesta = richiesta;
        this.stato = stato;
        this.nome = nome;
        this.cognome = cognome;
        this.obiettivo = obiettivo;
    }

    public int getIdRichiesta() {
        return idRichiesta;
    }

    public void setIdRichiesta(int idRichiesta) {
        this.idRichiesta = idRichiesta;
    }

    public int getIdUtente() {
        return idUtente;
    }

    public void setIdUtente(int idUtente) {
        this.idUtente = idUtente;
    }

    public int getIdPT() {
        return idPT;
    }

    public void setIdPT(int idPT) {
        this.idPT = idPT;
    }

    public String getRichiesta() {
        return richiesta;
    }

    public void setRichiesta(String richiesta) {
        this.richiesta = richiesta;
    }

    public String getStato() {
        return stato;
    }

    public void setStato(String stato) {
        this.stato = stato;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCognome() {
        return cognome;
    }

    public void setCognome(String cognome) {
        this.cognome = cognome;
    }

    public String getObiettivo() {
        return obiettivo;
    }

    public void setObiettivo(String obiettivo) {
        this.obiettivo = obiettivo;
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof ConsultareUtente that)) return false;
        return idRichiesta == that.idRichiesta && idUtente == that.idUtente && idPT == that.idPT && Objects.equals(richiesta, that.richiesta) && Objects.equals(stato, that.stato) && Objects.equals(nome, that.nome) && Objects.equals(cognome, that.cognome) && Objects.equals(obiettivo, that.obiettivo);
    }

    @Override
    public String toString() {
        return "ConsultareUtente{" +
                "idRichiesta=" + idRichiesta +
                ", idUtente=" + idUtente +
                ", idPT=" + idPT +
                ", richiesta='" + richiesta + '\'' +
                ", stato='" + stato + '\'' +
                ", nome='" + nome + '\'' +
                ", cognome='" + cognome + '\'' +
                ", obiettivo='" + obiettivo + '\'' +
                '}';
    }
}
