insert into instituto values
	('1', 'agrarias'),
	('2', 'engenharias'),
	('3', 'biologicas'),
	('4', 'exatas e da terra'),
	('5', 'humanas'), 
	('6', 'sociais e aplicadas'),
	('7', 'saude');

insert into curso values
	('1','6','Administração - Integral'),
    ('2','6','Administração - Noturno'),
    ('3','1','Agronomia - Integral'),
    ('4','3','Ciências Biológicas'),
    ('5','3','Ciência de Alimentos'),
    ('6','2','Engenharia Civil'),
    ('7','2','Engenharia de Produção'),
    ('8','2','Engenharia de Produção'),
    ('9','7','Nutrição'),
    ('10','4','Quimica'),
    ('11','4','Sistemas de Informação - Integral'),
    ('12','4','Sistemas de Informação - Noturno');
  
insert into cargo values
	('1', 'Professor Especialista'),
    ('2', 'Professor Mestre'),
    ('3', 'Professor Doutor'),
    ('4', 'Assessor de Controle e Normas'),
    ('5', 'Assessor de Relações Institucionais '),
    ('6', 'Coordenador Adjunto do NIP'),
    ('7', 'Coordenador de Curso'),
    ('8', 'Coordenador do CAPSI – Apoio Psicopedagógico'),
    ('9', 'Coordenador de Apoio Didático-Pedagógico '),
    ('10', 'Diretor Acadêmico'),
    ('11', 'Diretor Financeiro'),
    ('12', 'Diretor Geral'),
    ('13', 'Analista de Sistema'),
    ('14', 'Analista Administrativo'),
    ('15', 'Assistente Administrativo'),
    ('16', 'Auxiliar Administrativo'),
    ('17', 'Auxiliar de Bibliotecário'),
    ('18', 'Bibliotecário'),
    ('19', 'Chefe de Seção de Serviços Gerais'),
    ('20', 'Contador'),
    ('21', 'Faxineiro'),
    ('22', 'Inspetor de Sala'),
    ('23', 'Jardineiro'),
    ('24', 'Operador de Sistemas de Informática'),
    ('25', 'Porteiro'),
    ('26', 'Recepcionista'),
    ('27', 'Secretaria Acadêmica');

insert into funcionario 
	(idFuncionario,nome,sexo,cpf,identidade,UFidentidade,orgaoExpedidor,endereço,DataNascimento,
	mae,pai,cidade,nacionalidade,nrTituloEleitor,zonaTituloEleitor,sessaoTituloEleitor,localTituloEleitor,
	cidadeNascimento)
values
	(default,'ADRIANA ZANELLA MARTINHAGO','F','123456789','MG123456789','MG','SSP','araucárias 101','1982/03/03',
    'Mae da adriana','Pai da Adriana', 'Rio Paranaiba',default,'123456879111','123','123','rio paranaiba',
    'rio paranaiba');
    
    select * from funcionario