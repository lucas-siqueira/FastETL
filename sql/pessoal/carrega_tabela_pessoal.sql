INSERT INTO PGG_DW.CONTROLE.pessoal_orgao (
       ano_mes
       , informacao_tipo_id
       , informacao_tipo_desc
       , orgao_codigo_siorg
       , orgao_nome
       , orgao_natureza_juridica
       , orgao_classificacao
       , sum_valor
       , data_snapshot)
SELECT
	CONVERT(INT, SUBSTRING(CONVERT(VARCHAR, TEMPO_DIA_ID), 1, 6)) AS ano_mes
	, FT.INFORMACAO_TIPO_ID AS informacao_tipo_id
	, I.INFORMACAO_TIPO_DESCRICAO AS informacao_tipo_desc	
	, OP.ORG_PADR_CODIGO AS orgao_codigo_siorg
	, OP.ORG_PADR_NOME AS orgao_nome
	, NJ.ORGAO_NATUREZA_JURIDICA_DESCRICAO AS orgao_natureza_juridica
	, C.ORGAO_CLASSIFICACAO AS orgao_classificacao
	, SUM(FT.VALOR) AS sum_valor
	, GETDATE() AS data_snapshot
FROM
	PGG_DW.DW_APF_FATOS.FT_INFORMACOES_SIAPE FT
	JOIN PGG_DW.DW_APF_GERAL.DM_ORGAO_UNIFICADO OU
		ON FT.ORGAO_UNIFICADO_ID = OU.ORGAO_UNIFICADO_ID
	JOIN PGG_DW.DW_APF_GERAL.DM_ORG_PADRONIZADO OP
		ON OU.ORG_PADR_ID = OP.ORG_PADR_ID
	JOIN PGG_DW.DW_APF_GERAL.DM_INFORMACAO_TIPO I
		ON FT.INFORMACAO_TIPO_ID = I.INFORMACAO_TIPO_ID
	JOIN PGG_DW.DW_APF_GERAL.DM_ORGAO_NATUREZA_JURIDICA NJ
		ON OP.ORG_PADR_ID_NATUREZA_JURIDICA = NJ.ORGAO_NATUREZA_JURIDICA_ID
	JOIN PGG_DW.DW_APF_GERAL.DM_ORGAO_CLASSIFICACAO C
		ON OP.ORGAO_CLASSIFICACAO_ID = C.ORGAO_CLASSIFICACAO_ID
WHERE
	FT.INFORMACAO_TIPO_ID = {{ params.informacao_tipo_id }}
GROUP BY
	CONVERT(INT, SUBSTRING(CONVERT(VARCHAR, FT.TEMPO_DIA_ID), 1, 6))
	, OP.ORG_PADR_CODIGO
	, I.INFORMACAO_TIPO_DESCRICAO
	, FT.INFORMACAO_TIPO_ID
	, NJ.ORGAO_NATUREZA_JURIDICA_DESCRICAO
	, C.ORGAO_CLASSIFICACAO
	, OP.ORG_PADR_NOME;
