SELECT 
    city.name
FROM
    city
WHERE 
    city.CountryCode =(
        SELECT 
            country.code
        FROM 
            country
        WHERE 
            country.code = 'AFG'
    )