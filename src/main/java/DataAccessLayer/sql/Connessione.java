package DataAccessLayer.sql;
import java.sql.Connection;
import java.sql.DriverManager;

public class Connessione {

    public Connessione() {
    }

    public Connection connessione(){
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Caricamento esplicito

            String url = "jdbc:mysql://127.0.0.1:3306/Invictus?serverTimezone=UTC";
            String username = "root";
            String password = "localhost00";

            con = DriverManager.getConnection(url, username, password);

        } catch(Exception e) {
            System.out.println("Connessione Fallita \n");
            e.printStackTrace();
        }
        return con;
    }
}
