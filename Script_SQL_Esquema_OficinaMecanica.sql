-- criação do banco de dados para cenário de Oficina Mecânica
drop database OFICINA;
create database OFICINA;
use OFICINA;

create table CLIENTE (
					   ID			   integer auto_increment primary key,
					   NOME_RAZAO	   varchar(45) not null default '',
					   JURFIS          enum('FISICA', 'JURIDICA') default 'FISICA',
					   CPF_CNPJ        varchar(14) not null default '',
					   constraint UNIQUE_CLIENTE_CPF_CNPJ unique (CPF_CNPJ)
);

create table VEICULO (
					   ID				integer auto_increment primary key,
					   CLIENTE_ID		integer not null,
					   DESCRICAO		varchar(45) not null default '',
					   PLACA		    varchar(10) not null default '',
					   CHASSI		    varchar(45) not null default '',
					   foreign key FK_VEICULO_CLIENTE_ID (CLIENTE_ID) references CLIENTE(ID),
					   constraint UNIQUE_VEICULO_CHASSI unique (CHASSI)
);  

create table EQUIPE (
					  ID			integer auto_increment primary key,
					  DESCRICAO		varchar(45) not null default ''
);   

create table MECANICO (
						ID				integer auto_increment primary key,
                        CPF             varchar(11) not null default '',
						NOME		    varchar(45) not null default '',
                        ENDERECO        varchar(45) not null default '',
                        FONE            varchar(45) not null default '',
                        ESPECIALIDADE   enum('PINTURA', 'MOTOR', 'CHAPEACAO', 'ACESSORIOS', 'MANUTENCAO') default 'MOTOR',
                        constraint UNIQUE_MECANICO_CPF unique (CPF)
); 

create table COMPOSICAO_DA_EQUIPE (
									MECANICO_ID		integer not null,
									EQUIPE_ID		integer not null,
									foreign key FK_COMPOSICAO_DA_EQUIPE_MECANICO_ID (MECANICO_ID) references MECANICO(ID),
									foreign key FK_COMPOSICAO_DA_EQUIPE_EQUIPE_ID (EQUIPE_ID) references EQUIPE(ID)
);  

create table PECAS (
					 ID				integer auto_increment primary key,
					 DESCRICAO		varchar(45) not null default '',
					 VALOR           float
);

create table TIPO_SERVICO (
							ID				integer auto_increment primary key,
							DESCRICAO		varchar(45) not null default '',
							TABELA_PRECOS   enum('PROMOCAO', 'NORMAL') default 'NORMAL',
							TIPO_SERVICO    enum('CONSERTO', 'REVISAO') default 'REVISAO',
							VALOR           float
);

create table ORDEM_SERVICO (
							 ID					integer auto_increment primary key,
							 VEICULO_ID			integer not null,
                             EQUIPE_ID			integer not null,
                             TIPO_SERVICO_ID	integer not null,
							 DATA_EMISSAO   	date not null, 
                             DATA_ENTREGA   	date,
                             DATA_CONCLUSAO 	date,
                             NUMERO         	integer not null,
                             STATUS         	enum('ORCAMENTO', 'CANCELADO', 'AGENDADO', 'EM EXECUCAO', 'ENTREGUE') default 'ORCAMENTO',
							 VALOR          	float,
                             foreign key FK_ORDEM_SERVICO_VEICULO_ID (VEICULO_ID) references VEICULO(ID),
                             foreign key FK_ORDEM_SERVICO_EQUIPE_ID (EQUIPE_ID) references EQUIPE(ID),
							 foreign key FK_ORDEM_SERVICO_TIPO_SERVICO_ID (TIPO_SERVICO_ID) references TIPO_SERVICO(ID)
);   


create table AUTORIZACAO (
							CLIENTE_ID		integer not null,
							ORDEM_ID		integer not null,
							AUTORIZA		enum('SIM', 'NAO') default 'SIM',
                            foreign key FK_AUTORIZACAO_CLIENTE_ID (CLIENTE_ID) references CLIENTE(ID),
                            foreign key FK_AUTORIZACAO_ORDEM_ID (ORDEM_ID) references ORDEM_SERVICO(ID)
);                        
  
create table PECAS_DA_OS (
							ORDEM_ID		integer not null,
							PECAS_ID		integer not null,
                            QUANTIDADE      integer not null,
							foreign key FK_PECAS_DA_OS_ORDEM_ID (ORDEM_ID) references ORDEM_SERVICO(ID),
                            foreign key FK_PECAS_DA_OS_PECAS_ID (PECAS_ID) references PECAS(ID)
);    
  
show tables;
 