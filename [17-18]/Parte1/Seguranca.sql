-- Criaçao de Utilizadores e atribuiçao de proivilegios --

create user 'admin'@'localhost' 
	identified by '123';
grant all privileges on Gest_Hotel.*
	to 'admin'@'localhost' ;

create user 'user'@'localhost'
	identified by '1234';
grant select on Gest_Hotel.*
	to 'user'@'localhost';
grant insert, update on Gest_Hotel.Cliente
	to 'user'@'localhost';
grant insert, update on Gest_Hotel.Cartao_Cidadao
	to 'user'@'localhost';
grant insert, update on Gest_Hotel.Morada
	to 'user'@'localhost';
grant insert, update on Gest_Hotel.Reserva
	to 'user'@'localhost';
grant insert, update on Gest_Hotel.Tipo_Reserva
	to 'user'@'localhost';

