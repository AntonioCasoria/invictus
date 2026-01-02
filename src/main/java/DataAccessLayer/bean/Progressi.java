package DataAccessLayer.bean;

import java.util.Objects;

public class Progressi {
    private int idProgressi;
    private int idPerfomance;
    private int idUtente;
    private int idEsercizio;

    public Progressi() {
    }

    public Progressi(int idProgressi, int idPerfomance, int idUtente, int idEsercizio) {
        this.idProgressi = idProgressi;
        this.idPerfomance = idPerfomance;
        this.idUtente = idUtente;
        this.idEsercizio = idEsercizio;
    }

    public int getIdProgressi() {
        return idProgressi;
    }

    public void setIdProgressi(int idProgressi) {
        this.idProgressi = idProgressi;
    }

    public int getIdPerfomance() {
        return idPerfomance;
    }

    public void setIdPerfomance(int idPerfomance) {
        this.idPerfomance = idPerfomance;
    }

    public int getIdUtente() {
        return idUtente;
    }

    public void setIdUtente(int idUtente) {
        this.idUtente = idUtente;
    }

    public int getIdEsercizio() {
        return idEsercizio;
    }

    public void setIdEsercizio(int idEsercizio) {
        this.idEsercizio = idEsercizio;
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof Progressi progressi)) return false;
        return idProgressi == progressi.idProgressi && idPerfomance == progressi.idPerfomance && idUtente == progressi.idUtente && idEsercizio == progressi.idEsercizio;
    }

    @Override
    public String toString() {
        return "Progressi{" +
                "idProgressi=" + idProgressi +
                ", idPerfomance=" + idPerfomance +
                ", idUtente=" + idUtente +
                ", idEsercizio=" + idEsercizio +
                '}';
    }
}
