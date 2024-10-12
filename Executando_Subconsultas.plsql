/* Subconsultas no comando IN */

select *from pedidos

/*Queremos que sejam retornados os IDs dos nossos clientes da tabela de pedidos, onde o mês seja igual a 01, ou janeiro. Verificamos se nossa consulta está funcionando clicando em "Run". Temos a coluna "idcliente" com o valores, 10, 3, 8 e assim por diante.
Retorna o ID do cliente para o mês 01 da tabela pedidos */
SELECT idcliente FROM pedidos WHERE strftime('%m', datahorapedido) = '01' 

/*Inserindo o nome dos clientes
Utilizamos um igual aqui: ID = ( SELECT idcliente.
Nesse caso, ele só pega o primeiro valor de retorno. 
Retorna o nome do cliente e seu telefone */
SELECT nome, telefone 
FROM clientes 
WHERE ID = (
    SELECT idcliente 
    FROM pedidos 
    WHERE datahorapedido = '2023-01-02 08:15:00')

/* Subconsultas no comando IN 
Retorna o Nome do cliente */
SELECT nome
FROM clientes
WHERE id IN (
    SELECT idcliente
    FROM pedidos
    WHERE strftime('%m', datahorapedido) = '01')
    

/*Buscando a média de preço
Qual informação buscamos? Inicialmente, desejamos saber a média de preço dos produtos. 
Podemos buscar isso usando a função de agregação AVG(), que calcula a média dos preços. 
Aplicamos AVG() ao campo de preço.*/

SELECT AVG(preco) FROM produtos

/* Assim, usaremos o GROUP BY para agrupar o resultado pelo campo de preço e 
também pelo campo de nome e preço. Agruparemos pelos dois, 
presentes no nosso SELECT, então ele agrupará pelo nome e pelo preço. */
SELECT nome, preco 
FROM produtos
GROUP BY nome, preco
HAVING preco > (
    SELECT AVG(preco) 
    FROM produtos)
    
/*Use WHERE quando precisar de uma condição para filtrar linhas antes de qualquer agrupamento.
Use HAVING quando precisar aplicar um filtro depois de agrupar as linhas, especialmente quando estiver usando funções de agregação.*/

/***UNION
O operador UNION seleciona apenas valores distintos entre as tabelas.
Retorna de forma distinta o endereço completo de todos os colaboradores e fornecedores em uma única consulta.*/

SELECT Rua, Bairro, Cidade, Estado, CEP  
FROM Fornecedores f 
UNION 
SELECT Rua, Bairro, Cidade, Estado, CEP  
FROM Colaboradores c  ;

/***UNION ALL
O operador UNION ALL tem a mesma função do UNION, ou seja, ele combina os resultados de duas ou mais queries, a diferença é que ele mantém os valores duplicados de cada SELECT.
Retorna o nome e endereço completo de todos os colaboradores e fornecedores em uma única consulta mesmo as informações iguais.*/

SELECT Nome, Rua, Bairro, Cidade, Estado, CEP  
FROM Fornecedores f 
UNION ALL 
SELECT Nome, Rua, Bairro, Cidade, Estado, CEP  
FROM Colaboradores c  ;

/***SUBCONSULTAS
Subconsultas, são consultas aninhadas dentro outras consultas.
Retorna o nome de um cliente que fez um pedido em uma data específica.*/

SELECT Nome 
FROM clientes 
WHERE ID = (
SELECT ID_Cliente 
FROM pedidos 
WHERE DataHoraPedido = '2023-01-02 08:15:00');

/***SUBCONSULTAS no IN
A cláusula IN é usada em SQL para verificar se um valor corresponde a qualquer valor em uma lista específica de valores.
Retorna os nomes dos clientes que fizeram pedidos no mês de janeiro.*/

SELECT Nome
FROM clientes
WHERE ID IN (
    SELECT ID_Cliente
    FROM pedidos
    WHERE strftime('%m', DataHoraPedido) = '01');
    
/***SUBCONSULTAS com HAVING
A cláusula HAVING é usado para filtrar dados depois que eles foram agrupados com a cláusula GROUP BY.
Retorna o nome e o preco dos produtos cujo preço é maior que o preço médio de todos os produtos.*/

SELECT Nome, Preco
FROM produtos
GROUP BY Nome, Preco
HAVING Preco > (
SELECT AVG(Preco) 
FROM produtos);
