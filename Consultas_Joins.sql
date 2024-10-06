/* Portanto, com o INNER JOIN, retornamos apenas os pedidos e os clientes que correspondem. Se houver um pedido sem cliente, ele não retorna, e se o cliente não tiver pedido, ele também não retorna. 
INNER JOIN
Combina linhas de duas tabelas quando há uma correspondência entre as colunas especificadas.
Com esta consulta, estamos combinando duas tabelas, no caso, "pedidos" e "clientes", para recuperar informações sobre os pedidos e os clientes associados a esses pedidos.
*/

SELECT * FROM clientes

SELECT * FROM pedidos

SELECT c.nome, p.id, p.datahorapedido 
FROM clientes c 
INNER JOIN pedidos p 
ON c.id = p.idcliente;

SELECT p.ID, c.Nome
FROM pedidos p
INNER JOIN clientes c
ON p.IDCliente = c.ID;

/*
Tipos de JOIN
Há vários tipos de JOIN, mas vamos focar nos mais comuns:

INNER JOIN: Combina linhas de duas tabelas quando há uma correspondência entre as colunas especificadas. Se não houver correspondência, a linha não aparece no resultado.

LEFT JOIN (ou LEFT OUTER JOIN): Retorna todas as linhas da tabela da esquerda (a primeira mencionada) e as linhas correspondentes da tabela da direita. Se não houver correspondência, os resultados da tabela da direita terão valores NULL.

RIGHT JOIN (ou RIGHT OUTER JOIN): É o oposto do LEFT JOIN. Retorna todas as linhas da tabela da direita e as correspondentes da esquerda. Novamente, se não houver correspondência, os resultados da tabela da esquerda terão valores NULL.

FULL JOIN (ou FULL OUTER JOIN): Combina as linhas de ambas as tabelas. Se não houver correspondência, ainda assim as linhas serão mostradas, com NULL no lado sem correspondência.
*/


/*RIGHT JOIN
Retorna todas as linhas da tabela da direita e as correspondentes da esquerda.
Retorna todos os registros da tabela de produtos que estão em algum registro da tabela de itensPedidos.
*/

SELECT * FROM produtos;

INSERT INTO Produtos (ID, Nome, Descricao, Preco, Categoria)VALUES 
(31, 'Lasanha à Bolonhesa', 'Deliciosa lasanha caseira com molho bolonhesa', 12.50, 'Almoço');

/*Já sabíamos que a lasanha à bolonhesa não estaria em itenspedidos, porque ela não tinha sido vendida ainda, mas, será que conseguimos aplicar o filtro que já utilizamos anteriormente em clientes, quando fizemos as subconsultas, para saber se há produtos que não foram vendidos em um determinado mês?

A resposta é sim, mas, agora, vamos usar um recurso que já conhecemos: as subconsultas. O motivo é que a data e a hora do nosso pedido estão em outra tabela, de pedidos. */
SELECT pr.nome, ip.idproduto, ip.idpedido
FROM itenspedidos ip
RIGHT JOIN produtos pr
ON pr.id = ip.idproduto;

/*
Executado o código, obteremos exatamente isso: idpedido e idproduto. Agora, vamos fazer a junção com a nossa tabela de produtos. Vamos dar o nome de x para a subconsulta. E onde antes referenciávamos a tabela de itenspedidos, vamos referenciar com a nossa tabela montada através das subconsultas.clientes
Agora, podemos executar toda a nossa consulta. Obtemos apenas os produtos do mês 10 (outubro). Com a consulta, conseguimos saber que além da lasanha à bolonhesa, temos o omelete, o muffin e o croissant de amêndoa não foram pedidos no mês de outubro.
Dessa forma, criamos uma consulta que facilita o trabalho da gestão, possibilitando, por exemplo, que consigam identificar por que determinado produto não foi vendido em um determinado mês.
*/
SELECT pr.nome,  x.idproduto,  x.idpedido 
FROM(
    SELECT ip.idpedido, ip.idproduto
    FROM pedidos p
    JOIN itenspedidos ip 
    ON p.id = ip.idpedido
    WHERE strftime('%m', p.DataHoraPedido) = '10' ) x
