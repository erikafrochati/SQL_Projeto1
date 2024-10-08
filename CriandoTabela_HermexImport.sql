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
  
insert into tabelaclientes
(ID_Cliente,
  Nome_Cliente,
  Informacoes_de_Contato,
  Endereco_Cliente)
  VALUES
  ('2', 'Erika Salvatore', 'erikasalvatore@gmail.com', 'rua bosque da paz - casa 5');
  
  select * from tabelaclientes
  
 insert into tabelaclientes
(ID_Cliente,
  Nome_Cliente,
  Informacoes_de_Contato,
  Endereco_Cliente)
  VALUES
  ('3', 'Damon Salvatore', 'Damonsalvatore@gmail.com', 'rua bosque da paz - casa 7'),
  ('4', 'Stefan Salvatore', 'Stefansalvatore@gmail.com', 'rua bosque da paz - casa 8'),
  ('5', 'Caroline Salvatore', 'Carolinesalvatore@gmail.com', 'rua bosque da paz - casa 9');
  
select * from tabelaclientes

INSERT INTO tabelaclientes
(id_cliente,
 nome_cliente,
 informacoes_de_contato,
 Endereco_Cliente)
 VALUES
('7','Patrícia Lima','patricia.lima@email.com','Rua das Flores, 123'),
('8','Rodrigo Almeida','rodrigo.almeida@email.com','Avenida Central, 456');

INSERT INTO tabelaprodutos (
  ID_Produto,
  Nome_do_Produto,
  Descricao,
  Categoria,
  Preco_de_Compra,
  Unidade,
  Fornecedor,
  Data_de_Inclusao)
VALUES
('1', 'Smartphone X', 'Smartphone de última geração', 1, 699.99, 'Unidade', 1, '2023-08-01'),
('2', 'Notebook Pro', 'Notebook poderoso com tela HD', 2, 1199.99, 'Unidade', 2, '2023-08-02'),
('3', 'Tablet Lite', 'Tablet compacto e leve', 3, 299.99, 'Unidade', 3, '2023-08-03');
 
 select * from tabelaprodutos
 
create table tabelapedidosgold(
  ID_pedido_gold int PRIMARY key,
  Data_Do_Pedido_gold Date,
  Status_gold varchar (50),
  Total_Do_Pedido_gold decimal (10,2),
  Cliente_gold int,
  Data_De_Envio_Estimada_gold Date,
  FOREIGN key (cliente_gold) REFERENCES tabelaclientes (id_cliente)
  );
  
  insert into tabelapedidosgold
  (ID_pedido_gold,
  Data_Do_Pedido_gold,
  Status_gold,
  Total_Do_Pedido_gold,
  Cliente_gold,
  Data_De_Envio_Estimada_gold)
  SELECT
  id,
  data_do_pedido,
  status,
  total_do_pedido,
  cliente,
  data_de_envio_estimada
  from tabelapedidos
  WHERE total_do_pedido >= 400;
  
  SELECT * from tabelapedidosgold;
  
  
