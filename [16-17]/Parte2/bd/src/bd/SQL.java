package bd;
 
import bd.SQLreader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import jdk.nashorn.internal.runtime.Version;
import java.util.*;
import java.io.FileWriter;
import java.io.IOException;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.SerializationConfig;
import java.io.*;


public class SQL {

    public static void main(String[] args) throws Exception{
      SQLreader sql = new SQLreader();
     
      List<Cliente> vCliente = new ArrayList<>();
      List<Comboio> vComboio = new ArrayList<>();
      List<Reserva> vReserva = new ArrayList<>();
      List<Viagem> vViagem = new ArrayList<>();
      
      FileWriter clienteF;
      FileWriter comboioF;
      FileWriter reservaF;
      FileWriter viagemF;
      
      ObjectMapper cli = new ObjectMapper();
      cli.enable(SerializationConfig.Feature.INDENT_OUTPUT);
      cli.writerWithDefaultPrettyPrinter();
      
      ObjectMapper com = new ObjectMapper();
      com.enable(SerializationConfig.Feature.INDENT_OUTPUT);
      com.writerWithDefaultPrettyPrinter();
      
      ObjectMapper rs = new ObjectMapper();
      rs.enable(SerializationConfig.Feature.INDENT_OUTPUT);
      rs.writerWithDefaultPrettyPrinter();
      
      ObjectMapper vi = new ObjectMapper();
      vi.enable(SerializationConfig.Feature.INDENT_OUTPUT);
      vi.writerWithDefaultPrettyPrinter();
      
      sql.iniciarC();
      
      vCliente = sql.getCliente();
      vComboio = sql.getComboio();
      vReserva = sql.getReserva();
      vViagem = sql.getViagem();
      
      clienteF = new FileWriter("cliente.json");
      cli.writeValue(clienteF,vCliente);
      clienteF.close();
      
      comboioF = new FileWriter("comboio.json");
      com.writeValue(comboioF,vComboio);
      comboioF.close();
      
      reservaF = new FileWriter("reserva.json");
      rs.writeValue(reservaF,vReserva);
      reservaF.close();
      
      viagemF = new FileWriter("viagem.json");
      vi.writeValue(viagemF,vViagem);
      viagemF.close();
      
      sql.finalizarC();
      
      System.out.println("Successfully Copied JSON Object to File cliente");
      System.out.println("Successfully Copied JSON Object to File comboio");
      System.out.println("Successfully Copied JSON Object to File viagem");
      System.out.println("Successfully Copied JSON Object to File reserva");
      System.out.println("JSON Object: " + cli);
      System.out.println("JSON Object: " + com);
      System.out.println("JSON Object: " + rs);
      System.out.println("JSON Object: " + vi);
      
    }
}

