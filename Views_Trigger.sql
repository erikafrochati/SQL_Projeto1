select * from pedidos
select * from itenspedidos

/* 
Em seguida, vamos selecionar os campos específicos usando p.id, que é o ID do pedido, ip.quantidade, que é a quantidade de itens pedidos, 
e ip.precounitario, que é o preço de itens pedidos. Este último campo, precounitario, só existe na tabela itenspedidos,
mas é importante passarmos a identificação da tabela ip como uma boa prática.clientes
Ao executar, obtemos como retorno o ID do pedido, a quantidade e o preço unitário.
*/
SELECT p.id, ip.quantidade, ip.precounitario
FROM pedidos p
JOIN itenspedidos ip
ON p.id = ip.idpedido

/*Nas primeiras linhas já conseguimos identificar que o preço unitário tem uma multiplicação. 
Portanto, temos a quantidade e o preço unitário já calculados. Isso facilita um pouco o nosso trabalho.
Para tornar a visualização mais simples, vamos inverter a ordem das colunas precounitario e preco.*/
SELECT p.id, ip.quantidade, pr.preco, ip.precounitario 
FROM pedidos p
JOIN itenspedidos ip ON p.id = ip.idpedido
JOIN produtos pr ON pr.id = ip.idproduto

/*
Já temos o valor multiplicado, mas não precisamos exibir a quantidade e nem o preço que vem da nossa tabela de produtos. O que queremos, agora, são os dados do cliente que fez determinado pedido.
Pensando nisso, faremos uma modificação. Primeiro, vamos remover o join que fizemos com o produto. Em seguida, 
pegamos a tabela de clientes e fazemos um join com c.id e p.idcliente. No SELECT, incluímos o campo c.nome, que corresponde ao nome do cliente.
Ao executar, temos o id, o nome do cliente e o preço unitário.
*/
SELECT p.id, c.nome, ip.precounitario 
FROM clientes c
JOIN pedidos p ON c.id = p.idcliente
JOIN itenspedidos ip ON p.id = ip.idpedido

/*Ao executar, temos o id do pedido, o nome dos clientes e a soma do pedido.*/
SELECT p.id, c.nome, SUM(ip.precounitario)
FROM clientes c
JOIN pedidos p ON c.id = p.idcliente
JOIN itenspedidos ip ON p.id = ip.idpedido
GROUP BY p.id, c.nome

/*Essa consulta que calcula o valor total dos pedidos será executada com muita frequência.*/
SELECT p.id, c.nome, SUM(ip.precounitario) AS ValorTotalPedido
FROM clientes c
JOIN pedidos p ON c.id = p.idcliente
JOIN itenspedidos ip ON p.id = ip.idpedido
GROUP BY p.id, c.nome

/*
Utilizando as tabelas de clientes, pedidos e itensPedidos do Serenatto, crie uma consulta que busque o total dos pedidos feitos por cada cliente. 
A tabela "Clientes" contém informações sobre os clientes, enquanto a tabela "Pedidos" registra informações sobre os pedidos feitos por esses clientes. 
Em ItensPedidos, você encontra as informações de quantidade vendida de cada produto e o preço unitário.
Seu desafio é criar uma consulta SQL que retorne o nome de cada cliente e o valor total dos pedidos que cada um deles comprou.
*/

/*O primeiro passo é selecionar todas as tabelas para a consulta. Neste caso, você precisará das tabelas "Clientes", "Pedidos" e "itensPedidos".
 */
SELECT *
FROM clientes c
INNER JOIN Pedidos p 
ON c.ID = p.idcliente
INNER JOIN itensPedidos ip
On P.id = ip.idpedido;

/*Em seguida, busque apenas os campos necessários, lembrando que a coluna precounitario já é a multiplicação do preço do produto pela quantidade
 */
SELECT c.nome, ip.precounitario
FROM clientes c
INNER JOIN Pedidos p 
ON c.ID = p.idcliente
INNER JOIN itensPedidos ip
On P.id = ip.idpedido

/*Por último, agrupe pelo nome de cada cliente: */
SELECT c.nome AS NomeCliente, SUM(ip.precounitario) AS SomaTotalPedidos
FROM clientes c
INNER JOIN Pedidos p 
ON c.ID = p.idcliente
INNER JOIN itensPedidos ip
On P.id = ip.idpedido
GROUP BY c.Nome;

