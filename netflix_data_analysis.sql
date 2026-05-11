
SELECT * FROM [dbo].[netflix_raw]; 



drop table [dbo].[netflix_raw]; 


create TABLE [dbo].[netflix_raw](
	[show_id] [varchar](10) primary key,
	[type] [varchar](10) NULL,
	[title] [nvarchar](200) NULL,
	[director] [varchar](250) NULL,
	[cast] [varchar](1000) NULL,
	[country] [varchar](150) NULL,
	[date_added] [varchar](20) NULL,
	[release_year] [int] NULL,
	[rating] [varchar](10) NULL,
	[duration] [varchar](10) NULL,
	[listed_in] [varchar](100) NULL,
	[description] [varchar](500) NULL
);


select * from netflix_raw
where show_id = 's5023';


with cte as (
select * 
,ROW_NUMBER() over(partition by title , type order by show_id) as rn
from netflix_raw
)
select show_id,type,title, cast(date_added as date) as date_added,release_year,
rating,duration,description
from
cte 
where rn=1;

with cte as (
select * 
,ROW_NUMBER() over(partition by title , type order by show_id) as rn
from netflix_raw
)
select show_id,type,title,cast(date_added as date) as date_added,release_year
,rating,case when duration is null then rating else duration end as duration,description
into netflix
from cte 


select show_id, trim(value) as genre
into netflix_genre
from netflix_raw
cross apply string_split(listed_in,',');


 

SELECT
  director,
  country
FROM netflix_country nc
INNER JOIN netflix_directors nd
  ON nc.show_id = nd.show_id
GROUP BY
  director,
  country
ORDER BY
  director;


SELECT 
    nd.director,
    COUNT(DISTINCT CASE WHEN n.type = 'Movie' THEN n.show_id END) AS no_of_movies,
    COUNT(DISTINCT CASE WHEN n.type = 'TV Show' THEN n.show_id END) AS no_of_tvshow
FROM netflix n
INNER JOIN netflix_directors nd ON n.show_id = nd.show_id
GROUP BY nd.director
HAVING COUNT(DISTINCT n.type) > 1;


select  top 1 nc.country , COUNT(distinct ng.show_id ) as no_of_movies
from netflix_genre ng
inner join netflix_country nc on ng.show_id=nc.show_id
inner join netflix n on ng.show_id=nc.show_id
where ng.genre='Comedies' and n.type='Movie'
group by  nc.country
order by no_of_movies desc


with cte as (
select nd.director,YEAR(date_added) as date_year,count(n.show_id) as no_of_movies
from netflix n
inner join netflix_directors nd on n.show_id=nd.show_id
where type='Movie'
group by nd.director,YEAR(date_added)
)
, cte2 as (
select *
, ROW_NUMBER() over(partition by date_year order by no_of_movies desc, director) as rn
from cte
--order by date_year, no_of_movies desc
)
select * from cte2 where rn=1



select ng.genre , avg(cast(REPLACE(duration,' min','') AS int)) as avg_duration
from netflix n
inner join netflix_genre ng on n.show_id=ng.show_id
where type='Movie'
group by ng.genre


 

 select nd.director
, count(distinct case when ng.genre='Comedies' then n.show_id end) as no_of_comedy 
, count(distinct case when ng.genre='Horror Movies' then n.show_id end) as no_of_horror
from netflix n
inner join netflix_genre ng on n.show_id=ng.show_id
inner join netflix_directors nd on n.show_id=nd.show_id
where type='Movie' and ng.genre in ('Comedies','Horror Movies')
group by nd.director
having COUNT(distinct ng.genre)=2;


select * from netflix_genre where show_id in 
(select show_id from netflix_directors where director='Steve Brill')
order by genre