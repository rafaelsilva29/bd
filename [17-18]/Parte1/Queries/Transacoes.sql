
-- Transaçao 1 (Insere Cliente / Morada / Cartao Cidadao)

-- -- -- -- -- -- -- -- -- -- -- -- Inserir Morada -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

DELIMITER $$
drop procedure if exists insere_morada $$
create procedure insere_morada(in rua varchar(45), in localidade varchar(45), in codigo_postal varchar(45))
	begin
		start transaction;
		
		if(exists(select m.Rua, m.Localidade, m.Codigo_Postal from Morada as m where m.Rua=rua and m.Codigo_Postal=codigo_postal and m.Localidade=localidade))
			then
				select 'Morada Existe' as msg1;
		else

			select @id_Morada := max(id_Morada) from Morada;

			set @id_Morada = @id_Morada + 1;

			insert into Morada(id_Morada, rua, localidade, codigo_postal)
				values	
						(@id_Morada, rua, localidade, codigo_postal);
			select 'Morada Inserida';
	
		commit;
		
		end if;
	end $$
DELIMITER ;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- Inserir Cartao Cidadao -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

DELIMITER $$
drop procedure if exists insere_cartao_cidadao $$
create procedure insere_cartao_cidadao(in nome varchar(45), in numero varchar(45))
	begin
		start transaction;
		
		if(exists(select cc.Numero from Cartao_Cidadao as cc where numero=cc.Numero))
			then
				select 'Cliente existe' as msg1;
		
		else 
			select @id_Cartao_Cidadao := max(id_Cartao_Cidadao) from Cartao_Cidadao;

			set @id_Cartao_Cidadao = @id_Cartao_Cidadao + 1;

			insert into Cartao_Cidadao(id_Cartao_Cidadao, Nome, Numero)
				values	
						(@id_Cartao_Cidadao, nome, numero);
			select 'Inserido_Cartao_Cidadao';
	
			commit;
		end if;
	end $$
DELIMITER ;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- Inserir Cliente -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

DELIMITER $$
drop procedure if exists insere_Cliente $$
create procedure insere_Cliente(in email varchar(45), in n_cartao_debito bigint, in telefone int(9), in nome varchar(45), in numero varchar(45), in rua varchar(45), in localidade varchar(45), in codigo_postal varchar(45))
	begin
		start transaction;
		
		if(exists(select c.Email  from Cliente as c where c.Email=email))
			then 
				select 'Email existente' as msg1;
		else

			call `insere_cartao_cidadao`(nome,numero);
			call `insere_morada`(rua, localidade,codigo_postal);
			
			select @id_Cliente := max(id_Cliente) 
			from Cliente;
			set @id_Cliente = @id_Cliente  + 1;
 
			insert into cliente(id_Cliente, Email, NºCartao_Debito)
			values(@id_Cliente, email, n_cartao_debito);
			
			select 'Registo efetuado' as Msg;
			
			commit;
		
		end if;
	end $$
DELIMITER ;

-- Transacao 2 (Update Cliente / Update Morada / Upate Cartao_Cidadao)

-- -- -- -- -- -- -- -- -- -- (Update Morada) -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

DELIMITER $$
drop procedure if exists update_morada $$
create procedure update_morada(in id int , rua varchar(45), in localidade varchar(45), in codigo_postal varchar(45))
	begin
		start transaction;
		
		if(exists(select m.Rua, m.Localidade, m.Codigo_Postal from Morada as m where m.Rua=rua and localidade=m.Localidade and m.Codigo_Postal=codigo_postal))
			then
				select 'Morada igual a que quer mudar.' as msg1;
			
		else

			update Morada as m
			set m.Rua = rua
			where m.id_Morada=id;
			commit;
			
			update Morada as m
			set m.Localidade = localidade
			where m.id_Morada=id;
			commit;
		
			select 'Morada nao existe' as Msg1;
			update Morada as m
			set m.Codigo_Postal = codigo_postal
			where m.id_Morada=id;
			
			select 'Update da morada efetuada' as Msg;
			commit;
	
		end if;
		
	end $$
DELIMITER ;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- Update cartao cidadao -- -- -- -- -- -- -- -- -- -- -- -- -- -- 


DELIMITER $$
drop procedure if exists update_cartao_cidadao $$
create procedure update_cartao_cidadao(in id int , in nome varchar(45), in numero varchar(45))
	begin
		start transaction;
		
		if(exists(select cc.Numero, cc.Nome from Cartao_Cidadao as cc where cc.Numero=numero and cc.Nome=nome))
			then
				select 'Cartao de cidadao igual ao que quer mudar.' as msg1;
			
			else

			update Cartao_Cidadao as cc
			set cc.Nome = nome
			where cc.id_Cartao_Cidadao=id;
			commit;
			
			update Cartao_Cidadao as cc
			set cc.Numero = numero
			where cc.id_Cartao_Cidadao=id;
			commit;
			
			select 'Update do cartao de cidadao efetuada.' as Msg;
			commit;
	
		end if;
		
	end $$
DELIMITER ;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- Update Cliente -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

