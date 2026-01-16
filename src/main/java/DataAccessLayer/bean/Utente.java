package DataAccessLayer.bean;

import java.time.LocalDate;
import java.util.Objects;

public class Utente {
    private int idUtente;
    private String nome;
    private String cognome;
    private String email;
    private String password;
    private LocalDate dataNascita;
    private String indirizzo;
    private String ruolo;
    private int eta;
    private String sesso;
    private int altezza;
    private float peso;
    private String fitnessLevel;
    private String anniEsperienzaDichiarati;
    private int frequenzaSettimanale;
    private LocalDate dataIscrizione;
    private String obiettivo;

    public Utente(){}

    public Utente(String nome, String cognome, String email, String password, LocalDate dataNascita, String indirizzo, String ruolo, int eta, String sesso, int altezza, float peso, String fitnessLevel, String anniEsperienzaDichiarati, int frequenzaSettimanale, LocalDate dataIscrizione, String obiettivo) {
        this.nome = nome;
        this.cognome = cognome;
        this.email = email;
        this.password = password;
        this.dataNascita = dataNascita;
        this.indirizzo = indirizzo;
        this.ruolo = ruolo;
        this.eta = eta;
        this.sesso = sesso;
        this.altezza = altezza;
        this.peso = peso;
        this.fitnessLevel = fitnessLevel;
        this.anniEsperienzaDichiarati = anniEsperienzaDichiarati;
        this.frequenzaSettimanale = frequenzaSettimanale;
        this.dataIscrizione = dataIscrizione;
        this.obiettivo = obiettivo;
    }

    public int getIdUtente() {
        return idUtente;
    }

    public void setIdUtente(int idUtente) {
        this.idUtente = idUtente;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCognome() {
        return cognome;
    }

    public void setCognome(String cognome) {
        this.cognome = cognome;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public LocalDate getDataNascita() {
        return dataNascita;
    }

    public void setDataNascita(LocalDate dataNascita) {
        this.dataNascita = dataNascita;
    }

    public String getIndirizzo() {
        return indirizzo;
    }

    public void setIndirizzo(String indirizzo) {
        this.indirizzo = indirizzo;
    }

    public String getRuolo() {
        return ruolo;
    }

    public void setRuolo(String ruolo) {
        this.ruolo = ruolo;
    }

    public int getEta() {
        return eta;
    }

    public void setEta(int eta) {
        this.eta = eta;
    }

    public String getSesso() {
        return sesso;
    }

    public void setSesso(String sesso) {
        this.sesso = sesso;
    }

    public int getAltezza() {
        return altezza;
    }

    public void setAltezza(int altezza) {
        this.altezza = altezza;
    }

    public float getPeso() {
        return peso;
    }

    public void setPeso(float peso) {
        this.peso = peso;
    }

    public String getFitnessLevel() {
        return fitnessLevel;
    }

    public void setFitnessLevel(String fitnessLevel) {
        this.fitnessLevel = fitnessLevel;
    }

    public String getAnniEsperienzaDichiarati() {
        return anniEsperienzaDichiarati;
    }

    public void setAnniEsperienzaDichiarati(String anniEsperienzaDichiarati) {
        this.anniEsperienzaDichiarati = anniEsperienzaDichiarati;
    }

    public int getFrequenzaSettimanale() {
        return frequenzaSettimanale;
    }

    public void setFrequenzaSettimanale(int frequenzaSettimanale) {
        this.frequenzaSettimanale = frequenzaSettimanale;
    }

    public LocalDate getDataIscrizione() {
        return dataIscrizione;
    }

    public void setDataIscrizione(LocalDate dataIscrizione) {
        this.dataIscrizione = dataIscrizione;
    }

    public String getObiettivo() {
        return obiettivo;
    }

    public void setObiettivo(String obiettivo) {
        this.obiettivo = obiettivo;
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof Utente utente)) return false;
        return idUtente == utente.idUtente && eta == utente.eta && altezza == utente.altezza && Float.compare(peso, utente.peso) == 0 && frequenzaSettimanale == utente.frequenzaSettimanale && Objects.equals(nome, utente.nome) && Objects.equals(cognome, utente.cognome) && Objects.equals(email, utente.email) && Objects.equals(password, utente.password) && Objects.equals(dataNascita, utente.dataNascita) && Objects.equals(indirizzo, utente.indirizzo) && Objects.equals(ruolo, utente.ruolo) && Objects.equals(sesso, utente.sesso) && Objects.equals(fitnessLevel, utente.fitnessLevel) && Objects.equals(anniEsperienzaDichiarati, utente.anniEsperienzaDichiarati) && Objects.equals(dataIscrizione, utente.dataIscrizione) && Objects.equals(obiettivo, utente.obiettivo);
    }

    @Override
    public String toString() {
        return "Utente{" +
                "idUtente=" + idUtente +
                ", nome='" + nome + '\'' +
                ", cognome='" + cognome + '\'' +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                ", dataNascita=" + dataNascita +
                ", indirizzo='" + indirizzo + '\'' +
                ", ruolo='" + ruolo + '\'' +
                ", eta=" + eta +
                ", sesso='" + sesso + '\'' +
                ", altezza=" + altezza +
                ", peso=" + peso +
                ", fitnessLevel='" + fitnessLevel + '\'' +
                ", anniEsperienzaDichiarati='" + anniEsperienzaDichiarati + '\'' +
                ", frequenzaSettimanale=" + frequenzaSettimanale +
                ", dataIscrizione=" + dataIscrizione +
                ", obiettivo='" + obiettivo + '\'' +
                '}';
    }
}
