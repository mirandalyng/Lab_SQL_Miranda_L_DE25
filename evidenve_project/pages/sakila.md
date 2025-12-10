# BI - Report

LAB 1- Task 3

```sql all_movies
SELECT * FROM sakila.film;
```

<DataTable title= Movies data={all_movies} search=true />

## A. Movies longer than 3 hours (180 minutes)

```sql movies_over_3hours
SELECT
    title,
    length
FROM sakila.film
WHERE length > 180
ORDER BY length desc;
```

<DataTable data={movies_over_3hours} title={"Data table of the long movies"} >
<Column id=title />
<Column id=length contentType=colorscale/>
</DataTable>

## B. Which movies have the word "love" in its title? Show the following columns

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

<DataTable data={title_love}> </DataTable>

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

<DataTable data={ten_most_expensive_per_day}>
    <Column id=title />
    <Column id=rental_duration align=center/>
    <Column id=rental_rate align=center/>
    <Column id=cost_per_day/>
</DataTable>

## E. Which actors have played in most movies? Top 10 actors with the number of movies they have played in.

```sql actors
SELECT
actor_id,
first_name || ' ' || last_name as actor,
count(film_id) as nr_of_movies
FROM sakila.top_actors
GROUP BY actor_id, actor
ORDER BY nr_of_movies DESC LIMIT 10;

```

<DataTable data={actors} title = Top_Actors />

<BarChart 
    data={actors}
    x=actor
    y=nr_of_movies
    series=actor
/>

## F. More analytics from the Sakila Database

### 1. Are there customers which have rented the same movie more than once?

```sql rent_times_per_customer
SELECT
    first_name,
    last_name,
    film_id,
    customer_id,
    COUNT(*) as times_rented
FROM sakila.rent_per_customer
GROUP BY
    first_name,
    last_name,
    film_id,
    customer_id
ORDER BY
    times_rented DESC;

```

<DataTable data={rent_times_per_customer} title = "Rented Times" />

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

<DataTable data={top_10_rental_customers} titel="Top 10 renting customers">
<Column id = customer_id align=left/>
<Column id= customer/>
<Column id=total_rent_amount align=center contentType=colorscale fmt=usd/>  
</DataTable>
