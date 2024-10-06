/* Utilizando o UNION Para retornar essas informações em uma única consulta, 
utilizaremos o recurso da linguagem SQL, o UNION. Com o UNION, 
podemos unir as duas consultas select e trazer os dados de forma distinta, ou seja, sem repetição. */

SELECT rua, bairro, cidade, estado, cep FROM colaboradores 
UNION
SELECT rua, bairro, cidade, estado, cep FROM fornecedores 

/* Usando o UNION ALL Utilizaremos outro recurso da linguagem SQL para resolver esse problema. 
Na verdade, é o mesmo recurso, o UNION, mas em vez de UNION, colocaremos UNION ALL, ou seja, ele unirá e retornará todos os valores. Aqui ele trás repetição de dados. */

SELECT nome,rua, bairro, cidade, estado, cep FROM colaboradores 
UNION ALL
SELECT nome, rua, bairro, cidade, estado, cep FROM fornecedores 

/* Executando subconsultas, para trazer nome do cliente, id do cliente, para enviar possiveis mimos.
Quando executamos, temos como retorno o nome, que é Ana Maria Silva, e o seu telefone. 
Aqui nós estamos utilizando subconsultas, ou seja, 
são consultas alinhadas dentro de outras consultas, 
que podemos utilizar para unir informações que estão em tabelas distintas.*/
SELECT idcliente FROM pedidos WHERE datahorapedido = '2023-01-02 08:15:00'

SELECT nome, telefone 
FROM clientes 
WHERE ID = (
    SELECT idcliente 
    FROM pedidos 
    WHERE datahorapedido = '2023-01-02 08:15:00')

