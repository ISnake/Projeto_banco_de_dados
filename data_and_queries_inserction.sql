-- inserção de dados e querys
use ecommerce;

show tables;
-- idClient, Fnome, Minit, Lname, CPF, Address
insert into clients (Fname, Minit, Lname, CPF, Address)
	values ('Maria', 'M', 'Silva', 12116789, 'rua silva de prata 29, Cangola - Cidade das flores SP'),
		   ('João', 'L', 'Fernandes', 123321456, 'rua esplanada de cristo, Horizonte - São Paulo SP'),
           ('Mister M', 'M', 'Torres', 187654329, 'rua das baratas, Pallu - Americana SP');
           
-- idProduct, Pname, classification_kids boolean, category ('Edredom','Coberdrom', 'Mantas', 'Jogo de lençol', 'Cortinas', 'Toalhas'), avaliação, size 
insert into product (Pname, classification_kids, category, avaliação, size, descProduct)
	values ('Coberdrom canelado', false, 'Coberdrom', '5',' 2.20x2.50', 'King'),
		   ('Manta Fleece', false, 'Mantas', '4', '1,70mx2,20m', 'Queen'),
           ('Toalha de banho', true, 'Toalhas', '5', '1,20m', 'Solteiro');
           
-- idOrders, idOrdersClient, ordersStatus, ordersDescription, freight, paymentCash, idOPayment
insert into orders (idOrdersClient, ordersStatus, ordersDescription, freight, paymentCash, idOPayment)
	values (1, default, 'compra via app', null, 50, 1),
		   (2, default, 'compra via app', 30, 0, 2),
           (3, 'Confirmado', null, null, 1, 3);
  
-- idStock, stockLocal, quantity
insert into stock (stockLocal, quantity)
	values ('São Paulo', 10),
		   ('Rio de Janeiro', 20),
		   ('Bertioga', 15);
           
-- idSupplier, socialName, CNPJ, contact
insert into supplier (socialName, CNPJ, contact)
	values  ('Animatrix', '40.750.515/0001-23', 3841-9999),
			('Gin', '29.467.276/0001-66', 3841-7777),
            ('Enxovais', '76.636.608/0001-79', 3841-1222);
            
-- idSeller, socialName, sellerLocal, fantasyName, CNPJ, CPF, contact
insert into seller (socialName, sellerLocal, fantasyName, CNPJ, CPF, contact)
	 values ('João', 'Loja', null, null, null, '1234-1234'),
			('Rita', 'Loja', null, null, null, '4321-4321'),
            ('Chan', 'Site', null, null, null, '2323-2323');
            
-- idProductHave, idProductSupplier, quantity
insert into productHave (idProductHave, idProductSupplier, quantity)
	values (1, 3, 40),
		   (2, 2, 30),
           (3, 1, 20);
           
-- idProductSeller, idPproduct, quantity
insert into productsSeller (idProductSeller, idPproduct, quantity)
	values (1, 3, 1),
		   (2, 2, 2),
           (3, 1, 3);
           

-- idPOProduct, idProductOrder, quantity, POstatus
insert into productOrder (idPOProduct, idProductOrder, quantity, POstatus)
	values (1, 1, 2, default),
		   (2, 2, 3, default),
		   (3, 3, 4, 'sem Estoque');
	
-- idStockProduct, idProductProduct
insert into inStock (idStockProduct, idProductProduct)
	values (1, 2),
		   (2, 1),
		   (3, 3);
           
-- Mostrando clientes que fizeram pedido
select * from clients c, orders o where c.idClient = idOrdersClient;

-- Recuperação de pedido com produto associado!
select * from clients c inner join orders o ON c.idClient = o.idOrdersClient
                inner join productOrder p on p.idProductOrder = o.idOrders;

-- Recuperar quantos pedidos foram realizado pelos clientes?
select c.idClient, Fname, count(*) as Number_of_orders from clients c
				inner join orders o ON c.idClient = o.idOrdersClient
		group by idClient;
        