/*Já criamos a consulta que calcula o valor total do pedido. Antes de irmos para a solução do nosso último problema, vamos acrescentar um campo na nossa consulta: a data e hora do pedido. Para isso, basta incluir p.datahorapedido em SELECT.*/
SELECT p.id, c.nome, p.datahorapedido, SUM(ip.precounitario) AS ValorTotalPedido
FROM clientes c
JOIN pedidos p ON c.id = p.idcliente
JOIN itenspedidos ip ON p.id = ip.idpedido
GROUP BY p.id, c.nome

/*Para isso, vamos utilizar um novo recurso da linguagem SQL, que são as views. Uma view, ou visualização, é exatamente o que o próprio nome diz. 
No SQL, se trata de uma tabela virtual, ou seja, ela não existe fisicamente, mas é criada a partir do resultado de uma consulta SQL.

Para criá-la, usamos o CREATE e adicionamos a palavra VIEW. Em seguida, precisamos dar um nome para a nossa VIEW. Vamos chamá-la de ViewCliente.

Depois, usamos o AS, normalmente utilizado quando queremos dar um alias para as nossas tabelas ou colunas.

Na sequência, passamos SELECT nome, endereco FROM clientes. Dessa forma, estamos informando que queremos exatamente essas informações, nome e endereço, da tabela de clientes.*/

CREATE VIEW ViewCliente AS
SELECT nome, endereco FROM clientes;

SELECT * FROM ViewCliente;

/*Agora, vamos criar uma view com a consulta que calcula o valor total dos nossos pedidos. A chamaremos de ViewValorTotalPedido.*/
CREATE VIEW ViewValorTotalPedido AS
SELECT p.id, c.nome, p.datahorapedido, SUM(ip.precounitario) AS ValorTotalPedido
FROM clientes c
JOIN pedidos p ON c.id = p.idcliente
JOIN itenspedidos ip ON p.id = ip.idpedido
GROUP BY p.id, c.nome; 

SELECT * FROM ViewValorTotalPedido;

/*Nela, podemos aplicar diversos filtros normalmente. Por exemplo, podemos realizar uma consulta para buscar o nome das pessoas clientes.*/
SELECT nome FROM ViewValorTotalPedido

/*Podemos também aplicar filtros. Para isso, podemos passar WHERE, o valor do campo, ValorTotalPedido e = 10.*/
SELECT * FROM ViewValorTotalPedido;
WHERE ValorTotalPedido = 10;

/*Podemos aplicar outro filtro, onde o valor seja maior que 10.*/
SELECT * FROM ViewValorTotalPedido
WHERE ValorTotalPedido > 10;

/*Para filtrar ainda mais, ao invés de maior que 10, podemos colocar entre 10 e 14, utilizando o operador lógico AND.*/
SELECT * FROM ViewValorTotalPedido;
WHERE ValorTotalPedido > 10 AND ValorTotalPedido < 14;

/*Também podemos trabalhar com o campo de data. Lembre-se de que alteramos nosso comando SQL antes de criar nosso view para incluir o campo de data e hora. Para isso, passamos o strftime() e buscamos pelo mês.*/
SELECT * FROM ViewValorTotalPedido
WHERE strftime('%m', datahorapedido) = '08'

/*Criando TRIGGER*/

/*
Com DATE, extraímos de datahorapedido apenas a data, e damos o alias de Dia. Precisamos do preço unitário, então, ip.precounitario. Sabemos que precisamos somar esse campo, 
porque já temos o valor por produto, naquele pedido específico, então, só precisamos somar esse valor. Sendo assim, vamos dar um SUM() em ip.precounitario e colocar um alias de FaturamentoDiario.
Ao executar a consulta, obtemos como resultado a data e o faturamento diário, que na realidade não está diário, está o faturamento total de todas as vendas.
*/
SELECT DATE (datahorapedido) AS Dia, SUM(ip.precounitario) AS FaturamentoDiario
FROM pedidos p
JOIN itenspedidos ip
ON p.id = ip.idpedido

/*Então, ao final, depois de ON, passamos GROUP BY, indicando que essa soma deve ser agrupada por Dia. Podemos, inclusive, fazer a ordenação utilizando o ORDER BY também por Dia.
Agora, temos o nosso faturamento diário para cada dia do ano, calculando os pedidos que já existem na nossa base de dados.
*/
SELECT DATE (datahorapedido) AS Dia, SUM(ip.precounitario) AS FaturamentoDiario
FROM pedidos p
JOIN itenspedidos ip
ON p.id = ip.idpedido
GROUP BY Dia
ORDER BY Dia;

