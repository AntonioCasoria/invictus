package DataAccessLayer.bean;

import java.util.Objects;

public class Assegnare {
    private int idScheda;
    private int idUtente;

    public Assegnare(){}

    public Assegnare(int idScheda, int idUtente){
        this.idScheda = idScheda;
        this.idUtente = idUtente;
    }

    public int getIdScheda(){
        return idScheda;
    }

    public void setIdScheda(int idScheda){
        this.idScheda = idScheda;
    }

    public int getIdUtente(){
        return idUtente;
    }

    public void setIdUtente(int idUtente){
        this.idUtente = idUtente;
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof Assegnare assegnare)) return false;
        return idScheda == assegnare.idScheda && idUtente == assegnare.idUtente;
    }

    @Override
    public String toString() {
        return "Assegnare{" +
                "idScheda=" + idScheda +
                ", idUtente=" + idUtente +
                '}';
    }
}
