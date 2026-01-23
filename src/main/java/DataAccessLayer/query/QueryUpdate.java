package DataAccessLayer.query;

import DataAccessLayer.bean.Consultare;
import DataAccessLayer.bean.Utente;
import DataAccessLayer.sql.SelectMYSQL;
import DataAccessLayer.sql.UpdateMYSQL;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;


public class QueryUpdate {
    private Connection conn;

    public QueryUpdate(Connection conn) {
        this.conn = conn;
    }

    public void updateConsultare(int idUtente, int idPT, String richiesta){
        UpdateMYSQL update = new UpdateMYSQL(conn);
        String query = "UPDATE Consultare SET Richiesta = '"+ richiesta +"', Stato = 'Consultato' WHERE IdUtente = " + idUtente + " AND IdPT = " + idPT;
        update.update(query);
    }

    public void updateConsultare2(int idUtente, int idPT, int idRichiesta){
        UpdateMYSQL update = new UpdateMYSQL(conn);
        String query = "UPDATE Consultare SET Stato = 'Consegnato' WHERE IdUtente = " + idUtente + " AND IdPT = " + idPT + " AND IdRichiesta = " + idRichiesta;
        update.update(query);
    }

    public Utente updateProfiloUtente(int idUtente, String nome, String cognome, String indirizzo, LocalDate dataNascita, int  altezza, float peso, String obiettivo, String password){
        UpdateMYSQL update = new UpdateMYSQL(conn);
        String query = "UPDATE Utente SET Nome = '"+ nome +"', Cognome = '"+ cognome +"', Indirizzo = '"+ indirizzo +"', DataNascita = '"+ dataNascita +"', Altezza = "+ altezza +", Peso = "+ peso +", Obiettivo = '"+ obiettivo +"', Password = '"+ password +"' WHERE IdUtente = " + idUtente;
        update.update(query);

        QuerySelect querySelect = new QuerySelect(conn);
        Utente u = null;
        try {
            u = querySelect.selectUtenteById(idUtente);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return u;
    }

}
