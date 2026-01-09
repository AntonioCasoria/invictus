package DataAccessLayer.bean;

import java.util.Objects;

public class PersonalTrainer {
    private int idPT;
    private String nome;
    private String cognome;
    private String email;
    private String password;
    private String dataNascita;

    public PersonalTrainer() {
    }

    public PersonalTrainer(String nome, String cognome, String email, String password, String dataNascita) {
        this.nome = nome;
        this.cognome = cognome;
        this.email = email;
        this.password = password;
        this.dataNascita = dataNascita;
    }

    public int getIdPT() {
        return idPT;
    }

    public void setIdPT(int idPT) {
        this.idPT = idPT;
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

    public String getDataNascita() {
        return dataNascita;
    }

    public void setDataNascita(String dataNascita) {
        this.dataNascita = dataNascita;
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof PersonalTrainer that)) return false;
        return idPT == that.idPT && Objects.equals(nome, that.nome) && Objects.equals(cognome, that.cognome) && Objects.equals(email, that.email) && Objects.equals(password, that.password) && Objects.equals(dataNascita, that.dataNascita);
    }

    @Override
    public String toString() {
        return "PersonalTrainer{" +
                "idPT=" + idPT +
                ", nome='" + nome + '\'' +
                ", cognome='" + cognome + '\'' +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                ", dataNascita='" + dataNascita + '\'' +
                '}';
    }
}
