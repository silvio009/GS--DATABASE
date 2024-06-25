CREATE TABLE t_jv_ambiente (
    id_ambiente       NUMBER(8) NOT NULL,
    id_missao         NUMBER(8) NOT NULL,
    nm_geolocalizacao VARCHAR2(100) NOT NULL,
    nr_temperatura    VARCHAR2(50) NOT NULL,
    tp_fauna          VARCHAR2(80) NOT NULL
);

COMMENT ON COLUMN t_jv_ambiente.id_ambiente IS
    'Esse atributo recebe o UID primário dos dados maritimos, seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_jv_ambiente.nm_geolocalizacao IS
    'Esse atriubuto recebe o nome da geolocalização dos dados maritimos. seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_jv_ambiente.nr_temperatura IS
    'Esse atributo o número da temperatura do ambiente, seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_jv_ambiente.tp_fauna IS
    'Esse atributo recebe o tipo de fauna da geolocalizaçao, seu conteúdo é obrigatório.';

ALTER TABLE t_jv_ambiente ADD CONSTRAINT t_jv_ambiente_pk PRIMARY KEY ( id_ambiente );

CREATE TABLE t_jv_drone (
    id_drone      NUMBER(8) NOT NULL,
    nm_modelo     VARCHAR2(150) NOT NULL,
    nm_funcao     VARCHAR2(50) NOT NULL,
    nm_fabricante VARCHAR2(50) NOT NULL,
    nr_distancia  VARCHAR2(100) NOT NULL,
    tp_bateria    VARCHAR2(50) NOT NULL
);

COMMENT ON COLUMN t_jv_drone.id_drone IS
    'Esse atributo recebe o UID  primario do drone, seu conteúdo é obrigatório';

COMMENT ON COLUMN t_jv_drone.nm_modelo IS
    'Esse atributo recebe o nome do modelo do drone, seu conteúdo é obrigatório';

COMMENT ON COLUMN t_jv_drone.nm_funcao IS
    'Esse atributo recebe o UID  primario do drone, seu conteúdo é obrigatório';

COMMENT ON COLUMN t_jv_drone.nm_fabricante IS
    'Esse atributo recebe o nome do fabricante do drone, seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_jv_drone.nr_distancia IS
    'Esse atributo recebe a distancia que o drone pode percorrer, seu conteúdo é obrogatório';

COMMENT ON COLUMN t_jv_drone.tp_bateria IS
    'Esse atributo recebe o tipo de bateria do drone, seu conteudo é obrigatório.';

ALTER TABLE t_jv_drone ADD CONSTRAINT t_jv_drone_pk PRIMARY KEY ( id_drone );

CREATE TABLE t_jv_email (
    id_email       NUMBER(8) NOT NULL,
    id_funcionario NUMBER(8) NOT NULL,
    nm_email       VARCHAR2(150) NOT NULL,
    ds_email       VARCHAR2(30) NOT NULL,
    st_email       VARCHAR2(20) NOT NULL
);

COMMENT ON COLUMN t_jv_email.id_email IS
    'Esse atributo recebe o uid primario do email, seu coneudo é obrigatório';

COMMENT ON COLUMN t_jv_email.nm_email IS
    'Esse atributo recebe o nome do email do  cliente, seu conteúdo é obrigatório';

COMMENT ON COLUMN t_jv_email.ds_email IS
    'Esse atributo recebe a descrição loga do email, seu conteudo é obrigatório';

COMMENT ON COLUMN t_jv_email.st_email IS
    'Esse atriubuto recebe o status do email do cliente (A)tivo e (I)nativo , esse atributo é obrigatório';

ALTER TABLE t_jv_email ADD CONSTRAINT t_jv_telefone_pk PRIMARY KEY ( id_email );

CREATE TABLE t_jv_func_drone (
    id_drone       NUMBER(8) NOT NULL,
    id_funcionario NUMBER(8) NOT NULL
);

ALTER TABLE t_jv_func_drone ADD CONSTRAINT t_jv_func_drone_pk PRIMARY KEY ( id_drone,
                                                                            id_funcionario );

CREATE TABLE t_jv_funcionario (
    id_funcionario NUMBER(8) NOT NULL,
    nm_funcionario VARCHAR2(50) NOT NULL,
    nr_cpf         NUMBER(11) NOT NULL,
    nm_cargo       VARCHAR2(100) NOT NULL,
    cd_senha       VARCHAR2(150) NOT NULL
);

