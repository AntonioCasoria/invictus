package DataAccessLayer.bean;

import java.time.LocalDate;
import java.util.Objects;

public class SchedaAllenamento {
    private int idScheda;
    private int idPT;
    private LocalDate dataCreazione;
    private String durata;
    private String obiettivo;
    private String nome;

    public SchedaAllenamento() {
    }

    public SchedaAllenamento(int idPT, LocalDate dataCreazione, String durata, String obiettivo, String nome) {
        this.idPT = idPT;
        this.dataCreazione = dataCreazione;
        this.durata = durata;
        this.obiettivo = obiettivo;
        this.nome = nome;
    }

    public int getIdScheda() {
        return idScheda;
    }

    public void setIdScheda(int idScheda) {
        this.idScheda = idScheda;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public int getIdPT() {
        return idPT;
    }

    public void setIdPT(int idPT) {
        this.idPT = idPT;
    }

    public LocalDate getDataCreazione() {
        return dataCreazione;
    }

    public void setDataCreazione(LocalDate dataCreazione) {
        this.dataCreazione = dataCreazione;
    }

    public String getDurata() {
        return durata;
    }

    public void setDurata(String durata) {
        this.durata = durata;
    }

    public String getObiettivo() {
        return obiettivo;
    }

    public void setObiettivo(String obiettivo) {
        this.obiettivo = obiettivo;
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof SchedaAllenamento that)) return false;
        return idScheda == that.idScheda && idPT == that.idPT && Objects.equals(dataCreazione, that.dataCreazione) && Objects.equals(durata, that.durata) && Objects.equals(obiettivo, that.obiettivo) && Objects.equals(nome, that.nome);
    }

    @Override
    public String toString() {
        return "SchedaAllenamento{" +
                "idScheda=" + idScheda +
                ", idPT=" + idPT +
                ", dataCreazione='" + dataCreazione + '\'' +
                ", durata='" + durata + '\'' +
                ", obiettivo='" + obiettivo + '\'' +
                ", nome='" + nome + '\'' +
                '}';
    }
}
