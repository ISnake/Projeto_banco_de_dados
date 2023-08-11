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
    frete float default 10,
    paymentCash bool default false,
    constraint fk_orders_client foreign key (idOrdersClient) references clients(idClient) 
);

-- criar tabela Pagamento