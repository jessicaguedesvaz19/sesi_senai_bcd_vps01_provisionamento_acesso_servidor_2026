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