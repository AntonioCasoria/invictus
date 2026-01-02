package DataAccessLayer.bean;

import java.util.Objects;

public class ArchivioSchedeAllenamento {
    private int idArchivioSchedaAllenamento;
    private int idUtente;
    private int idScheda;
    private int idPT;

    public ArchivioSchedeAllenamento() {
    }

    public ArchivioSchedeAllenamento(int idArchivioSchedaAllenamento, int idUtente, int idScheda, int idPT) {
        this.idArchivioSchedaAllenamento = idArchivioSchedaAllenamento;
        this.idUtente = idUtente;
        this.idScheda = idScheda;
        this.idPT = idPT;
    }

    public int getIdArchivioSchedaAllenamento() {
        return idArchivioSchedaAllenamento;
    }

    public void setIdArchivioSchedaAllenamento(int idArchivioSchedaAllenamento) {
        this.idArchivioSchedaAllenamento = idArchivioSchedaAllenamento;
    }

    public int getIdUtente() {
        return idUtente;
    }

    public void setIdUtente(int idUtente) {
        this.idUtente = idUtente;
    }

    public int getIdScheda() {
        return idScheda;
    }

    public void setIdScheda(int idScheda) {
        this.idScheda = idScheda;
    }

    public int getIdPT() {
        return idPT;
    }

    public void setIdPT(int idPT) {
        this.idPT = idPT;
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof ArchivioSchedeAllenamento that)) return false;
        return idArchivioSchedaAllenamento == that.idArchivioSchedaAllenamento && idUtente == that.idUtente && idScheda == that.idScheda && idPT == that.idPT;
    }

    @Override
    public String toString() {
        return "ArchivioSchedeAllenamento{" +
                "idArchivioSchedaAllenamento=" + idArchivioSchedaAllenamento +
                ", idUtente=" + idUtente +
                ", idScheda=" + idScheda +
                ", idPT=" + idPT +
                '}';
    }
}
