use OFICINA;

select * from CLIENTE;

select * from VEICULO;

select * from EQUIPE;

select * from MECANICO;

select * from COMPOSICAO_DA_EQUIPE;

select * from PECAS;

select * from TIPO_SERVICO;

select * from ORDEM_SERVICO;

select * from AUTORIZACAO;

select * from PECAS_DA_OS;

-- SELECIONAR OS CLIENTES ORDENANDO PELO NOME DO CLIENTE
select * from CLIENTE order by NOME_RAZAO;

-- SELECIONAR A ORDEM DE SERVICO COM O VEICULO E AS PEÇAS UTILIZADAS NO SERVICO. MOSTRAR QUAL TIPO DE SERVIÇO FOI EXECUTADO E POR QUAL EQUIPE
select OS.ID as ORDEM_SERVICO, 
       OS.DATA_EMISSAO, 
	   OS.NUMERO, 
       C.NOME_RAZAO as CLIENTE,
	   OS.STATUS, 
       V.DESCRICAO AS VEICULO, 
       V.PLACA, 
       V.CHASSI, 
       P.ID as CODIGO_PECA, 
       P.DESCRICAO as PECA, 
       TS.TABELA_PRECOS, 
       TS.TIPO_SERVICO,
	   TS.DESCRICAO as DESCRICAO_DO_SERVICO,
       A.AUTORIZA as AUTORIZACAO,
       ( select E.DESCRICAO from EQUIPE E where E.ID = OS.EQUIPE_ID) as EQUIPE 
  from ORDEM_SERVICO OS, PECAS_DA_OS PO, AUTORIZACAO A, VEICULO V, PECAS P, CLIENTE C, TIPO_SERVICO TS
 where OS.ID = PO.ORDEM_ID
   and OS.ID = A.ORDEM_ID
   and OS.VEICULO_ID = V.ID
   and PO.PECAS_ID = P.ID
   and V.CLIENTE_ID = C.ID
   and OS.TIPO_SERVICO_ID = TS.ID;
   
-- SELECIONAR A ORDEM DE SERVICO QUE NAO FORAM AUTORIZADOS O SERVICO
select OS.ID as ORDEM_SERVICO, 
       OS.DATA_EMISSAO, 
	   OS.NUMERO, 
       C.NOME_RAZAO as CLIENTE,
	   OS.STATUS, 
       V.DESCRICAO AS VEICULO, 
       V.PLACA, 
       V.CHASSI,  
       TS.TABELA_PRECOS, 
       TS.TIPO_SERVICO,
	   TS.DESCRICAO as DESCRICAO_DO_SERVICO,
       format(OS.VALOR, 2, 'de_DE') as VALOR_SERVICO,
       A.AUTORIZA as AUTORIZACAO
  from ORDEM_SERVICO OS, AUTORIZACAO A, VEICULO V, CLIENTE C, TIPO_SERVICO TS
 where OS.ID = A.ORDEM_ID
   and OS.VEICULO_ID = V.ID
   and V.CLIENTE_ID = C.ID
   and OS.TIPO_SERVICO_ID = TS.ID
   and A.AUTORIZA = 'NAO';

-- SELECIONAR A ORDEM DE SERVICO QUE FORAM AUTORIZADOS O SERVICO
select OS.ID as ORDEM_SERVICO, 
       OS.DATA_EMISSAO, 
	   OS.NUMERO, 
       C.NOME_RAZAO as CLIENTE,
	   OS.STATUS, 
       V.DESCRICAO AS VEICULO, 
       V.PLACA, 
       V.CHASSI, 
       TS.TABELA_PRECOS, 
       TS.TIPO_SERVICO,
	   TS.DESCRICAO as DESCRICAO_DO_SERVICO,
       format(OS.VALOR, 2, 'de_DE') as VALOR_SERVICO,
       A.AUTORIZA as AUTORIZACAO
  from ORDEM_SERVICO OS, AUTORIZACAO A, VEICULO V, CLIENTE C, TIPO_SERVICO TS
 where OS.ID = A.ORDEM_ID
   and OS.VEICULO_ID = V.ID
   and V.CLIENTE_ID = C.ID
   and OS.TIPO_SERVICO_ID = TS.ID
   and A.AUTORIZA = 'SIM';

