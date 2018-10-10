use sakila

select * from actor

select first_name, last_name from actor

select concat( first_name, ' ', last_name ) as "Actor_Name" from actor

select actor_id, first_name, last_name
from actor 
where lower( first_name) = 'joe'

select * from actor
where upper( last_name) like '%GEN%'

select * from actor
where upper( last_name) like '%LI%'
order by last_name, first_name

-- Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:

select country_id, country
from country
where country in ( 'Afghanistan', 'Bangladesh', 'China' )

alter table actor add column description blob

alter table actor drop column description

select last_name , count(last_name)
from actor
group by last_name

select last_name , count(last_name)
from actor
group by last_name
having count(last_name) > 1

update actor
set first_name = 'HARPO'
where first_name = 'GROUCHO'
and last_name = 'WILLIAMS'

update actor
set first_name = 'GROUCHO'
where first_name = 'HARPO'
and last_name = 'WILLIAMS'

show create table address
-- ---------------------
select * from payment
where payment_date >= '2005-08-01' and payment_date <'2005-09-01'

select first_name, last_name, 
	address, city, postal_code
from staff, address, city
where staff.address_id = address.address_id
	and address.city_id = city.city_id
    
select s.first_name, s.last_name, sum(p.amount)
from staff s, payment p
where s.staff_id = p.staff_id
	and  payment_date >= '2005-08-01' and payment_date <'2005-09-01'
group by s.first_name, s.last_name

-- 6c--------------------------------

select f.title, count( fa.actor_id) no_of_actors
from film f, film_actor fa
where f.film_id = fa.film_id
group by f.title 

-- 6d -----------------
select * from inventory

select f.title, count(1) no_of_copies
from film f, inventory i
where f.film_id = i.film_id
	and f.title = 'Hunchback Impossible'
    
-- 6e ---------------
select * from customer

select s.first_name, s.last_name, sum(p.amount)
from customer s, payment p
where s.customer_id = p.customer_id
group by s.first_name, s.last_name
order by last_name 

-- 7a --------------------
select * From language

select * from film
where title like 'K%' or title like 'Q%'
and language_id in (
	select language_id from language
    where name = 'English' 
    )

--  7b --------------------------

select * from actor
where actor_id in (
	select actor_id from film_actor
    where film_id in (
		select film_id from film
        where title= 'Alone Trip'
		)
    )
    
-- 7c ----------------

select cu.first_name, cu.last_name, cu.email, cr.country
from customer cu,
	address a,
    city cy,
    country cr
where cu.address_id = a.address_id
	and a.city_id = cy.city_id
    and cy.country_id = cr.country_id
    and cr.country = 'Canada'
    
-- 7d --------------------
select * 
from film f,
	film_category fc,
    category c
where f.film_id = fc.film_id
	and fc.category_id = c.category_id
    and c.name = 'Family'
    
-- 7e --------------------
select title, count( r.rental_id) rental_frequency
From film f, inventory i, rental r
where f.film_id = i.film_id
	and i.inventory_id = r.inventory_id
group by title
order by rental_frequency desc

-- 7f-----------------
select s.store_id, sum(p.amount) total_business
from rental r, 
	staff s,
    payment p
where r.rental_id = p.rental_id
	and r.staff_id = s.staff_id
group by s.store_id

-- 7g ------------------
select s.store_id, 
	c.city,
    cc.country
from store s,
	address a,
    city c,
    country cc
where s.address_id = a.address_id
	and a.city_id = c.city_id
    and c.country_id = cc.country_id
    
-- 7h ---------------
category, film_category, inventory, payment, and rental

select c.name, sum(p.amount) gross_Revenue
from category c, film_category fc , inventory i,  payment p, 
	rental r
where fc.category_id = c.category_id
	and fc.film_id = i.film_id
    and i.inventory_id = r.inventory_id
     and r.rental_id = p.rental_id
	group by c.name
    order by gross_Revenue desc 
    limit 5
    
-- 8a-------

create view top5_Gross_genres as
select c.name, sum(p.amount) gross_Revenue
from category c, film_category fc , inventory i,  payment p, 
	rental r
where fc.category_id = c.category_id
	and fc.film_id = i.film_id
    and i.inventory_id = r.inventory_id
     and r.rental_id = p.rental_id
	group by c.name
    order by gross_Revenue desc 
    limit 5
    
-- 8b -----------------
select * from top5_Gross_genres

--
-- 8b ------------
drop view top5_Gross_genres