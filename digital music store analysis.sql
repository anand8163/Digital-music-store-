    DIGITAL MUSIC STORE ANALYSIS

/* Q1: Who is the senior most employee based on job title? */

select * from employee
ORDER BY title DESC
limit 1

/* Q2: Which country has the most invoices? */

select count(*) as c,billing_country from invoice
group by billing_country
order by c desc

/* Q3: What are top 3 values of total invoice? */

Select total from invoice
ORDER BY total DESC
limit 3

/* Q4: Which city has the best customers? we would like
to throw a promotional music festival in the city we made
the most money. Write a query that returns one city that has  
the highest sum of invoice totals. Return both the city name 
& sum of all invoice totals*/

Select SUM(total) as invoice_total, billing_city from invoice
group by billing_city
order by invoice_total desc
limit 1

/* Q5 Who is the best customer? The customer who has spent
the most money will be declared the best customer. Write a 
query that returns the person who has spent the most money. */

select customer.customer_id, customer.first_name, customer.last_name,
SUM(invoice.total) as total
from customer
JOIN invoice 
ON invoice.customer_id = customer.customer_id
GROUP BY customer.customer_id
ORDER BY total desc
LIMIT 1

/* Q6 Write query to return the email,first_name,last_name & genre of all 
Rock music listeners. Return your list order alphabetically by email 
starting with A */

select DISTINCT email,first_name,last_name from customer 
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id 
WHERE track_id IN (
  SELECT track_id FROM track
  JOIN genre ON track.genre_id = genre.genre_id
  where genre.name LIKE 'Rock'
)
ORDER BY email;

/* Q7 Let's invite the artist who have written the most rock music in our
dataset. Write a query that returns the artist name and total track count 
of the top 10 rock bands*/

select artist.artist_id,artist.name,COUNT(artist.artist_id) as no_of_songs
from track
JOIN album ON album.album_id = track.album_id 
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
where genre.name LIKE 'Rock'
GROUP BY artist.artist_id
ORDER BY no_of_songs DESC
LIMIT 10;

/* Q8 Return all the track names that have a song length longer than the 
average song length. Return the name and milliseconds for each track. 
Order by the song length with the longest song listed first.*/

select name,milliseconds from track
where milliseconds > (
      select AVG(milliseconds) as avg_track_length
      from track)
ORDER BY milliseconds DESC