COMMENT ON COLUMN t_jv_funcionario.id_funcionario IS
    'Esse atributo recebe o UID primario do funcionario, seu atributo é obrigatório';

COMMENT ON COLUMN t_jv_funcionario.nm_funcionario IS
    'Esse atributo recebe o nome do funcionario, seu atributo é orbigatório.';

COMMENT ON COLUMN t_jv_funcionario.nr_cpf IS
    'Esse atributo recebe o número do cpf do funcionario, seu conteúdo é orbigatório. ';

COMMENT ON COLUMN t_jv_funcionario.nm_cargo IS
    'Esse atributo é responsavel por armazenar o cargo do funcionario,seu conteudo é obrigatório';

COMMENT ON COLUMN t_jv_funcionario.cd_senha IS
    'Esse atributo recebe o codigo da senha do funcionario, seu conteudo é obrigatório';

ALTER TABLE t_jv_funcionario ADD CONSTRAINT t_jv_funcionario_pk PRIMARY KEY ( id_funcionario );

CREATE TABLE t_jv_log (
    id_log       NUMBER(8) NOT NULL,
    nm_procedure VARCHAR2(100),
    nm_usuario   VARCHAR2(150),
    dt_error     DATE,
    nr_error     VARCHAR2(150)
);

COMMENT ON COLUMN t_jv_log.id_log IS
    'Esse atriubuto recebe o UID primario do log,seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_jv_log.nm_procedure IS
    'Esse atributo recebe o nome da procedure, seu conteúdo é opcional';

COMMENT ON COLUMN t_jv_log.nm_usuario IS
    'Esse atributo recebe o nome do usuario do banco,seu conteudo é opcional';

COMMENT ON COLUMN t_jv_log.dt_error IS
    'Esse atributo recebe a data de error, seu conteudo é opcional';

COMMENT ON COLUMN t_jv_log.nr_error IS
    'Esse atributo recebe o numero do error no banco,seu conteúdo é opcional.';

ALTER TABLE t_jv_log ADD CONSTRAINT t_jv_log_pk PRIMARY KEY ( id_log );

CREATE TABLE t_jv_missao (
    id_missao NUMBER(8) NOT NULL,
    id_drone  NUMBER(8) NOT NULL,
    nm_missao VARCHAR2(100) NOT NULL,
    ds_missao VARCHAR2(150) NOT NULL,
    dt_inicio DATE NOT NULL,
    dt_fim    DATE
);

COMMENT ON COLUMN t_jv_missao.id_missao IS
    'Esse atributo recebe o UID primario das missoes, seu conteúdo é obrigatório.  ';

COMMENT ON COLUMN t_jv_missao.nm_missao IS
    'Esse atributo recebe o nome da missão, seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_jv_missao.ds_missao IS
    'Esse atributo recebe a descrição longa da missão, seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_jv_missao.dt_inicio IS
    'Esse atributo recebe a data de inicio da missão, seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_jv_missao.dt_fim IS
    'Esse atributo recebe a data de fim da missão, seu conteúdo é opcional.';

ALTER TABLE t_jv_missao ADD CONSTRAINT t_jv_missao_pk PRIMARY KEY ( id_missao );

ALTER TABLE t_jv_email
    ADD CONSTRAINT fk_cliente_email FOREIGN KEY ( id_funcionario )
        REFERENCES t_jv_funcionario ( id_funcionario );

ALTER TABLE t_jv_func_drone
    ADD CONSTRAINT fk_drone_funcionario FOREIGN KEY ( id_drone )
        REFERENCES t_jv_drone ( id_drone );

ALTER TABLE t_jv_missao
    ADD CONSTRAINT fk_drone_missao FOREIGN KEY ( id_drone )
        REFERENCES t_jv_drone ( id_drone );

ALTER TABLE t_jv_func_drone
    ADD CONSTRAINT fk_funcionario_drone FOREIGN KEY ( id_funcionario )
        REFERENCES t_jv_funcionario ( id_funcionario );

ALTER TABLE t_jv_ambiente
    ADD CONSTRAINT fk_missao_dadosmart FOREIGN KEY ( id_missao )
        REFERENCES t_jv_missao ( id_missao );

CREATE SEQUENCE t_jv_log_seq START WITH 1 INCREMENT BY 1;

