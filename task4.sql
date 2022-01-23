--Task 1
--Database Yaradin Adi Ne Olursa Olsun
create database Mallar 

use Mallar

--Brands Adinda Table Yaradin 2 dene colum Id ve Name
create table Brands
 (
	Id int primary key identity, 
	Name nvarchar(30)
 )
 
--Notebooks Adinda Table Yaradin Id,Name, Price Columlari Olsun.
 create table Notebooks 
 (
  Id int primary key identity,
  Name nvarchar(25),
  Price decimal 
 )

--Phones Adinda Table Yaradin Id, Name, Price Columlari Olsun.
 create table Phones
 (
  Id int primary key identity,
  Name nvarchar(25),
  Price decimal 
 )

--1) Notebook ve Brand Arasinda Mentiqe Uygun Relation Qurun.
  alter table notebooks 
  add   BrandId int 

  alter table notebooks 
  add foreign key (BrandId) REFERENCES brands(Id)

--2) Phones ve Brand Arasinda Mentiqe Uygun Relation Qurun.
  alter table phones 
  add   BrandId int

  alter table phones 
  add foreign key (BrandId) REFERENCES brands(Id)

  -- Data Insert
   insert into Brands(name)
  values 
  ('Lenove'),
  ('Hp'),
  ('Toshiba'),
  ('Asus'),
  ('Dell'),
  ('Acer'),
  ('Appel'),
  ('hp pavilyon'),
  ('Micrasoft'),
  ('MSI'),
  ('Razer'),
  ('Samsung'),
  ('Apple '),
  ('REDmi'),
  ('Onepluse'),
  ('Honor'),
  ('ZTE'),
  ('Blackberry'),
  ('Nokia'),
  ('Huawei'),
  ('Realme'),
  ('BQ')


  insert into notebooks (name,price,brandid)
  values 
  ('Lenove yoga',2000,1),
  ('Hp omen',3500,2),
  ('Toshiba ofice',5000,3),
  ('Asus pradator',4899,4),
  ('Dell gaming',1000,5),
  ('Acer povilion',2500,6),
  ('Apple maccbak',5500,7),
  ('hp pavilyon',2700,8),
  ('Micrasoft bill gates',1500,9),
  ('MSI 50 cent',3200,10),
  ('Razer blade',2200,11)

    insert into Phones (name,price,brandid)
  values 
  ('Samsung s21',2000,12),
  ('Apple ippod',4200,13),
  ('REDmi',1300,14),
  ('Onepluse',2300,15),
  ('Honor',1000,16),
  ('ZTE',2100,17),
  ('Blackberry',500,18),
  ('Nokia',600,19),
  ('Huawei',3200,20),
  ('Realme',3400,21),
  ('BQ',2013,22)



--3) Notebooks Adini, Brandin Adini BrandName kimi ve Qiymetini Cixardan Query.
select n.Name , b.Name BrandName,n.Price from notebooks n 
  left join Brands b on n.brandid=b.id 
  use Mallar

--4) Phones Adini, Brandin Adini BrandName kimi ve Qiymetini Cixardan Query.
  select p.Name , b.Name BrandName ,p.Price from Phones p 
  left join Brands b on p.brandid=b.id

--5) Brand Adinin Terkibinde s Olan Butun Notebooklari Cixardan Query.
  select  n.Name , b.Name BrandName,n.Price from notebooks n 
  left join Brands b on n.brandid=b.id 
  where charindex('s',lower(b.Name))>0

select  n.Name , b.Name BrandName,n.Price from notebooks n 
  left join Brands b on n.brandid=b.id 
  where lower(b.Name) like '%s%'

--6) Qiymeti 2000 ve 5000 arasi ve ya 5000 den yuksek Notebooklari Cixardan Query.
select  n.Name , b.Name BrandName,n.Price from notebooks n 
  left join Brands b on n.brandid=b.id 
  where (n.price between 2000 and 5000) or n.price>5000

--7) Qiymeti 1000 ve 1500 arasi ve ya 1500 den yuksek Phonelari Cixardan Query.
    select p.Name , b.Name BrandName ,p.Price from Phones p 
  left join Brands b on p.brandid=b.id
  where (p.price between 1000 and 1500) or p.price>1500

--8) Her Branda Aid Nece dene Notebook Varsa Brandin Adini Ve Yaninda Sayini Cixardan Query.
  select b.Name , count(*) from notebooks n 
  left join Brands b on n.brandid=b.id 
  group by b.name

--9) Her Branda Aid Nece dene Phone Varsa Brandin Adini Ve Yaninda Sayini Cixardan Query.
select b.Name ,count(*) from Phones p 
  left join Brands b on p.brandid=b.id
  group by b.Name
--10) Hem Phone Hem de Notebookda Ortaq Olan Name ve BrandId Datalarni Bir Cedvelde Cixardan Query.
select b.Name, b.id BrandId from brands b
  left join Phones p on p.brandid= b.id
  left join Notebooks n on n.brandid = b.id
  where p.brandid=n.brandid
--11) Phone ve Notebook da Id, Name, Price, ve BrandId Olan Butun Datalari Cixardan Query.
  select id,Name,price, brandid from Phones
  union all
  select id,Name,price, brandid from Notebooks

--12) Phone ve Notebook da Id, Name, Price, ve Brandin Adini BrandName kimi Olan Butun Datalari Cixardan Query.
  select p.id, p.Name , p.Price, b.Name BrandName  from Phones p 
  left join Brands b on p.brandid=b.id
  union all
select  n.id, n.Name , n.Price, b.Name BrandName  from notebooks n 
  left join Brands b on n.brandid=b.id 
--13) Phone ve Notebook da Id, Name, Price, ve Brandin Adini BrandName kimi Olan Butun 
--Datalarin Icinden Price 1000-den Boyuk Olan Datalari Cixardan Query.
  
    select p.id, p.Name , p.Price, b.Name BrandName  from Phones p 
  left join Brands b on p.brandid=b.id
  where p.Price>1000
  union all
select  n.id, n.Name , n.Price, b.Name BrandName  from notebooks n 
  left join Brands b on n.brandid=b.id 
  where n.Price>1000
/*14) Phones Tabelenden Data Cixardacaqsiniz Amma Nece Olacaq Brandin Adi (BrandName kimi), 
Hemin Brandda Olan Telefonlarin Pricenin Cemi (TotalPrice Kimi) ve 
Hemin Branda Nece dene Telefon Varsa Sayini (ProductCount Kimi) 
Olan Datalari Cixardan Query.Misal
BrandName:        TotalPrice:        ProductCount:
Apple                   6750                3
Samsung            3500                4
Redmi                 800                1
*/
  select b.Name BrandName,sum(p.price) TotalPrice, count(*) ProductCount from Phones p 
  left join Brands b on p.brandid=b.id
  group by b.Name

/*15) Notebooks Tabelenden Data Cixardacaqsiniz Amma Nece Olacaq Brandin Adi (BrandName kimi), Hemin Brandda Olan Telefonlarin Pricenin Cemi (TotalPrice Kimi) , Hemin Branda Nece dene Telefon Varsa Sayini (ProductCount Kimi) Olacaq ve Sayi 3-ve 3-den Cox Olan Datalari Cixardan Query.Misal
BrandName:        TotalPrice:        ProductCount:
Apple                    6750                3
Samsung              3500                4
*/
  select b.Name BrandName,sum(n.price) TotalPrice, count(*) ProductCountfrom from notebooks n 
  left join Brands b on n.brandid=b.id 
  group by b.name
  having count(*)>=3