DELIMITER $$
drop procedure if exists update_cliente $$
create procedure update_cliente(in id_C int , in id_Cc int, in id_M int, in email varchar(45), in numero_debito bigint, in telefone int(9), in nome varchar(45), in numero varchar(45), in rua varchar(45), in localidade varchar(45), in codigo_postal varchar(45))
	begin

		start transaction;
		
		if(exists(select c.Email , c.NºCartao_Debito, c.Contacto_Telefonico from Cliente as c where c.Email=email and c.NºCartao_Debito=numero_debito and c.Contacto_Telefonico=telefone ))
			then
				select 'Cliente igual ao que quer mudar.' as msg;
				
			else
			
			call `update_morada`(id_M,rua,localidade,codigo_postal);
			call `update_cartao_cidadao`(id_Cc,nome,numero);

			update Cliente as c
			set c.Email = email
			where c.id_Cliente=id_C;
			commit;
			
			update Cliente as c
			set c.NºCartao_Debito = numero_debito
			where c.id_Cliente=id_C;
			commit;

			update Cliente as c
			set c.Contacto_Telefonico = telefone
			where c.id_Cliente=id_C;
			commit;
			
			
			select 'Update do cliente efetuado com sucesso.' as Msg;
			commit;
	
		end if;
		
	end $$
DELIMITER ;

-- Transacao 3 (Inserir Reserva / Tipo de Reserva)

-- -- -- -- -- -- -- -- -- -- -- Insere Tipo de Reserva -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

DELIMITER $$
drop procedure if exists insere_tipo_reserva $$
create procedure insere_tipo_reserva(in id_TR int, in tipo_quarto mediumtext, in opcao_estadia varchar(20), in id_R int)
	begin
		start transaction;

			insert into Tipo_Reserva(id_Tipo_Reserva, Tipo_Quarto, Opcao_Estadia, Reserva_id_Reserva)
				values	
						(id_TR, tipo_quarto, opcao_estadia, id_R);
			select 'Tipo_Reserva Inserida';
	
		commit;

	end $$
DELIMITER ;

-- -- -- -- -- -- -- -- -- -- -- Insere Reserva -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

DELIMITER $$
drop procedure if exists insere_Reserva $$
create procedure insere_Reserva(in data_i date, in data_o date, in data_r datetime, in preco decimal(10,2), in quantidade_quartos int(4), in tipo_quarto mediumtext, in opcao_estadia varchar(20),  in id_C int, in id_H int)
	begin
		start transaction;

			if(exists(select r.Data_Check_In, r.Data_Check_Out from Reserva as r where data_i=r.Data_Check_In and data_o=r.Data_Check_Out))
				then
					select 'Reserva ja existe.' as msg1;

			else
			
			select @id_Reserva := max(id_Reserva) 
			from Reserva;
			set @id_Reserva= @id_Reserva  + 1;
 
			insert into reserva(id_Reserva, Data_Check_In, Data_Check_Out, Data_Reserva, Preco, Quantidade_Quartos, Cliente_id_Cliente, Hotel_id_Hotel)
			values(@id_Reserva, data_i, data_o, data_r, preco, quantidade_quartos, id_C, id_H);

			call `insere_tipo_reserva`(@id_Reserva, tipo_quarto, opcao_estadia,@id_Reserva);
			
			select 'Registo efetuado' as Msg;
			
			commit;
		
		end if;
	end $$
DELIMITER ;

-- Transacao 4 (Inserir Hotel)

DELIMITER $$
drop procedure if exists insere_Hotel $$
create procedure insere_Hotel(in nomeHotel varchar(45), in cidade varchar(45), in contacto varchar(20), in classificacao decimal(2,1), in endereco varchar(100))
	begin
		start transaction;
		if(exists (select h.Nome_Hotel, h.Cidade, h.Contacto, h.Classificacao, h.Endereco from Hotel as h where h.Nome_Hotel=nomeHotel and h.Cidade=cidade and h.Contacto=contacto or h.Classificacao=classificacao and h.Endereco=endereco))
		   				then select 'Hotel existe' as msg1;
		else 
			if(exists (select h.Classificacao from Hotel as h where classificacao >= 0 and classificacao <= 5))
				then
					select @id_Hotel := max(id_Hotel) from Hotel;

					set @id_Hotel = @id_Hotel + 1;

					insert into Hotel(id_Hotel, Nome_Hotel, Cidade, Contacto, Classificacao, Endereco)
						values	
							(@id_Hotel, nomeHotel, cidade, contacto, classificacao, endereco);
					select 'Hotel Inserido';
				
			else 
				select 'Classificacao fora dos limites' as msg2;
		
			commit;
			
			end if;
		end if;
	end $$
DELIMITER ;


-- Transacao 4( Remover Cliente / Morada / Cartao Cidadao / Reserva / Tipo Reserva)



-- -- -- -- -- -- -- -- -- -- -- Remove Reserva -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

DELIMITER $$
drop procedure if exists remove_reserva $$
create procedure remove_reserva (in id_Tr int)
	begin
		start transaction;

			if(exists(select tr.id_Tipo_Reserva from Tipo_Reserva as tr where tr.id_Tipo_Reserva=id_Tr))
				then
					delete from Tipo_Reserva
					where id_Tipo_Reserva = id_Tr;

					call `remove_tipo_reserva`(id_TR);

					select 'Reserva eliminda';
			
			else
				
select 'Reserva nao existe' as msg2;

		commit;

			end if;
	end $$
DELIMITER ;

-- -- -- -- -- -- -- -- -- -- -- Remove Tipo de Reserva -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
 

DELIMITER $$
drop procedure if exists remove_tipo_reserva $$
create procedure remove_tipo_reserva (in id_R int)
	begin
		start transaction;

			if(not exists(select r.id_Reserva from Reserva as r where r.id_Reserva=id_R))
				then
					select 'Reserva nao existe.' as msg1;
			
			else
				delete from Reserva
					where id_Reserva = id_R;

		commit;

			end if;
	end $$
DELIMITER ;
