CREATE DATABASE swiftplan;
USE swiftplan;

CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT,
    nome VARCHAR(120) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    senha_hash VARCHAR(255) NOT NULL,
    criado_em DATETIME NOT NULL,
    deletado_em DATETIME NULL,
    
    PRIMARY KEY (id_usuario)
);

CREATE TABLE usuario_tipo (
    usuario_id INT NOT NULL,
    tipo ENUM('ADM', 'COORD', 'PROF') NOT NULL,
    
    PRIMARY KEY (usuario_id, tipo),
    CONSTRAINT fk_tipo_usuario FOREIGN KEY (usuario_id) REFERENCES usuario (id_usuario)
);

CREATE TABLE curso (
    id_curso INT AUTO_INCREMENT,
    coordenador_id INT NULL UNIQUE,  
    nome VARCHAR(120) NOT NULL UNIQUE,
    turno ENUM('manha','noite') NOT NULL,
    qtd_semestres TINYINT NOT NULL,
    deletado_em DATETIME NULL, 
    
    PRIMARY KEY (id_curso),
    CONSTRAINT fk_curso_coordenador FOREIGN KEY (coordenador_id) REFERENCES usuario_tipo (usuario_id)
);

CREATE TABLE semestre_letivo (
    id_semestre_letivo INT AUTO_INCREMENT,
    criado_por_adm_id INT NOT NULL,
    ano YEAR NOT NULL,
    numero_semestre TINYINT NOT NULL, -- 1 ou 2
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    data_tg DATE NOT NULL,
    data_feira DATE NOT NULL,

    
    PRIMARY KEY (id_semestre_letivo),
    UNIQUE KEY uq_semestre_letivo (ano, numero_semestre),
    CONSTRAINT fk_sl_adm FOREIGN KEY (criado_por_adm_id) REFERENCES usuario_tipo (usuario_id)
);

CREATE TABLE sprint (
    id_sprint INT AUTO_INCREMENT,
    semestre_letivo_id  INT NOT NULL,
    numero TINYINT NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    data_review DATE NOT NULL,
    
    PRIMARY KEY (id_sprint),
    UNIQUE KEY uq_sprint (semestre_letivo_id, numero),
    CONSTRAINT fk_sprint_sl FOREIGN KEY (semestre_letivo_id) REFERENCES semestre_letivo (id_semestre_letivo)
);

CREATE TABLE data_bloqueada (
    id_data_bloqueada INT AUTO_INCREMENT,
    semestre_letivo_id INT NOT NULL,
	adm_id INT  NOT NULL,
    data DATE NOT NULL,
    motivo VARCHAR(255) NOT NULL,
    recorrente TINYINT(1) NOT NULL DEFAULT 0, -- repete nos proximos anos
    
    PRIMARY KEY (id_data_bloqueada),
    UNIQUE KEY uq_data_bloqueada (semestre_letivo_id, data),
    CONSTRAINT fk_db_sl FOREIGN KEY (semestre_letivo_id) REFERENCES semestre_letivo (id_semestre_letivo),
    CONSTRAINT fk_db_adm FOREIGN KEY (adm_id) REFERENCES usuario_tipo (usuario_id)
);

CREATE TABLE template_horario_turno (
    id_template INT AUTO_INCREMENT,
    turno ENUM('manha','noite') NOT NULL,
    tipo ENUM('aula','intervalo') NOT NULL,
    numero_ordem TINYINT NOT NULL, -- ex: 1 = aula1, 2 = intervalo, 3 = aula2
    hora_inicio TIME NOT NULL,
    hora_fim TIME NOT NULL,
    
    PRIMARY KEY(id_template),
    UNIQUE KEY uq_template (turno, numero_ordem)
);

