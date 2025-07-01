--liquibase formatted sql

--changeset system:1-insert-role-data
--comment: Insertion des données de rôles
INSERT INTO ref_role (code, name, name_fr, created_by) VALUES
('ADMIN', 'Administrateur', 'Administrateur', 'system'),
('ENQ', 'Interrogation', 'Interrogation', 'system'),
('UDW', 'Souscripteur', 'Souscripteur', 'system'),
('ACC', 'Comptabilite', 'Comptabilité', 'system'),
('CLM', 'Gestionnaire Sinistre', 'Gestionnaire Sinistre', 'system'),
('FIN', 'Gestionnaire Finance', 'Gestionnaire Finance', 'system'),
('UDW_MNG', 'Souscripteur Senior', 'Souscripteur Senior', 'system'),
('ACC_MNG', 'Comptable Senior', 'Comptable Senior', 'system'),
('MNG', 'Gestionnaire', 'Gestionnaire', 'system');

--changeset system:2-insert-function-data
--comment: Insertion des données de fonctions
INSERT INTO ref_function (code, name_fr, description_fr, created_by) VALUES
('MNT_CTR', 'Maintenance Police', 'Maintenance des polices', 'system'),
('REF_PRT', 'Partenaires', 'Gestion des partenaires', 'system'),
('REF_INS', 'Assurés', 'Gestion des assurés', 'system');

--changeset system:2a-insert-role-function-data
--comment: Insertion des données de référence de base
INSERT INTO ref_role_function (role_id, function_id, created_by) VALUES
                                                                     ((SELECT id FROM ref_role WHERE code = 'ADMIN'), (SELECT id FROM ref_function WHERE code = 'MNT_CTR'), 'tradi'),
                                                                     ((SELECT id FROM ref_role WHERE code = 'ADMIN'), (SELECT id FROM ref_function WHERE code = 'REF_PRT'), 'tradi'),
                                                                     ((SELECT id FROM ref_role WHERE code = 'ADMIN'), (SELECT id FROM ref_function WHERE code = 'REF_INS'), 'tradi');
--changeset system:3-insert-basic-reference-data
--comment: Insertion des données de référence de base
-- Insert basic region
INSERT INTO ref_region (code, name, name_fr, created_by) VALUES
('WAF', 'Afrique de l''Ouest', 'Afrique de l''Ouest', 'system');

-- Insert basic country
INSERT INTO ref_country (code, name, name_fr, region_id, created_by) VALUES
('CI', 'Côte d''Ivoire', 'Côte d''Ivoire', (SELECT id FROM ref_region WHERE name_fr = 'Afrique de l''Ouest'), 'system');

-- Insert basic city
INSERT INTO ref_city (code, name, name_fr, country_id, created_by) VALUES
('ABJ', 'Abidjan', 'Abidjan', (SELECT id FROM ref_country WHERE code = 'CI'), 'system');

-- Insert basic currency
INSERT INTO ref_currency (code, name, name_fr, created_by) VALUES
('XOF', 'Franc CFA', 'Franc CFA', 'system');

-- Insert basic period
INSERT INTO ref_period (year, month, name, start_date, end_date, created_by) VALUES
(2024, 1, 'Janvier 2024', '2024-01-01', '2024-01-31', 'system');

-- Insert basic partner type
INSERT INTO ref_partner_type (code, name, name_fr, created_by) VALUES
('COMP', 'Compagnie', 'Compagnie', 'system');

-- Insert basic partner
INSERT INTO ref_partner (code, name, short_name, partner_type_id, region_id, country_id, currency_id, created_by) VALUES
('RAMSYS', 'RAMSYS Insurance', 'RAMSYS', 
 (SELECT id FROM ref_partner_type WHERE code = 'COMP'),
 (SELECT id FROM ref_region WHERE name_fr = 'Afrique de l''Ouest'),
 (SELECT id FROM ref_country WHERE code = 'CI'),
 (SELECT id FROM ref_currency WHERE code = 'XOF'),
 'system');

--changeset system:4-insert-location-data
--comment: Insertion des données de localisation
INSERT INTO ref_location (code, name, partner_id, city_id, currency_id, accounting_period_id, created_by) VALUES
('L1', 'Siège Abidjan', 
 (SELECT id FROM ref_partner WHERE code = 'RAMSYS'),
 (SELECT id FROM ref_city WHERE code = 'ABJ'),
 (SELECT id FROM ref_currency WHERE code = 'XOF'),
 (SELECT id FROM ref_period WHERE year = 2024 AND month = 1),
 'system');

--changeset system:5-insert-division-data
--comment: Insertion des données de division
INSERT INTO ref_division (code, name, location_id, created_by) VALUES
('F01', 'Facultative', (SELECT id FROM ref_location WHERE code = 'L1'), 'system'),
('T01', 'Traité', (SELECT id FROM ref_location WHERE code = 'L1'), 'system');

--changeset system:6-insert-user-data
--comment: Insertion des données utilisateurs
INSERT INTO ref_user_detail (username, password_hash, first_name, last_name, email, created_by) VALUES
('admin', '$2a$10$DowJonesPasswordHash123456789012345678901234567890', 'System', 'Administrator', 'admin@ramsys.local', 'system'),
('demo', '$2a$10$DemoPasswordHash1234567890123456789012345678901234', 'Demo', 'User', 'demo@ramsys.local', 'system');

--changeset system:7-insert-profit-centre-data
--comment: Insertion des données de centres de profit
INSERT INTO ref_profit_center (code, name, name_fr, location_id, division_id, manager_id, created_by) VALUES
('F1', 'Département Facultative', 'Département Facultative', (SELECT id FROM ref_location WHERE code = 'L1'), (SELECT id FROM ref_division WHERE code = 'F01'), (SELECT id FROM ref_user_detail WHERE username = 'admin'), 'system'),
('T1', 'Département Traité', 'Département Traité', (SELECT id FROM ref_location WHERE code = 'L1'), (SELECT id FROM ref_division WHERE code = 'T01'), (SELECT id FROM ref_user_detail WHERE username = 'admin'), 'system');
