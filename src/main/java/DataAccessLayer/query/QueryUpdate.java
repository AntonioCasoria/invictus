package DataAccessLayer.query;

import DataAccessLayer.bean.Consultare;
import DataAccessLayer.sql.UpdateMYSQL;

import java.sql.Connection;


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

}
