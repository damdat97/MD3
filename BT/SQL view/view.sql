-- Bước 1:
create database demo;

-- Bước 2:
use demo;
create table products (
product_id int not null auto_increment primary key,
product_code varchar(45),
product_name varchar(45),
product_price int,
product_amount int,
product_description varchar(45),
product_status varchar(45)
);
-- Thêm dữ liệu
insert into products
values
(1,"A01","IPhone",12000000,1,"màu trắng","Mới 100%"),
(2,"B06","Sam sung",7000000,2,"màu xanh","Mới 99%"),
(3,"C04","Oppo",11000000,1,"màu xám","Mới 100%"),
(4,"A09","Xiaomi",9000000,3,"màu đen","Mới 80%"),
(5,"B01","Vivo",5000000,1,"màu trắng","Cũ"),
(6,"A05","Realme",10000000,1,"màu đỏ","Mới 70%"),
(7,"A07","Vsmart",10000000,1,"màu hồng","Mới"),
(8,"C01","Nokia",7000000,1,"màu vàng","Cũ"),
(9,"D01","Masstel",8000000,1,"màu bạc","Cũ");

-- Bước 3:
create unique index index_product_code on products (product_code);
create unique index index_name_price on products (product_name,product_price);
explain select * from products where product_code = 'A09'; 
explain select * from products where product_name = 'Vsmart' and product_price = 10000000; 

-- Bước 4:
-- Tạo view
create view product_views as
select product_code,product_name,product_price,product_status
from products;
select * from product_views;
-- Update view
update product_views
set product_status = "Cũ"
where product_code = "B06";
-- Xóa view
drop view product_views;

-- Bước 5:
-- Tạo Stored procedure, lấy tất cả thông tin của sản phẩm
delimiter //
create procedure  find_all_products()
begin
  select * from products;
end //
delimiter ;
call find_all_products();
-- Tạo Stored procedure thêm 1 sản phẩm 
delimiter //
create procedure insert_products(in product_code varchar(45),in product_name varchar(45),in product_price int,in product_amount int,in product_description varchar(45),in product_status varchar(45))
begin
insert into products (product_id,product_code,product_name,product_price,product_amount,product_description,product_status)
values (product_id,product_code,product_name,product_price,product_amount,product_description,product_status);
end //
delimiter ;
call insert_products("D03","IPhone X",14000000,2,"màu xám","Mới 100%");
call insert_products("D07","Sam sung Galaxy",10000000,1,"màu xanh","Mới 100%");
select * from products;
-- Tạo Stored procedure sửa thông tin sản phẩm theo id
delimiter //
create procedure update_products(in product_id_in int, in product_code_in varchar(45))
begin
update products
set product_code = product_code_in
where product_id = product_id_in;
end //
delimiter ;
call update_products (8,"C02");
select * from products;
-- Tạo store procedure xoá sản phẩm theo id
delimiter //
create procedure delete_products(in product_id_in int)
begin
delete from products
where product_id = product_id_in;
end //
delimiter ;
call delete_products (3);
select * from products;