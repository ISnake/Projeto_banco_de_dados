-- criação do banco de dados para o cenário de E-commerce

create database ecommerce;
use ecommerce;

-- drop database ecommerce;

-- criar tabela cliente
create table clients(
	idClient INT PRIMARY KEY AUTO_INCREMENT,
	Fnome VARCHAR(10),
    Minit CHAR(3),
    Lname VARCHAR(20),
    CPF CHAR(11) NOT NULL,
    Adress VARCHAR(45),
    CONSTRAINT unique_cpf_client UNIQUE (CPF)
);

alter table clients auto_increment=1;

-- criar tabela produto
-- size: dimensão do produto
create table product(
	idProduct INT PRIMARY KEY AUTO_INCREMENT,
	Fnome VARCHAR(20) not null,
    classification_kids bool default false,
    category enum('Edredom','Coberdrom', 'Mantas', 'Jogo de lençol', 'Cortinas', 'Toalhas') not null,
    avaliação FLOAT default 0,
    size VARCHAR(10)
);

-- Desafio: implementara tabela pagamento e crie a conexão com as tabelas necessárias.
-- além disso, reflita essa modificaçaõ no diagrama de modelo relacional.
-- criar contraints relacionadas ao pagamento

-- criar tabela pedido

create table orders(
	idOrders int auto_increment primary key,
    idOrdersClient int,
    ordersStatus enum('Cancelado', 'Confirmado', 'Em processamento'),
    ordersDescription varchar(255),
    freight float default 10,
    paymentCash bool default false,
    idPayment int,
    constraint fk_orders_client foreign key (idOrdersClient) references clients(idClient) 
		on update cascade
);
-- desc payment;

-- criar tabela Pagamento
create table payment(
	idPayment int,
    idPaymentOrders int,
    idPayClient int,
    typePayment enum('Cartão','Pix', 'PagSeguro'),
    period_buy datetime,
    limitAvailable float,
    primary key (idPaymentOrders, idPayClient),
    constraint fk_order_pay foreign key (idPaymentOrders) references orders(idOrders),
    constraint fk_pay_client foreign key (idPayClient) references clients(idClient)
);

-- criar tabela Estoque
create table stock(
	idStock int auto_increment primary key,
    stockLocal varchar (255),
    quantity int default 0
);

-- criar tabela fornecedor 
create table supplier(
	idSupplier int auto_increment primary key,
    socialName varchar (45) not null,
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_cnpj_supplier unique (CNPJ)
);

-- criar tabela Vendedor
create table seller(
	idSeller int auto_increment primary key,
    socialName varchar(45) not null unique,
    sellerLocal varchar(45),
    fantasyName varchar(45),
	CNPJ char(15),
    CPF char(9),
    contact char(11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF)
);	

-- criar tabela Disponibilizando um produto
create table productHave (
	idProductHave int,
    idProductSupplier int,
    quantity int not null,
    primary key (idProductHave, idProductSupplier),
    constraint fk_productSeller foreign key (idProductHave) references product (idProduct),
    constraint fk_supplier foreign key (idProductSupplier) references supplier (idSupplier)
);

-- criar tabela Produtos por vendedor
create table productsSeller (
	idProductSeller int,
    idPproduct int,
    quantity int default 1,
    primary key (idProductSeller, idPproduct),
    constraint fk_product_seller foreign key (idProductSeller) references seller(idSeller),
    constraint fk_product_product foreign key (idPproduct) references product(idProduct)

);

-- criar tabela produto/pedido
create table productOrder (
	idPOProduct int,
	idProductOrder int,
    quantity int default 1,
    status enum('Disponível', 'sem Estoque') default 'Disponível',
    primary key (idPOproduct, idProductOrder),
    constraint fk_product foreign key (idPOProduct) references product(idProduct),
    constraint fk_producy_order foreign key (idProductOrder) references orders(idOrders)
);

-- criar tabela Em Estoque
create table inStock (
	idStockProduct int,
    idProductProduct int,
    primary key (idStockProduct, idProductProduct),
    constraint fk_stock_product foreign key (idStockProduct) references stock (idStock),
    constraint fk_products_products foreign key (idProductProduct) references product (idProduct)
    
);

show tables;