-- SELECIONAR A ORDEM DE SERVICO QUE AINDA NAO FORAM ENTREGUES   
   select OS.ID as ORDEM_SERVICO, 
       OS.DATA_EMISSAO, 
	   OS.NUMERO, 
       C.NOME_RAZAO as CLIENTE,
	   OS.STATUS, 
       V.DESCRICAO AS VEICULO, 
       V.PLACA, 
       V.CHASSI, 
       TS.TABELA_PRECOS, 
       TS.TIPO_SERVICO,
       TS.DESCRICAO as DESCRICAO_DO_SERVICO,
       format(OS.VALOR, 2, 'de_DE') as VALOR_SERVICO,
       A.AUTORIZA as AUTORIZACAO
  from ORDEM_SERVICO OS, AUTORIZACAO A, VEICULO V, CLIENTE C, TIPO_SERVICO TS
 where OS.ID = A.ORDEM_ID
   and OS.VEICULO_ID = V.ID
   and V.CLIENTE_ID = C.ID
   and OS.TIPO_SERVICO_ID = TS.ID
   and A.AUTORIZA = 'SIM'
   and OS.STATUS <> 'ENTREGUE';
   
-- SELECIONAR AS EQUIPES E SEUS MECANICOS
select E.DESCRICAO as EQUIPE,
       M.NOME as MECANICO,
       M.ESPECIALIDADE 
  from EQUIPE E, COMPOSICAO_DA_EQUIPE CE, MECANICO M
  where E.ID = CE.EQUIPE_ID
    and CE.MECANICO_ID = M.ID;
    
-- SELECIONAR AS CLIENTES E SEUS VEICULOS
select C.NOME_RAZAO as CLIENTE, 
       CONCAT(SUBSTR(C.CPF_CNPJ,1,3),'.',SUBSTR(C.CPF_CNPJ,4,3),'.',SUBSTR(C.CPF_CNPJ,7,3),'-',SUBSTR(C.CPF_CNPJ,10,2)) as CPF,
       V.DESCRICAO as VEICULO,
       V.PLACA
  from CLIENTE C, VEICULO V
  where C.ID = V.CLIENTE_ID;

-- SELECIONAR O VALOR TOTAL DO SERVICO POR CLIENTE
select C.NOME_RAZAO as CLIENTE, 
       CONCAT(SUBSTR(C.CPF_CNPJ,1,3),'.',SUBSTR(C.CPF_CNPJ,4,3),'.',SUBSTR(C.CPF_CNPJ,7,3),'-',SUBSTR(C.CPF_CNPJ,10,2)) as CPF,
	   format(max(TS.VALOR), 2, 'de_DE') as VALOR_MAO_DE_OBRA, 
       format(sum(P.VALOR * PO.QUANTIDADE), 2, 'de_DE') as VALOR_DAS_PECAS,
       format(( max(TS.VALOR) + sum(P.VALOR * PO.QUANTIDADE) ), 2, 'de_DE') as VALOR_TOTAL_SERVICO
  from ORDEM_SERVICO OS, PECAS_DA_OS PO, AUTORIZACAO A, VEICULO V, PECAS P, CLIENTE C, TIPO_SERVICO TS
 where OS.ID = PO.ORDEM_ID
   and OS.ID = A.ORDEM_ID
   and OS.VEICULO_ID = V.ID
   and PO.PECAS_ID = P.ID
   and V.CLIENTE_ID = C.ID
   and OS.TIPO_SERVICO_ID = TS.ID
 group by C.NOME_RAZAO, C.CPF_CNPJ;

-- SELECIONAR O VALOR TOTAL DO SERVICO POR CLIENTE ONDE O VALOR TOTAL FOR MAIOR QUE 3 MIL
select C.NOME_RAZAO as CLIENTE, 
       CONCAT(SUBSTR(C.CPF_CNPJ,1,3),'.',SUBSTR(C.CPF_CNPJ,4,3),'.',SUBSTR(C.CPF_CNPJ,7,3),'-',SUBSTR(C.CPF_CNPJ,10,2)) as CPF,
	   format(max(TS.VALOR), 2, 'de_DE') as VALOR_MAO_DE_OBRA, 
       format(sum(P.VALOR * PO.QUANTIDADE), 2, 'de_DE') as VALOR_DAS_PECAS,
       format(( max(TS.VALOR) + sum(P.VALOR * PO.QUANTIDADE) ), 2, 'de_DE') as VALOR_TOTAL_SERVICO
  from ORDEM_SERVICO OS, PECAS_DA_OS PO, AUTORIZACAO A, VEICULO V, PECAS P, CLIENTE C, TIPO_SERVICO TS
 where OS.ID = PO.ORDEM_ID
   and OS.ID = A.ORDEM_ID
   and OS.VEICULO_ID = V.ID
   and PO.PECAS_ID = P.ID
   and V.CLIENTE_ID = C.ID
   and OS.TIPO_SERVICO_ID = TS.ID
 group by C.NOME_RAZAO, C.CPF_CNPJ
 having ( max(TS.VALOR) + sum(P.VALOR * PO.QUANTIDADE) ) > 3000
 