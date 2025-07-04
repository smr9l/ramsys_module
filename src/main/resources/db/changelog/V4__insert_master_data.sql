--liquibase formatted sql

--changeset tradi:1-insert-geo-data
--comment: Insertion des données de référence géographiques
INSERT INTO ref_region (name, name_fr, name_en, name_ar, created_by) VALUES
('N/A', 'N/A', 'N/A', NULL, 'tradi'),
('CIMA', 'CIMA', 'CIMA', NULL, 'tradi'),
('Hors CIMA Anglophone', 'Hors CIMA Anglophone', 'Non-CIMA English Speaking', NULL, 'tradi'),
('Hors CIMA Francophone', 'Hors CIMA Francophone', 'Non-CIMA French Speaking', NULL, 'tradi'),
('Autre', 'Autre', 'Other', NULL, 'tradi'),
('Monde Entier', 'Monde Entier', 'Worldwide', NULL, 'tradi');

INSERT INTO ref_country (code, name, name_fr, name_en, name_ar, region_id, created_by) VALUES
('NN', 'N/A', 'N/A', 'N/A', NULL, (SELECT id FROM ref_region WHERE name='N/A'), 'tradi'),
('CI', 'Côte d''Ivoire', 'Côte d''Ivoire', 'Ivory Coast', NULL, (SELECT id FROM ref_region WHERE name='CIMA'), 'tradi'),
('BF', 'Burkina Faso', 'Burkina Faso', 'Burkina Faso', NULL, (SELECT id FROM ref_region WHERE name='CIMA'), 'tradi'),
('SN', 'Sénégal', 'Sénégal', 'Senegal', NULL, (SELECT id FROM ref_region WHERE name='CIMA'), 'tradi'),
('ML', 'Mali', 'Mali', 'Mali', NULL, (SELECT id FROM ref_region WHERE name='CIMA'), 'tradi'),
('NE', 'Niger', 'Niger', 'Niger', NULL, (SELECT id FROM ref_region WHERE name='CIMA'), 'tradi'),
('TG', 'Togo', 'Togo', 'Togo', NULL, (SELECT id FROM ref_region WHERE name='CIMA'), 'tradi'),
('BJ', 'Bénin', 'Bénin', 'Benin', NULL, (SELECT id FROM ref_region WHERE name='CIMA'), 'tradi'),
('CM', 'Cameroun', 'Cameroun', 'Cameroon', NULL, (SELECT id FROM ref_region WHERE name='CIMA'), 'tradi'),
('CF', 'République centrafricaine', 'République centrafricaine', 'Central African Republic', NULL, (SELECT id FROM ref_region WHERE name='CIMA'), 'tradi'),
('CG', 'Congo', 'Congo', 'Congo', NULL, (SELECT id FROM ref_region WHERE name='CIMA'), 'tradi'),
('GA', 'Gabon', 'Gabon', 'Gabon', NULL, (SELECT id FROM ref_region WHERE name='CIMA'), 'tradi'),
('GN', 'Guinée', 'Guinée', 'Guinea', NULL, (SELECT id FROM ref_region WHERE name='Hors CIMA Francophone'), 'tradi'),
('CD', 'République démocratique du Congo', 'République démocratique du Congo', 'Democratic Republic of Congo', NULL, (SELECT id FROM ref_region WHERE name='Hors CIMA Francophone'), 'tradi'),
('MR', 'Mauritanie', 'Mauritanie', 'Mauritania', NULL, (SELECT id FROM ref_region WHERE name='Hors CIMA Francophone'), 'tradi'),
('GH', 'Ghana', 'Ghana', 'Ghana', NULL, (SELECT id FROM ref_region WHERE name='Hors CIMA Anglophone'), 'tradi'),
('LR', 'Libéria', 'Libéria', 'Liberia', NULL, (SELECT id FROM ref_region WHERE name='Hors CIMA Anglophone'), 'tradi'),
('NG', 'Nigeria', 'Nigeria', 'Nigeria', NULL, (SELECT id FROM ref_region WHERE name='Hors CIMA Anglophone'), 'tradi'),
('FR', 'France', 'France', 'France', NULL, (SELECT id FROM ref_region WHERE name='Autre'), 'tradi'),
('CH', 'Suisse', 'Suisse', 'Switzerland', NULL, (SELECT id FROM ref_region WHERE name='Autre'), 'tradi'),
('DE', 'Allemagne', 'Allemagne', 'Germany', NULL, (SELECT id FROM ref_region WHERE name='Autre'), 'tradi'),
('GB', 'Royaume-Uni', 'Royaume-Uni', 'United Kingdom', NULL, (SELECT id FROM ref_region WHERE name='Autre'), 'tradi'),
('US', 'États-Unis', 'États-Unis', 'United States', NULL, (SELECT id FROM ref_region WHERE name='Autre'), 'tradi'),
('MA', 'Maroc', 'Maroc', 'Morocco', NULL, (SELECT id FROM ref_region WHERE name='Autre'), 'tradi'),
('W0', 'Monde Entier', 'Monde Entier', 'Worldwide', NULL, (SELECT id FROM ref_region WHERE name='Monde Entier'), 'tradi');