CREATE TABLE horario_curso (
    id_horario_curso INT AUTO_INCREMENT,
    curso_id INT NOT NULL,
    semestre_letivo_id INT NOT NULL,
    tipo ENUM('aula','intervalo') NOT NULL,
    numero_ordem TINYINT NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fim TIME NOT NULL,
	
    PRIMARY KEY (id_horario_curso),
    UNIQUE KEY uq_horario_curso (curso_id, semestre_letivo_id, numero_ordem),
    CONSTRAINT fk_hc_curso FOREIGN KEY (curso_id) REFERENCES curso (id_curso),
	CONSTRAINT fk_hc_sl FOREIGN KEY (semestre_letivo_id) REFERENCES semestre_letivo (id_semestre_letivo)
);

CREATE TABLE cancelamento_adm (
	id_cancelamento_adm INT AUTO_INCREMENT,
	adm_id INT NOT NULL,
	semestre_letivo_id INT NOT NULL,
	data DATE NOT NULL,
	turno ENUM('manha','noite') NULL, -- NULL = ambos
    dia_inteiro TINYINT(1) NOT NULL DEFAULT 0,
	motivo VARCHAR(255) NOT NULL,
	criado_em DATETIME NOT NULL,
    deletado_em DATETIME NULL,
    
    PRIMARY KEY (id_cancelamento_adm),
	CONSTRAINT fk_ca_adm FOREIGN KEY (adm_id) REFERENCES usuario_tipo (usuario_id),
	CONSTRAINT fk_ca_sl FOREIGN KEY (semestre_letivo_id) REFERENCES semestre_letivo (id_semestre_letivo)
);

-- Usada apenas quando dia_inteiro = 0 e o ADM seleciona checkboxes de horários individuais.
CREATE TABLE cancelamento_adm_horario (
	id_cancelamento_adm_horario INT AUTO_INCREMENT,
	cancelamento_adm_id INT NOT NULL,
	horario_curso_id INT NOT NULL,
    
    PRIMARY KEY(id_cancelamento_adm_horario),
	UNIQUE KEY uq_cah (cancelamento_adm_id, horario_curso_id),
	CONSTRAINT fk_cah_ca FOREIGN KEY (cancelamento_adm_id) REFERENCES cancelamento_adm (id_cancelamento_adm),
	CONSTRAINT fk_cah_hc FOREIGN KEY (horario_curso_id) REFERENCES horario_curso (id_horario_curso)
);

CREATE TABLE disciplina (
	id_disciplina INT AUTO_INCREMENT,
	curso_id INT NOT NULL,
	nome VARCHAR(120) NOT NULL,
	semestre_curso TINYINT NOT NULL, -- posição curricular
	carga_horaria_minima SMALLINT NOT NULL, -- mínimo de aulas no semestre
	deletado_em DATETIME NULL, -- soft-delete
    
    PRIMARY KEY (id_disciplina),
	CONSTRAINT fk_disciplina_curso FOREIGN KEY (curso_id) REFERENCES curso (id_curso)
);

CREATE TABLE atribuicao_professor (
	id_atribuicao_professor INT AUTO_INCREMENT,
	disciplina_id INT NOT NULL,
	professor_id INT NOT NULL,
	semestre_letivo_id INT NOT NULL,
    
    PRIMARY KEY (id_atribuicao_professor),
	UNIQUE KEY uq_atribuicao (disciplina_id, semestre_letivo_id), -- 1 disci por professor
	CONSTRAINT fk_ap_disciplina FOREIGN KEY (disciplina_id) REFERENCES disciplina (id_disciplina),
	CONSTRAINT fk_ap_professor FOREIGN KEY (professor_id) REFERENCES usuario (id_usuario),
	CONSTRAINT fk_ap_sl FOREIGN KEY (semestre_letivo_id) REFERENCES semestre_letivo (id_semestre_letivo)
);

