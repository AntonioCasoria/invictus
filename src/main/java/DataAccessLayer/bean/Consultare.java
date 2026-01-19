package DataAccessLayer.bean;

import java.util.Objects;

public class Consultare {
    private int idRichiesta;
    private int idUtente;
    private int idPT;
    private String richiesta;
    private String stato;

    public Consultare() {
    }

    public Consultare(int idUtente, int idPT, String richiesta, String stato) {
        this.idUtente = idUtente;
        this.idPT = idPT;
        this.richiesta = richiesta;
        this.stato = stato;
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

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof Consultare that)) return false;
        return idRichiesta == that.idRichiesta && idUtente == that.idUtente && idPT == that.idPT && Objects.equals(richiesta, that.richiesta) && Objects.equals(stato, that.stato);
    }

    @Override
    public String toString() {
        return "Consultare{" +
                "idRichiesta=" + idRichiesta +
                ", idUtente=" + idUtente +
                ", idPT=" + idPT +
                ", richiesta='" + richiesta + '\'' +
                ", stato='" + stato + '\'' +
                '}';
    }
}
