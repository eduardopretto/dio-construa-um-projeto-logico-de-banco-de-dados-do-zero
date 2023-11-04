 use OFICINA;
 
 alter table CLIENTE auto_increment = 1;
 
 insert into CLIENTE ( 	NOME_RAZAO,
						JURFIS,
                        CPF_CNPJ )
              values ('LUIS SILVA', 'FISICA', '00112233001'),          
                     ('EDUARDO SANTOS', 'FISICA', '11112233002'),
                     ('PEDRO SILVA', 'FISICA', '22112233003'), 
                     ('MARIA LUZ', 'FISICA', '33112233004'),
                     ('ALICE DA SILVA', 'FISICA', '44112233005'),
                     ('RAFAEL MARQUES', 'FISICA', '55112233006'),
                     ('JOAO OLIVEIRA', 'FISICA', '66112233007'), 
                     ('BRUNO SANTOS', 'FISICA', '77112233008'), 
                     ('HEIOR FERNADEZ', 'FISICA', '88112233009'), 
                     ('MIGUEL MESSIAS', 'FISICA', '99112233010');

 alter table VEICULO auto_increment = 1;
 
 insert into VEICULO ( CLIENTE_ID, DESCRICAO, PLACA, CHASSI )
			  values ('1', 'MOTO', 'MKT-2935', 00112233000),          
                     ('2', 'CARRO', 'KJH-9837', 11112233001),
                     ('3', 'CAMINHONETE', 'JXT-1267', '22112233003'), 
                     ('4', 'CAMINHAO', 'IKL-7427', '33112233004'),
                     ('5', 'ONIBUS', 'JKM-9032', '44112233005'),
                     ('6', 'CARRO', 'MUL-4587', '55112233006'),
                     ('7', 'MOTO', 'KGA-3476', '66112233007'), 
                     ('8', 'CARRO', 'MJY-1896', '77112233008'), 
                     ('9', 'SUV', 'KPL-2798', '88112233009'), 
                     ('10', 'SUV', 'KQW-2765', '99112233010');

alter table EQUIPE auto_increment = 1;
 
insert into EQUIPE ( DESCRICAO)
            values ('EQUIPE 1'), 
                   ('EQUIPE 2'), 
                   ('EQUIPE 3');
                   
alter table MECANICO auto_increment = 1;
 
insert into MECANICO ( CPF, NOME, ENDERECO, FONE, ESPECIALIDADE )
              values ('99115533036', 'JOAO', 'RUA PORTUGAL, 365, CHAPECO, SC', '49-92040-9999', 'PINTURA' ), 
					 ('88115533030', 'PEDRO', 'RUA ORQUIDEA, 420, CHAPECO, SC', '49-92040-8888', 'MOTOR' ), 
					 ('77115533031', 'ROBERTO', 'RUA SAO PAULO, 780, CHAPECO, SC', '49-92040-7777', 'CHAPEACAO' ), 
					 ('66115533032', 'FLAVIO', 'RUA PORTUGAL, 200, CHAPECO, SC', '49-92040-6666', 'MANUTENCAO' ), 
                     ('55115533033', 'JOANA', 'RUA ORQUIDEA, 400, CHAPECO, SC', '49-92040-5555', 'ACESSORIOS' ), 
                     ('44115533034', 'MARIA', 'RUA SAO PAULO, 963, CHAPECO, SC', '49-92040-4444', 'ACESSORIOS' );

insert into COMPOSICAO_DA_EQUIPE ( MECANICO_ID, EQUIPE_ID)
                          values ('2', '1'), 
                                 ('3', '1'), 
                                 ('1', '2'),
								 ('5', '3'),
                                 ('6', '3'),
                                 ('4', '3');

alter table PECAS auto_increment = 1;

insert into PECAS ( DESCRICAO, VALOR )
           values ('PNEU', '599.90'), 
                  ('PARAFUSO', '9.90'), 
                  ('PARABRISA', '980.90'), 
                  ('LIMPADOR', '19.90'), 
                  ('FILTRO DE AR', '39.90'),
                  ('BATERIA', '89.90'),
                  ('PISTAO', '99.90'),
                  ('VIRA BREQUIM', '129.90'),
                  ('BICO INJETOR', '300.00'),
                  ('TINTA ESPECIAL', '1500.00');

alter table TIPO_SERVICO auto_increment = 1;

insert into TIPO_SERVICO ( DESCRICAO, TABELA_PRECOS, TIPO_SERVICO, VALOR )   
				  values ('LIMPAR O SISTEMA DE AR', 'NORMAL', 'CONSERTO', '100.00'),  
						 ('CONSERTO/TROCA DE PNEU', 'NORMAL', 'CONSERTO', '200.00'), 
                         ('CONSERTO MOTOR', 'NORMAL', 'CONSERTO', '2000.00'),  
                         ('REVISAO BASICA', 'PROMOCAO', 'REVISAO', '600.00'), 
                         ('REVISAO COMPLETA', 'PROMOCAO', 'REVISAO', '1200.00'),
                         ('PINTURA', 'PROMOCAO', 'CONSERTO', '1200.00');

alter table ORDEM_SERVICO auto_increment = 1;

insert into ORDEM_SERVICO ( VEICULO_ID, EQUIPE_ID, TIPO_SERVICO_ID, DATA_EMISSAO, DATA_ENTREGA, DATA_CONCLUSAO, NUMERO, STATUS, VALOR )
                   values ('1', '1', '3', '2023-11-04', '2023-11-14', null, '100001', 'AGENDADO', '2539.70' ), 
                          ('2', '3', '5', '2023-11-04', '2023-11-04', '2023-11-04', '100002', 'ENTREGUE', '3470.20' ), 
                          ('3', '2', '6', '2023-11-04', '2023-11-04', '2023-11-04', '100003', 'CANCELADO', '2700.00' ),
                          ('4', '2', '6', '2023-11-04', '2023-12-04', null, '100004', 'ORCAMENTO', '2700.00' ),
                          ('5', '2', '6', '2023-11-04', '2023-12-04', null, '100005', 'AGENDADO', '2700.00' );

insert into AUTORIZACAO ( CLIENTE_ID, ORDEM_ID, AUTORIZA )
                 values ('1', '1', 'SIM' ),
                        ('2', '2', 'SIM' ),
                        ('3', '3', 'NAO' ),
                        ('4', '4', 'SIM' ),
                        ('5', '5', 'SIM' );

insert into PECAS_DA_OS ( ORDEM_ID, PECAS_ID, QUANTIDADE )
                 values ('1', '2', '1' ),
                        ('1', '7', '1' ),
                        ('1', '8', '1' ),
                        ('1', '9', '1' ),
                        ('2', '1', '1' ),
                        ('2', '2', '1' ),
                        ('2', '3', '1' ),
                        ('2', '4', '1' ),
                        ('2', '5', '1' ),
                        ('2', '6', '1' ),
                        ('2', '7', '1' ),
                        ('2', '8', '1' ),
                        ('2', '9', '1' ),
                        ('3', '10', '1' ),
                        ('4', '10', '1' ),
                        ('5', '10', '1' );
                        