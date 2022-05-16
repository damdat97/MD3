-- Tạo database quản lý bán hàng
create database quanlybanhang;
use quanlybanhang;

create table customer (
    customer_id 	int not null auto_increment primary key,
	customer_name 	varchar(60) not null,
	customer_age 	int check(customer_age > 0)
);

create table `order` (
	order_id 			int not null auto_increment primary key,
	customer_id			int,
	order_date 			date,
	order_total_price 	double,
	foreign key (customer_id) references customer (customer_id)
);

create table product (
    product_id 		int not null auto_increment primary key,
	product_name 	varchar(60) not null,
	product_price 	double
);

create table order_detail (
    order_id 		int,
    product_id		int,
    amount 			int,
    primary key (order_id,product_id),
    foreign key (order_id) references `order` (order_id),
    foreign key (product_id) references product (product_id)
);

-- Thêm dữ liệu
insert into customer
values
(1,"Minh Quan",10),
(2,"Ngoc Oanh",20),
(3,"Hong Ha",50);

insert into `order`(order_id,customer_id,order_date)
values
(1,1,"2006-03-21"),
(2,2,"2006-03-23"),
(3,1,"2006-03-16");

insert into product
values
(1, "May Giat",3),
(2, "Tu lanh",5),
(3, "Dieu Hoa",7),
(4, "Quat",1),
(5, "Bep Dien",2);

insert into order_detail
values
(1,1,3),
(1,3,7),
(1,4,2),
(2,1,1),
(3,1,8),
(2,5,4),
(2,3,3);

-- Truy vấn dữ liệu
-- Hiển thị các thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order
select `order`.order_id,`order`.order_date,product.product_price
from `order`
join order_detail on `order`.order_id=order_detail.order_id
join product on order_detail.product_id=product.product_id;

-- Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách
select customer.customer_name,product.product_name,product.product_price
from customer
join `order` on customer.customer_id=`order`.customer_id
join order_detail on `order`.order_id=order_detail.order_id
join product on order_detail.product_id= product.product_id;

-- Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
select customer.customer_name
from customer
left join `order` on customer.customer_id=`order`.customer_id
where `order`.order_id is null;

/* Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn 
(giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn.
 Giá bán của từng loại được tính = odQTY*pPrice)*/
 select `order`.order_id,`order`.order_date,sum(order_detail.amount*product.product_price) as price
 from `order`
 join order_detail on `order`.order_id=order_detail.order_id
 join product on order_detail.product_id=product.product_id
 group by `order`.order_id;