/*
 * Compute the country with the most customers in it. 
 */

SELECT country
FROM (
    SELECT country, COUNT(customer_id) AS customer_count
    FROM customer
    JOIN address ON (customer.address_id = address.address_id)
    JOIN city ON (address.city_id = city.city_id)
    JOIN country ON (city.country_id = country.country_id)
    WHERE country.country != 'United States'
    GROUP BY country.country
    ORDER BY customer_count DESC
) t1
LIMIT 1;
