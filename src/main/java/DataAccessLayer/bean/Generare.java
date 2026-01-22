package DataAccessLayer.bean;

public class Generare {
    private int idEsercizio;
    private int idPerfomance;

    public Generare() {
    }

    public Generare(int idEsercizio, int idPerfomance) {
        this.idEsercizio = idEsercizio;
        this.idPerfomance = idPerfomance;
    }

    public int getIdEsercizio() {
        return idEsercizio;
    }

    public void setIdEsercizio(int idEsercizio) {
        this.idEsercizio = idEsercizio;
    }

    public int getIdPerfomance() {
        return idPerfomance;
    }

    public void setIdPerfomance(int idPerfomance) {
        this.idPerfomance = idPerfomance;
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof Generare generare)) return false;
        return idEsercizio == generare.idEsercizio && idPerfomance == generare.idPerfomance;
    }

    @Override
    public String toString() {
        return "Generare{" +
                "idEsercizio=" + idEsercizio +
                ", idPerfomance=" + idPerfomance +
                '}';
    }
}
