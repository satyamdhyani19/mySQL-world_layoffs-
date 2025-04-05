SELECT * FROM world_layoffs.layoffs;

create table layoff_staging
like layoffs;


select*
from layoff_staging2;

insert layoff_staging
select*
from layoffs;

select*,
row_number() over(
partition by company, location, industry, total_laid_off, percentage_laid_off, `date`,stage, country, 
funds_raised_millions) as row_num
from layoff_staging;


with duplicate_cte as
(
select*,
row_number() over(
partition by company, location, industry, total_laid_off, percentage_laid_off, `date`,stage, country, 
funds_raised_millions) as row_num
from layoff_staging
)
select*
from duplicate_cte
where row_num > 1;


select*
from layoff_staging
where company = 'casper';

CREATE TABLE `layoff_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num`int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



select*
from layoff_staging2
where row_num > 1;

insert into layoff_staging2
select*,
row_number() over(
partition by company, location, industry, total_laid_off, percentage_laid_off, `date`,stage, country, 
funds_raised_millions) as row_num
from layoff_staging;


delete
from layoff_staging2
where row_num > 1;

select* from layoff_staging2;


-- Standardizing data


select company,trim(company) 
from layoff_staging2;

update layoff_staging2
set company = trim(company);

select* 
from layoff_staging2
where industry like 'crypto%';

update layoff_staging2
set industry = 'crypto'
where industry like 'crypto%';


select distinct country, trim(trailing'.' from country)
from layoff_staging2
order by 1;

update layoff_staging2
set country = trim(trailing'.' from country)
where country like 'united states%';

select `date`,
str_to_date(`DATE`,'%m/%d/%Y' )
from layoff_staging2;



update layoff_staging2
set `date`= str_to_date(`date`,' %m/%d/%Y');

alter table layoff_staging2
modify column `date` DATE;



select *
from layoff_staging2
where total_laid_off is null
and percentage_laid_off is null;

update layoff_staging2
set industry = null
where industry = '';





select *
from layoff_staging2
where industry is null 
or industry = ''; 

select t1.industry, t2.industry 
from layoff_staging2 t1
join layoff_staging2 t2
   on t1.location = t2.location
   where (t1.industry is null or t1.industry = '')
   and t2.industry is not null; 
   
update layoff_staging2 t1
join layoff_staging2 t2
   on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null 
and t2.industry is not null;  


select*
from layoff_staging2; 



alter table layoff_staging2
drop column row_num;



delete
from layoff_staging2
where total_laid_off is null
and percentage_laid_off is null; 












   