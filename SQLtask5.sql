---Task 2
--Kitabxana database-i qurursunuz
create database LibraryDB;
 use LibraryDB
  
/*Books (Id, Name, PageCount)

Books-un Name columu minimum 2 simvol maksimum 100 simvol deyer ala bileceyi serti olsun.
Books-un PageCount columu minimum 10 deyerini ala bileceyi serti olsun.
*/
create table Books 
(
Id int primary key identity,
Name nvarchar(100) check (len(name) between 2 and 100),
Pagecount int check( pagecount >=10))

--Authors (Id, Name, Surname)

create table Authors 
(
Id int primary key identity, 
Name nvarchar(32), Surname nvarchar(50))

--Books ve Authors table-larinizin mentiqi uygun elaqesi olsun.

create table BookAuthor
(
  Id int primary key identity,
  BookId int,
  AuthorId int ,
  foreign key (BOOKID)  references  Books(ID),
  foreign key (Authorid)  references  Authors(ID)
  )


  --data insert 
  insert into books 
  values
  ('Qraf monte',1200),
  ('Deli kur',500)

  insert into Authors
  values
  (
     'Aleksandr','Duma'
  ),
  (
    'Ismail','Shixli'
  )
  

  insert into bookauthor values
  (
   1,1

  ),
  (
   2,2
  )
--Id, Name, PageCount ve AuthorFullName columnlarinin valuelarini qaytaran bir view yaradin

create  view BookauthorV 
as 
select b.id, b.name,b.pagecount,a.name+' '+a.surname authorfullname from books b 
left join bookauthor ba on b.id=ba.bookid
left join authors a on a.id=ba.Authorid

--Gonderilmis axtaris deyirene gore hemin axtaris deyeri name ve ya authorFullNamelerinde 
--olan Book-lari Id, Name, PageCount, AuthorFullName columnlari seklinde gostern procedure yazin
CREATE PROCEDURE searchBook 
@pName nvarchar(100) ,
@pauthorfullname nvarchar(90)
AS
	select * from BookauthorV v where v.Name=@pName or  v.authorfullname=@pauthorfullname 
GO

--Authors tableinin insert, update ve deleti ucun (her biri ucun ayrica) procedure yaradin
--Authors  insert

CREATE PROCEDURE insertAuthor 
@pName nvarchar(32),
@pSurname nvarchar(50)

AS
if (@pName is not null or @pSurname is not null )
begin
insert into Authors
values
(
@pName,@pSurname
)
end
GO


--Authors  update
CREATE PROCEDURE updateAuthor 
@pId int,
@pName nvarchar(32),
@pSurname nvarchar(50)

AS
if (@pName is not null or @pSurname is not null) and @pId is not null
begin 
update Authors
set Name = @pName, Surname = @pSurname
where id = @pId
end
GO


--Authors  delete
CREATE PROCEDURE deleteAuthor 
@pId int
AS
if @pId is not null
begin 
delete from Authors
where id = @pId
end
GO

--Authors-lari Id,FullName,BooksCount,MaxPageCount seklinde qaytaran view yaradirsiniz 
--Id-author id-si, FullName - Name ve Surname birlesmesi, 
--BooksCount - Hemin authorun elaqeli oldugu kitablarin sayi, 
--MaxPageCount - hemin authorun elaqeli oldugu kitablarin icerisindeki max pagecount deyeri

select a.id, a.name+' '+a.surname authorfullname, count(*) BooksCount,max(b.pagecount) MaxPageCount 
from books b 
left join bookauthor ba on b.id=ba.bookid
left join authors a on a.id=ba.Authorid
group by a.id, a.name+' '+a.surname 

-- execute 
select * from Authors
EXEC insertAuthor 'Parvin' ,'Pashayev'
exec updateAuthor  5 , 'Parvin','Pasha'
exec deleteAuthor 3