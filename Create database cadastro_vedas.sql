Create database cadastro_vedas;

create sequence cliente_id_seq Increment 1;
create sequence endereco_id_seq Increment 1;
create sequence contrato_id_seq Increment 1;
create sequence proprietario_id_seq Increment 1;
create sequence imovel_id_seq Increment 1;
create sequence cartorio_id_seq Increment 1;
create sequence gasto_imovel_id_seq Increment 1; 
create sequence financiamento_id_seq Increment 1;

Create Table enderecos ( --1
	id integer primary key not null default nextval('endereco_id_seq'::regclass),
	endereco_rua varchar (255) not null,
	endereco_complemento varchar (255) null,
	endereco_bloco char null,
    endereco_cep integer not null,
	endereco_cidade char not null,
	endereco_uf char not null
)

Create Table imovel (--2
	id integer primary key not null default nextval('imovel_id_seq'::regclass),
	imovel_tipo char  not null,
	imovel_idade char not null,
	imovel_matricula char not null,
	imovel_tamanho char not null,
    endereco_id integer,
	Foreign key (id) References
		public.enderecos(id),
)


Create Table proprietario (--3
	id integer primary key not null default nextval('proprietario_id_seq'::regclass),
	proprietario_nome VARCHAR (255) not null,
	proprietario_data_nascimento date not null,
    proprietario_rg char not null,
	proprietario_cpf int not null,
	proprietario_estado_civil char not null,
	proprietario_profissao char not null,
	proprietario_telefone char not null,
    proprietario_email char not null,
	endereco_id integer,
	imovel_id integer,
	Foreign key (endereco_id) References
		public.endereco(id),
	Foreign key (imovel_id) References
		public.imovel(id)
)


Create Table gasto_imovel (--4
	id integer primary key not null default nextval('gasto_imovel_id_seq'::regclass),
	gasto_luz char  not null,
	gasto_agua char not null,
	gasto_condominio char null,
	imovel_id integer,
    Foreign key (id) References
		public.imovel(id)

)

Create Table cartorio (--5
	id integer primary key not null default nextval('cartorio_id_seq'::regclass),
	cartorio_registro char  not null,
	cartorio_nome varchar(255) not null,
	endereco_id integer,
	Foreign key (id) References
		public.enderecos(id)
)

Create Table cliente (--6
	id integer primary key not null default nextval('cliente_id_seq'::regclass),
	cliente_nome VARCHAR (255) not null,
	cliente_data_nascimento date not null,
    cliente_rg char not null,
	cliente_cpf int not null,
	cliente_estado_civil char not null,
	cliente_profissao char not null,
	cliente_telefone char not null,
    cliente_email char not null,
	cliente_financiamento bit not null,
	financiamento_id integer,
    endereco_id integer,
    Foreign key (id) References
		public.enderecos(id)
	
)


Create Table financiamento (--7
	id integer primary key not null default nextval('gasto_imovel_id_seq'::regclass),
	financiamento_banco char   null,
	financiamento_parcelas integer  null,
	financiamento_porcentagem decimal null,
	cliente_id integer,
	Foreign key (id) References
		public.cliente(id)
)

Create Table contrato (
	id integer primary key not null default nextval('contrato_id_seq'::regclass),
	imovel_id integer,
	proprietario_id integer,
	cliente_id integer,
	cartorio_id integer,
	gasto_imovel_id integer,
	financiamento_id integer,
	Foreign key (id) References
		public.imovel(id),
	Foreign key (id) References
		public.proprietario(id),
	Foreign key (id) References
		public.cliente(id),
	Foreign key (id) References
		public.cartorio(id),
	Foreign key (id) References
		public.gasto_imovel(id),
	Foreign key (id) References
		public.financiamento(id)
)