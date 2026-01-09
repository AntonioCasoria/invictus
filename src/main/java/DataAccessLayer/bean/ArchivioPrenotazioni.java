package DataAccessLayer.bean;

import java.util.Objects;

public class ArchivioPrenotazioni{
    private int idArchivioPrenotazione;
    private int idUtente;
    private int idPrenotazione;

    public ArchivioPrenotazioni() {
    }

    public ArchivioPrenotazioni(int idUtente, int idPrenotazione) {
        this.idUtente = idUtente;
        this.idPrenotazione = idPrenotazione;
    }

    public int getIdArchivioPrenotazione() {
        return idArchivioPrenotazione;
    }

    public void setIdArchivioPrenotazione(int intArchivioPrenotazione) {
        this.idArchivioPrenotazione = intArchivioPrenotazione;
    }

    public int getIdUtente() {
        return idUtente;
    }

    public void setIdUtente(int idUtente) {
        this.idUtente = idUtente;
    }

    public int getIdPrenotazione() {
        return idPrenotazione;
    }

    public void setIdPrenotazione(int idPrenotazione) {
        this.idPrenotazione = idPrenotazione;
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof ArchivioPrenotazioni that)) return false;
        return idArchivioPrenotazione == that.idArchivioPrenotazione && idUtente == that.idUtente && idPrenotazione == that.idPrenotazione;
    }

    @Override
    public String toString() {
        return "ArchivioPrenotazioni{" +
                "intArchivioPrenotazione=" + idArchivioPrenotazione +
                ", idUtente=" + idUtente +
                ", idPrenotazione=" + idPrenotazione +
                '}';
    }
}
