-- Transaçao 1 (Insere Cliente)
DELIMITER $$
drop procedure if exists insere_Cliente $$
create procedure insere_Cliente(in nome1 varchar(45), in nif1 int(9), in genero1 enum('M','F'), in telemovel1 int(9), in email1 varchar(45), in senha1 varchar(7))
	
    begin

		start transaction;

		select @id_Cliente := max(id_Cliente) 
		from cliente;

		set @id_Cliente = @id_Cliente  + 1;
 
		insert into cliente(id_Cliente, nome, nif, genero, telemovel, email, senha)
		values(@id_Cliente, nome1, nif1, genero1, telemovel1, email1, senha1);
		select 'Registo efetuado' as Msg;
		commit;

	end $$
DELIMITER ;


-- Transaçao 2 (Insere Comboio)
DELIMITER $$
drop procedure if exists insere_Comboio $$
create procedure insere_Comboio(in Tipo_Comboio1 varchar(20), in Lotaçao_Primeira_Classe1 int, in Lotaçao_Economica1 int, in Capacidade1 int)
    begin

		start transaction;

		select @id_Comboio := max(id_Comboio) 
		from comboio;

		set @id_Comboio = @id_Comboio  + 1;
 
		insert into comboio
		(id_Comboio, Tipo_comboio, Lotaçao_Primeira_Classe, Lotaçao_Economica , Capacidade)
		values
        (@id_Comboio, Tipo_comboio1, Lotaçao_Primeira_Classe1, Lotaçao_Economica1, Capacidade1);
		select 'Registo efetuado' as Msg;
		commit;

	end $$
DELIMITER ;

-- Transaçao 3(Update Cliente)

DELIMITER $$
drop procedure if exists update_Cliente $$
create procedure update_Cliente (in id_Cliente1 int, in telemovel1 int(9))
	begin

		start transaction;
    
		update cliente
			set telemovel = telemovel1
			where id_Cliente = id_Cliente1;
			select 'Upate do numero efetuado com sucesso' as Msg;
			commit;

	end $$
DELIMITER ;

-- Transaçao 4(Update Comboio)

DELIMITER $$
drop procedure if exists update_Comboio $$
create procedure update_Comboio (in id_Comboio1 int, in Tipo_Comboio1 varchar(20))
		begin

		    start transaction;
    
			update comboio
				set  Tipo_Comboio = Tipo_Comboio1
				where id_Comboio = id_Comboio1;
                select 'Upate do comboio efetuado com sucesso' as Msg;
                commit;

		end $$
DELIMITER ;