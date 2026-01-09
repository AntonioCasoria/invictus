package DataAccessLayer.bean;

import java.util.Objects;

public class Esercizio {
    private int idEsercizio;
    private String nome;
    private String descrizione;
    private String gruppoMuscolare;
    private int serie;
    private int ripetizione;
    private int tempoRecupero;
    private String contenutoMultimediale;
    private String contenutoMultimediale2;

    public Esercizio() {
    }

    public Esercizio(String nome, String descrizione, String gruppoMuscolare, int serie, int ripetizione, int tempoRecupero, String contenutoMultimediale, String contenutoMultimediale2) {
        this.nome = nome;
        this.descrizione = descrizione;
        this.gruppoMuscolare = gruppoMuscolare;
        this.serie = serie;
        this.ripetizione = ripetizione;
        this.tempoRecupero = tempoRecupero;
        this.contenutoMultimediale = contenutoMultimediale;
        this.contenutoMultimediale2 = contenutoMultimediale2;
    }

    public int getIdEsercizio() {
        return idEsercizio;
    }

    public void setIdEsercizio(int idEsercizio) {
        this.idEsercizio = idEsercizio;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getDescrizione() {
        return descrizione;
    }

    public void setDescrizione(String descrizione) {
        this.descrizione = descrizione;
    }

    public String getGruppoMuscolare() {
        return gruppoMuscolare;
    }

    public void setGruppoMuscolare(String gruppoMuscolare) {
        this.gruppoMuscolare = gruppoMuscolare;
    }

    public int getSerie() {
        return serie;
    }

    public void setSerie(int serie) {
        this.serie = serie;
    }

    public int getRipetizione() {
        return ripetizione;
    }

    public void setRipetizione(int ripetizione) {
        this.ripetizione = ripetizione;
    }

    public int getTempoRecupero() {
        return tempoRecupero;
    }

    public void setTempoRecupero(int tempoRecupero) {
        this.tempoRecupero = tempoRecupero;
    }

    public String getContenutoMultimediale() {
        return contenutoMultimediale;
    }

    public void setContenutoMultimediale(String contenutoMultimediale) {
        this.contenutoMultimediale = contenutoMultimediale;
    }

    public String getContenutoMultimediale2() {
        return contenutoMultimediale2;
    }

    public void setContenutoMultimediale2(String contenutoMultimediale2) {
        this.contenutoMultimediale2 = contenutoMultimediale2;
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof Esercizio esercizio)) return false;
        return idEsercizio == esercizio.idEsercizio && serie == esercizio.serie && ripetizione == esercizio.ripetizione && tempoRecupero == esercizio.tempoRecupero && Objects.equals(nome, esercizio.nome) && Objects.equals(descrizione, esercizio.descrizione) && Objects.equals(gruppoMuscolare, esercizio.gruppoMuscolare) && Objects.equals(contenutoMultimediale, esercizio.contenutoMultimediale) && Objects.equals(contenutoMultimediale2, esercizio.contenutoMultimediale2);
    }

    @Override
    public String toString() {
        return "Esercizio{" +
                "idEsercizio=" + idEsercizio +
                ", nome='" + nome + '\'' +
                ", descrizione='" + descrizione + '\'' +
                ", gruppoMuscolare='" + gruppoMuscolare + '\'' +
                ", serie=" + serie +
                ", ripetizione=" + ripetizione +
                ", tempoRecupero=" + tempoRecupero +
                ", contenutoMultimediale='" + contenutoMultimediale + '\'' +
                ", contenutoMultimediale2='" + contenutoMultimediale2 + '\'' +
                '}';
    }
}
