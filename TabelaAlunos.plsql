/* Você é um professor e deseja identificar o aluno que obteve a maior nota em sua disciplina. 
Você tem duas tabelas em seu banco de dados: "Alunos" e "Notas". 
A tabela "Notas" registra as notas dos alunos em sua disciplina. 
Seu desafio é encontrar o aluno com a maior nota. 
Tabela "Alunos":
ID_aluno (chave primária)
Nome
Curso

Tabela "Notas":
ID_nota (chave primária)
ID_aluno (chave estrangeira)
Nota
Seu desafio é criar uma consulta SQL que retorne o nome do aluno que obteve a maior nota em sua disciplina.clientes
*/

create table Alunos (
  id_Aluno int not null,
  nome varchar (255),
  curso varchar(255),
  primary key (id_Aluno)
  );

create table Notas (
  id_nota int primary key,
  id_Aluno int,
  Nota decimal (5,2),
  FOREIGN KEY (id_Aluno) REFERENCES Alunos(id_Aluno)
  );

INSERT INTO Alunos (id_Aluno, nome, curso)
VALUES
    (1, 'João Silva', 'Ciência da Computação'),
    (2, 'Maria Santos', 'Engenharia Civil'),
    (3, 'Pedro Almeida', 'Ciência da Computação');
    
select * from Alunos
    
INSERT INTO Notas (id_nota, id_Aluno, Nota)
VALUES
    (1, 1, 9.5),
    (2, 2, 8.0),
    (3, 3, 10.0);
    
select * from Notas

/* O primeiro passo foi encontrar a maior nota registrada. */
SELECT MAX(Nota)
FROM Notas

/* Em seguida, encontrar o ID do aluno que obteve essa nota máxima. */
   SELECT ID_aluno
    FROM Notas
    WHERE Nota = (
        SELECT MAX(Nota)
        FROM Notas
    )

/* Por fim, retorne o nome do aluno que obteve a maior nota. */
SELECT Nome
FROM Alunos
WHERE ID_aluno = (
    SELECT ID_aluno
    FROM Notas
    WHERE Nota = (
        SELECT MAX(Nota)
        FROM Notas
    )
);
