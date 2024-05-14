create database music
use music


create table artist(
artist_id int,
name varchar(50)
)

select * from artist
select* from album
alter table album2
rename album
select *from customer
select * from employee
select * from genre
select * from invoice
select * from invoice_line
select * from media_type
select *from playlist
select *from playlist_track
select *from track


/* 1.  Who is the senior most employee based on job title ? */

select * from employee
order by levels desc
limit 1

/* 2. Which country have the most invoices ? */

select count(*),billing_country
from invoice
group by billing_country
limit 1

/* 3. What are top 3 values of total invoices ? */

select *
from invoice
order by total desc
limit 3

 /* Which city has the best customers ? We would like to throw a promotional Music Festival in the
    city we made the most money. Write a query that returns one city that has the highest 
    sum of invoice totals. Return both the city_name and sum of all invoice total. */

select billing_city as city_name , sum(total) as total_invoice
from invoice
group by billing_city
order by total_invoice desc

/* Who is the best customer ? The customer who has spent the most money will be declared the best 
   customer . Write a query that returns the person who has spent the most money. */

select (customer.customer_id),(customer.first_name),(customer.last_name)
from customer
inner join invoice 
on customer.customer_id=invoice.customer_id
group by customer.customer_id
order by total desc
limit 1

moderate level 

/*# Write query to return the email,first_name,last_name & Genre of all Rock music listeners.
  Return your list ordered alphabetically by email starting with "A". */

select distinct email,first_name,last_name
from customer
join invoice on customer.customer_id=invoice.customer_id
join invoice_line on invoice.invoice_id=invoice_line.invoice_id
where track_id in(
      select track_id from track
      join genre 
      on track.genre_id=genre.genre_id
      where genre.name="Rock"
)
order by email 

/*# Write a query to return Artist_id and total track count of the top 10 Rock bands. */

select artist.artist_id,count(artist.artist_id) as no_of_songs
from track
join album on album.album_id=track.album_id
join artist on artist.artist_id=album.artist_id
join genre on genre.genre_id=track.genre_id
where genre.name like "Rock"
group by artist.artist_id
order by no_of_songs desc
limit 10;

/* #  Write a query that return all the track names that have a song length greater than the average 
      song length. Return the names and milliseconds for each track . Order by the song length with the 
      longest songs listed first. */

select name,milliseconds
from track
where milliseconds > (
       select avg(milliseconds) as avg_track_length
       from track
)
order by milliseconds desc