-- dia_semana: 1=Segunda … 6=Sábado
CREATE TABLE atribuicao_horario (
	id_atribuicao_horario INT AUTO_INCREMENT,
	atribuicao_id INT NOT NULL,
	dia_semana TINYINT NOT NULL, -- dia semana = 1 ate 6
	horario_curso_id INT NOT NULL,
    
    PRIMARY KEY (id_atribuicao_horario),
	UNIQUE KEY uq_ah (atribuicao_id, dia_semana, horario_curso_id),
	CONSTRAINT fk_ah_atribuicao FOREIGN KEY (atribuicao_id) REFERENCES atribuicao_professor (id_atribuicao_professor),
	CONSTRAINT fk_ah_horario FOREIGN KEY (horario_curso_id) REFERENCES horario_curso (id_horario_curso)
);

CREATE TABLE tema (
	id_tema INT AUTO_INCREMENT,
	disciplina_id INT NOT NULL,
	semestre_letivo_id INT NOT NULL,
	nome VARCHAR(120) NOT NULL,
	eh_avaliacao TINYINT(1) NOT NULL DEFAULT 0,
	qtd_min_aulas TINYINT NOT NULL DEFAULT 1,
	qtd_max_aulas TINYINT NOT NULL DEFAULT 1,
	prioridade SMALLINT NOT NULL DEFAULT 1, -- 1 = maior
	eh_opcional TINYINT(1) NOT NULL DEFAULT 0,
	deletado_em DATETIME NULL, -- soft-delete
    
    PRIMARY KEY (id_tema),
	CONSTRAINT fk_tema_disciplina FOREIGN KEY (disciplina_id) REFERENCES disciplina (id_disciplina),
	CONSTRAINT fk_tema_sl FOREIGN KEY (semestre_letivo_id) REFERENCES semestre_letivo (id_semestre_letivo)
);

-- `ordem` define a sequência das dependências: Se o usuário selecionar que C depende de A e B, mas A tiver ordem = 1, então A virá antes de B.
CREATE TABLE dependencia_tema (
	id_dependencia_tema INT AUTO_INCREMENT,
	tema_id INT  NOT NULL, -- tema que depende
	tema_dependencia_id INT  NOT NULL, -- tema que deve vir antes
	ordem TINYINT  NOT NULL,
    
    PRIMARY KEY (id_dependencia_tema),
	UNIQUE KEY uq_dep (tema_id, tema_dependencia_id),
	CONSTRAINT fk_dt_tema FOREIGN KEY (tema_id) REFERENCES tema (id_tema),
	CONSTRAINT fk_dt_dependencia FOREIGN KEY (tema_dependencia_id) REFERENCES tema (id_tema)
);

CREATE TABLE planejamento (
	id_planejamento INT AUTO_INCREMENT,
	atribuicao_professor_id INT UNIQUE NOT NULL,
	gerado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	
    PRIMARY KEY (id_planejamento),
	CONSTRAINT fk_plan_atribuicao FOREIGN KEY (atribuicao_professor_id) REFERENCES atribuicao_professor (id_atribuicao_professor)
);

CREATE TABLE slot_planejamento (
	id_slot_planejamento INT AUTO_INCREMENT,
	planejamento_id INT NOT NULL,
	data DATE NOT NULL,
	horario_curso_id INT NOT NULL,
	tema_id INT NULL,
	status ENUM( 'nao_ministrada', 'ministrada', 'cancelada_professor', 'cancelada_adm') NOT NULL DEFAULT 'nao_ministrada',
	motivo_cancelamento VARCHAR(255) NULL, -- somente para cancelada_professor
	cancelamento_adm_id INT NULL, -- somente para cancelada_adm
    
    PRIMARY KEY (id_slot_planejamento),
	CONSTRAINT fk_sp_planejamento FOREIGN KEY (planejamento_id) REFERENCES planejamento (id_planejamento),
	CONSTRAINT fk_sp_horario FOREIGN KEY (horario_curso_id) REFERENCES horario_curso (id_horario_curso),
	CONSTRAINT fk_sp_tema FOREIGN KEY (tema_id) REFERENCES tema (id_tema),
	CONSTRAINT fk_sp_cancelamento_adm FOREIGN KEY (cancelamento_adm_id) REFERENCES cancelamento_adm (id_cancelamento_adm)
);


