create database provisionamento_acessos;

use provisionamento_acessos;

create table usuario (
    id int auto_increment primary key,
    nome varchar(100) not null,
    email varchar(100) not null,
    cargo varchar(100),
    departamento varchar(100),
    status varchar(20)
);

create table servidor (
    id int auto_increment primary key,
    nome varchar(100) not null,
    hostname varchar(100) not null,
    ip varchar(45) not null,
    sistema_operacional varchar(50),
    ambiente varchar(20)
);

create table perfil_permissao (
    id_perfil int auto_increment primary key,
    nome varchar(50) not null,
    descricao varchar(255),
    nivel_acesso int
);

create table conta_acesso (
    id_conta int auto_increment primary key,
    id_usuario int not null,
    id_servidor int not null,
    login varchar(50) not null,
    status varchar(20),
    data_criacao Date,
    data_expiracao Date,

    foreign key (id_usuario) references usuario(id),
    foreign key (id_servidor) references servidor(id)
);

create table acesso (
    id_acesso int auto_increment primary key,
    id_conta int not null,
    id_perfil int not null,
    data_inicio Date,
    data_fim Date,
    status varchar(20),

    foreign key (id_conta) references conta_acesso(id_conta),
    foreign key (id_perfil) references perfil_permissao(id_perfil)
);
