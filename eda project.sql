-- exploratory data analysis

select*
from layoff_staging2;

select max(total_laid_off), max(percentage_laid_off)
from layoff_staging2;

select*
from layoff_staging2
where percentage_laid_off = 1
order by funds_raised_millions desc;

select company, sum(total_laid_off)
from layoff_staging2
group by company 
order by 2 desc;


select*
from layoff_staging2;

select year(`date`), sum(total_laid_off)
from layoff_staging2
group by year(`date`) 
order by 1 desc;




select substring(`date`,1,7) AS `MONTHS`, SUM(total_laid_off) 
from layoff_staging2
WHERE substring(`date`,1,7) IS NOT NULL
GROUP BY `MONTHS`
order by 1 ASC
;


with rolling_Total AS
(
select substring(`date`,1,7) AS `MONTHS`, SUM(total_laid_off)  as total_off
from layoff_staging2
WHERE substring(`date`,1,7) IS NOT NULL
GROUP BY `MONTHS`
order by 1 ASC
)

select `MONTHS`, total_off
,sum(total_off) over(order by `MONTHS` ) as rolling_total
from Rolling_total;


select company, sum(total_laid_off)
from layoff_staging2
group by company 
order by 2 desc;

select company, year(`date`), sum(total_laid_off)
from layoff_staging2
group by company ,year(`date`)
order by 3 desc;

with Company_year (company, years, total_laid_off) as
(
select company, year(`date`), sum(total_laid_off)
from layoff_staging2
group by company ,year(`date`)
), company_year_rank as 
(select*, 
dense_rank() over (partition by years order by total_laid_off desc) as ranking
from company_year
where years is not null 
)
select*
from company_year_rank
where ranking <= 5;



