CREATE TABLE produto (
  idproduto INTEGER   NOT NULL ,
  nome VARCHAR(255)    ,
  quantidade INTEGER    ,
  precoVenda NUMERIC(5,2)      ,
PRIMARY KEY(idproduto));




CREATE TABLE usuario (
  idusuario INTEGER   NOT NULL ,
  nomeUsuario VARCHAR(255)    ,
  senha VARCHAR(255)      ,
PRIMARY KEY(idusuario));




CREATE TABLE pessoa (
  idpessoa INTEGER   NOT NULL ,
  nome VARCHAR(255)    ,
  logradouro VARCHAR(255)    ,
  cidade VARCHAR(255)    ,
  estado VARCHAR(2)    ,
  telefone VARCHAR(15)    ,
  email VARCHAR(255)    ,
  cpf_cnpj VARCHAR(18)    ,
  tipoPessoa CHAR(1)      ,
PRIMARY KEY(idpessoa));




CREATE TABLE movimento (
  idmovimento INTEGER   NOT NULL ,
  usuario_idusuario INTEGER   NOT NULL ,
  pessoa_idpessoa INTEGER    ,
  produto_idproduto INTEGER    ,
  tipoMovimento CHAR(1)    ,
  quantidade INTEGER    ,
  valorUnitario NUMERIC(5,2)      ,
PRIMARY KEY(idmovimento)      ,
  FOREIGN KEY(produto_idproduto)
    REFERENCES produto(idproduto),
  FOREIGN KEY(pessoa_idpessoa)
    REFERENCES pessoa(idpessoa),
  FOREIGN KEY(usuario_idusuario)
    REFERENCES usuario(idusuario));

	create sequence seq_Pessoa
	as numeric
	start with 1
	increment by 1
	no cycle;