INSERT INTO ref_city (code, name, name_fr, name_en, name_ar, country_id, created_by) VALUES
('ABD', 'Abidjan', 'Abidjan', 'Abidjan', NULL, (SELECT id FROM ref_country WHERE code='CI'), 'tradi'),
('OUA', 'Ouagadougou', 'Ouagadougou', 'Ouagadougou', NULL, (SELECT id FROM ref_country WHERE code='BF'), 'tradi'),
('DAK', 'Dakar', 'Dakar', 'Dakar', NULL, (SELECT id FROM ref_country WHERE code='SN'), 'tradi'),
('BAM', 'Bamako', 'Bamako', 'Bamako', NULL, (SELECT id FROM ref_country WHERE code='ML'), 'tradi'),
('NIA', 'Niamey', 'Niamey', 'Niamey', NULL, (SELECT id FROM ref_country WHERE code='NE'), 'tradi'),
('LOM', 'Lomé', 'Lomé', 'Lome', NULL, (SELECT id FROM ref_country WHERE code='TG'), 'tradi'),
('COT', 'Cotonou', 'Cotonou', 'Cotonou', NULL, (SELECT id FROM ref_country WHERE code='BJ'), 'tradi'),
('DOU', 'Douala', 'Douala', 'Douala', NULL, (SELECT id FROM ref_country WHERE code='CM'), 'tradi'),
('CAS', 'Casablanca', 'Casablanca', 'Casablanca', NULL, (SELECT id FROM ref_country WHERE code='MA'), 'tradi');

--changeset tradi:2-insert-financial-data
--comment: Insertion des données financières
INSERT INTO ref_currency (code, name, name_fr, name_en, name_ar, is_active, created_by) VALUES
('XOF', 'Franc CFA (BCEAO)', 'Franc CFA (BCEAO)', 'CFA Franc (BCEAO)', NULL, true, 'tradi'),
('XAF', 'Franc CFA (BEAC)', 'Franc CFA (BEAC)', 'CFA Franc (BEAC)', NULL, true, 'tradi'),
('EUR', 'Euro', 'Euro', 'Euro', NULL, true, 'tradi'),
('USD', 'Dollar américain', 'Dollar américain', 'US Dollar', NULL, true, 'tradi'),
('GBP', 'Livre sterling', 'Livre sterling', 'British Pound', NULL, true, 'tradi'),
('CHF', 'Franc suisse', 'Franc suisse', 'Swiss Franc', NULL, true, 'tradi'),
('GNF', 'Franc guinéen', 'Franc guinéen', 'Guinean Franc', NULL, true, 'tradi'),
('MRU', 'Ouguiya mauritanienne', 'Ouguiya mauritanienne', 'Mauritanian Ouguiya', NULL, true, 'tradi'),
('CDF', 'Franc congolais', 'Franc congolais', 'Congolese Franc', NULL, false, 'tradi'),
('NGN', 'Naira nigérian', 'Naira nigérian', 'Nigerian Naira', NULL, false, 'tradi'),
('GHS', 'Cedi ghanéen', 'Cedi ghanéen', 'Ghanaian Cedi', NULL, false, 'tradi'),
('LRD', 'Dollar libérien', 'Dollar libérien', 'Liberian Dollar', NULL, false, 'tradi'),
('MAD', 'Dirham marocain', 'Dirham marocain', 'Moroccan Dirham', NULL, false, 'tradi');

