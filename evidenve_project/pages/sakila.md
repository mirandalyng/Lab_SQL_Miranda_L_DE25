# BI - Report

LAB 1- Task 3

## Movies longer than 3 hours (180 minutes)

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

## Which movies have the word "love" in its title? Show the following columns

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

## Statistics of movie-length

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
            radius: ['40%', '70%'],
            avoidLabelOverlap: true,
            data: [...statistics_length],
            label: { show: true, formatter: '{b}: {c} ({d}%)' }
        }
    ]
}}/>
