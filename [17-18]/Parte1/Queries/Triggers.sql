
DELIMITER $$
CREATE TRIGGER before_cliente_update
    BEFORE UPDATE ON Cliente
    FOR EACH ROW 
BEGIN
    INSERT INTO Cliente
    SET action = 'update',
     id_Cliente= OLD.id_Cliente,
        Email= OLD.Email ,
       NºCartao_Debito = OLD.NºCartao_Debito,
		Contacto_Telefonico = OLD.Contacto_Telefonico;
END$$
DELIMITER ;