/*
Para facilitar, poderíamos usar uma view, que criaria uma tabela virtual que armazenaria esse resultado nesse formato, com o dia e o faturamento diário. 
Sempre que chamássemos essa view, teríamos esse resultado. Mas será que existe uma forma mais simples e automática de fazer o cálculo do nosso faturamento diário e armazenar em uma tabela física? 
Isso facilitaria o acesso dos nossos gestores a essa informação. A resposta é sim, temos essa possibilidade.

Para isso, podemos usar Trigger (gatilho), um procedimento armazenado que é acionado através de alguma ação. É utilizado justamente para automatizar algumas etapas, como a inserção, 
exclusão ou atualização de dados. Pode ser utilizado justamente para, por exemplo, calcular um valor e inserir de forma automática em uma tabela.

Vamos utilizar esse recurso, Trigger, para facilitar ainda mais o nosso trabalho. Quando começarmos a criar todo o processo e acionar o nosso gatilho, você entenderá melhor como funciona esse recurso.

O primeiro passo é criar a nossa tabela. Portanto, vamos criar uma nova tabela de faturamento diário com o seguinte comando:
*/
CREATE TABLE FaturamentoDiario (
    Dia DATE,
    FaturamentoTotal DECIMAL(10, 2)
);


/*
FaturamentoDiario será o nome da tabela. Nela, teremos dois campos, 'Dia', que é um DATE, e 'FaturamentoTotal', que vai ser um DECIMAL.

Ao executar, criamos a nossa tabela, que aparecerá na lateral esquerda, na área de tabelas. Agora, podemos criar o Trigger. Para isso, 
usamos o comando CREATE TRIGGER e passamos um nome. Vamos chamar de CalculaFaturamentoDiario.

Em seguida, informamos quando deve ser acionado, no caso, AFTER INSERT ON itenspedidos. Ou seja, após o comando INSERT na tabela de itens pedidos. 
Na sequência, passamos a informação FOR EACH ROW, indicando que isso deve acontecer para cada linha da tabela.

Agora, abrimos um bloco de código com BEGIN, onde colocaremos o SELECT, e o fechamos com END.
*/
CREATE TRIGGER CalculaFaturamentoDiario
AFTER INSERT ON itenspedidos
FOR EACH ROW
BEGIN
DELETE FROM FaturamentoDiario;
INSERT INTO FaturamentoDiario (Dia, FaturamentoTotal)
SELECT DATE(datahorapedido) AS Dia, SUM(ip.precounitario) AS FaturamentoDiario
FROM pedidos p
JOIN itenspedidos ip
ON p.id = ip.idpedido
GROUP BY Dia
ORDER BY Dia;
END;

select * from FaturamentoDiario

/*Note que o último registro de FaturamentoDiario é do dia 06.10.2023, no valor de 58. Já nas tabelas pedidos e itenspedidos, o último registro é do ID 450. 
  Vamos inserir um novo pedido na tabela pedidos, de ID 451, usando o comando de INSERT:*/
INSERT INTO Pedidos(id, idcliente, datahorapedido, status)
VALUES (451, 27, '2023-10-07 14:30:00', 'Em Andamento');

/*Após executar essa inserção, podemos checar novamente a tabela de pedidos. Agora, o último registro de pedidos possui o ID 451. 
Já o último registro de FaturamentoDiario continua sendo do dia 06.10.2023, no valor de 58. Isso ocorre porque o gatilho só será acionado quando inserirmos em itenspedidos. Portanto, vamos fazer isso.*/
INSERT INTO ItensPedidos(IDPedido, IDProduto, Quantidade, PrecoUnitario)
VALUES (451, 14, 1, 6.0),
         (451, 13, 1, 7.0);

select * from itenspedidos
select * from FaturamentoDiario

/*Após executar essa inserção, podemos checar a tabela itenspedidos. Agora, o último registro possui o ID 451. Já o último registro de FaturamentoDiario é do dia 07.10.2023, no valor de 13. Portanto, o nosso gatilho está funcionando.

Sempre que um novo pedido for inserido, automaticamente esse valor vai aparecer na nossa tabela de FaturamentoDiario, o que será muito interessante para ajudar nossos gestores, porque eles terão acesso a essa informação à mão.

Vamos inserir outro registro, primeiro em pedidos, depois em itenspedidos:*/

INSERT INTO Pedidos (ID, IDCliente, DataHoraPedido, Status) 
VALUES (452, 28, '2023-10-07 14:35:00', 'Em Andamento');

INSERT INTO ItensPedidos (IDPedido, IDProduto, Quantidade, PrecoUnitario) 
VALUES (452, 10, 1, 5.0),
       (452, 31, 1, 12.50);
       
select * from FaturamentoDiario
