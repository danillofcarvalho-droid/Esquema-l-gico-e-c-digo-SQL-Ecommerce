-- Criação do banco de dados para o cenário e-commerce

create database ecommerce;
use ecommerce;

-- criar tabaela cliente
create table clients(
	idClient int auto_increment primary key,
    Fname varchar (15),
    Minit char(3),
    Lname varchar (20),
    CPF char(11) not null,
    Address varchar(100),
    constraint unique_cpf_client unique(CPF)
);

alter table clients auto_increment=1;

-- criar tabaela produto
create table product(
	idProduct int auto_increment primary key,
    Pname varchar (15) not null,
    category enum ('Eletrônico', 'Vestiments', 'Brinquedos', 'Alimentos', 'Móveis', 'Livro') NOT NULL,
    Avaliação float default 0
);
ALTER TABLE product MODIFY Pname VARCHAR(50) NOT NULL;
ALTER TABLE product MODIFY category ENUM('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis','Livro') NOT NULL;

-- criar tabaela pagamento
DROP TABLE payments;
create table payments (
  idPayment int auto_increment primary key ,
  idClient int,
  TypePayment enum('Crédito','Débito','Pix'),
  limitAvailable float,
  constraint fk_payment_client foreign key (idClient) references clients(idClient)
);

-- criar tabela pedido
create table orders(
	idOrder int auto_increment primary key,
    idOrderClient int,
	idOrderPayment int,
	orderStatus enum('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
    orderDescription varchar(255),
    sendValue float default 10,
    constraint fk_order_client foreign key (idOrderClient) references clients(idClient),
    constraint fk_order_payment foreign key (idOrderPayment) references payments (idPayment)
);

-- criar tabela estoque
create table productStorage(
	idProdStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantify int default 0
    );
    alter table productStorage change quantify quantity int default 0;

-- criar tabaela fornecedor
create table supplier(
	idSupplier int auto_increment primary key,
    socialName varchar(255) not null,
    CNPJ char (15) not null,
    contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);
desc supplier;

-- criar tabaela vendedor
create table seller(
	idSeller int auto_increment primary key,
    socialName varchar(255) not null,
    AbstName varchar (255),
    CNPJ char (15),
    CPF char (9),
    location varchar (255),
    contact char(11) not null,
    constraint unique_cnpj_supplier unique (CNPJ),
    constraint unique_cpf_supplier unique (CPF)
    );
    
    -- criar tabaela vendedor
create table productSeller(
	idPseller int,
    idPproduct int,
    prodQuantity int default 1,
    primary key (idPseller, idPproduct),
    constraint fk_product_seller foreign key (idPseller) references seller (idSeller),
    constraint fk_product_product foreign key (idPproduct) references product (idProduct)
 );
 
  -- criar tabaela produto-vendedor
create table productOrder(
	idPOproduct int,
    idPOorder int,
    podQuantify int default 1,
    poStatus enum('Disponível', 'Sem estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder),
    constraint fk_productorder_seller foreign key (idPOproduct) references product (idProduct),
    constraint fk_productorder_product foreign key (idPOorder) references orders (idOrder)
  );  
 alter table productOrder change podQuantify poQuantity INT DEFAULT 1;
 alter table productOrder change poQuantity podQuantity INT DEFAULT 1;
    
create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
	primary key (idLproduct, idLstorage),
    constraint fk_storage_location_product foreign key (idLproduct) references product (idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage (idProdStorage)
);

create table produtcSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
	primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier (idSupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product (idProduct)
);
RENAME TABLE produtcSupplier TO productSupplier;

USE ecommerce;

-- Tabela de entrega (delivery): status + código de rastreio
create table delivery (
  idDelivery int auto_increment primary key,
  idOrder int not null,
  deliveryStatus enum('Preparando','Enviado','Em Trânsito','Entregue','Devolvido') not null default 'Preparando',
  trackingCode varchar (100) not null unique,
  carrier varchar(100) null,
  estimatedDate date null,
  actualDate date null,
  created_at timestamp default current_timestamp,
constraint fk_delivery_order foreign key (idOrder) references orders(idOrder)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
alter table delivery drop column actualDate, drop column created_at;


