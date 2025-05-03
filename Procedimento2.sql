insert into usuario
values (1, 'op1', 'op1'),(2, 'op2', 'op2');

insert into produto
values (1, 'Banana', 100, 5.00),(3, 'Laranja', 500, 2.00),(4, 'Manga', 800, 4.00);

INSERT INTO pessoa
VALUES (
    NEXT VALUE FOR seq_pessoa_id,
    'Joao',
    'Rua 12, cas 3, Quitanda',
    'Riacho do Sul',
    'PA',
    '1111-1111',
    'joao@riacho.com',
    '11111111111',
    'F'
);

INSERT INTO pessoa
VALUES (
    NEXT VALUE FOR seq_pessoa_id,
    'JJC',
    'Rua 11, Centro',
    'Riacho do Norte',
    'PA',
    '1212-1212',
    'jjc@riacho.com',
    '22222222222222',
    'J'
);

INSERT INTO movimento
VALUES
(1,1,1,1,'S',20,4.00),
(4,1,1,3,'S',15,2.00),
(5,2,1,3,'S',10,3.00),
(7,1,2,3,'E',15,5.00),
(8,1,2,4,'E',20,4.00);

--Dados completos de pessoas físicas.
select * from pessoa	
where tipoPessoa = 'F';

--Dados completos de pessoas jurídicas.
select * from pessoa	
where tipoPessoa = 'J';

--Movimentações de entrada, com produto, fornecedor, quantidade, preço unitário e valor total.
SELECT 
    idmovimento, 
    produto_idproduto, 
    produto.nome AS 'Produto',
    pessoa_idpessoa, 
    pessoa.nome AS 'Fornecedor', 
    movimento.quantidade, 
    valorUnitario,
    (movimento.quantidade * valorUnitario) AS valor_total
FROM movimento
JOIN pessoa
    ON movimento.pessoa_idpessoa = pessoa.idpessoa
JOIN produto 
    ON movimento.produto_idproduto = produto.idproduto
WHERE movimento.tipoMovimento = 'E';

-- Movimentações de saída, com produto, comprador, quantidade, preço unitário e valor total
SELECT 
    idmovimento, 
    produto_idproduto, 
    produto.nome AS Produto,
    pessoa_idpessoa, 
    pessoa.nome AS Comprador, 
    movimento.quantidade, 
    valorUnitario,
    (movimento.quantidade * valorUnitario) AS valor_total
FROM movimento
JOIN pessoa
    ON movimento.pessoa_idpessoa = pessoa.idpessoa
JOIN produto 
    ON movimento.produto_idproduto = produto.idproduto
WHERE movimento.tipoMovimento = 'S';

--Valor total das entradas agrupadas por produto.
SELECT 
    produto.nome, 
    SUM(movimento.quantidade * movimento.valorUnitario) AS ValorTotalEntradas
FROM movimento
JOIN produto
    ON produto.idproduto = movimento.produto_idproduto 
WHERE movimento.tipoMovimento = 'E'
GROUP BY produto.nome;

--Valor total das saídas agrupadas por produto.
SELECT 
    produto.nome, 
    SUM(movimento.quantidade * movimento.valorUnitario) AS ValorTotalSaidas
FROM movimento
JOIN produto
    ON produto.idproduto = movimento.produto_idproduto 
WHERE movimento.tipoMovimento = 'S'
GROUP BY produto.nome;

-- Operadores que não efetuaram movimentações de entrada (compra).
SELECT movimento.usuario_idusuario AS ID_DO_OPERADOR
FROM movimento
EXCEPT
SELECT movimento.usuario_idusuario
FROM movimento
WHERE movimento.tipoMovimento = 'E';

-- Valor total de entrada, agrupado por operador.
SELECT 
    usuario.nomeUsuario AS OPERADOR, 
    SUM(movimento.quantidade * movimento.valorUnitario) AS ValorTotalEntradas
FROM movimento
JOIN usuario
    ON usuario.idusuario = movimento.usuario_idusuario 
WHERE movimento.tipoMovimento = 'E'
GROUP BY usuario.nomeUsuario;

-- Valor total de saída, agrupado por operador.
SELECT 
    usuario.nomeUsuario AS OPERADOR, 
    SUM(movimento.quantidade * movimento.valorUnitario) AS ValorTotalSaidas
FROM movimento
JOIN usuario
    ON usuario.idusuario = movimento.usuario_idusuario 
WHERE movimento.tipoMovimento = 'S'
GROUP BY usuario.nomeUsuario;

-- Valor médio de venda por produto, utilizando média ponderada.
SELECT 
    produto.nome, 
    SUM(movimento.quantidade * movimento.valorUnitario) / SUM(movimento.quantidade) AS ValorMedioDeVenda
FROM movimento
JOIN produto
    ON produto.idproduto = movimento.produto_idproduto 
WHERE movimento.tipoMovimento = 'S'
GROUP BY produto.nome;
