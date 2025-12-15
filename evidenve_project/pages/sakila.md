# LAB 1

Author : Miranda Lyng

```sql all_movies
SELECT * FROM sakila.film;
```

<DataTable title= "List and search of all movies" data={all_movies} search=true />

# Task 1

## A. Movies longer than 3 hours (180 minutes)

```sql movies_over_3hours
SELECT
    title,
    length
FROM sakila.film
WHERE length > 180
ORDER BY length desc;
```

<DataTable data={movies_over_3hours} title={"Data table of movies over 3 hours"} >
<Column id=title />
<Column id=length contentType=colorscale colorScale={['#cc0000', '#e74e4eff', '#ecb8b8ff']}/>
</DataTable>

## B. Which movies have the word "love" in its title?

```sql title_love
SELECT
    title,
    rating,
    length,
    description
FROM sakila.film
WHERE
    regexp_matches(title, '\\bLOVE\\b');
```

<DataTable data={title_love} title= "Movies with 'LOVE' in the title"> </DataTable>

## C. Statistics of movie-length

(In minutes)

```sql statistics_length
select 'Longest movie' as name, MAX(length) as value from sakila.film
union all
select 'Shortest movie' as name, MIN(length) as value from sakila.film
union all
select 'Average movie length' as name, ROUND(AVG(length)) as value from sakila.film
union all
select 'Median movie length' as name, MEDIAN(length) as value from sakila.film
```

<ECharts config={{
    tooltip: { formatter: '{b}: {c} ({d}%)' },
    legend: { orient: 'vertical', right: 'right' },
    color: ['#5470C6', '#91CC75', '#EE6666', '#FAC858'],
    series: [
        {
            name: 'Film Length Stats',
            type: 'pie',
            radius: ['30%', '55%'],
            avoidLabelOverlap: true,
            data: [...statistics_length],
            label: { show: true, formatter: '{b}: {c} ({d}%)' }
        }
    ]
}}/>

## D. The 10 most expensive movies to rent per day

```sql ten_most_expensive_per_day
SELECT
    title,
    rental_duration,
    rental_rate,
    (rental_rate / rental_duration) as cost_per_day
FROM sakila.film
ORDER BY cost_per_day desc LIMIT 10
;

```

<DataTable data={ten_most_expensive_per_day} title="Rental cost per day">
    <Column id=title />
    <Column id=rental_duration align=center/>
    <Column id=rental_rate align=center/>
    <Column id=cost_per_day align=center/>
</DataTable>

## E. Top 10 actors with the number of movies they have played in.

```sql actors
SELECT
actor_id,
first_name || ' ' || last_name as actor,
count(film_id) as nr_of_movies
FROM sakila.top_actors
GROUP BY actor_id, actor
ORDER BY nr_of_movies DESC LIMIT 10;

```

<DataTable data={actors} title = "Top 10 Actors"/>

<BarChart 
    title = "Top 10 actors chart"
    data={actors}
    x=actor
    y=nr_of_movies
    series=actor
/>

## F. More analytics from the Sakila Database

### 1. Are there customers which have rented the same movie more than once?

```sql rent_times_per_customer
SELECT
    first_name || ' ' || last_name as customer_name,
    film_id,
    title as movie_title,
    customer_id,
    COUNT(*) as times_rented_same_movie
FROM sakila.rent_per_customer
GROUP BY
    first_name,
    last_name,
    film_id,
    Movie_title,
    customer_id
ORDER BY
    times_rented_same_movie DESC;

```

<DataTable data={rent_times_per_customer} search = true title = "Rented Times - search for customer/movie title/times rented">
<Column id = customer_name align=left/>
<Column id = movie_title align=left/>
<Column id=times_rented_same_movie align=center contentType=colorscale colorScale={['#62947bff','#75b696ff','#aaf5cfff']}/>  
</DataTable>

### 2. Top 10 rental customers

```sql top_10_rental_customers
SELECT
    first_name || ' ' || last_name as customer,
    customer_id,
    ROUND(SUM(amount)) AS total_rent_amount,
FROM sakila.top_10_renting_customers
GROUP BY
    customer_id,
    customer
ORDER BY
    total_rent_amount DESC LIMIT 10;
```

<DataTable data={top_10_rental_customers} title="Top 10 renting customers (amount in USD)">
<Column id = customer_id align=left/>
<Column id= customer/>
<Column id=total_rent_amount align=center contentType=colorscale fmt=usd/>  
</DataTable>

### 3. What is the total sum of payments each staff has handled?

```sql staff_handled_pay
SELECT
    staff_id,
    first_name || ' ' || last_name as staff_name,
    SUM(amount) as total_sum_rentedout_movies

GROUP BY
    staff_id,
    staff_name
ORDER BY
    total_sum_rentedout_movies DESC;

```

<BarChart
title = "Sum of payments handled (in USD)"
data={staff_handled_pay}
x=staff_name
y=total_sum_rentedout_movies
yFmt=usd
swapXY=true
/>

# Task 2

## A. Top 5 paying customers

```sql top_5_rental_customers
SELECT
    first_name || ' ' || last_name as customer,
    customer_id,
    ROUND(SUM(amount)) AS total_rent_amount,
FROM sakila.top_10_renting_customers
GROUP BY
    customer_id,
    customer
ORDER BY
    total_rent_amount DESC LIMIT 5;
```

<DataTable data={top_5_rental_customers} title="Top 5 renting customers (in USD)">
<Column id = customer_id align=left/>
<Column id= customer/>
<Column id=total_rent_amount align=center contentType=colorscale fmt=usd/>  
</DataTable>

<FunnelChart 
    title="Top 5 paying customers(in USD) - Funnel chart"
    data={top_5_rental_customers} 
    nameCol=customer
    valueCol=total_rent_amount
    valueFmt=usd
    funnelSort=descending
/>

## B. How much money does each film category bring in?

```sql earnings_per_film_category
SELECT
    film_category_name,
    SUM(amount) as earnings
FROM
    sakila.income_per_film_category
GROUP BY
    film_category_name
ORDER BY
    earnings DESC,
    film_category_name;
```

<BarChart 
    title = "Earnings per film category (in USD)"
    data={earnings_per_film_category}
    x=film_category_name
    y=earnings
    series=film_category_name
    yFmt=usd
/>

## Top 10 cities with the most movies rented out

Bonus

```sql rentals_per_city
SELECT
    city,
    COUNT(rental_count) as rental_cnt
FROM
    sakila.rentals_per_city
GROUP BY

    city,

ORDER BY
    rental_cnt desc
LIMIT 10;

```

<BarChart
title = "Top 10 cities for rented movies"
data={rentals_per_city}
x=city
y=rental_cnt
swapXY=true
/>
