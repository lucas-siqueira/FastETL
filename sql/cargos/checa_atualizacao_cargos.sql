-- código definitivo
-- SELECT COUNT(1)
-- FROM PGG_DW.DW_APF_FATOS.FT_INFORMACOES_SIAPE
-- WHERE INFORMACAO_TIPO_ID = 20001 AND SUBSTRING(CONVERT(VARCHAR, TEMPO_DIA_ID), 1, 6) = {{ macros.datetime(execution_date.year, execution_date.month -1, 1).strftime("%Y%m") }};

SELECT COUNT(1)
FROM PGG_DW.DW_APF_FATOS.FT_INFORMACOES_SIAPE
WHERE INFORMACAO_TIPO_ID = 20001
AND SUBSTRING(CONVERT(VARCHAR, TEMPO_DIA_ID), 1, 6) = 201907;

