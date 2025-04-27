# 🎬 Netflix Movies & TV Shows Data Analysis using SQL
  🚀 Unveiling trends in Netflix content to drive data-backed decision-making!

![](https://github.com/Palak019/netflix_sql_project/blob/main/netflix%20logo.jpg)

## 📌 Overview
Netflix dominates the global streaming industry, but what drives its content strategy? This project uncovers:

✔️ How Netflix’s content library evolved over time

✔️ Which regions dominate content production

✔️ The most popular genres & ratings

✔️ Trends in Movies vs. TV Shows

✔️ Business insights to optimize content strategies

## Objectives
✅ Unveil Content Evolution – Analyze Netflix’s content expansion and production trends over time.

✅ Decode Regional Dominance – Identify top content-producing countries shaping Netflix’s global library.

✅ Explore Genre & Rating Patterns – Discover audience preferences through genre popularity and rating trends.

✅ Contrast Content Formats – Compare the dominance of Movies vs. TV Shows across different years.

✅ Spotlight Creative Minds – Highlight top directors and analyze content duration trends.

✅ Empower Strategic Decisions – Deliver data-driven insights to optimize content curation and audience engagement. 🚀

## 📊 Dataset

 📥 Source: [Netflix Kaggle Dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)

## Schema

```sql
DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
    show_id      VARCHAR(5),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);
```
## 📌 Business Problems & Insights

## 1. Duplicate Titles – Are Content Clones Common?
```sql
SELECT title, COUNT(*) AS count
FROM netflix
GROUP BY title
HAVING count(*) > 1;
```
🔍 Insight:  Some titles appear multiple times, possibly due to remakes, re-releases, or regional licensing variations. Netflix can optimize its catalog by reducing redundant content.

## 2. Movies vs. TV Shows – Which Format Dominates?
```sql
select type, 
count(*) as total_count
from netflix
group by type;
```
🔍 Insight:  While movies have historically dominated, TV Shows are gaining traction, likely due to higher engagement and binge-watching culture. Strategic Move: Invest more in original series!

## 3. Top 5 Countries Producing the Most Content
```sql
select country,
count(*) as content_count
from netflix
where country is not null
group by country
order by content_count desc
limit 5;
```
🔍 Insight: The USA, India, and the UK lead in content production, reflecting Netflix’s strong partnerships with Hollywood and Bollywood. Regional Focus: Expanding into emerging markets like Korea & Latin America can increase subscriber growth.

## 4. Most Common Ratings – What Does Netflix Prioritize?
```sql
select rating,
count(*) as rating_count
from netflix
where rating is not null
group by rating 
order by rating_count desc
limit 5;
```
🔍 Insight: A large share of content falls under TV-MA (Mature Audience), indicating Netflix’s focus on adult viewers. However, expanding family-friendly content (TV-Y, PG) could attract a broader demographic.

## 5. Year with the Most Releases
```sql
select release_year,
count(*) as release_count
from netflix
where release_year is not null
group by release_year
order by release_count  desc
limit 1;
```
🔍 Insight: Netflix's content production peaked in recent years, reflecting the global streaming boom. Identifying peak release years can help optimize future content strategies.

## 6. Content Trend Over the Years
```sql
select release_year,
count(*) as content_count
from netflix
group by release_year
order by release_year asc;
```
🔍 Insight: Content production has significantly increased in the last decade, proving Netflix’s aggressive expansion. Maintaining high-quality content while scaling up is key to sustaining growth.

## 7. Most Frequent Directors
```sql
select director,
count(*) as movie_count
from netflix
where director is not null
group by director
order by movie_count desc
limit 10;
```
🔍 Insight: A few directors have multiple projects on Netflix, showing strong relationships with top creators. Diversifying the director pool can bring fresh storytelling perspectives.

## 8. Most Popular Genres
```sql
select listed_in as Genres,
count(*) as genre_count
from netflix
where listed_in is not null
group by listed_in
order by genre_count desc
limit 5;
```
🔍 Insight: Drama, Comedy, and Documentaries dominate, but Thriller & Sci-Fi are on the rise. Netflix should monitor genre trends and invest in emerging categories.

## 9. TV Shows vs. Movies Per Year – Trend Analysis
```sql
select release_year,
		sum(case when type = 'Movie' then 1 else 0 end) as movie_count,
		sum(case when type = 'TV Show' then 1 else 0 end) as tv_show_count
from netflix
group by release_year
order by release_year;
```
🔍 Insight: The number of TV Shows is steadily increasing, reflecting a preference for long-term engagement. Balancing both formats ensures a diverse content strategy.

## 10. Most Common Movie Durations
```sql
select duration,
count(*) as DURATION_count
from netflix 
where type = 'Movie'
group by duration
order by DURATION_count desc
limit 5;
```
🔍 Insight: 90–120 minutes is the optimal movie length, aligning with audience attention spans. Shorter or excessively long movies may reduce viewer retention.

## 11. Countries with the Most TV Shows
```sql
select country,
count(type) as tv_show_count
from netflix
where type = 'TV Show' 
and country is not null
group by country 
order by tv_show_count desc;
```
🔍 Insight: The USA dominates, but South Korea is emerging as a content powerhouse (K-Dramas!). Investing in regional series can boost engagement.

## 12. Longest Running TV Shows
```sql
select title,
duration 
from netflix 
where type = 'TV Show'
order by duration desc
limit 5;
```
🔍 Insight: Longer-running TV shows indicate strong audience loyalty. Netflix should identify and promote successful long-term series for retention.

## 13. Countries Producing the Most Movies
```sql
select country,
count(type) as Movie_count
from netflix
where type = 'Movie'
and country is not null
group by country
order by Movie_count desc;
```
🔍 Insight: The USA, India, and the UK lead, but South Korea and Spain are growing rapidly. Expanding in high-demand regions ensures a competitive advantage.

## 14. Percentage of Content by Type
```sql
select type,
count(*) as content_count,
round(count(*)*100.0/(select count(*) from netflix),2) as percentage
from netflix
group by type
order by content_count desc;
```
🔍 Insight: Movies still dominate, but TV Shows are catching up. A hybrid content strategy will keep Netflix competitive.

## 15. Directors with the Most TV Shows
```sql
select director,
count(type) as director_count
from netflix
where type = 'TV Show'
and director is not null
group by director
order by director_count desc
limit 5;
```
🔍 Insight: Some directors specialize in high-impact series. Strengthening collaborations with proven talent can enhance Netflix’s content quality.

## 16. Most Recent Movie Releases
```sql
select title,
release_year
from netflix
where type = 'Movie'
order by release_year desc
limit 5;
```
🔍 Insight: Recent releases align with audience demand trends. Strategic release timing can maximize engagement and viewership.

## 17. Most Recent TV Shows
```sql
select title,
release_year
from netflix
where type = 'TV Show'
order by release_year desc
limit 5;
```
🔍 Insight: New TV Shows highlight Netflix’s evolving content strategy. Analyzing audience response can improve future content investments.

## 18. Directors Who Directed Multiple Genres
```sql
select director,
count(distinct listed_in) as total_genres
from netflix
where director is not null
group by director 
having count(distinct listed_in) > 1
order by  total_genres desc;
```
🔍 Insight: Versatile directors bring diverse storytelling perspectives. Netflix should leverage multi-genre directors to reach wider audiences.

## 19. Content Availability by Region
```sql
select country as Region,
count(*) as total_content
from netflix
where country is not null
group by country
order by total_content desc;
```
🔍 Insight: Netflix heavily invests in certain regions. Expanding underrepresented markets can broaden its global subscriber base.

## 20. Content Added Per Month – Seasonal Trends
```sql
SELECT SUBSTR(date_added, 1, POSITION(' ' IN date_added) - 1) AS month , count(*) as content_count
FROM netflix
WHERE date_added IS NOT NULL
GROUP BY month
ORDER BY content_count DESC;
```
🔍 Insight: Content additions peak in holiday months, optimizing engagement. Planning major releases during peak periods can maximize viewership.

## 21. Which countries lead content production each year?
```sql
select country,
release_year,
count(*) as content_count,
rank() over (partition by release_year ORDER BY count(*)  DESC) AS rank
from netflix
where country is not null
group by release_year , country
order by release_year desc , rank;
 ```
🔍 Insight: Regions with steady content expansion indicate high engagement. Netflix should prioritize these areas for future content investments.

## 22. How do content ratings change yearly?
```sql
with rating_per_year as (
	select rating,
	release_year,
	count(*) as rating_count,
	rank() over(partition by release_year order by count(*) desc) as rank
	from netflix
	where rating is not null
	group by rating,release_year
)
select rating,
release_year,
rating_count
from rating_per_year
where rank = 1
order by release_year;
```
🔍 Insight: Rating preferences shift over time, showing changes in audience demand. Tailoring content based on historical data can improve engagement.

## 23. What are the top trending genres each year?
```sql
with genre_rank as(
		select release_year,
		listed_in as genre,
		count(*) as genre_count,
		rank() over(partition by release_year order by count(*) desc) as rank
		from netflix
		group by release_year , genre
) 
select release_year,
genre,
genre_count
from genre_rank
where rank <= 3
order by release_year desc , rank;
```
🔍 Insight: Certain genres gain or lose popularity annually. Tracking genre shifts helps align content strategy with audience demand.

## 24. Identify Countries with Consistent Content Growth
```sql
WITH content_growth AS (
    SELECT 
        country, 
        release_year, 
        COUNT(*) AS content_count,
        LAG(COUNT(*)) OVER (PARTITION BY country ORDER BY release_year) AS prev_year_count
    FROM netflix
    WHERE country IS NOT NULL
    GROUP BY country, release_year
)
SELECT 
    country, 
    release_year, 
    content_count, 
    prev_year_count,
    content_count - prev_year_count AS growth
FROM content_growth
WHERE prev_year_count IS NOT NULL
ORDER BY country, release_year DESC;
```
🔍 Insight: Regions with steady content expansion indicate high engagement. Netflix should prioritize these areas for future content investments.

## 📊 Key Takeaways & Business Recommendations

✅ Invest in Regional Content – Expanding into emerging markets like South Korea & Latin America can drive global growth.


✅ Balance Movies & TV Shows – With the rise of binge culture, more investment in original TV Shows can boost engagement.


✅ Leverage Data for Content Planning – Align new content drops with peak engagement periods (holidays & weekends).


✅ Expand Family-Friendly Content – With most content being TV-MA, increasing PG & TV-Y shows can attract a broader audience.


✅ Optimize Movie Length – Keeping movies in the 90–120 min range ensures maximum viewer retention.




















