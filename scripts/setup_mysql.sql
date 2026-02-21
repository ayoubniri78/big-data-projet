-- ============================================================
-- setup_mysql.sql
-- Création et peuplement de la table `ventes` dans la BDD bigdata
-- ============================================================

USE bigdata;

DROP TABLE IF EXISTS ventes;

CREATE TABLE ventes (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    produit     VARCHAR(100) NOT NULL,
    categorie   VARCHAR(50)  NOT NULL,
    quantite    INT          NOT NULL,
    prix_unitaire DECIMAL(10,2) NOT NULL,
    montant_total DECIMAL(10,2) GENERATED ALWAYS AS (quantite * prix_unitaire) STORED,
    date_vente  DATE         NOT NULL,
    region      VARCHAR(50)  NOT NULL
);

INSERT INTO ventes (produit, categorie, quantite, prix_unitaire, date_vente, region) VALUES
('Laptop Pro 15',    'Informatique',  3,  1299.99, '2024-01-05', 'Casablanca'),
('Souris sans fil',  'Accessoires',  15,    29.99, '2024-01-06', 'Rabat'),
('Clavier mécanique','Accessoires',   8,    89.99, '2024-01-07', 'Agadir'),
('Écran 27 pouces',  'Informatique',  5,   349.99, '2024-01-08', 'Fès'),
('Smartphone X12',   'Mobile',       10,   699.99, '2024-01-09', 'Marrakech'),
('Tablette 10"',     'Mobile',        4,   399.99, '2024-01-10', 'Casablanca'),
('Casque Bluetooth', 'Audio',        12,    79.99, '2024-01-11', 'Rabat'),
('Webcam HD',        'Accessoires',   7,    59.99, '2024-01-12', 'Agadir'),
('Disque SSD 1To',   'Stockage',      9,   119.99, '2024-01-13', 'Fès'),
('Clé USB 64Go',     'Stockage',     25,    12.99, '2024-01-14', 'Marrakech'),
('Router WiFi 6',    'Réseau',        6,   149.99, '2024-01-15', 'Casablanca'),
('Switch 8 ports',   'Réseau',        3,    89.99, '2024-01-16', 'Rabat'),
('Imprimante laser', 'Impression',    2,   299.99, '2024-01-17', 'Agadir'),
('Encre HP noire',   'Impression',   20,    18.99, '2024-01-18', 'Fès'),
('Batterie externe', 'Mobile',       18,    39.99, '2024-01-19', 'Marrakech'),
('Hub USB-C',        'Accessoires',  11,    44.99, '2024-01-20', 'Casablanca'),
('Laptop Ultra 13',  'Informatique',  2,  1499.99, '2024-01-21', 'Rabat'),
('Enceinte BT',      'Audio',         9,    99.99, '2024-01-22', 'Agadir'),
('Carte graphique',  'Informatique',  1,   599.99, '2024-01-23', 'Fès'),
('Tapis de souris',  'Accessoires',  30,     9.99, '2024-01-24', 'Marrakech');

SELECT 'Table ventes créée avec succès.' AS message;
SELECT categorie, COUNT(*) AS nb_produits, SUM(quantite) AS total_qte
FROM ventes
GROUP BY categorie;