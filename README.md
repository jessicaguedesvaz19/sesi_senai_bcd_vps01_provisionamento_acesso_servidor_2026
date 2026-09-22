# VPF 01 - Banco de Dados
## Desafio: Projeto Provisionamento de acesso a servidores

Um banco de dados de Gestão e Provisionamento de Acessos de TI a servidores. O sistema tem como objetivo controlar os usuários, servidores, contas de acesso e permissões, permitindo registrar quais usuários possuem acesso a determinados servidores e quais níveis de permissão foram concedidos.
##
## MER/DER Conceitual e Lógico

![MER/DER](./MER_DER_conceitual_logico.png)

## Dicionário de Dados

| Entidade            | Atributo            | Tipo    | Tamanho | Descrição                                                                 |
| ------------------- | ------------------- | ------- | ------: | ------------------------------------------------------------------------- |
| Usuário             | id                  | int     |       — | Identificador único do usuário                                            |
| Usuário             | nome                | varchar |     100 | Nome completo do usuário                                                  |
| Usuário             | email               | varchar |     100 | E-mail do usuário                                                         |
| Usuário             | cargo               | varchar |     100 | Cargo do usuário                                                          |
| Usuário             | departamento        | varchar |     100 | Departamento do usuário                                                   |
| Usuário             | status              | varchar |      20 | Situação do usuário                                                       |
| Servidor            | id                  | int     |       — | Identificador único do servidor                                           |
| Servidor            | nome                | varchar |     100 | Nome do servidor                                                          |
| Servidor            | hostname            | varchar |     100 | Nome de identificação do servidor na rede                                 |
| Servidor            | ip                  | varchar |      45 | Endereço IP do servidor                                                   |
| Servidor            | sistema_operacional | varchar |      50 | Sistema operacional utilizado pelo servidor                               |
| Servidor            | ambiente            | varchar |      20 | Ambiente em que o servidor está, como Desenvolvimento, Testes ou Produção |
| Conta de Acesso     | id_conta            | int     |       — | Identificador único da conta                                              |
| Conta de Acesso     | id_usuario          | int     |       — | Identifica o usuário relacionado à conta                                  |
| Conta de Acesso     | id_servidor         | int     |       — | Identifica o servidor relacionado à conta                                 |
| Conta de Acesso     | login               | varchar |      50 | Login utilizado para acessar o servidor                                   |
| Conta de Acesso     | status              | varchar |      20 | Situação da conta de acesso                                               |
| Conta de Acesso     | data_criacao        | Date    |       — | Data em que a conta foi criada                                            |
| Conta de Acesso     | data_expiracao      | Date    |       — | Data em que a conta deixará de ser válida                                 |
| Perfil de Permissão | id_perfil           | int     |       — | Identificador único do perfil                                             |
| Perfil de Permissão | nome                | varchar |      50 | Nome do perfil de permissão                                               |
| Perfil de Permissão | descricao           | varchar |     255 | Descrição das permissões do perfil                                        |
| Perfil de Permissão | nivel_acesso        | int     |       — | Nível de acesso do perfil                                                 |
| Acesso              | id_acesso           | int     |       — | Identificador único do acesso                                             |
| Acesso              | id_conta            | int     |       — | Identifica a conta que recebeu o acesso                                   |
| Acesso              | id_perfil           | int     |       — | Identifica o perfil de permissão concedido                                |
| Acesso              | data_inicio         | Date    |       — | Data em que o acesso começa                                               |
| Acesso              | data_fim            | Date    |       — | Data em que o acesso termina                                              |
| Acesso              | status              | varchar |      20 | Situação do acesso                                                        |

## Dados de Teste em CSV

- [Usuários](./usuario.csv)
- [Servidores](./servidor.csv)
- [Contas de Acesso](./conta_acesso.csv)
- [Perfis de Permissão](./perfil_permissao.csv)
- [Acessos](./acesso.csv)

## Script SQL DDL (Desenvolvimento: Criação do Banco de dados)

```sql
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
```

## Script SQL DML(Manipulação: População com dados de teste)

```sql
insert into usuario
(nome, email, cargo, departamento, status)
values
('João Silva', 'joao@email.com', 'Desenvolvedor', 'TI', 'ATIVO'),
('Camila Rodrigues', 'camila@email.com', 'Analista', 'TI', 'ATIVO'),
('Henrique Costa', 'henrique@email.com', 'Administrador', 'Infraestrutura', 'ATIVO');

insert into servidor
(nome, hostname, ip, sistema_operacional, ambiente)
values
('Servidor Web', 'WEB01', '192.168.1.10', 'Linux', 'Produção'),
('Servidor Banco', 'DB01', '192.168.1.20', 'Linux', 'Produção'),
('Servidor Teste', 'TEST01', '192.168.1.30', 'Windows Server', 'Testes');

insert into perfil_permissao
(nome, descricao, nivel_acesso)
values
('Leitura', 'Permissão somente para visualizar', 1),
('Operador', 'Permissão para executar operações', 2),
('Administrador', 'Acesso administrativo ao servidor', 3);

insert into conta_acesso
(id_usuario, id_servidor, login, status, data_criacao, data_expiracao)
values
(1, 1, 'joao.silva', 'ATIVO', '2026-09-22', '2027-09-22'),
(2, 2, 'camila.rodrigues', 'ATIVO', '2026-09-22', '2027-09-22'),
(3, 1, 'henrique.costa', 'ATIVO', '2026-09-22', '2027-09-22');

insert into acesso
(id_conta, id_perfil, data_inicio, data_fim, status)
values
(1, 1, '2026-09-22', '2027-09-22', 'ATIVO'),
(2, 2, '2026-09-22', '2027-09-22', 'ATIVO'),
(3, 3, '2026-09-22', '2027-09-22', 'ATIVO');
```