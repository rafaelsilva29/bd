package bd;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import jdk.nashorn.internal.runtime.Version;
import java.util.*;
import java.sql.Time;
 

public class SQLreader {
        List<Cliente> cliente;
        Connection con;
        
 
    public SQLreader(){
        this.cliente= new ArrayList<>();
        this.con=null;
    }
    
    public void iniciarC () throws Exception{
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/comboios_flavienses?user=root&password=silva2010");
    }
    
    public void finalizarC() throws Exception{
        try{
                if (con != null) {
                    con.close();
                }
        }
         catch (SQLException ex) {
                Logger lgr = Logger.getLogger(Version.class.getName());
                lgr.log(Level.WARNING, ex.getMessage(), ex);
            }
               
    }
    
    
    public List<Cliente> getCliente() throws ClassNotFoundException{
        ResultSet cli=null;
        PreparedStatement stCL=null;
        ArrayList<Cliente> clientes = new ArrayList<>();
        try {           
            stCL= con.prepareStatement("SELECT * FROM Comboios_Flavienses.cliente;");
            cli=stCL.executeQuery();
            while(cli.next()){
                String Nome = cli.getString ("nome");
                int nif = cli.getInt ("nif");
                String genero = cli.getString("genero");
                int telemovel = cli.getInt("telemovel");
                String emai = cli.getString("email");
                String senha = cli.getString("senha");
                clientes.add( new Cliente (Nome,nif,genero,telemovel,emai,senha));
            }
        }
         catch (SQLException ex) {
            Logger lgr = Logger.getLogger(Version.class.getName());
            lgr.log(Level.SEVERE, ex.getMessage(), ex);
          } 
          finally {
            try {
                if (cli != null) {
                  cli.close();
                }
                if (stCL != null) {
                    stCL.close();
                }
            } 
            catch (SQLException ex) {
                Logger lgr = Logger.getLogger(Version.class.getName());
                lgr.log(Level.WARNING, ex.getMessage(), ex);
            }
        }
        return clientes;
    }
    

    
   public List<Comboio> getComboio () throws ClassNotFoundException{
        ResultSet comboio=null;
        ResultSet lc=null;
        PreparedStatement stC=null;
        PreparedStatement stLC=null;
        List<Comboio> com = new ArrayList<>();
        try {
            stC= con.prepareStatement("SELECT * FROM Comboios_Flavienses.Comboio;");
            comboio=stC.executeQuery();
            while(comboio.next()){
                int id = comboio.getInt("id_Comboio");
                String tipo = comboio.getString ("Tipo_Comboio");
                int Lotacao_Primeira_Classe = comboio.getInt ("Lotaçao_Primeira_Classe");
                int Lotacao_Classe_Economica = comboio.getInt ("Lotaçao_Economica");
                int Capacidade = comboio.getInt ("Capacidade");
                stLC=con.prepareStatement("SELECT * FROM comboios_flavienses.Lugar where Comboio_id_Comboio= "+id);
                List<Lugar> lugares = new ArrayList<>();
                lc=stLC.executeQuery();
                while (lc.next()){
                    int N = lc.getInt ("N_Lugar");
                    String Classe = lc.getString ("Classe");
                    lugares.add(new Lugar (N,Classe));
                }
                com.add (new Comboio (id, tipo, Lotacao_Primeira_Classe, Lotacao_Classe_Economica, Capacidade, lugares));
            }
            
          } 
          catch (SQLException ex) {
            Logger lgr = Logger.getLogger(Version.class.getName());
            lgr.log(Level.SEVERE, ex.getMessage(), ex);
          } 
          finally {
            try {
                if (lc != null) {
                    lc.close();
                }
                if (comboio != null) {
                  comboio.close();
                }
                if (stLC != null) {
                    stLC.close();
                }
                if (stC != null) {
                    stC.close();
                } 
            } 
            catch (SQLException ex) {
                Logger lgr = Logger.getLogger(Version.class.getName());
                lgr.log(Level.WARNING, ex.getMessage(), ex);
            }
        }
        return com;
    }
  
    public List<Reserva> getReserva () throws ClassNotFoundException{
        ResultSet reserva=null;
        PreparedStatement stR=null;
        List<Cliente> cliente = new ArrayList<>();
        List<Reserva> bt = new ArrayList<>();
        List<Viagem> viagem = new ArrayList<>();
        try {
            stR= con.prepareStatement("SELECT * FROM comboios_flavienses.Reserva");
            reserva=stR.executeQuery();
            while (reserva.next()){
                int idR = reserva.getInt ("id_Reserva");
                int idC = reserva.getInt ("Cliente_id_Cliente");
                float Custo = reserva.getInt ("Custo");
                int lugar = reserva.getInt ("Lugar");
                String Classe = reserva.getString ("Classe");
                String DR = reserva.getString("Data_Reserva");
                cliente = getCliente();
                viagem = getViagem();
                bt.add (new Reserva (idR, Custo, lugar, Classe, DR, cliente, viagem));
            }
          } 
          catch (SQLException ex) {
            Logger lgr = Logger.getLogger(Version.class.getName());
            lgr.log(Level.SEVERE, ex.getMessage(), ex);
          } 
          finally {
            try {
                if (reserva != null) {
                    reserva.close();
                }
                if (stR != null) {
                    stR.close();
                }
            } 
            catch (SQLException ex) {
                Logger lgr = Logger.getLogger(Version.class.getName());
                lgr.log(Level.WARNING, ex.getMessage(), ex);
            }
        }
        return bt;
    }
    
    public List<Viagem> getViagem () throws ClassNotFoundException{
        ResultSet V =null;
        PreparedStatement stV=null;
        List<Viagem> viagem = new ArrayList<>();
        List<Comboio> comboio = new ArrayList<>();
        try {
            stV= con.prepareStatement("SELECT * FROM comboios_flavienses.Viagem");
            V=stV.executeQuery();
            while(V.next()){
                int idV = V.getInt ("id_Viagem");
                int idC = V.getInt ("Comboio_id_Comboio");
                float Preco_Primeira_Classe = V.getFloat ("Preço_Primeira_classe");
                float Preco_Economica = V.getFloat ("Preço_Economica");
                int Ocupacao_Primeira = V.getInt ("Ocupaçao_Primeira_Classe");
                int Ocupacao_Economica = V.getInt ("Ocupaçao_Classe_Economica");
                String HP = V.getString("Hora_Partida");
                String HD = V.getString("Hora_Destino");
                String Partida = V.getString("Partida");
                String Destino = V.getString("Destino");
                comboio = getComboio();
                viagem.add (new Viagem (Preco_Primeira_Classe, Preco_Economica, Ocupacao_Primeira, 
                                        Ocupacao_Economica, HP, HD, Partida, Destino, comboio));
            }
          } 
          catch (Exception ex) {
            Logger lgr = Logger.getLogger(Version.class.getName());
            lgr.log(Level.SEVERE, ex.getMessage(), ex);
          } 
          finally {
            try {
                if (V != null) {
                    V.close();
                }
                if (stV != null) {
                    stV.close();
                } 
            } 
            catch (SQLException ex) {
                Logger lgr = Logger.getLogger(Version.class.getName());
                lgr.log(Level.WARNING, ex.getMessage(), ex);
            }
        }
        return viagem;
    }
}

