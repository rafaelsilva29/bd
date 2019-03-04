package bd;

import java.util.*;
import static java.lang.System.out;
import java.io.*;

public class Cliente
{
    private String nome;
    private int nif ;
    private String genero;
    private int telemovel;
    private String email;
    private String senha;

 
    public Cliente()
    {
        nome = " ";
        nif = 000000000;
        genero = " ";
        telemovel = 000000000;
        email = " ";
        senha = " ";
    }
    
    public Cliente (Cliente a)
    {
        nome = a.getNome();
        nif = a.getNif();
        genero = a.getGenero();
        telemovel = a.getTelemovel();
        email = a.getEmail();
        senha = a.getSenha();
    }
    
    public Cliente (String nome, int nif, String genero, int telemovel, String email, String senha)
    {
        setNome(nome);
        setNif(nif);
        setGenero(genero);
        setTelemovel(telemovel);
        setEmail(email);
        setSenha(senha);
    }
    
    public String getNome(){
        return this.nome;
    }
    
    public int getNif(){
        return this.nif;
    }
    
    public String getGenero(){
        return this.genero;
    }
    
    public int getTelemovel(){
        return this.telemovel;
    }
    
    public String getEmail(){
        return this.email;
    }
    
    public String getSenha(){
        return this.senha;
    }
    
    public void setNome(String nome){
        this.nome = nome;
    }
    
    public void setNif(int nif){
        this.nif = nif;
    }
    
    public void setGenero(String genero){
        this.genero = genero;
    }
    
    public void setTelemovel(int telemovel){
        this.telemovel = telemovel;
    }
    
    public void setEmail(String email){
        this.email = email;
    }
    
    public void setSenha(String senha){
        this.senha = senha;
    }
}