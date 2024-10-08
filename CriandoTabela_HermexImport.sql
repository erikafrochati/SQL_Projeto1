SELECT * FROM tabelafornecedores;

SELECT * FROM tabelapedidos;

SELECT * FROM tabelafornecedores where País_de_Origem = 'China';

select distinct Cliente from tabelapedidos;

create table tabelaclientes (
  ID_Cliente int PRIMARY key,
  Nome_Cliente varchar (250),
  Informacoes_de_Contato varchar (250)
  );

select * from tabelaclientes;

alter table tabelaclientes add Endereco_Cliente varchar (250);

DROP TABLE tabelaclientes;

create table tabelacategorias(
  ID_Categoria int PRIMARY key,
  Nome_Categoria varchar (250),
  Descricao_Categoria text
  );

create table tabelaprodutos (
  ID_Produto int PRIMARY key,
  Nome_do_Produto varchar (250),
  Descricao text,
  Categoria int,
  Preco_de_Compra decimal (10,2),
  Unidade varchar (50),
  Fornecedor int,
  Data_de_Inclusao date,
  foreign key (Categoria) REFERENCES tabelacategoria (ID_Categoria),
  foreign key (Fornecedor) REFERENCES tabelafornecedores (ID)
  );
  
  
  
