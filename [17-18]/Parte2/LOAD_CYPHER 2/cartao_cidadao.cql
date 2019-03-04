LOAD CSV WITH HEADERS FROM 'file:///cartao_cidadao.csv' AS row
CREATE (cc: Cartao_Cidadao {id_Cartao_Cidadao: toInt(row.id_Cartao_Cidadao)})
SET cc.Nome = toString(row.Nome),
	cc.Numero = toInt(row.Numero)
RETURN cc;