RIGHT JOIN produtos pr
ON pr.id =  x.idproduto;

INSERT INTO Clientes (id, Nome, Telefone, Email, Endereco)
VALUES (28, 'João Santos', '215555678', 'joao.santos@email.com', 'Avenida Principal, 456, Cidade B'),
       (29, 'Carla Ferreira', '315557890', 'carla.ferreira@email.com', 'Travessa das Ruas, 789, Cidade C');
      
select * from clientes

/* 
Então, usando o LEFT JOIN, podemos deixar o cliente do lado esquerdo. Com o comando ON, vamos trazer, de clientes, o ID, ou seja, c.id, e da tabela de pedidos o p.idcliente.
Também vamos especificar o nome do nosso cliente e o id do nosso pedido: c.nome, p.id.
Vamos executar e analisar o que recebemos como retorno. Visualizando o retorno, ao fim da tabela, na última linha, verificamos que "Paulo Souza", "João Santo"s e "Carla Ferreira" não têm nenhum pedido associado a eles. Temos os dois clientes que acabamos de inserir e outro cliente que também não possuía nenhuma venda e constam como "NULL". Informação bem interessante!
Retorna todas as linhas da tabela da esquerda e as linhas correspondentes da tabela da direita.
Retorna todos os registros da tabela de clientes que estão em algum registro da tabela de pedidos.
*/

SELECT c.nome, p.id
FROM clientes c 
LEFT JOIN Pedidos p 
ON c.id = p.idcliente;

/* 
Mas, como já buscamos na nossa tabela de produtos, queremos apenas identificar quais clientes não realizaram o pedido em um determinado mês. Então, voltaremos à nossa consulta anterior e selecionaremos o WHERE strftime com datahorapedido e executar.clientes
O retorno é uma tabela com uma série de cliente. É curioso, porque ele deveria ter retornado os dados dos nossos clientes e, em pedidos, ele deveria ter retornado também aqueles clientes que não possuem venda. Mas ele não retornou, ele retornou apenas os clientes que possuem venda. Dessa forma, temos todos os nomes dos clientes e apenas os que realizaram pedidos.
O retorno foi o nome dos clientes e o id de todos que realizaram pedidos.
*/

SELECT c.nome, p.id
FROM clientes c 
LEFT JOIN Pedidos p 
ON c.id = p.idcliente
WHERE strftime('%m', p.datahorapedido) = '10' ;

/*
Agora que aplicamos o primeiro filtro, que é o de data, fora da nossa subconsulta, vamos aplicar o outro filtro, que é justamente o que busca apenas os clientes que não fizeram nenhum tipo de pedido. Então, no WHERE, passamos x.idclient e o IS NULL, ou seja, se idclient estiver vazio, ele vai retornar.clientes
Vamos executar. Agora, temos o inverso da nossa primeira consulta: ao invés de obtermos apenas os clientes que têm pedidos, nosso retorno trouxe apenas os clientes que não possuem pedidos. Então, temos "João Pereira", "Pedro Alves", "Ana Maria", enfim, todos esses clientes não realizaram pedidos no mês de outubro.
*/
SELECT c.nome, x.id
FROM clientes c 
LEFT JOIN
(
    SELECT p.id, p.idcliente 
    FROM pedidos p 
    WHERE strftime('%m', p.datahorapedido) = '10')x
ON c.id = x.idcliente
WHERE x.idcliente IS NULL

/*FULL JOIN
Podemos colocar, por exemplo, c.id e buscar apenas os pedidos que não possuem pessoas clientes.
Assim, teremos apenas os pedidos que não possuem pessoas clientes e podemos fazer o inverso, trazendo apenas as pessoas clientes que não possuem pedido.
Combina as linhas de ambas as tabelas.
Com esta consulta temos o resultado de todos os clientes que possuem ou não pedidos.
*/
SELECT c.nome, p.id 
FROM clientes c
FULL JOIN pedidos p
ON c.id = p.idcliente
