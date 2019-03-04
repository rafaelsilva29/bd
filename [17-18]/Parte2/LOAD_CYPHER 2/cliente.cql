LOAD CSV WITH HEADERS FROM 'file:///cliente.csv' AS row
CREATE (c: Cliente {id_Cliente: toInt(row.id_Cliente)})
SET c.Email = toString(row.Email),
	c.Contacto_Telefonico = toInt(row.Contacto_Telefonico),
	c.NºCartao_Debito = toInt(row.NºCartao_Debito),
	c.Morada_id_Morada = toInt(row.Morada_id_Morada),
	c.Cartao_Cidadao_id_Cartao_Cidadao = toInt(row.Cartao_Cidadao_id_Cartao_Cidadao)
RETURN c;
