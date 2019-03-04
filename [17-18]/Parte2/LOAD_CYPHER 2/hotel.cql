LOAD CSV WITH HEADERS FROM 'file:///hotel.csv' AS row
CREATE (h: Hotel {id_Hotel: toInt(row.id_Hotel)})
SET h.Nome_Hotel = toString(row.Nome_Hotel),
 	h.Cidade = toString(row.Cidade),
	h.Contacto = toString(row.Contacto),
	h.Classificacao = toFloat(row.Classificacao),
	h.Endereco = toString(row.Endereco)
RETURN h;
