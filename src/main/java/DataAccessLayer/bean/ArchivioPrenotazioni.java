package DataAccessLayer.bean;

import java.util.Objects;

public class ArchivioPrenotazioni{
    private int intArchivioPrenotazione;
    private int idUtente;
    private int idPrenotazione;

    public ArchivioPrenotazioni() {
    }

    public ArchivioPrenotazioni(int intArchivioPrenotazione, int idUtente, int idPrenotazione) {
        this.intArchivioPrenotazione = intArchivioPrenotazione;
        this.idUtente = idUtente;
        this.idPrenotazione = idPrenotazione;
    }

    public int getIntArchivioPrenotazione() {
        return intArchivioPrenotazione;
    }

    public void setIntArchivioPrenotazione(int intArchivioPrenotazione) {
        this.intArchivioPrenotazione = intArchivioPrenotazione;
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
        return intArchivioPrenotazione == that.intArchivioPrenotazione && idUtente == that.idUtente && idPrenotazione == that.idPrenotazione;
    }

    @Override
    public String toString() {
        return "ArchivioPrenotazioni{" +
                "intArchivioPrenotazione=" + intArchivioPrenotazione +
                ", idUtente=" + idUtente +
                ", idPrenotazione=" + idPrenotazione +
                '}';
    }
}