-- Périodes pour 2024
INSERT INTO ref_period (year, month, name, start_date, end_date, is_current_processing, is_open_for_linkage, is_open_for_exchange_rates, is_open_for_bank_balance, created_by) VALUES
(2024, 1, 'Janvier 2024', '2024-01-01', '2024-01-31', false, false, false, false, 'tradi'),
(2024, 2, 'Février 2024', '2024-02-01', '2024-02-29', false, false, false, false, 'tradi'),
(2024, 3, 'Mars 2024', '2024-03-01', '2024-03-31', false, false, false, false, 'tradi'),
(2024, 4, 'Avril 2024', '2024-04-01', '2024-04-30', false, false, false, false, 'tradi'),
(2024, 5, 'Mai 2024', '2024-05-01', '2024-05-31', false, false, false, false, 'tradi'),
(2024, 6, 'Juin 2024', '2024-06-01', '2024-06-30', false, false, false, false, 'tradi'),
(2024, 7, 'Juillet 2024', '2024-07-01', '2024-07-31', false, false, false, false, 'tradi'),
(2024, 8, 'Août 2024', '2024-08-01', '2024-08-31', false, false, false, false, 'tradi'),
(2024, 9, 'Septembre 2024', '2024-09-01', '2024-09-30', false, false, false, false, 'tradi'),
(2024, 10, 'Octobre 2024', '2024-10-01', '2024-10-31', false, false, false, false, 'tradi'),
(2024, 11, 'Novembre 2024', '2024-11-01', '2024-11-30', false, false, false, false, 'tradi'),
(2024, 12, 'Décembre 2024', '2024-12-01', '2024-12-31', true, true, true, true, 'tradi');

--changeset tradi:3-insert-business-data
--comment: Insertion des données métier (partenaires, secteurs)
INSERT INTO ref_partner_type (code, name, name_fr, name_en, name_ar, created_by) VALUES
('CEDANT', 'Cédant', 'Cédant', 'Cedant', NULL, 'tradi'),
('BROKER', 'Courtier', 'Courtier', 'Broker', NULL, 'tradi'),
('REINSURER', 'Réassureur', 'Réassureur', 'Reinsurer', NULL, 'tradi');

-- NOTE: Les inserts pour ref_partner ne contiennent plus les colonnes de traduction
INSERT INTO ref_partner (code, name, short_name, partner_type_id, is_reinsurer, is_inwards, is_outwards, region_id, country_id, currency_id, created_by) VALUES
('CI0C000000', 'Sunu Réassurance', 'Sunu Ré', (SELECT id FROM ref_partner_type WHERE code='CEDANT'), false, false, true, (SELECT id FROM ref_region WHERE name='CIMA'), (SELECT id FROM ref_country WHERE code='CI'), (SELECT id FROM ref_currency WHERE code='XOF'), 'tradi'),
('CH0C000001', 'Swiss Reinsurance', 'Swiss Re', (SELECT id FROM ref_partner_type WHERE code='REINSURER'), true, true, true, (SELECT id FROM ref_region WHERE name='Autre'), (SELECT id FROM ref_country WHERE code='CH'), (SELECT id FROM ref_currency WHERE code='CHF'), 'tradi'),
('FR0C000002', 'AXA Réassurance', 'AXA Ré', (SELECT id FROM ref_partner_type WHERE code='REINSURER'), true, true, true, (SELECT id FROM ref_region WHERE name='Autre'), (SELECT id FROM ref_country WHERE code='FR'), (SELECT id FROM ref_currency WHERE code='EUR'), 'tradi'),
('GB0C000003', 'Lloyd''s of London', 'Lloyd''s', (SELECT id FROM ref_partner_type WHERE code='REINSURER'), true, true, true, (SELECT id FROM ref_region WHERE name='Autre'), (SELECT id FROM ref_country WHERE code='GB'), (SELECT id FROM ref_currency WHERE code='GBP'), 'tradi'),
('CI0B000004', 'Marsh Courtiers', 'Marsh', (SELECT id FROM ref_partner_type WHERE code='BROKER'), false, false, false, (SELECT id FROM ref_region WHERE name='CIMA'), (SELECT id FROM ref_country WHERE code='CI'), (SELECT id FROM ref_currency WHERE code='XOF'), 'tradi');

