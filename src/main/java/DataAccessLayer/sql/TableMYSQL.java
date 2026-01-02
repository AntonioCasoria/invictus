package DataAccessLayer.sql;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;


public class TableMYSQL {

	private Connection c;

	public TableMYSQL(Connection c) {
	
		this.c = c;
	}

	public void createTable(String sql){


		try	{		

			PreparedStatement ps = c.prepareStatement(sql);	
			ps.executeUpdate();
			ps.close();		
		}		
		catch(SQLException	ex)	{		
			System.out.println("Errore nella creazione della tabella");
			ex.printStackTrace();
		}

	}

}
