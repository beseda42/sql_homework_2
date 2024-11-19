-- Блиц-задание: вывести id, name товара, количество складов, на которых он хранится и суммарное кол-во товара на складах

SELECT Good.id, Good.name, COUNT(Good_Warehouse.id_Warehouse), COALESCE(SUM(Good_Warehouse.count), 0)  
FROM Good LEFT OUTER JOIN Good_Warehouse ON (Good.id = Good_Warehouse.id_Good)
GROUP BY (Good.id, Good.name)

-- Блиц-задание: вывести id, name магазина и количество уникальных категорий товаров, которые продают в этом магазине

SELECT Shop.id, Shop.name, COUNT(DISTINCT GoodCategory.id) FROM GoodCategory JOIN Good ON (GoodCategory.id = Good.id_GoodCategory) JOIN Good_Shop ON (Good.id = Good_Shop.id_Good) JOIN Shop ON (Good_Shop.id_Shop = Shop.id)
GROUP BY (Shop.id, Shop.name)

-- Д/З 1: вывести id, name товаров, которые представлены в магазинах в наименьшем количестве 

SELECT DISTINCT Good.id, Good.name FROM Good JOIN Good_Shop ON (Good.id = Good_Shop.id_Good) 
GROUP BY (Good.id, Good.name, Good_Shop.count)
HAVING Good_Shop.count = (SELECT MIN(Good_Shop.count) FROM Good_Shop)

-- Д/З 2: вывести id, name товаров, суммарное количество которых на всех складах максимально

SELECT Good.id, Good.name FROM Good
LEFT OUTER JOIN Good_Warehouse ON (Good.id = Good_Warehouse.id_Good)
GROUP BY Good.id, Good.name
HAVING COALESCE(SUM(Good_Warehouse.count), 0) = 
(SELECT MAX(total) FROM 
(SELECT COALESCE(SUM(Good_Warehouse.count), 0) AS total
FROM Good
LEFT OUTER JOIN Good_Warehouse ON (Good.id = Good_Warehouse.id_Good)
GROUP BY Good.id, Good.name
))