INSERT INTO ref_occupancy_group (name, name_fr, name_en, name_ar, created_by) VALUES
('Industrie', 'Industrie', 'Industry', NULL, 'tradi'),
('Transport', 'Transport', 'Transport', NULL, 'tradi'),
('Construction', 'Construction', 'Construction', NULL, 'tradi'),
('Technologie', 'Technologie', 'Technology', NULL, 'tradi'),
('Santé', 'Santé', 'Health', NULL, 'tradi'),
('Agriculture', 'Agriculture', 'Agriculture', NULL, 'tradi'),
('Services', 'Services', 'Services', NULL, 'tradi'),
('Émergents', 'Émergents', 'Emerging', NULL, 'tradi');

INSERT INTO ref_occupancy (code, name, name_fr, name_en, name_ar, group_id, created_by) VALUES
('0001', 'N/A', 'N/A', 'N/A', NULL, (SELECT id FROM ref_occupancy_group WHERE name='Industrie'), 'tradi'),
('1001', 'Pétrole & Gaz', 'Pétrole & Gaz', 'Oil & Gas', NULL, (SELECT id FROM ref_occupancy_group WHERE name='Industrie'), 'tradi'),
('1002', 'Chimie/Pharmaceutique', 'Chimie/Pharmaceutique', 'Chemical/Pharmaceutical', NULL, (SELECT id FROM ref_occupancy_group WHERE name='Industrie'), 'tradi'),
('1003', 'Métallurgie/Mines', 'Métallurgie/Mines', 'Metallurgy/Mining', NULL, (SELECT id FROM ref_occupancy_group WHERE name='Industrie'), 'tradi'),
('1101', 'Aviation', 'Aviation', 'Aviation', NULL, (SELECT id FROM ref_occupancy_group WHERE name='Transport'), 'tradi'),
('1102', 'Maritime', 'Maritime', 'Maritime', NULL, (SELECT id FROM ref_occupancy_group WHERE name='Transport'), 'tradi'),
('1103', 'Automobile', 'Automobile', 'Automotive', NULL, (SELECT id FROM ref_occupancy_group WHERE name='Transport'), 'tradi'),
('1201', 'BTP', 'BTP', 'Construction', NULL, (SELECT id FROM ref_occupancy_group WHERE name='Construction'), 'tradi'),
('1202', 'Énergie', 'Énergie', 'Energy', NULL, (SELECT id FROM ref_occupancy_group WHERE name='Construction'), 'tradi'),
('1301', 'Télécoms/Data Centers', 'Télécoms/Data Centers', 'Telecoms/Data Centers', NULL, (SELECT id FROM ref_occupancy_group WHERE name='Technologie'), 'tradi'),
('1302', 'Spatial', 'Spatial', 'Space', NULL, (SELECT id FROM ref_occupancy_group WHERE name='Technologie'), 'tradi'),
('1401', 'Hôpitaux', 'Hôpitaux', 'Hospitals', NULL, (SELECT id FROM ref_occupancy_group WHERE name='Santé'), 'tradi'),
('1402', 'Pharmacies', 'Pharmacies', 'Pharmacies', NULL, (SELECT id FROM ref_occupancy_group WHERE name='Santé'), 'tradi'),
('1501', 'Agroalimentaire', 'Agroalimentaire', 'Agri-food', NULL, (SELECT id FROM ref_occupancy_group WHERE name='Agriculture'), 'tradi'),
('1502', 'Sylviculture', 'Sylviculture', 'Forestry', NULL, (SELECT id FROM ref_occupancy_group WHERE name='Agriculture'), 'tradi'),
('1601', 'Finance', 'Finance', 'Finance', NULL, (SELECT id FROM ref_occupancy_group WHERE name='Services'), 'tradi'),
('1602', 'Tourisme', 'Tourisme', 'Tourism', NULL, (SELECT id FROM ref_occupancy_group WHERE name='Services'), 'tradi'),
('1701', 'Cyber', 'Cyber', 'Cyber', NULL, (SELECT id FROM ref_occupancy_group WHERE name='Émergents'), 'tradi'),
('1702', 'Climatique', 'Climatique', 'Climate', NULL, (SELECT id FROM ref_occupancy_group WHERE name='Émergents'), 'tradi');

