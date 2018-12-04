-- -----------------------------------------------------
-- 1. Lista dos Cursos da UFV-CRP
-- -----------------------------------------------------
SELECT 
    nome_curso
FROM
    curso;
-- -----------------------------------------------------
-- 2. Lista dos Cursos, por Instituto
-- -----------------------------------------------------
SELECT 
    c.nome_curso AS 'Curso', i.nome AS 'Instituto'
FROM
    curso c
        JOIN
    instituto i
WHERE
    instituto_idInstituto = idInstituto
ORDER BY instituto_idInstituto;
 
-- -----------------------------------------------------
-- 3. Lista das disciplinas obrigatórias de um curso ordenadas pelo período em que são
-- oferecidas
-- -----------------------------------------------------
SELECT 
    nome_discipilina AS 'Disciplina',
    semestreOfertado AS 'Semestre Ofertado'
FROM
    disciplina d
        JOIN
    disciplina_has_curso dc
WHERE
    curso_idCurso = 10
        AND idDisciplina = disciplina_idDisciplina
ORDER BY semestreOfertado;

-- -----------------------------------------------------
-- 4. Lista dos Professores, por Curso
-- -----------------------------------------------------
SELECT 
    nome AS 'Professor'
FROM
    funcionario
        JOIN
    cargo
WHERE
    atua = 'professor'
        AND cargo_idCargo IN (1 , 2, 3);
-- -----------------------------------------------------
-- 5. Lista de alunos, por curso, contendo matrícula, nome, email e ano de entrada na
-- UFV.
-- -----------------------------------------------------
SELECT 
    a.matricula, a.nome, r.email, a.entrada_curso
FROM
    aluno a
        JOIN
    registro r
WHERE
    a.matricula = r.aluno_matricula
ORDER BY curso_idCurso;
-- -----------------------------------------------------
-- 6. Lista das disciplinas e seus pré-requisitos
-- -----------------------------------------------------
SELECT 
    d.nome_disciplina AS 'Disciplina',
    p.nomePrerequisito AS 'Prerequisito'
FROM
    disciplina d
        JOIN
    prerequisito
WHERE
    idDisciplina = disciplina_idDisciplina;
-- -----------------------------------------------------
-- 7. Número de alunos, por disciplina, para um determinado período letivo
-- -----------------------------------------------------
SELECT 
    COUNT(*), D.Disciplina, P.Tipo_Periodo
FROM
    Aluno AS A
        JOIN
    Disciplina AS D
        JOIN
    Periodo AS P ON P.Ano = D.Periodo_Ano
        AND A.Matricula_A = D.Aluno_Matricula_A
WHERE
    D.Codigo = A.Disciplinas_Codigo;
-- -----------------------------------------------------
-- 8. Lista de disciplinas e respectivos períodos em que foi cursada e resultados para um
-- determinado aluno (como se fosse o histórico escolar)
-- -----------------------------------------------------

-- -----------------------------------------------------
-- 9. Lista de disciplinas obrigatórias que um determinado aluno ainda falta fazer
-- -----------------------------------------------------
SELECT 
    d.Nome
FROM
    Disciplina AS d,
    matriculado AS m,
    Conclui AS c
WHERE
    d.status = ‘obrigatória’
        AND c.Disciplinas_Codigo <> d.Codigo
        AND m.Disciplina_codigo <> d.Codigo
-- -----------------------------------------------------
-- 10. Lista de disciplinas, por período letivo, por curso, contendo o número total de
-- alunos, número de aprovados, número de reprovados, % de alunos aprovados, % de
-- alunos reprovados
-- -----------------------------------------------------