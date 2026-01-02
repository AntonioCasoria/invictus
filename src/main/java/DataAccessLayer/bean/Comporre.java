package DataAccessLayer.bean;

import java.util.Objects;

public class Comporre {
    private int idEsercizio;
    private int idScheda;

    public Comporre() {
    }

    public Comporre(int idEsercizio, int idScheda) {
        this.idEsercizio = idEsercizio;
        this.idScheda = idScheda;
    }

    public int getIdEsercizio() {
        return idEsercizio;
    }

    public void setIdEsercizio(int idEsercizio) {
        this.idEsercizio = idEsercizio;
    }

    public int getIdScheda() {
        return idScheda;
    }

    public void setIdScheda(int idScheda) {
        this.idScheda = idScheda;
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof Comporre comporre)) return false;
        return idEsercizio == comporre.idEsercizio && idScheda == comporre.idScheda;
    }

    @Override
    public String toString() {
        return "Comporre{" +
                "idEsercizio=" + idEsercizio +
                ", idScheda=" + idScheda +
                '}';
    }
}
