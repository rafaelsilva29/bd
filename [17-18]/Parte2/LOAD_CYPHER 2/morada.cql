LOAD CSV WITH HEADERS FROM 'file:///morada.csv' AS row 
CREATE (m: Morada {id_Morada: toInt(row.id_Morada)})
SET m.Rua = toString(row.Rua),
	m.Localidade = toString(row.Localidade),
	m.Codigo_Postal = toString(row.Codigo_Postal)
return m;