--changeset tradi:4-insert-arrangement-data
--comment: Insertion des données pour les types d'arrangement (structure complète)
INSERT INTO ref_arrangement_portfolio_type (code, name, name_fr, name_en, name_ar) VALUES
('TREATY', 'Traité', 'Traité', 'Treaty', NULL),
('FACULTATIVE', 'Facultatif', 'Facultatif', 'Facultative', NULL),
('OTREATY', 'Outward Treaty', 'Outward Treaty', 'Outward Treaty', NULL);

INSERT INTO ref_arrangement_contract_type (code, name, name_fr, name_en, name_ar) VALUES
('PRORATA', 'Prorata', 'Prorata', 'Proportional', NULL),
('EXCESS', 'Excess', 'Excess', 'Excess', NULL);

INSERT INTO ref_arrangement_processing_type (code, name, name_fr, name_en, name_ar) VALUES
('STATEMENT', 'Statement', 'Statement', 'Statement', NULL),
('INSTALLMENT', 'Installment', 'Installment', 'Installment', NULL);

INSERT INTO ref_arrangement_business_type (code, name, name_fr, name_en, name_ar) VALUES
('INWARDS', 'Inwards', 'Inwards', 'Inwards', NULL),
('RETROCESSION', 'Retrocession', 'Retrocession', 'Retrocession', NULL);

-- Insertion dans la table principale avec sous-requêtes
INSERT INTO ref_arrangement_type (code, name, name_fr, name_en, name_ar, portfolio_type_id, contract_type_id, processing_type_id, business_type_id, created_by) VALUES
('A1', 'Quota Share', 'Quota Share', 'Quota Share', NULL, (SELECT id from ref_arrangement_portfolio_type where code='TREATY'), (SELECT id from ref_arrangement_contract_type where code='PRORATA'), (SELECT id from ref_arrangement_processing_type where code='STATEMENT'), (SELECT id from ref_arrangement_business_type where code='INWARDS'), 'tradi'),
('A2', 'SurPlus', 'SurPlus', 'SurPlus', NULL, (SELECT id from ref_arrangement_portfolio_type where code='TREATY'), (SELECT id from ref_arrangement_contract_type where code='PRORATA'), (SELECT id from ref_arrangement_processing_type where code='STATEMENT'), (SELECT id from ref_arrangement_business_type where code='INWARDS'), 'tradi'),
('A3', 'FacOb', 'FacOb', 'FacOb', NULL, (SELECT id from ref_arrangement_portfolio_type where code='TREATY'), (SELECT id from ref_arrangement_contract_type where code='PRORATA'), (SELECT id from ref_arrangement_processing_type where code='STATEMENT'), (SELECT id from ref_arrangement_business_type where code='INWARDS'), 'tradi'),
('A4', 'Facultative', 'Facultative', 'Facultative', NULL, (SELECT id from ref_arrangement_portfolio_type where code='FACULTATIVE'), (SELECT id from ref_arrangement_contract_type where code='PRORATA'), (SELECT id from ref_arrangement_processing_type where code='INSTALLMENT'), (SELECT id from ref_arrangement_business_type where code='INWARDS'), 'tradi'),
('A5', 'Excess of Loss', 'Excess of Loss', 'Excess of Loss', NULL, (SELECT id from ref_arrangement_portfolio_type where code='TREATY'), (SELECT id from ref_arrangement_contract_type where code='EXCESS'), (SELECT id from ref_arrangement_processing_type where code='INSTALLMENT'), (SELECT id from ref_arrangement_business_type where code='INWARDS'), 'tradi'),
('A6', 'Pool Common Account XL', 'Pool Common Account XL', 'Pool Common Account XL', NULL, (SELECT id from ref_arrangement_portfolio_type where code='TREATY'), (SELECT id from ref_arrangement_contract_type where code='EXCESS'), (SELECT id from ref_arrangement_processing_type where code='INSTALLMENT'), (SELECT id from ref_arrangement_business_type where code='INWARDS'), 'tradi'),
('A7', 'Excess of loss Cover', 'Excess of loss Cover', 'Excess of loss Cover', NULL, (SELECT id from ref_arrangement_portfolio_type where code='OTREATY'), (SELECT id from ref_arrangement_contract_type where code='EXCESS'), (SELECT id from ref_arrangement_processing_type where code='INSTALLMENT'), (SELECT id from ref_arrangement_business_type where code='RETROCESSION'), 'tradi'),
('A8', 'Quota Share Retro', 'Quota Share Retro', 'Quota Share Retro', NULL, (SELECT id from ref_arrangement_portfolio_type where code='OTREATY'), (SELECT id from ref_arrangement_contract_type where code='PRORATA'), (SELECT id from ref_arrangement_processing_type where code='STATEMENT'), (SELECT id from ref_arrangement_business_type where code='RETROCESSION'), 'tradi'),
('A9', 'SurPlus Retro', 'SurPlus Retro', 'SurPlus Retro', NULL, (SELECT id from ref_arrangement_portfolio_type where code='OTREATY'), (SELECT id from ref_arrangement_contract_type where code='PRORATA'), (SELECT id from ref_arrangement_processing_type where code='STATEMENT'), (SELECT id from ref_arrangement_business_type where code='RETROCESSION'), 'tradi'),
('A10', 'FacOb Retro', 'FacOb Retro', 'FacOb Retro', NULL, (SELECT id from ref_arrangement_portfolio_type where code='OTREATY'), (SELECT id from ref_arrangement_contract_type where code='PRORATA'), (SELECT id from ref_arrangement_processing_type where code='STATEMENT'), (SELECT id from ref_arrangement_business_type where code='RETROCESSION'), 'tradi');

