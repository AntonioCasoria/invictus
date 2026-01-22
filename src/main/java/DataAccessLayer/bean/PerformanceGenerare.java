package DataAccessLayer.bean;

import java.time.LocalDate;
import java.util.Objects;

public class PerformanceGenerare {
    private int idPerformance;
    private int idUtente;
    private LocalDate data;
    private String feedback;
    private float carico;
    private int RPE;
    private int serieEffettive;
    private int ripetizioniEffettive;
    private int tempoRecuperoEffettivo;
    private int RPEeffettivo;
    private int idEsercizio;

    public PerformanceGenerare() {
    }

    public PerformanceGenerare(int idPerformance, int idUtente, LocalDate data, String feedback, float carico, int RPE, int serieEffettive, int ripetizioniEffettive, int tempoRecuperoEffettivo, int RPEeffettivo, int idEsercizio) {
        this.idPerformance = idPerformance;
        this.idUtente = idUtente;
        this.data = data;
        this.feedback = feedback;
        this.carico = carico;
        this.RPE = RPE;
        this.serieEffettive = serieEffettive;
        this.ripetizioniEffettive = ripetizioniEffettive;
        this.tempoRecuperoEffettivo = tempoRecuperoEffettivo;
        this.RPEeffettivo = RPEeffettivo;
        this.idEsercizio = idEsercizio;
    }

    public int getIdPerformance() {
        return idPerformance;
    }

    public void setIdPerformance(int idPerformance) {
        this.idPerformance = idPerformance;
    }

    public int getIdUtente() {
        return idUtente;
    }

    public void setIdUtente(int idUtente) {
        this.idUtente = idUtente;
    }

    public LocalDate getData() {
        return data;
    }

    public void setData(LocalDate data) {
        this.data = data;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    public float getCarico() {
        return carico;
    }

    public void setCarico(float carico) {
        this.carico = carico;
    }

    public int getRPE() {
        return RPE;
    }

    public void setRPE(int RPE) {
        this.RPE = RPE;
    }

    public int getSerieEffettive() {
        return serieEffettive;
    }

    public void setSerieEffettive(int serieEffettive) {
        this.serieEffettive = serieEffettive;
    }

    public int getRipetizioniEffettive() {
        return ripetizioniEffettive;
    }

    public void setRipetizioniEffettive(int ripetizioniEffettive) {
        this.ripetizioniEffettive = ripetizioniEffettive;
    }

    public int getTempoRecuperoEffettivo() {
        return tempoRecuperoEffettivo;
    }

    public void setTempoRecuperoEffettivo(int tempoRecuperoEffettivo) {
        this.tempoRecuperoEffettivo = tempoRecuperoEffettivo;
    }

    public int getRPEeffettivo() {
        return RPEeffettivo;
    }

    public void setRPEeffettivo(int RPEeffettivo) {
        this.RPEeffettivo = RPEeffettivo;
    }

    public int getIdEsercizio() {
        return idEsercizio;
    }

    public void setIdEsercizio(int idEsercizio) {
        this.idEsercizio = idEsercizio;
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof PerformanceGenerare that)) return false;
        return idPerformance == that.idPerformance && idUtente == that.idUtente && Float.compare(carico, that.carico) == 0 && RPE == that.RPE && serieEffettive == that.serieEffettive && ripetizioniEffettive == that.ripetizioniEffettive && tempoRecuperoEffettivo == that.tempoRecuperoEffettivo && RPEeffettivo == that.RPEeffettivo && idEsercizio == that.idEsercizio && Objects.equals(data, that.data) && Objects.equals(feedback, that.feedback);
    }

    @Override
    public String toString() {
        return "PerformanceGenerare{" +
                "idPerformance=" + idPerformance +
                ", idUtente=" + idUtente +
                ", data=" + data +
                ", feedback='" + feedback + '\'' +
                ", carico=" + carico +
                ", RPE=" + RPE +
                ", serieEffettive=" + serieEffettive +
                ", ripetizioniEffettive=" + ripetizioniEffettive +
                ", tempoRecuperoEffettivo=" + tempoRecuperoEffettivo +
                ", RPEeffettivo=" + RPEeffettivo +
                ", idEsercizio=" + idEsercizio +
                '}';
    }
}
