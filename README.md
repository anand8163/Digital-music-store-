# Digital-music-store-Analysis

#Objective:-

In this project I have examine the dataset with PostgreSQL(Pgadmin v4) and help the store understand its business growth.

Features :-

/* Q1: Who is the senior most employee based on job title? */

select * from employee

ORDER BY title DESC

limit 1

![Screenshot (1)](https://user-images.githubusercontent.com/125815238/235422841-d5b204af-b869-4f98-b371-c94af9955be2.png)

/* Q2: Which country has the most invoices? */

select count(*) as c,billing_country from invoice

group by billing_country

order by c desc
![Screenshot (2)](https://user-images.githubusercontent.com/125815238/235423372-22b38add-9062-49f3-a862-11d67c3d4b44.png)

/* Q3: What are top 3 values of total invoice? */

Select total from invoice

ORDER BY total DESC

limit 3
![Screenshot (3)](https://user-images.githubusercontent.com/125815238/235424241-a4807b23-5d70-4138-bc20-ea4a0e1e2a2b.png)

/* Q4: Which city has the best customers? we would like
to throw a promotional music festival in the city we made
the most money. Write a query that returns one city that has  
the highest sum of invoice totals. Return both the city name 
& sum of all invoice totals*/

Select SUM(total) as invoice_total, billing_city from invoice

group by billing_city

order by invoice_total desc

limit 1
![Screenshot (4)](https://user-images.githubusercontent.com/125815238/235424454-546b86b6-430b-426a-a9d2-3eb3a82cd349.png)

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
![Screenshot (5)](https://user-images.githubusercontent.com/125815238/235424732-4e747d5f-620a-4a66-b62e-2108c6516e0c.png)

/* Q6 Write query to return the email,first_name,last_name & genre of all 
Rock music listeners. Return your list order alphabetically by email 
starting with A */

select DISTINCT email,first_name,last_name from customer 

JOIN invoice ON customer.customer_id = invoice.customer_id

JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id 

WHERE track_id IN
(

SELECT track_id FROM track
  
  JOIN genre ON track.genre_id = genre.genre_id
  
  where genre.name LIKE 'Rock'

)

ORDER BY email;
![Screenshot (6)](https://user-images.githubusercontent.com/125815238/235425334-cd6053f1-c798-4d5e-8c54-4af27cac7cef.png)

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
![Screenshot (7)](https://user-images.githubusercontent.com/125815238/235425610-95d1a320-2b36-484a-9c0b-01361ad5e7a4.png)

/* Q8 Return all the track names that have a song length longer than the 
average song length. Return the name and milliseconds for each track. 
Order by the song length with the longest song listed first.*/

select name,milliseconds from track

where milliseconds > (

select AVG(milliseconds) as avg_track_length

from track)

ORDER BY milliseconds DESC
![Screenshot (8)](https://user-images.githubusercontent.com/125815238/235425783-1a17e024-db32-4dc1-9269-23da5eefc2fc.png)
