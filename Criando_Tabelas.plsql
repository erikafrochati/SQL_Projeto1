/* 1. Criando a tabela produtos, A tabela de produtos, onde teremos as informações dos produtos*/
CREATE TABLE produtos (
  id TEXT PRIMARY KEY,
  nome VARCHAR(255),
  descricao VARCHAR(255),
  preco DECIMAL(10,2),
  categoria VARCHAR(50)
);

/* 2. Criando a tabela colaboradores, A tabela colaboradores, onde teremos nome, ID, endereço*/
CREATE TABLE colaboradores (
    ID TEXT PRIMARY KEY ,
    Nome VARCHAR(255) NOT NULL,
    Cargo VARCHAR(100),
    DataContratacao DATE,
    Telefone VARCHAR(20),
    Email VARCHAR(100),
	Rua VARCHAR(100) NOT NULL,
	Bairro VARCHAR(100) NOT NULL,
	Cidade VARCHAR(100) NOT NULL,
	Estado VARCHAR(2) NOT NULL,
	cep VARCHAR(8) NOT NULL
);

/* 3.Criando a tabela fornecedores, A tabela fornecedores, com informações da pessoa responsável quando entramos em contato, endereço, entre outras */
CREATE TABLE fornecedores (
    ID TEXT PRIMARY KEY ,
    Nome VARCHAR(255) NOT NULL,
  	Contato VARCHAR(100) NOT NULL,
    Telefone VARCHAR(20),
    Email VARCHAR(100),
	Rua VARCHAR(100) NOT NULL,
	Bairro VARCHAR(100) NOT NULL,
	Cidade VARCHAR(100) NOT NULL,
	Estado VARCHAR(2) NOT NULL,
	cep VARCHAR(8) NOT NULL
);

/* 4. Criando a tabela de clientes, A tabela clientes, com endereço e e-mail de contato */
CREATE TABLE clientes (
  id TEXT NOT NULL,
  nome VARCHAR(255),
  telefone VARCHAR(20),
  email VARCHAR(100) DEFAULT 'Sem email',
  endereco VARCHAR(255),
  PRIMARY KEY (id)
);

/* 5.Criando a tabela de pedidos, A tabela pedidos, com as informações das vendas */
CREATE TABLE pedidos (
  id TEXT PRIMARY KEY,
  idcliente TEXT,
  datahorapedido DATETIME,
  status VARCHAR(50),
  FOREIGN KEY (idcliente) REFERENCES clientes(id) ON DELETE CASCADE
);

/* 6. Criando a tabela de itenspedidos, E a itenspedidos, com os itens vendidos em cada pedido. */
CREATE TABLE itenspedidos (
  idpedido TEXT,
  idproduto TEXT,
  quantidade INTEGER,
  precounitario DECIMAL(10,2),
  PRIMARY KEY (idpedido,idproduto),
  FOREIGN KEY (idpedido) REFERENCES pedidos(id) ON DELETE CASCADE,
  FOREIGN KEY (idproduto) REFERENCES produtos(id) ON DELETE CASCADE
);
