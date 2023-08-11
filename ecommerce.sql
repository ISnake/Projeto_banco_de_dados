-- criação do banco de dados para o cenário de E-commerce

create database ecommerce;
use ecommerce;

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

-- criar tabela produto
-- size: dimensão do produto

create table product(
	idProduct INT PRIMARY KEY AUTO_INCREMENT,
	Fnome VARCHAR(20) not null,
    classification_kids bool default false,
    category enum('Edredom','Coberdrom', 'Mantas', 'Jogo de lençol', 'Cortinas', 'Toalhas') not null,
    avaliação FLOAT default 0,
    size VARCHAR(10),
    CONSTRAINT unique_cpf_client UNIQUE (CPF)
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
);

-- criar tabela Pagamento

create table payment(
	idPayment int auto_increment,
    idPaymentOrders int,
    idClient int,
    typePayment enum('Cartão','Pix', 'PagSeguro'),
    period_buy datetime,
    limitAvailable float,
    primary key (idClient, idPayment),
    constraint fk_pedido foreign key (idPaymentOrders) references orders(idOrders),
    constraint fk_client foreign key (idClient) references clients(idClient)
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
	productIdProduct int,
    stockIdStock int,
    constraint fk_productSeller foreign key (productIdProduct) references product (idProduct)
);

-- criar tabela Produtos por vendedor
create table productsSeller (
	idProductSeller int,
    idProduct int,
    quantity int default 1,
    primary key (idProductSeller, idSeller),
    constraint fk_product_seller foreign key (idProductSeller) references seller(idSeller),
    constraint fk_product_product foreign key (idProduct) references product(idProduct)
    
);