--changeset tradi:5-insert-auth-data
--comment: Insertion des données pour les droits et habilitations
INSERT INTO ref_role (code, name, name_fr, name_en, name_ar, created_by) VALUES
('ADMIN', 'Administrateur', 'Administrateur', 'Administrator', NULL, 'tradi'),
('ENQ', 'Interrogation', 'Interrogation', 'Inquiry', NULL, 'tradi'),
('UDW', 'Souscripteur', 'Souscripteur', 'Underwriter', NULL, 'tradi'),
('ACC', 'Comptabilité', 'Comptabilité', 'Accounting', NULL, 'tradi'),
('CLM', 'Gestionnaire Sinistre', 'Gestionnaire Sinistre', 'Claims Manager', NULL, 'tradi'),
('FIN', 'Gestionnaire Finance', 'Gestionnaire Finance', 'Finance Manager', NULL, 'tradi'),
('UDW_MNG', 'Souscripteur Senior', 'Souscripteur Senior', 'Senior Underwriter', NULL, 'tradi'),
('ACC_MNG', 'Comptable Senior', 'Comptable Senior', 'Senior Accountant', NULL, 'tradi'),
('MNG', 'Gestionnaire', 'Gestionnaire', 'Manager', NULL, 'tradi');

INSERT INTO ref_group (code, name, name_fr, name_en, name_ar, sequence_in_menu, description_fr, description_en, description_ar, icon, created_by) VALUES
('UWR_MGT', 'Souscription', 'Souscription', 'Underwriting', NULL, 1, 'Gestion de la souscription', 'Underwriting management', NULL, 'contract', 'tradi'),
('PRM_ACC', 'Prime & Compte Technique', 'Prime & Compte Technique', 'Premium & Technical Account', NULL, 2, 'Gestion des primes et comptes techniques', 'Premium and technical account management', NULL, 'money', 'tradi'),
('CLM_MGT', 'Gestion de Sinistre', 'Gestion de Sinistre', 'Claims Management', NULL, 3, 'Gestion des sinistres', 'Claims management', NULL, 'warning', 'tradi'),
('FIN_MGT', 'Finance', 'Finance', 'Finance', NULL, 4, 'Gestion financière', 'Financial management', NULL, 'bank', 'tradi'),
('ENQ_ALL', 'Interrogation', 'Interrogation', 'Inquiry', NULL, 5, 'Interrogation générale', 'General inquiry', NULL, 'search', 'tradi'),
('REP_ALL', 'Reporting', 'Reporting', 'Reporting', NULL, 6, 'Rapports et statistiques', 'Reports and statistics', NULL, 'chart', 'tradi'),
('REF_TAB', 'Tables de Références', 'Tables de Références', 'Reference Tables', NULL, 7, 'Gestion des tables de référence', 'Reference tables management', NULL, 'database', 'tradi'),
('ADM_MGR', 'Administration', 'Administration', 'Administration', NULL, 8, 'Administration du système', 'System administration', NULL, 'settings', 'tradi');

