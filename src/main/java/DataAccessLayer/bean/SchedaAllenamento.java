package DataAccessLayer.bean;

import java.util.Objects;

public class SchedaAllenamento {
    private int idScheda;
    private int idUtente;
    private int idPT;
    private String dataCreazione;
    private String durata;
    private String obiettivo;

    public SchedaAllenamento() {
    }

    public SchedaAllenamento(int idUtente, int idPT, String dataCreazione, String durata, String obiettivo) {
        this.idUtente = idUtente;
        this.idPT = idPT;
        this.dataCreazione = dataCreazione;
        this.durata = durata;
        this.obiettivo = obiettivo;
    }

    public int getIdScheda() {
        return idScheda;
    }

    public void setIdScheda(int idScheda) {
        this.idScheda = idScheda;
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

    public String getDataCreazione() {
        return dataCreazione;
    }

    public void setDataCreazione(String dataCreazione) {
        this.dataCreazione = dataCreazione;
    }

    public String getDurata() {
        return durata;
    }

    public void setDurata(String durata) {
        this.durata = durata;
    }

    public String getObiettivo() {
        return obiettivo;
    }

    public void setObiettivo(String obiettivo) {
        this.obiettivo = obiettivo;
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof SchedaAllenamento that)) return false;
        return idScheda == that.idScheda && idUtente == that.idUtente && idPT == that.idPT && Objects.equals(dataCreazione, that.dataCreazione) && Objects.equals(durata, that.durata) && Objects.equals(obiettivo, that.obiettivo);
    }

    @Override
    public String toString() {
        return "SchedaAllenamento{" +
                "idScheda=" + idScheda +
                ", idUtente=" + idUtente +
                ", idPT=" + idPT +
                ", dataCreazione='" + dataCreazione + '\'' +
                ", durata='" + durata + '\'' +
                ", obiettivo='" + obiettivo + '\'' +
                '}';
    }
}
