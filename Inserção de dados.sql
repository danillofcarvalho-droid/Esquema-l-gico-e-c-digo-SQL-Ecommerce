-- inserção de dados e queries

use ecommerce;

show tables;
-- idClient, Fname, Minit, Lname, CPF, Address
insert into Clients (Fname, Minit, Lname, CPF, Address)
values('Maria','M','Silva', 12346789, 'rua silva de prata 29, Carangola - Cidade das flores'),
      ('Matheus','O','Pimentel', 987654321,'rua alameda 289, Centro - Cidade das flores'),
      ('Ricardo','F','Silva', 45678913,'avenida alameda vinha 1009, Centro - Cidade das flores'),
      ('Julia','S','França', 789123456,'rua laranjeiras 861, Centro - Cidade das flores'),
      ('Roberta','G','Assis', 98745631,'avenidade koller 19, Centro - Cidade das flores'),
      ('Isabela','M','Cruz', 654789123,'rua alameda das flores 28, Centro - Cidade das flores');
  
-- idProduct, Pname, category('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis', 'Livro'), avaliação
SET NAMES utf8mb4;
insert into product (Pname, category, Avaliação) values
('Fone de ouvido','Eletrônico',4),
('Barbie Elsa','Brinquedos',3),
('Body Carters','Vestimenta',5),
('Microfone Vedo - Youtuber','Eletrônico',4),
('Comida japonesa','Alimentos',4),
('Sofá retrátil','Móveis',3),
('Farinha de arroz','Alimentos',2),
('Maus','Livro',4),
('Fire Stick Amazon','Eletrônico',3);
SHOW COLUMNS FROM product LIKE 'category';

select * from clients;
select * from product;

insert into orders (idOrderClient, orderStatus, orderDescription, sendValue) values
(1, default, 'compra via aplicativo', 1),
(2, default, 'compra via aplicativo', 0),
(3, 'Confirmado', null, 1),
(4, default, 'compra via web site', 0);

-- idPOproduct, idPOorder, poQuantity, poStatus
insert into productOrder (idPOproduct, idPOorder, podQuantity, poStatus) values
(154,1,2,null),
(155,2,1,null),
(156,3,1,null);
SELECT idOrder FROM orders;
SELECT idProduct FROM product;

-- storageLocation, quantity
insert into productStorage (storageLocation, quantity) values
('Rio de Janeiro',1000),
('Rio de Janeiro',500),
('São Paulo',10),
('São Paulo',100),
('São Paulo',10),
('Brasilia',60);

-- idLproduct, idLstorage, location
insert into storageLocation (idLproduct, idLstorage, location) values
(154,2,'RJ'),
(159,6,'DF');
SELECT idProduct FROM product;
SELECT idProdStorage, storageLocation, quantity FROM productStorage;

-- idSupplier, SocialName, CNPJ, contact
insert into supplier (SocialName, CNPJ, contact) values
('Almeida e filhos', 123456789123456, '21985474'),
('Eletrônicos Silva', 854519649143457, '21985484'),
('Eletrônicos Valma', 934567893934695, '21975474');

select * from supplier;

-- idPsSupplier, idPsProduct, quantity
insert into productSupplier (idPsSupplier, idPsProduct, quantity) values
(1,154,500),
(1,155,400),
(2,157,633),
(3,156,5),
(2,158,10);
SELECT idSupplier, socialName FROM supplier;
SELECT idProduct, Pname FROM product;

-- idSeller, SocialName, AbstName, CNPJ, CPF, location, contact
insert into seller (SocialName, AbstName, CNPJ, CPF, location, contact) values
('Tech eletronics', null, 123456789456321, null, 'Rio de Janeiro', 219946287),
('Botique Durgas', null, null, 123456783, 'Rio de Janeiro', 219567895),
('Kids World', null, 456789123654485, null, 'São Paulo', 1198657484);

select * from seller;

-- idPseller, idPproduct, prodQuantity
insert into productSeller (idPseller, idPproduct, prodQuantity) values
(1,154,80),
(2,155,10);

select * from clients c, orders o where c.idClient = idOrderClient;

INSERT INTO delivery (idOrder, deliveryStatus, trackingCode, carrier, estimatedDate)
VALUES (1, 'Enviado', 'BR123456789BR', 'Correios', DATE_ADD(CURDATE(), INTERVAL 5 DAY));

-- CRIANDO AS QUERYS
-- Quantos pedidos foram feitos por cada cliente?
select c.idclient, concat(c.fname, ' ', c.lname) as cliente,
count(o.idorder) as total_pedidos
from clients c
left join orders o on o.idorderclient = c.idclient
group by c.idclient, cliente
order by total_pedidos desc;

-- Produtos por categoria
select idproduct, pname, category, avaliação from product
where category in ('eletrônico','livro')
order by avaliação desc, pname asc;

-- O que cada fornecedor está entregando?
select s.socialname as fornecedor, p.pname as produto, ps.quantity
from supplier s
join productsupplier ps on ps.idpssupplier = s.idsupplier
join product p on p.idproduct = ps.idpsproduct
order by fornecedor, produto;

-- Quais produtos tem uma ótima avaliação?
select idproduct, pname, category, avaliação from product
where avaliação > (select avg(avaliação) from product)
order by avaliação desc;

-- Qual pedido tem entrega cadastrada?
select o.idorder, o.idorderclient, d.deliverystatus, d.trackingcode from orders o
join delivery d on d.idorder = o.idorder
order by o.idorder;
