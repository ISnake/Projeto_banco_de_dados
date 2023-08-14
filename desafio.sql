use ecommerce;

alter table clients
	add People enum('PF', 'PJ') default 'PF';

-- criar tabela Pagamento
create table payment(
	idPayment int primary key auto_increment,
    typePayment enum('Cartão','Pix', 'PagSeguro') not null,
    period_buy varchar(20) not null,
    limitAvailable float not null
);

-- idPayment, typePayment, period_buy, limitAvailable
insert into payment (typePayment, period_buy, limitAvailable)
	values ('Pix', 2023-08-12, 100),
		   ('Cartão', 2023-08-12, 200),
           ('PagSeguro', 2023-08-12, 300);
    
-- Criar tabela Entrega - Possui status e código de rastreio;
create table delivery (
	idDelivery int auto_increment,
    idD_order int,
--    idD_client int,
--    idD_payment int,
    delivery_status enum('Separando seu pedido', 'Enviando, a caminho', 'Entregue') default 'Separando seu pedido' not null,
    cod_delivery char(30) not null,
    primary key (idDelivery, idD_order),
--    primary key(idDelivery, idD_client, idD_order, idD_payment),
    constraint fk_D_order foreign key (idD_order) references orders(idOrders)
--    constraint fk_D_client foreign key (idD_client) references clients(idClient),
--    constraint fk_D_payment foreign key (idD_payment) references payment(idPayment)
);

-- idOrders, idOrdersClient, ordersStatus, ordersDescription, freight, paymentCash, idOPayment, 
insert into orders (idOrdersClient, ordersStatus, ordersDescription, freight, paymentCash, idOPayment)
			values (3, 'Confirmado', null, null, 1, 3),
				   (2, default, null, null, 1, 0);
select * from orders;

-- Quantos pedidos foram feitos para cada cliente?
select c.idClient, Fname, count(*) as Number_of_orders from clients c
				inner join orders o ON c.idClient = o.idOrdersClient
		group by idClient;

-- Algum vendedor também é fornecedor?
select * from seller sel, supplier sup where sel.contact = sup.contact
		order by (sel.socialName);
        
-- Relação de produtos fornecedores e estoques;
select p.idProduct, sup.socialName, s.quantity, Pname as Nome_produto
		from product p INNER JOIN supplier sup
        ON p.idProduct = sup.idSupplier
        INNER JOIN stock s;
        
-- Relação de nomes dos fornecedores e nomes dos produtos;
select sup.socialName, p.Pname
		from supplier sup INNER JOIN product p;
        
-- Mostrar todos pedidos e status ordernado pelo cliente.
select Fname, idOrders, ordersStatus from clients c, orders o
	where c.idClient = idOrdersClient
    order by Fname;

-- idDelivery, idD_order, delivery_status, cod_delivery
desc delivery;
select * from delivery;
insert into delivery (idDelivery, idD_order, delivery_status, cod_delivery)
			values (0, 1, 'Entregue', 'cod123'),
				   (0, 2, default, 'cod321'),
				   (0, 3, default, 'cod213');

drop table delivery;

-- Relação dos clientes e status da entrega do pedido
select concat(Fname, ' ', Lname) as complete_name, idDelivery, delivery_status, cod_delivery
			from clients c, delivery d
            where c.idClient = idDelivery
            order by cod_delivery;
            
-- Mostrando o limite de pagamento maior que 100, e o tipo de pagamento por cada cliente.
select p.idPayment, p.limitAvailable, p.typePayment, c.Fname from payment p
				inner join clients c ON p.idPayment = c.idClient
			group by p.idPayment
            having limitAvailable > 100;

-- Como listar todos os id do pedido e suas formas de pagamento, filtrando por pix?
select p.idPayment, p.limitAvailable, p.typePayment, o.OrdersStatus from payment p
				inner join orders o ON p.idPayment = o.idOrdersClient
			group by o.idOrders
            having typePayment = 'Pix';
            
    