package DataAccessLayer.bean;

import java.time.LocalDate;
import java.util.Objects;

public class Prenotazione {
   private int idPrenotazione;
   private int idUtente;
   private LocalDate dataPrenotazione;
   private String fasciaOraria;
   private String stato;

    public Prenotazione() {
    }

    public Prenotazione(int idUtente, LocalDate dataPrenotazione, String fasciaOraria, String stato) {
        this.idUtente = idUtente;
        this.dataPrenotazione = dataPrenotazione;
        this.fasciaOraria = fasciaOraria;
        this.stato = stato;
    }

    public int getIdPrenotazione() {
        return idPrenotazione;
    }

    public void setIdPrenotazione(int idPrenotazione) {
        this.idPrenotazione = idPrenotazione;
    }

    public int getIdUtente() {
        return idUtente;
    }

    public void setIdUtente(int idUtente) {
        this.idUtente = idUtente;
    }

    public LocalDate getDataPrenotazione() {
        return dataPrenotazione;
    }

    public void setDataPrenotazione(LocalDate dataPrenotazione) {
        this.dataPrenotazione = dataPrenotazione;
    }

    public String getFasciaOraria() {
        return fasciaOraria;
    }

    public void setFasciaOraria(String fasciaOraria) {
        this.fasciaOraria = fasciaOraria;
    }

    public String getStato() {
        return stato;
    }

    public void setStato(String stato) {
        this.stato = stato;
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof Prenotazione that)) return false;
        return idPrenotazione == that.idPrenotazione && idUtente == that.idUtente && Objects.equals(dataPrenotazione, that.dataPrenotazione) && Objects.equals(fasciaOraria, that.fasciaOraria) && Objects.equals(stato, that.stato);
    }

    @Override
    public String toString() {
        return "Prenotazione{" +
                "idPrenotazione=" + idPrenotazione +
                ", idUtente=" + idUtente +
                ", dataPrenotazione='" + dataPrenotazione + '\'' +
                ", fasciaOraria='" + fasciaOraria + '\'' +
                ", stato='" + stato + '\'' +
                '}';
    }
}