INSERT INTO ref_function_type (code, name, name_fr, name_en, name_ar) VALUES
('MENU', 'Menu', 'Menu', 'Menu', NULL),
('BUTTON', 'Bouton', 'Bouton', 'Button', NULL),
('ACTION', 'Action', 'Action', 'Action', NULL);

INSERT INTO ref_function (code, name_fr, name_en, name_ar, description_fr, description_en, description_ar, group_id, sequence_in_group, function_type_id, created_by) VALUES
('MNT_CTR', 'Maintenance Police', 'Contract Maintenance', NULL, 'Maintenance des polices', 'Contract maintenance', NULL, (SELECT id FROM ref_group WHERE code='UWR_MGT'), 10, (SELECT id FROM ref_function_type WHERE code='MENU'), 'tradi'),
('REF_PRT', 'Partenaires', 'Partners', NULL, 'Gestion des partenaires', 'Partner management', NULL, (SELECT id FROM ref_group WHERE code='REF_TAB'), 70, (SELECT id FROM ref_function_type WHERE code='MENU'), 'tradi'),
('REF_INS', 'Assurés', 'Insured', NULL, 'Gestion des assurés', 'Insured management', NULL, (SELECT id FROM ref_group WHERE code='REF_TAB'), 71, (SELECT id FROM ref_function_type WHERE code='MENU'), 'tradi');

-- Liaisons Rôles-Fonctions
INSERT INTO ref_role_function (role_id, function_id, created_by) VALUES
((SELECT id FROM ref_role WHERE code='ADMIN'), (SELECT id FROM ref_function WHERE code='MNT_CTR'), 'tradi'),
((SELECT id FROM ref_role WHERE code='ADMIN'), (SELECT id FROM ref_function WHERE code='REF_PRT'), 'tradi'),
((SELECT id FROM ref_role WHERE code='ADMIN'), (SELECT id FROM ref_function WHERE code='REF_INS'), 'tradi'),
((SELECT id FROM ref_role WHERE code='UDW'), (SELECT id FROM ref_function WHERE code='MNT_CTR'), 'tradi'),
((SELECT id FROM ref_role WHERE code='UDW_MNG'), (SELECT id FROM ref_function WHERE code='MNT_CTR'), 'tradi'),
((SELECT id FROM ref_role WHERE code='UDW_MNG'), (SELECT id FROM ref_function WHERE code='REF_PRT'), 'tradi'),
((SELECT id FROM ref_role WHERE code='UDW_MNG'), (SELECT id FROM ref_function WHERE code='REF_INS'), 'tradi');

-- Liaisons Rôles-Groupes
INSERT INTO ref_role_group (role_id, group_id, sequence_in_menu, created_by) VALUES
((SELECT id FROM ref_role WHERE code='ADMIN'), (SELECT id FROM ref_group WHERE code='UWR_MGT'), 1, 'tradi'),
((SELECT id FROM ref_role WHERE code='ADMIN'), (SELECT id FROM ref_group WHERE code='REF_TAB'), 7, 'tradi'),
((SELECT id FROM ref_role WHERE code='ADMIN'), (SELECT id FROM ref_group WHERE code='ADM_MGR'), 8, 'tradi'),
((SELECT id FROM ref_role WHERE code='UDW'), (SELECT id FROM ref_group WHERE code='UWR_MGT'), 1, 'tradi'),
((SELECT id FROM ref_role WHERE code='UDW_MNG'), (SELECT id FROM ref_group WHERE code='UWR_MGT'), 1, 'tradi'),
((SELECT id FROM ref_role WHERE code='UDW_MNG'), (SELECT id FROM ref_group WHERE code='REF_TAB'), 7, 'tradi'); 