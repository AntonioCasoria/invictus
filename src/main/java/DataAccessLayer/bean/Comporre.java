package DataAccessLayer.bean;

import java.util.Objects;

public class Comporre {
    private int idEsercizio;
    private int idScheda;
    private int giorno;

    public Comporre() {
    }

    public Comporre(int idEsercizio, int idScheda, int giorno) {
        this.idEsercizio = idEsercizio;
        this.idScheda = idScheda;
        this.giorno = giorno;
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

    public int getGiorno() {
        return giorno;
    }

    public void setGiorno(int giorno) {
        this.giorno = giorno;
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof Comporre comporre)) return false;
        return idEsercizio == comporre.idEsercizio && idScheda == comporre.idScheda && giorno == comporre.giorno;
    }

    @Override
    public String toString() {
        return "Comporre{" +
                "idEsercizio=" + idEsercizio +
                ", idScheda=" + idScheda +
                ", giorno=" + giorno +
                '}';
    }
}
