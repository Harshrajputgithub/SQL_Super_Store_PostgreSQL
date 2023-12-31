--1. Who is the senior most employee based on job title?
select * from employee order by levels desc limit 1

--2. Which countries have the most Invoices?

select count(*) as "Noofinvoice", billing_country from invoice 
group by billing_country order by count(*) desc limit 1

--3. What are top 3 values of total invoice?

select total from invoice order by total desc limit 3

--4. Which city has the best customers? We would like to throw a promotional Music
--Festival in the city we made the most money. Write a query that returns one city that
--has the highest sum of invoice totals. Return both the city name & sum of all invoice
--totals

select * from invoice
select billing_city, sum(total) from invoice group by billing_city 
order by sum(total) desc limit 1

--5. Who is the best customer? The customer who has spent the most money will be
--declared the best customer. Write a query that returns the person who has spent the
--most money

select * from customer
select * from invoice
select customer.customer_id,customer.first_name,customer.last_name,sum(invoice.total) from invoice inner join customer 
ON 
invoice.customer_id=customer.customer_id group by customer.customer_id
order by sum desc limit 1


--1. Write query to return the email, first name, last name, & Genre of all Rock Music
--listeners. Return your list ordered alphabetically by email starting with A

select distinct customer.email, customer.first_name,customer.last_name,genre.name from customer join invoice ON customer.customer_id=invoice.customer_id
join invoice_line ON invoice.invoice_id=invoice_line.invoice_id
Join track ON track.track_id=invoice_line.track_id
Join genre ON genre.genre_id=track.genre_id 
where genre.name='Rock'
order by customer.email

--2. Let's invite the artists who have written the most rock music in our dataset. Write a
--query that returns the Artist name and total track count of the top 10 rock bands

select artist.artist_id,artist.name,count(artist.artist_id) from artist join album ON artist.artist_id=album.artist_id
Join track ON track.album_id=album.album_id 
Join genre ON genre.genre_id=track.genre_id 
where genre.name='Rock'
group by artist.artist_id
order by count(artist.artist_id) desc
limit 10

--3. Return all the track names that have a song length longer than the average song length.
--Return the Name and Milliseconds for each track. Order by the song length with the
--longest songs listed first

select name,milliseconds from track
where milliseconds > (select avg(milliseconds) from track)

--1. Find how much amount spent by each customer on artists? Write a query to return
--customer name, artist name and total spent

with best_selling_artist as(
select artist.artist_id,artist.name,sum(invoice_line.unit_price*invoice_line.quantity) from invoice_line join track ON invoice_line.track_id=track.track_id
join album ON album.album_id=track.album_id
Join artist ON artist.artist_id=album.artist_id
group by artist.artist_id
order by sum desc
limit 1)

select customer.customer_id,customer.first_name,customer.last_name,best_selling_artist.name,
sum(invoice_line.unit_price*invoice_line.quantity)
from invoice
join customer ON customer.customer_id=invoice.customer_id
join invoice_line ON invoice_line.invoice_id=invoice.invoice_id
join track ON track.track_id=invoice_line.track_id
join album ON album.album_id=track.album_id
join best_selling_artist ON album.artist_id=best_selling_artist.artist_id
group by 1,2,3,4
order by 5 desc





