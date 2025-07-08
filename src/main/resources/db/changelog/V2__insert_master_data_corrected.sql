--liquibase formatted sql

--changeset system:1-insert-missing-periods
--comment: Insert missing period data from R1
INSERT INTO ref_period (year, month, name, start_date, end_date, is_current_processing, is_open_for_linkage, is_open_for_exchange_rates, is_open_for_bank_balance, created_by) VALUES
-- 2024 periods
(2024, 1, 'Janvier 2024', '2024-01-01', '2024-01-31', false, true, true, true, 'system'),

(2024, 2, 'Février 2024', '2024-02-01', '2024-02-29', false, true, true, true, 'system'),
(2024, 3, 'Mars 2024', '2024-03-01', '2024-03-31', false, true, true, true, 'system'),
(2024, 4, 'Avril 2024', '2024-04-01', '2024-04-30', false, true, true, true, 'system'),
(2024, 5, 'Mai 2024', '2024-05-01', '2024-05-31', false, true, true, true, 'system'),
(2024, 6, 'Juin 2024', '2024-06-01', '2024-06-30', false, true, true, true, 'system'),
(2024, 7, 'Juillet 2024', '2024-07-01', '2024-07-31', false, true, true, true, 'system'),
(2024, 8, 'Août 2024', '2024-08-01', '2024-08-31', false, true, true, true, 'system'),
(2024, 9, 'Septembre 2024', '2024-09-01', '2024-09-30', false, true, true, true, 'system'),
(2024, 10, 'Octobre 2024', '2024-10-01', '2024-10-31', false, true, true, true, 'system'),
(2024, 11, 'Novembre 2024', '2024-11-01', '2024-11-30', false, true, true, true, 'system'),
(2024, 12, 'Décembre 2024', '2024-12-01', '2024-12-31', false, true, true, true, 'system'),
-- 2025 periods
(2025, 1, 'Janvier 2025', '2025-01-01', '2025-01-31', true, false, false, false, 'system'),
(2025, 2, 'Février 2025', '2025-02-01', '2025-02-28', false, false, false, false, 'system');

--changeset system:1-insert-role-data
--comment: Insertion des données de rôles
INSERT INTO ref_role (code, name, name_fr, created_by)
VALUES ('ADMIN', 'Administrateur', 'Administrateur', 'system'),
       ('ENQ', 'Interrogation', 'Interrogation', 'system'),
       ('UDW', 'Souscripteur', 'Souscripteur', 'system'),
       ('ACC', 'Comptabilite', 'Comptabilité', 'system'),
       ('CLM', 'Gestionnaire Sinistre', 'Gestionnaire Sinistre', 'system'),
       ('FIN', 'Gestionnaire Finance', 'Gestionnaire Finance', 'system'),
       ('UDW_MNG', 'Souscripteur Senior', 'Souscripteur Senior', 'system'),
       ('ACC_MNG', 'Comptable Senior', 'Comptable Senior', 'system'),
       ('MNG', 'Gestionnaire', 'Gestionnaire', 'system');

--changeset system:2b-insert-group-data
--comment: Insertion des données de groupes (manquants du R1)
INSERT INTO ref_group (code, name, name_fr, name_en, name_ar, created_by)
VALUES ('UWR_MGT', 'Souscription', 'Souscription', 'Underwriting', 'الاكتتاب', 'admin'),
       ('PRM_ACC', 'Prime & Compte Technique', 'Prime & Compte Technique', 'Premium & Technical Account',
        'القسط والحساب التقني', 'admin'),
       ('CLM_MGT', 'Gestion de Sinistre', 'Gestion de Sinistre', 'Claims Management', 'إدارة المطالبات', 'admin'),
       ('FIN_MGT', 'Finance', 'Finance', 'Finance', 'المالية', 'admin'),
       ('ENQ_ALL', 'Interrogation', 'Interrogation', 'Inquiry', 'الاستعلام', 'admin'),
       ('REP_ALL', 'Reporting', 'Reporting', 'Reporting', 'التقارير', 'admin'),
       ('REF_TAB', 'Tables de Références', 'Tables de Références', 'Reference Tables', 'جداول المراجع', 'admin'),
       ('ADM_MGR', 'Administration', 'Administration', 'Administration', 'الإدارة', 'admin');

--changeset system:2-insert-function-data
--comment: Insertion des données de fonctions
INSERT INTO ref_function (code, name_fr, name_en, name_ar, group_id, sequence_in_group, created_by)
VALUES ('MNT_CTR', 'Maintenance Police', 'Policy Maintenance', 'صيانة البوليصة',
        (SELECT id FROM ref_group WHERE code = 'UWR_MGT'), 10, 'system'),
       ('REF_PRT', 'Partenaires', 'Partners', 'الشركاء',
        (SELECT id FROM ref_group WHERE code = 'REF_TAB'), 70, 'system'),
       ('REF_INS', 'Assurés', 'Insureds', 'المؤمن عليهم',
        (SELECT id FROM ref_group WHERE code = 'REF_TAB'), 71, 'system') ON CONFLICT (code) DO
UPDATE SET
    group_id = EXCLUDED.group_id,
    sequence_in_group = EXCLUDED.sequence_in_group;

-- Add granular permissions to ref_function table
INSERT INTO ref_function (code, name_fr, name_en, name_ar, group_id, sequence_in_group, created_by)
VALUES
-- Partners granular permissions
('REF_PRT_READ', 'Partenaires - Lecture', 'Partners - Read', 'الشركاء - قراءة',
 (SELECT id FROM ref_group WHERE code = 'REF_TAB'), 72, 'system'),
('REF_PRT_WRITE', 'Partenaires - Écriture', 'Partners - Write', 'الشركاء - كتابة',
 (SELECT id FROM ref_group WHERE code = 'REF_TAB'), 73, 'system'),
('REF_PRT_DELETE', 'Partenaires - Suppression', 'Partners - Delete', 'الشركاء - حذف',
 (SELECT id FROM ref_group WHERE code = 'REF_TAB'), 74, 'system'),

-- Insureds granular permissions
('REF_INS_READ', 'Assurés - Lecture', 'Insureds - Read', 'المؤمن عليهم - قراءة',
 (SELECT id FROM ref_group WHERE code = 'REF_TAB'), 75, 'system'),
('REF_INS_WRITE', 'Assurés - Écriture', 'Insureds - Write', 'المؤمن عليهم - كتابة',
 (SELECT id FROM ref_group WHERE code = 'REF_TAB'), 76, 'system'),
('REF_INS_DELETE', 'Assurés - Suppression', 'Insureds - Delete', 'المؤمن عليهم - حذف',
 (SELECT id FROM ref_group WHERE code = 'REF_TAB'), 77, 'system')

    ON CONFLICT (code) DO UPDATE SET
    group_id = EXCLUDED.group_id,
                              sequence_in_group = EXCLUDED.sequence_in_group;

--changeset system:2a-insert-role-function-data
--comment: Insertion des données de référence de base
INSERT INTO ref_role_function (role_id, function_id, created_by)
SELECT r.id, f.id, 'system'
FROM ref_role r,
     ref_function f
WHERE r.code = 'ADMIN' ON CONFLICT DO NOTHING;



--changeset system:3-insert-basic-reference-data
--comment: Insertion des données de référence géographiques (conformes R1)
-- Insert regions (exactement comme R1 - 6 régions)
INSERT INTO ref_region (code, name, name_fr, name_en, name_ar, created_by)
VALUES ('N/A', 'N/A', 'N/A', 'N/A', 'غير محدد', 'system'),
       ('CIMA', 'CIMA', 'CIMA', 'CIMA', 'سيما', 'system'),
       ('HCANG', 'Hors CIMA Anglophone', 'Hors CIMA Anglophone', 'Non-CIMA English Speaking',
        'خارج سيما الناطقة بالإنجليزية', 'system'),
       ('HCFRA', 'Hors CIMA Francophone', 'Hors CIMA Francophone', 'Non-CIMA French Speaking',
        'خارج سيما الناطقة بالفرنسية', 'system'),
       ('AUT', 'Autre', 'Autre', 'Other', 'أخرى', 'system'),
       ('WW', 'Monde Entier', 'Monde Entier', 'Worldwide', 'العالم كله', 'system');

-- Insert countries (154 pays conformes R1)
INSERT INTO ref_country (code, name, name_fr, name_en, name_ar, region_id, created_by)
VALUES ('NN', 'N/A', 'N/A', 'N/A', 'غير محدد', (SELECT id FROM ref_region WHERE code = 'N/A'), 'system'),
-- Pays CIMA (11 pays)
       ('BJ', 'Bénin', 'Bénin', 'Benin', 'بنين', (SELECT id FROM ref_region WHERE code = 'CIMA'), 'system'),
       ('BF', 'Burkina Faso', 'Burkina Faso', 'Burkina Faso', 'بوركينا فاسو',
        (SELECT id FROM ref_region WHERE code = 'CIMA'), 'system'),
       ('CM', 'Cameroun', 'Cameroun', 'Cameroon', 'الكاميرون', (SELECT id FROM ref_region WHERE code = 'CIMA'),
        'system'),
       ('CF', 'République centrafricaine', 'République centrafricaine', 'Central African Republic',
        'جمهورية أفريقيا الوسطى', (SELECT id FROM ref_region WHERE code = 'CIMA'), 'system'),
       ('CG', 'Congo', 'Congo', 'Congo', 'الكونغو', (SELECT id FROM ref_region WHERE code = 'CIMA'), 'system'),
       ('GA', 'Gabon', 'Gabon', 'Gabon', 'الغابون', (SELECT id FROM ref_region WHERE code = 'CIMA'), 'system'),
       ('CI', 'Côte d''Ivoire', 'Côte d''Ivoire', 'Ivory Coast', 'ساحل العاج',
        (SELECT id FROM ref_region WHERE code = 'CIMA'), 'system'),
       ('ML', 'Mali', 'Mali', 'Mali', 'مالي', (SELECT id FROM ref_region WHERE code = 'CIMA'), 'system'),
       ('NE', 'Niger', 'Niger', 'Niger', 'النيجر', (SELECT id FROM ref_region WHERE code = 'CIMA'), 'system'),
       ('SN', 'Sénégal', 'Sénégal', 'Senegal', 'السنغال', (SELECT id FROM ref_region WHERE code = 'CIMA'), 'system'),
       ('TG', 'Togo', 'Togo', 'Togo', 'توغو', (SELECT id FROM ref_region WHERE code = 'CIMA'), 'system'),
-- Hors CIMA Francophone (3 pays)
       ('MR', 'Mauritanie', 'Mauritanie', 'Mauritania', 'موريتانيا', (SELECT id FROM ref_region WHERE code = 'HCFRA'),
        'system'),
       ('CD', 'République démocratique du Congo', 'République démocratique du Congo', 'Democratic Republic of Congo',
        'جمهورية الكونغو الديمقراطية', (SELECT id FROM ref_region WHERE code = 'HCFRA'), 'system'),
       ('GN', 'Guinée', 'Guinée', 'Guinea', 'غينيا', (SELECT id FROM ref_region WHERE code = 'HCFRA'), 'system'),
-- Hors CIMA Anglophone (3 pays)
       ('GH', 'Ghana', 'Ghana', 'Ghana', 'غانا', (SELECT id FROM ref_region WHERE code = 'HCANG'), 'system'),
       ('LR', 'Libéria', 'Libéria', 'Liberia', 'ليبيريا', (SELECT id FROM ref_region WHERE code = 'HCANG'), 'system'),
       ('NG', 'Nigeria', 'Nigeria', 'Nigeria', 'نيجيريا', (SELECT id FROM ref_region WHERE code = 'HCANG'), 'system'),
-- Autres pays (134 pays)
       ('DZ', 'Algérie', 'Algérie', 'Algeria', 'الجزائر', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('LY', 'Libye', 'Libye', 'Libya', 'ليبيا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('MA', 'Maroc', 'Maroc', 'Morocco', 'المغرب', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('TN', 'Tunisie', 'Tunisie', 'Tunisia', 'تونس', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('CV', 'Cap-Vert', 'Cap-Vert', 'Cape Verde', 'الرأس الأخضر', (SELECT id FROM ref_region WHERE code = 'AUT'),
        'system'),
       ('TD', 'Tchad', 'Tchad', 'Chad', 'تشاد', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('DJ', 'Djibouti', 'Djibouti', 'Djibouti', 'جيبوتي', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('EG', 'Égypte', 'Égypte', 'Egypt', 'مصر', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('GQ', 'Guinée équatoriale', 'Guinée équatoriale', 'Equatorial Guinea', 'غينيا الاستوائية',
        (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('ER', 'Érythrée', 'Érythrée', 'Eritrea', 'إريتريا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('ET', 'Éthiopie', 'Éthiopie', 'Ethiopia', 'إثيوبيا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('GM', 'Gambie', 'Gambie', 'Gambia', 'غامبيا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('GW', 'Guinée-Bissau', 'Guinée-Bissau', 'Guinea-Bissau', 'غينيا بيساو',
        (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('KE', 'Kenya', 'Kenya', 'Kenya', 'كينيا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('MG', 'Madagascar', 'Madagascar', 'Madagascar', 'مدغشقر', (SELECT id FROM ref_region WHERE code = 'AUT'),
        'system'),
       ('MW', 'Malawi', 'Malawi', 'Malawi', 'ملاوي', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('MZ', 'Mozambique', 'Mozambique', 'Mozambique', 'موزمبيق', (SELECT id FROM ref_region WHERE code = 'AUT'),
        'system'),
       ('NA', 'Namibie', 'Namibie', 'Namibia', 'ناميبيا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('RW', 'Rwanda', 'Rwanda', 'Rwanda', 'رواندا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('SL', 'Sierra Leone', 'Sierra Leone', 'Sierra Leone', 'سيراليون',
        (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('SO', 'Somalie', 'Somalie', 'Somalia', 'الصومال', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('ZA', 'Afrique du Sud', 'Afrique du Sud', 'South Africa', 'جنوب أفريقيا',
        (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('SS', 'Soudan du Sud', 'Soudan du Sud', 'South Sudan', 'جنوب السودان',
        (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('SD', 'Soudan', 'Soudan', 'Sudan', 'السودان', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('TZ', 'Tanzanie', 'Tanzanie', 'Tanzania', 'تنزانيا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('UG', 'Ouganda', 'Ouganda', 'Uganda', 'أوغندا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('ZM', 'Zambie', 'Zambie', 'Zambia', 'زامبيا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('ZW', 'Zimbabwe', 'Zimbabwe', 'Zimbabwe', 'زيمبابوي', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
-- Europe
       ('BE', 'Belgique', 'Belgique', 'Belgium', 'بلجيكا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('CY', 'Chypre', 'Chypre', 'Cyprus', 'قبرص', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('CZ', 'République tchèque', 'République tchèque', 'Czech Republic', 'التشيك',
        (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('FI', 'Finlande', 'Finlande', 'Finland', 'فنلندا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('FR', 'France', 'France', 'France', 'فرنسا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('DE', 'Allemagne', 'Allemagne', 'Germany', 'ألمانيا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('GB', 'Royaume-Uni', 'Royaume-Uni', 'United Kingdom', 'المملكة المتحدة',
        (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('GR', 'Grèce', 'Grèce', 'Greece', 'اليونان', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('IE', 'Irlande', 'Irlande', 'Ireland', 'أيرلندا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('IT', 'Italie', 'Italie', 'Italy', 'إيطاليا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('LU', 'Luxembourg', 'Luxembourg', 'Luxembourg', 'لوكسمبورغ', (SELECT id FROM ref_region WHERE code = 'AUT'),
        'system'),
       ('MC', 'Monaco', 'Monaco', 'Monaco', 'موناكو', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('NL', 'Pays-Bas', 'Pays-Bas', 'Netherlands', 'هولندا', (SELECT id FROM ref_region WHERE code = 'AUT'),
        'system'),
       ('PL', 'Pologne', 'Pologne', 'Poland', 'بولندا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('PT', 'Portugal', 'Portugal', 'Portugal', 'البرتغال', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('RO', 'Roumanie', 'Roumanie', 'Romania', 'رومانيا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('RU', 'Russie', 'Russie', 'Russia', 'روسيا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('RS', 'Serbie', 'Serbie', 'Serbia', 'صربيا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('SK', 'Slovaquie', 'Slovaquie', 'Slovakia', 'سلوفاكيا', (SELECT id FROM ref_region WHERE code = 'AUT'),
        'system'),
       ('SI', 'Slovénie', 'Slovénie', 'Slovenia', 'سلوفينيا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('ES', 'Espagne', 'Espagne', 'Spain', 'إسبانيا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('SE', 'Suède', 'Suède', 'Sweden', 'السويد', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('CH', 'Suisse', 'Suisse', 'Switzerland', 'سويسرا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('VA', 'Vatican', 'Vatican', 'Vatican', 'الفاتيكان', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
-- Moyen-Orient
       ('BH', 'Bahrain', 'Bahrain', 'Bahrain', 'البحرين', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('IQ', 'Irak', 'Irak', 'Iraq', 'العراق', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('JO', 'Jordanie', 'Jordanie', 'Jordan', 'الأردن', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('KW', 'Koweït', 'Koweït', 'Kuwait', 'الكويت', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('LB', 'Liban', 'Liban', 'Lebanon', 'لبنان', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('OM', 'Oman', 'Oman', 'Oman', 'عُمان', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('QA', 'Qatar', 'Qatar', 'Qatar', 'قطر', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('SA', 'Arabie saoudite', 'Arabie saoudite', 'Saudi Arabia', 'السعودية',
        (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('SY', 'Syrie', 'Syrie', 'Syria', 'سوريا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('AE', 'Émirats arabes unis', 'Émirats arabes unis', 'United Arab Emirates', 'الإمارات العربية المتحدة',
        (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('YE', 'Yémen', 'Yémen', 'Yemen', 'اليمن', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
-- Asie
       ('AF', 'Afghanistan', 'Afghanistan', 'Afghanistan', 'أفغانستان', (SELECT id FROM ref_region WHERE code = 'AUT'),
        'system'),
       ('AZ', 'Azerbaïdjan', 'Azerbaïdjan', 'Azerbaijan', 'أذربيجان', (SELECT id FROM ref_region WHERE code = 'AUT'),
        'system'),
       ('BD', 'Bangladesh', 'Bangladesh', 'Bangladesh', 'بنغلاديش', (SELECT id FROM ref_region WHERE code = 'AUT'),
        'system'),
       ('CN', 'Chine', 'Chine', 'China', 'الصين', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('HK', 'Hong Kong', 'Hong Kong', 'Hong Kong', 'هونغ كونغ', (SELECT id FROM ref_region WHERE code = 'AUT'),
        'system'),
       ('IN', 'Inde', 'Inde', 'India', 'الهند', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('ID', 'Indonésie', 'Indonésie', 'Indonesia', 'إندونيسيا', (SELECT id FROM ref_region WHERE code = 'AUT'),
        'system'),
       ('IR', 'Iran', 'Iran', 'Iran', 'إيران', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('JP', 'Japon', 'Japon', 'Japan', 'اليابان', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('KR', 'Corée du Sud', 'Corée du Sud', 'South Korea', 'كوريا الجنوبية',
        (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('MY', 'Malaisie', 'Malaisie', 'Malaysia', 'ماليزيا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('PH', 'Philippines', 'Philippines', 'Philippines', 'الفلبين', (SELECT id FROM ref_region WHERE code = 'AUT'),
        'system'),
       ('SG', 'Singapour', 'Singapour', 'Singapore', 'سنغافورة', (SELECT id FROM ref_region WHERE code = 'AUT'),
        'system'),
       ('LK', 'Sri Lanka', 'Sri Lanka', 'Sri Lanka', 'سريلانكا', (SELECT id FROM ref_region WHERE code = 'AUT'),
        'system'),
       ('TW', 'Taiwan', 'Taiwan', 'Taiwan', 'تايوان', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('TJ', 'Tajikistan', 'Tajikistan', 'Tajikistan', 'طاجيكستان', (SELECT id FROM ref_region WHERE code = 'AUT'),
        'system'),
       ('TH', 'Thaïlande', 'Thaïlande', 'Thailand', 'تايلاند', (SELECT id FROM ref_region WHERE code = 'AUT'),
        'system'),
       ('TR', 'Turquie', 'Turquie', 'Turkey', 'تركيا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('TM', 'Turkmenistan', 'Turkmenistan', 'Turkmenistan', 'تركمانستان',
        (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('UZ', 'Uzbekistan', 'Uzbekistan', 'Uzbekistan', 'أوزبكستان', (SELECT id FROM ref_region WHERE code = 'AUT'),
        'system'),
-- Amériques et autres continents
       ('AL', 'Albanie', 'Albanie', 'Albania', 'ألبانيا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('AD', 'Andorre', 'Andorre', 'Andorra', 'أندورا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('AO', 'Angola', 'Angola', 'Angola', 'أنغولا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('AI', 'Anguilla', 'Anguilla', 'Anguilla', 'أنغويلا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('AG', 'Antigua-et-Barbuda', 'Antigua-et-Barbuda', 'Antigua and Barbuda', 'أنتيغوا وبربودا',
        (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('AR', 'Argentine', 'Argentine', 'Argentina', 'الأرجنتين', (SELECT id FROM ref_region WHERE code = 'AUT'),
        'system'),
       ('AM', 'Arménie', 'Arménie', 'Armenia', 'أرمينيا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('AU', 'Australie', 'Australie', 'Australia', 'أستراليا', (SELECT id FROM ref_region WHERE code = 'AUT'),
        'system'),
       ('AT', 'Autriche', 'Autriche', 'Austria', 'النمسا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('BS', 'Bahamas', 'Bahamas', 'Bahamas', 'البهاما', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('BB', 'Barbados', 'Barbados', 'Barbados', 'بربادوس', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('BM', 'Bermudes', 'Bermudes', 'Bermuda', 'برمودا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('BW', 'Botswana', 'Botswana', 'Botswana', 'بوتسوانا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('BN', 'Brunei Darussalam', 'Brunei Darussalam', 'Brunei', 'بروناي',
        (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('BI', 'Burundi', 'Burundi', 'Burundi', 'بوروندي', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('CA', 'Canada', 'Canada', 'Canada', 'كندا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('KM', 'Comores', 'Comores', 'Comoros', 'جزر القمر', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('CR', 'Costa Rica', 'Costa Rica', 'Costa Rica', 'كوستاريكا', (SELECT id FROM ref_region WHERE code = 'AUT'),
        'system'),
       ('CU', 'Cuba', 'Cuba', 'Cuba', 'كوبا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('FJ', 'Fiji', 'Fiji', 'Fiji', 'فيجي', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('GT', 'Guatemala', 'Guatemala', 'Guatemala', 'غواتيمالا', (SELECT id FROM ref_region WHERE code = 'AUT'),
        'system'),
       ('HT', 'Haiti', 'Haiti', 'Haiti', 'هايتي', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('HN', 'Honduras', 'Honduras', 'Honduras', 'هندوراس', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('HU', 'Hongrie', 'Hongrie', 'Hungary', 'المجر', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('LA', 'Laos', 'Laos', 'Laos', 'لاوس', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('LS', 'Lesotho', 'Lesotho', 'Lesotho', 'ليسوتو', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('MV', 'Maldives', 'Maldives', 'Maldives', 'المالديف', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('MU', 'Maurice', 'Maurice', 'Mauritius', 'موريشيوس', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('YT', 'Mayotte', 'Mayotte', 'Mayotte', 'مايوت', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('MX', 'Mexique', 'Mexique', 'Mexico', 'المكسيك', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('ME', 'Montenegro', 'Montenegro', 'Montenegro', 'الجبل الأسود', (SELECT id FROM ref_region WHERE code = 'AUT'),
        'system'),
       ('MM', 'Myanmar', 'Myanmar', 'Myanmar', 'ميانمار', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('NP', 'Nepal', 'Nepal', 'Nepal', 'نيبال', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('AN', 'Antilles néerlandaises', 'Antilles néerlandaises', 'Netherlands Antilles', 'الأنتيل الهولندية',
        (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('NZ', 'Nouvelle-Zélande', 'Nouvelle-Zélande', 'New Zealand', 'نيوزيلندا',
        (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('NI', 'Nicaragua', 'Nicaragua', 'Nicaragua', 'نيكاراغوا', (SELECT id FROM ref_region WHERE code = 'AUT'),
        'system'),
       ('NO', 'Norvège', 'Norvège', 'Norway', 'النرويج', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('PW', 'Palau', 'Palau', 'Palau', 'بالاو', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('PA', 'Panama', 'Panama', 'Panama', 'بنما', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('PR', 'Puerto Rico', 'Puerto Rico', 'Puerto Rico', 'بورتوريكو', (SELECT id FROM ref_region WHERE code = 'AUT'),
        'system'),
       ('RE', 'La Réunion', 'La Réunion', 'Reunion', 'ريونيون', (SELECT id FROM ref_region WHERE code = 'AUT'),
        'system'),
       ('VC', 'Saint Vincent & Grenadines', 'Saint Vincent & Grenadines', 'Saint Vincent and the Grenadines',
        'سانت فنسنت والغرينادين', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('SM', 'San Marino', 'San Marino', 'San Marino', 'سان مارينو', (SELECT id FROM ref_region WHERE code = 'AUT'),
        'system'),
       ('ST', 'Sao Tomé-et-Principe', 'Sao Tomé-et-Principe', 'Sao Tome and Principe', 'ساو تومي وبرينسيبي',
        (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('SC', 'Seychelles', 'Seychelles', 'Seychelles', 'سيشل', (SELECT id FROM ref_region WHERE code = 'AUT'),
        'system'),
       ('SR', 'Suriname', 'Suriname', 'Suriname', 'سورينام', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('SZ', 'Eswatini', 'Eswatini', 'Eswatini', 'إسواتيني', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('TK', 'Tokelau', 'Tokelau', 'Tokelau', 'توكيلاو', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('TO', 'Tonga', 'Tonga', 'Tonga', 'تونغا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('UA', 'Ukraine', 'Ukraine', 'Ukraine', 'أوكرانيا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('US', 'États-Unis', 'États-Unis', 'United States', 'الولايات المتحدة',
        (SELECT id FROM ref_region WHERE code = 'AUT'), 'system'),
       ('VE', 'Venezuela', 'Venezuela', 'Venezuela', 'فنزويلا', (SELECT id FROM ref_region WHERE code = 'AUT'),
        'system'),
-- Zones spéciales (2 pays)
       ('W0', 'Monde Entier', 'Monde Entier', 'Worldwide', 'العالم كله', (SELECT id FROM ref_region WHERE code = 'WW'),
        'system'),
       ('W1', 'Monde Entier sauf États-Unis', 'Monde Entier sauf États-Unis', 'Worldwide except USA',
        'العالم كله عدا الولايات المتحدة', (SELECT id FROM ref_region WHERE code = 'WW'), 'system'),
       ('AA', 'Afrique', 'Afrique', 'Africa', 'أفريقيا', (SELECT id FROM ref_region WHERE code = 'AUT'), 'system');

-- Insert cities (9 villes - mieux que R1 qui n'en a que 2)
INSERT INTO ref_city (code, name, name_fr, name_en, name_ar, country_id, created_by)
VALUES ('ABD', 'Abidjan', 'Abidjan', 'Abidjan', 'أبيدجان', (SELECT id FROM ref_country WHERE code = 'CI'), 'system'),
       ('OUA', 'Ouagadougou', 'Ouagadougou', 'Ouagadougou', 'واغادوغو', (SELECT id FROM ref_country WHERE code = 'BF'),
        'system'),
       ('DAK', 'Dakar', 'Dakar', 'Dakar', 'داكار', (SELECT id FROM ref_country WHERE code = 'SN'), 'system'),
       ('BAM', 'Bamako', 'Bamako', 'Bamako', 'باماكو', (SELECT id FROM ref_country WHERE code = 'ML'), 'system'),
       ('NIA', 'Niamey', 'Niamey', 'Niamey', 'نيامي', (SELECT id FROM ref_country WHERE code = 'NE'), 'system'),
       ('LOM', 'Lomé', 'Lomé', 'Lome', 'لومي', (SELECT id FROM ref_country WHERE code = 'TG'), 'system'),
       ('COT', 'Cotonou', 'Cotonou', 'Cotonou', 'كوتونو', (SELECT id FROM ref_country WHERE code = 'BJ'), 'system'),
       ('DOU', 'Douala', 'Douala', 'Douala', 'دوالا', (SELECT id FROM ref_country WHERE code = 'CM'), 'system'),
       ('CAS', 'Casablanca', 'Casablanca', 'Casablanca', 'الدار البيضاء',
        (SELECT id FROM ref_country WHERE code = 'MA'), 'system');

--changeset system:2-insert-missing-currencies
-- Insert basic currency
INSERT INTO ref_currency (code, name, name_fr, name_en, name_ar, is_active, created_by)
VALUES ('XOF', 'Franc CFA (BCEAO)', 'Franc CFA (BCEAO)', 'CFA Franc (BCEAO)', 'فرنك أفريقيا الوسطى (بسياو)', true,
        'system'),
       ('XAF', 'Franc CFA (BEAC)', 'Franc CFA (BEAC)', 'CFA Franc (BEAC)', 'فرنك أفريقيا الوسطى (بياك)', true,
        'system'),
       ('EUR', 'Euro', 'Euro', 'Euro', 'يورو', true, 'system'),
       ('USD', 'Dollar américain', 'Dollar américain', 'US Dollar', 'دولار أمريكي', true, 'system'),
       ('GBP', 'Livre sterling', 'Livre sterling', 'British Pound', 'جنيه إسترليني', true, 'system'),
       ('CHF', 'Franc suisse', 'Franc suisse', 'Swiss Franc', 'فرنك سويسري', true, 'system'),
       ('GNF', 'Franc guinéen', 'Franc guinéen', 'Guinean Franc', 'فرنك غيني', true, 'system'),
       ('MRU', 'Ouguiya mauritanienne', 'Ouguiya mauritanienne', 'Mauritanian Ouguiya', 'أوقية موريتانية', true,
        'system'),
       ('CDF', 'Franc congolais', 'Franc congolais', 'Congolese Franc', 'فرنك كونغولي', false, 'system'),
       ('NGN', 'Naira nigérian', 'Naira nigérian', 'Nigerian Naira', 'نايرا نيجيري', false, 'system'),
       ('GHS', 'Cedi ghanéen', 'Cedi ghanéen', 'Ghanaian Cedi', 'سيدي غاني', false, 'system'),
       ('LRD', 'Dollar libérien', 'Dollar libérien', 'Liberian Dollar', 'دولار ليبيري', false, 'system'),
       ('MAD', 'Dirham marocain', 'Dirham marocain', 'Moroccan Dirham', 'درهم مغربي', false, 'system');
--comment: Insert missing currencies from R1 (163 currencies total)
INSERT INTO ref_currency (code, name, name_fr, name_en, name_ar, is_active, created_by)
VALUES ('NN', 'N/A', 'N/A', 'N/A', 'غير محدد', false, 'system'),
       ('AED', 'Dirham des Émirats arabes unis', 'Dirham des Émirats arabes unis', 'UAE Dirham', 'درهم إماراتي', false,
        'system'),
       ('AFN', 'Afghani afghan', 'Afghani afghan', 'Afghan Afghani', 'أفغاني', false, 'system'),
       ('ALL', 'Lek albanais', 'Lek albanais', 'Albanian Lek', 'ليك ألباني', false, 'system'),
       ('AMD', 'Dram arménien', 'Dram arménien', 'Armenian Dram', 'درام أرميني', false, 'system'),
       ('ANG', 'Florin antillais', 'Florin antillais', 'Netherlands Antillean Guilder', 'غيلدر أنتيلي', false,
        'system'),
       ('AOA', 'Kwanza angolais', 'Kwanza angolais', 'Angolan Kwanza', 'كوانزا أنغولي', false, 'system'),
       ('ARS', 'Peso argentin', 'Peso argentin', 'Argentine Peso', 'بيزو أرجنتيني', false, 'system'),
       ('AUD', 'Dollar australien', 'Dollar australien', 'Australian Dollar', 'دولار أسترالي', false, 'system'),
       ('AWG', 'Florin arubais', 'Florin arubais', 'Aruban Florin', 'فلورين أروبي', false, 'system'),
       ('AZN', 'Manat azerbaïdjanais', 'Manat azerbaïdjanais', 'Azerbaijani Manat', 'مانات أذربيجاني', false, 'system'),
       ('BAM', 'Mark convertible', 'Mark convertible de Bosnie-Herzégovine', 'Bosnia-Herzegovina Convertible Mark',
        'مارك بوسني', false, 'system'),
       ('BBD', 'Dollar barbadien', 'Dollar barbadien', 'Barbadian Dollar', 'دولار بربادوسي', false, 'system'),
       ('BDT', 'Taka bangladais', 'Taka bangladais', 'Bangladeshi Taka', 'تاكا بنغلاديشي', false, 'system'),
       ('BGN', 'Lev bulgare', 'Lev bulgare', 'Bulgarian Lev', 'ليف بلغاري', false, 'system'),
       ('BHD', 'Dinar bahreïni', 'Dinar bahreïni', 'Bahraini Dinar', 'دينار بحريني', false, 'system'),
       ('BIF', 'Franc burundais', 'Franc burundais', 'Burundian Franc', 'فرنك بوروندي', false, 'system'),
       ('BMD', 'Dollar bermudien', 'Dollar bermudien', 'Bermudian Dollar', 'دولار برمودي', false, 'system'),
       ('BND', 'Dollar brunéien', 'Dollar brunéien', 'Brunei Dollar', 'دولار بروناي', false, 'system'),
       ('BOB', 'Boliviano bolivien', 'Boliviano bolivien', 'Bolivian Boliviano', 'بوليفيانو بوليفي', false, 'system'),
       ('BRL', 'Réal brésilien', 'Réal brésilien', 'Brazilian Real', 'ريال برازيلي', false, 'system'),
       ('BSD', 'Dollar bahaméen', 'Dollar bahaméen', 'Bahamian Dollar', 'دولار بهامي', false, 'system'),
       ('BTN', 'Ngultrum bhoutanais', 'Ngultrum bhoutanais', 'Bhutanese Ngultrum', 'نولتروم بوتاني', false, 'system'),
       ('BWP', 'Pula botswanais', 'Pula botswanais', 'Botswanan Pula', 'بولا بوتسواني', false, 'system'),
       ('BYN', 'Rouble biélorusse', 'Rouble biélorusse', 'Belarusian Ruble', 'روبل بيلاروسي', false, 'system'),
       ('BZD', 'Dollar bélizien', 'Dollar bélizien', 'Belize Dollar', 'دولار بليزي', false, 'system'),
       ('CAD', 'Dollar canadien', 'Dollar canadien', 'Canadian Dollar', 'دولار كندي', false, 'system'),
       ('CLP', 'Peso chilien', 'Peso chilien', 'Chilean Peso', 'بيزو شيلي', false, 'system'),
       ('CNY', 'Yuan chinois', 'Yuan chinois', 'Chinese Yuan', 'يوان صيني', false, 'system'),
       ('COP', 'Peso colombien', 'Peso colombien', 'Colombian Peso', 'بيزو كولومبي', false, 'system'),
       ('CRC', 'Colón costaricain', 'Colón costaricain', 'Costa Rican Colón', 'كولون كوستاريكي', false, 'system'),
       ('CUC', 'Peso cubain convertible', 'Peso cubain convertible', 'Cuban Convertible Peso', 'بيزو كوبي قابل للتحويل',
        false, 'system'),
       ('CUP', 'Peso cubain', 'Peso cubain', 'Cuban Peso', 'بيزو كوبي', false, 'system'),
       ('CVE', 'Escudo cap-verdien', 'Escudo cap-verdien', 'Cape Verdean Escudo', 'إسكودو الرأس الأخضر', false,
        'system'),
       ('CZK', 'Couronne tchèque', 'Couronne tchèque', 'Czech Koruna', 'كرونة تشيكية', false, 'system'),
       ('DJF', 'Franc djiboutien', 'Franc djiboutien', 'Djiboutian Franc', 'فرنك جيبوتي', false, 'system'),
       ('DKK', 'Couronne danoise', 'Couronne danoise', 'Danish Krone', 'كرونة دنماركية', false, 'system'),
       ('DOP', 'Peso dominicain', 'Peso dominicain', 'Dominican Peso', 'بيزو دومينيكاني', false, 'system'),
       ('DZD', 'Dinar algérien', 'Dinar algérien', 'Algerian Dinar', 'دينار جزائري', false, 'system'),
       ('EGP', 'Livre égyptienne', 'Livre égyptienne', 'Egyptian Pound', 'جنيه مصري', false, 'system'),
       ('ERN', 'Nakfa érythréen', 'Nakfa érythréen', 'Eritrean Nakfa', 'ناكفا إريتري', false, 'system'),
       ('ETB', 'Birr éthiopien', 'Birr éthiopien', 'Ethiopian Birr', 'بير إثيوبي', false, 'system'),
       ('FJD', 'Dollar fidjien', 'Dollar fidjien', 'Fijian Dollar', 'دولار فيجي', false, 'system'),
       ('FKP', 'Livre des îles Falkland', 'Livre des îles Falkland', 'Falkland Islands Pound', 'جنيه جزر فوكلاند',
        false, 'system'),
       ('GEL', 'Lari géorgien', 'Lari géorgien', 'Georgian Lari', 'لاري جورجي', false, 'system'),
       ('GIP', 'Livre de Gibraltar', 'Livre de Gibraltar', 'Gibraltar Pound', 'جنيه جبل طارق', false, 'system'),
       ('GMD', 'Dalasi gambien', 'Dalasi gambien', 'Gambian Dalasi', 'دالاسي غامبي', false, 'system'),
       ('GTQ', 'Quetzal guatémaltèque', 'Quetzal guatémaltèque', 'Guatemalan Quetzal', 'كيتزال غواتيمالي', false,
        'system'),
       ('GYD', 'Dollar guyanien', 'Dollar guyanien', 'Guyanese Dollar', 'دولار غياني', false, 'system'),
       ('HKD', 'Dollar de Hong Kong', 'Dollar de Hong Kong', 'Hong Kong Dollar', 'دولار هونغ كونغ', false, 'system'),
       ('HNL', 'Lempira hondurien', 'Lempira hondurien', 'Honduran Lempira', 'لمبيرا هندوراسي', false, 'system'),
       ('HRK', 'Kuna croate', 'Kuna croate', 'Croatian Kuna', 'كونا كرواتية', false, 'system'),
       ('HTG', 'Gourde haïtienne', 'Gourde haïtienne', 'Haitian Gourde', 'غورد هايتي', false, 'system'),
       ('HUF', 'Forint hongrois', 'Forint hongrois', 'Hungarian Forint', 'فورنت مجري', false, 'system'),
       ('IDR', 'Roupie indonésienne', 'Roupie indonésienne', 'Indonesian Rupiah', 'روبية إندونيسية', false, 'system'),
       ('ILS', 'Shekel israélien', 'Shekel israélien', 'Israeli New Shekel', 'شيكل إسرائيلي', false, 'system'),
       ('INR', 'Roupie indienne', 'Roupie indienne', 'Indian Rupee', 'روبية هندية', false, 'system'),
       ('IQD', 'Dinar irakien', 'Dinar irakien', 'Iraqi Dinar', 'دينار عراقي', false, 'system'),
       ('IRR', 'Rial iranien', 'Rial iranien', 'Iranian Rial', 'ريال إيراني', false, 'system'),
       ('ISK', 'Couronne islandaise', 'Couronne islandaise', 'Icelandic Króna', 'كرونة آيسلندية', false, 'system'),
       ('JMD', 'Dollar jamaïcain', 'Dollar jamaïcain', 'Jamaican Dollar', 'دولار جامايكي', false, 'system'),
       ('JOD', 'Dinar jordanien', 'Dinar jordanien', 'Jordanian Dinar', 'دينار أردني', false, 'system'),
       ('JPY', 'Yen japonais', 'Yen japonais', 'Japanese Yen', 'ين ياباني', false, 'system'),
       ('KES', 'Shilling kényan', 'Shilling kényan', 'Kenyan Shilling', 'شلن كيني', false, 'system'),
       ('KGS', 'Som kirghize', 'Som kirghize', 'Kyrgystani Som', 'سوم قيرغيزي', false, 'system'),
       ('KHR', 'Riel cambodgien', 'Riel cambodgien', 'Cambodian Riel', 'رييل كمبودي', false, 'system'),
       ('KMF', 'Franc comorien', 'Franc comorien', 'Comorian Franc', 'فرنك قمري', false, 'system'),
       ('KPW', 'Won nord-coréen', 'Won nord-coréen', 'North Korean Won', 'وون كوري شمالي', false, 'system'),
       ('KRW', 'Won sud-coréen', 'Won sud-coréen', 'South Korean Won', 'وون كوري جنوبي', false, 'system'),
       ('KWD', 'Dinar koweïtien', 'Dinar koweïtien', 'Kuwaiti Dinar', 'دينار كويتي', false, 'system'),
       ('KYD', 'Dollar des îles Caïmans', 'Dollar des îles Caïmans', 'Cayman Islands Dollar', 'دولار جزر كايمان', false,
        'system'),
       ('KZT', 'Tenge kazakh', 'Tenge kazakh', 'Kazakhstani Tenge', 'تنغي كازاخستاني', false, 'system'),
       ('LAK', 'Kip laotien', 'Kip laotien', 'Lao Kip', 'كيب لاوي', false, 'system'),
       ('LBP', 'Livre libanaise', 'Livre libanaise', 'Lebanese Pound', 'ليرة لبنانية', false, 'system'),
       ('LKR', 'Roupie srilankaise', 'Roupie srilankaise', 'Sri Lankan Rupee', 'روبية سريلانكية', false, 'system'),
       ('LSL', 'Loti lesothan', 'Loti lesothan', 'Lesotho Loti', 'لوتي ليسوتو', false, 'system'),
       ('LYD', 'Dinar libyen', 'Dinar libyen', 'Libyan Dinar', 'دينار ليبي', false, 'system'),
       ('MDL', 'Leu moldave', 'Leu moldave', 'Moldovan Leu', 'ليو مولدوفي', false, 'system'),
       ('MGA', 'Ariary malgache', 'Ariary malgache', 'Malagasy Ariary', 'أرياري ملغاشي', false, 'system'),
       ('MKD', 'Denar macédonien', 'Denar macédonien', 'Macedonian Denar', 'دينار مقدوني', false, 'system'),
       ('MMK', 'Kyat birman', 'Kyat birman', 'Myanmar Kyat', 'كيات ميانماري', false, 'system'),
       ('MNT', 'Tugrik mongol', 'Tugrik mongol', 'Mongolian Tugrik', 'توغريك منغولي', false, 'system'),
       ('MOP', 'Pataca macanaise', 'Pataca macanaise', 'Macanese Pataca', 'باتاكا ماكاوية', false, 'system'),
       ('MUR', 'Roupie mauricienne', 'Roupie mauricienne', 'Mauritian Rupee', 'روبية موريشية', false, 'system'),
       ('MVR', 'Rufiyaa maldivienne', 'Rufiyaa maldivienne', 'Maldivian Rufiyaa', 'روفيا مالديفية', false, 'system'),
       ('MWK', 'Kwacha malawien', 'Kwacha malawien', 'Malawian Kwacha', 'كواشا مالاوي', false, 'system'),
       ('MXN', 'Peso mexicain', 'Peso mexicain', 'Mexican Peso', 'بيزو مكسيكي', false, 'system'),
       ('MYR', 'Ringgit malaisien', 'Ringgit malaisien', 'Malaysian Ringgit', 'رينغيت ماليزي', false, 'system'),
       ('MZN', 'Metical mozambicain', 'Metical mozambicain', 'Mozambican Metical', 'ميتيكال موزمبيقي', false, 'system'),
       ('NAD', 'Dollar namibien', 'Dollar namibien', 'Namibian Dollar', 'دولار ناميبي', false, 'system'),
       ('NIO', 'Córdoba nicaraguayen', 'Córdoba nicaraguayen', 'Nicaraguan Córdoba', 'كوردوبا نيكاراغوي', false,
        'system'),
       ('NOK', 'Couronne norvégienne', 'Couronne norvégienne', 'Norwegian Krone', 'كرونة نرويجية', false, 'system'),
       ('NPR', 'Roupie népalaise', 'Roupie népalaise', 'Nepalese Rupee', 'روبية نيبالية', false, 'system'),
       ('NZD', 'Dollar néo-zélandais', 'Dollar néo-zélandais', 'New Zealand Dollar', 'دولار نيوزيلندي', false,
        'system'),
       ('OMR', 'Rial omanais', 'Rial omanais', 'Omani Rial', 'ريال عماني', false, 'system'),
       ('PAB', 'Balboa panaméen', 'Balboa panaméen', 'Panamanian Balboa', 'بالبوا بنمي', false, 'system'),
       ('PEN', 'Sol péruvien', 'Sol péruvien', 'Peruvian Sol', 'سول بيروفي', false, 'system'),
       ('PGK', 'Kina papou-néo-guinéen', 'Kina papou-néo-guinéen', 'Papua New Guinean Kina', 'كينا بابوا غينيا الجديدة',
        false, 'system'),
       ('PHP', 'Peso philippin', 'Peso philippin', 'Philippine Peso', 'بيزو فلبيني', false, 'system'),
       ('PKR', 'Roupie pakistanaise', 'Roupie pakistanaise', 'Pakistani Rupee', 'روبية باكستانية', false, 'system'),
       ('PLN', 'Złoty polonais', 'Złoty polonais', 'Polish Zloty', 'زلوتي بولندي', false, 'system'),
       ('PYG', 'Guarani paraguayen', 'Guarani paraguayen', 'Paraguayan Guarani', 'غواراني باراغواي', false, 'system'),
       ('QAR', 'Riyal qatari', 'Riyal qatari', 'Qatari Riyal', 'ريال قطري', false, 'system'),
       ('RON', 'Leu roumain', 'Leu roumain', 'Romanian Leu', 'ليو روماني', false, 'system'),
       ('RSD', 'Dinar serbe', 'Dinar serbe', 'Serbian Dinar', 'دينار صربي', false, 'system'),
       ('RUB', 'Rouble russe', 'Rouble russe', 'Russian Ruble', 'روبل روسي', false, 'system'),
       ('RWF', 'Franc rwandais', 'Franc rwandais', 'Rwandan Franc', 'فرنك رواندي', false, 'system'),
       ('SAR', 'Riyal saoudien', 'Riyal saoudien', 'Saudi Riyal', 'ريال سعودي', false, 'system'),
       ('SBD', 'Dollar des îles Salomon', 'Dollar des îles Salomon', 'Solomon Islands Dollar', 'دولار جزر سليمان',
        false, 'system'),
       ('SCR', 'Roupie seychelloise', 'Roupie seychelloise', 'Seychellois Rupee', 'روبية سيشيلية', false, 'system'),
       ('SDG', 'Livre soudanaise', 'Livre soudanaise', 'Sudanese Pound', 'جنيه سوداني', false, 'system'),
       ('SEK', 'Couronne suédoise', 'Couronne suédoise', 'Swedish Krona', 'كرونة سويدية', false, 'system'),
       ('SGD', 'Dollar de Singapour', 'Dollar de Singapour', 'Singapore Dollar', 'دولار سنغافوري', false, 'system'),
       ('SHP', 'Livre de Sainte-Hélène', 'Livre de Sainte-Hélène', 'Saint Helena Pound', 'جنيه سانت هيلانة', false,
        'system'),
       ('SLL', 'Leone sierra-léonais', 'Leone sierra-léonais', 'Sierra Leonean Leone', 'ليون سيراليوني', false,
        'system'),
       ('SOS', 'Shilling somalien', 'Shilling somalien', 'Somali Shilling', 'شلن صومالي', false, 'system'),
       ('SRD', 'Dollar surinamais', 'Dollar surinamais', 'Surinamese Dollar', 'دولار سورينامي', false, 'system'),
       ('SSP', 'Livre sud-soudanaise', 'Livre sud-soudanaise', 'South Sudanese Pound', 'جنيه جنوب سوداني', false,
        'system'),
       ('STN', 'Dobra santoméen', 'Dobra santoméen', 'São Tomé and Príncipe Dobra', 'دوبرا ساو تومي', false, 'system'),
       ('SVC', 'Colón salvadorien', 'Colón salvadorien', 'Salvadoran Colón', 'كولون سلفادوري', false, 'system'),
       ('SYP', 'Livre syrienne', 'Livre syrienne', 'Syrian Pound', 'ليرة سورية', false, 'system'),
       ('SZL', 'Lilangeni swazi', 'Lilangeni swazi', 'Swazi Lilangeni', 'ليلانجيني سوازي', false, 'system'),
       ('THB', 'Baht thaïlandais', 'Baht thaïlandais', 'Thai Baht', 'بات تايلاندي', false, 'system'),
       ('TJS', 'Somoni tadjik', 'Somoni tadjik', 'Tajikistani Somoni', 'سوموني طاجيكي', false, 'system'),
       ('TMT', 'Manat turkmène', 'Manat turkmène', 'Turkmenistan Manat', 'مانات تركماني', false, 'system'),
       ('TND', 'Dinar tunisien', 'Dinar tunisien', 'Tunisian Dinar', 'دينار تونسي', false, 'system'),
       ('TOP', 'Paanga tongan', 'Paanga tongan', 'Tongan Paʻanga', 'بانغا تونغي', false, 'system'),
       ('TRY', 'Livre turque', 'Livre turque', 'Turkish Lira', 'ليرة تركية', false, 'system'),
       ('TTD', 'Dollar trinidadien', 'Dollar trinidadien', 'Trinidad and Tobago Dollar', 'دولار ترينيداد وتوباغو',
        false, 'system'),
       ('TWD', 'Dollar taïwanais', 'Dollar taïwanais', 'New Taiwan Dollar', 'دولار تايواني جديد', false, 'system'),
       ('TZS', 'Shilling tanzanien', 'Shilling tanzanien', 'Tanzanian Shilling', 'شلن تنزاني', false, 'system'),
       ('UAH', 'Hryvnia ukrainienne', 'Hryvnia ukrainienne', 'Ukrainian Hryvnia', 'هريفنيا أوكرانية', false, 'system'),
       ('UGX', 'Shilling ougandais', 'Shilling ougandais', 'Ugandan Shilling', 'شلن أوغندي', false, 'system'),
       ('UYU', 'Peso uruguayen', 'Peso uruguayen', 'Uruguayan Peso', 'بيزو أوروغواي', false, 'system'),
       ('UZS', 'Sum ouzbek', 'Sum ouzbek', 'Uzbekistani Som', 'سوم أوزبكي', false, 'system'),
       ('VES', 'Bolívar vénézuélien', 'Bolívar vénézuélien', 'Venezuelan Bolívar', 'بوليفار فنزويلي', false, 'system'),
       ('VND', 'Dong vietnamien', 'Dong vietnamien', 'Vietnamese Dong', 'دونغ فيتنامي', false, 'system'),
       ('VUV', 'Vatu vanuatuan', 'Vatu vanuatuan', 'Vanuatu Vatu', 'فاتو فانواتو', false, 'system'),
       ('WST', 'Tala samoan', 'Tala samoan', 'Samoan Tala', 'تالا ساموي', false, 'system'),
       ('XCD', 'Dollar des Caraïbes orientales', 'Dollar des Caraïbes orientales', 'East Caribbean Dollar',
        'دولار شرق الكاريبي', false, 'system'),
       ('XPF', 'Franc CFP', 'Franc CFP', 'CFP Franc', 'فرنك سي إف بي', false, 'system'),
       ('YER', 'Rial yéménite', 'Rial yéménite', 'Yemeni Rial', 'ريال يمني', false, 'system'),
       ('ZAR', 'Rand sud-africain', 'Rand sud-africain', 'South African Rand', 'راند جنوب أفريقي', false, 'system'),
       ('ZMW', 'Kwacha zambien', 'Kwacha zambien', 'Zambian Kwacha', 'كواشا زامبي', false, 'system');

--changeset system:3-insert-currency-exchange-rates
--comment: Insert currency exchange rates from R1
INSERT INTO ref_currency_exchange (period_id, currency_id, rate, created_by)
VALUES
-- 2024 January rates
((SELECT id FROM ref_period WHERE year = 2024 AND month = 1),
(SELECT id FROM ref_currency WHERE code = 'GNF'), 17.00000, 'system'),
((SELECT id FROM ref_period WHERE year = 2024 AND month = 1), (SELECT id FROM ref_currency WHERE code = 'MRU'), 0.06000, 'system'),
((SELECT id FROM ref_period WHERE year = 2024 AND month = 1), (SELECT id FROM ref_currency WHERE code = 'USD'), 0.00162, 'system'),
((SELECT id FROM ref_period WHERE year = 2024 AND month = 1), (SELECT id FROM ref_currency WHERE code = 'XAF'), 1.00000, 'system'),
((SELECT id FROM ref_period WHERE year = 2024 AND month = 1), (SELECT id FROM ref_currency WHERE code = 'XOF'), 1.00000, 'system'),
-- 2024 December rates
((SELECT id FROM ref_period WHERE year = 2024 AND month = 12), (SELECT id FROM ref_currency WHERE code = 'GNF'), 17.00000, 'system'),
((SELECT id FROM ref_period WHERE year = 2024 AND month = 12), (SELECT id FROM ref_currency WHERE code = 'MRU'), 0.06000, 'system'),
((SELECT id FROM ref_period WHERE year = 2024 AND month = 12), (SELECT id FROM ref_currency WHERE code = 'USD'), 0.00162, 'system'),
((SELECT id FROM ref_period WHERE year = 2024 AND month = 12), (SELECT id FROM ref_currency WHERE code = 'XAF'), 1.00000, 'system'),
((SELECT id FROM ref_period WHERE year = 2024 AND month = 12), (SELECT id FROM ref_currency WHERE code = 'XOF'), 1.00000, 'system'),
-- 2025 January rates
((SELECT id FROM ref_period WHERE year = 2025 AND month = 1), (SELECT id FROM ref_currency WHERE code = 'GNF'), 17.00000, 'system'),
((SELECT id FROM ref_period WHERE year = 2025 AND month = 1), (SELECT id FROM ref_currency WHERE code = 'MRU'), 0.06000, 'system'),
((SELECT id FROM ref_period WHERE year = 2025 AND month = 1), (SELECT id FROM ref_currency WHERE code = 'USD'), 0.00162, 'system'),
((SELECT id FROM ref_period WHERE year = 2025 AND month = 1), (SELECT id FROM ref_currency WHERE code = 'XAF'), 1.00000, 'system'),
((SELECT id FROM ref_period WHERE year = 2025 AND month = 1), (SELECT id FROM ref_currency WHERE code = 'XOF'), 1.00000, 'system');


-- Insert partner types
INSERT INTO ref_partner_type (code, name, name_fr, name_en, name_ar, created_by)
VALUES ('CEDANT', 'Cédant', 'Cédant', 'Cedant', 'المتنازل', 'system'),
       ('BROKER', 'Courtier', 'Courtier', 'Broker', 'وسيط', 'system'),
       ('OTHER', 'Autre', 'Autre', 'Other', 'أخرى', 'system');

-- Insert rating data
INSERT INTO ref_rating (code, name, name_fr, name_en, name_ar, description, numeric_value, created_by)
VALUES ('N/A', 'Non évalué', 'Non évalué', 'Not Rated', 'غير مقيم', 'Non évalué', 0, 'system'),
       ('AAA', 'AAA', 'AAA', 'AAA', 'AAA', 'AAA', 95, 'system'),
       ('AA+', 'AA+', 'AA+', 'AA+', 'AA+', 'AA+', 90, 'system'),
       ('AA', 'AA', 'AA', 'AA', 'AA', 'AA', 85, 'system'),
       ('AA-', 'AA-', 'AA-', 'AA-', 'AA-', 'AA-', 80, 'system'),
       ('A+', 'A+', 'A+', 'A+', 'A+', 'A+', 75, 'system'),
       ('A', 'A', 'A', 'A', 'A', 'A', 70, 'system'),
       ('A-', 'A-', 'A-', 'A-', 'A-', 'A-', 65, 'system'),
       ('BBB+', 'BBB+', 'BBB+', 'BBB+', 'BBB+', 'BBB+', 60, 'system'),
       ('BBB', 'BBB', 'BBB', 'BBB', 'BBB', 'BBB', 55, 'system'),
       ('BBB-', 'BBB-', 'BBB-', 'BBB-', 'BBB-', 'BBB-', 50, 'system'),
       ('BB+', 'BB+', 'BB+', 'BB+', 'BB+', 'BB+', 45, 'system'),
       ('BB', 'BB', 'BB', 'BB', 'BB', 'BB', 40, 'system'),
       ('BB-', 'BB-', 'BB-', 'BB-', 'BB-', 'BB-', 35, 'system'),
       ('B++', 'B++', 'B++', 'B++', 'B++', 'B++', 32, 'system'),
       ('B+', 'B+', 'B+', 'B+', 'B+', 'B+', 30, 'system'),
       ('B', 'B', 'B', 'B', 'B', 'B', 25, 'system'),
       ('B-', 'B-', 'B-', 'B-', 'B-', 'B-', 20, 'system');


--changeset system:12-insert-all-partners-data
--comment: Insertion de tous les partenaires depuis R1
INSERT INTO ref_partner (code, name, short_name, partner_type_id, region_id, country_id, currency_id, rating_id,
                         is_reinsurer, is_inwards, is_outwards, created_by)
VALUES ('CI0C000000', 'Sunu Réassurance', 'Sunu Ré', (SELECT id FROM ref_partner_type WHERE code = 'CEDANT'),
        (SELECT id FROM ref_region WHERE code = 'CIMA'), (SELECT id FROM ref_country WHERE code = 'CI'),
        (SELECT id FROM ref_currency WHERE code = 'XOF'), (SELECT id FROM ref_rating WHERE code = 'N/A'), TRUE, FALSE,
        FALSE, 'system'),
       ('AE0B000001', 'Gallagher Reinsurance', 'Gallagher Re', (SELECT id FROM ref_partner_type WHERE code = 'BROKER'),
        (SELECT id FROM ref_region WHERE code = 'AUT'), (SELECT id FROM ref_country WHERE code = 'AE'),
        (SELECT id FROM ref_currency WHERE code = 'XOF'), (SELECT id FROM ref_rating WHERE code = 'N/A'), FALSE, TRUE,
        TRUE, 'system'),
       ('CD0C000001', 'ZEP Re (PTA Reinsurance Company) RDC', 'Zep Re RDC',
        (SELECT id FROM ref_partner_type WHERE code = 'CEDANT'), (SELECT id FROM ref_region WHERE code = 'HCFRA'),
        (SELECT id FROM ref_country WHERE code = 'CD'), (SELECT id FROM ref_currency WHERE code = 'XOF'),
        (SELECT id FROM ref_rating WHERE code = 'B++'), TRUE, TRUE, TRUE, 'system'),
       ('CH0C000001', 'Swiss Reinsurance', 'Swiss Re', (SELECT id FROM ref_partner_type WHERE code = 'CEDANT'),
        (SELECT id FROM ref_region WHERE code = 'AUT'), (SELECT id FROM ref_country WHERE code = 'CH'),
        (SELECT id FROM ref_currency WHERE code = 'XOF'), (SELECT id FROM ref_rating WHERE code = 'A'), TRUE, TRUE,
        TRUE, 'system'),
       ('CI0B000001', 'AMGS Abidjan', 'AMGS', (SELECT id FROM ref_partner_type WHERE code = 'BROKER'),
        (SELECT id FROM ref_region WHERE code = 'CIMA'), (SELECT id FROM ref_country WHERE code = 'CI'),
        (SELECT id FROM ref_currency WHERE code = 'XOF'), (SELECT id FROM ref_rating WHERE code = 'N/A'), FALSE, TRUE,
        TRUE, 'system'),
       ('CI0C000005', 'Africa Re Abidjan', 'Africa Re', (SELECT id FROM ref_partner_type WHERE code = 'CEDANT'),
        (SELECT id FROM ref_region WHERE code = 'CIMA'), (SELECT id FROM ref_country WHERE code = 'CI'),
        (SELECT id FROM ref_currency WHERE code = 'XOF'), (SELECT id FROM ref_rating WHERE code = 'A-'), TRUE, TRUE,
        TRUE, 'system'),
       ('CI0C000007', 'CICA Reinsurance Abidjan', 'CICA Re', (SELECT id FROM ref_partner_type WHERE code = 'CEDANT'),
        (SELECT id FROM ref_region WHERE code = 'CIMA'), (SELECT id FROM ref_country WHERE code = 'CI'),
        (SELECT id FROM ref_currency WHERE code = 'XOF'), (SELECT id FROM ref_rating WHERE code = 'B+'), TRUE, TRUE,
        TRUE, 'system'),
       ('DE0C000001', 'Munich Re', 'Munich Re', (SELECT id FROM ref_partner_type WHERE code = 'CEDANT'),
        (SELECT id FROM ref_region WHERE code = 'AUT'), (SELECT id FROM ref_country WHERE code = 'DE'),
        (SELECT id FROM ref_currency WHERE code = 'XOF'), (SELECT id FROM ref_rating WHERE code = 'AA'), TRUE, TRUE,
        TRUE, 'system'),
       ('MA0C000001', 'Société Centrale de Réassurance', 'SCR', (SELECT id FROM ref_partner_type WHERE code = 'CEDANT'),
        (SELECT id FROM ref_region WHERE code = 'AUT'), (SELECT id FROM ref_country WHERE code = 'MA'),
        (SELECT id FROM ref_currency WHERE code = 'XOF'), (SELECT id FROM ref_rating WHERE code = 'B++'), TRUE, TRUE,
        TRUE, 'system'),
       ('US0C000001', 'American International Group', 'AIG', (SELECT id FROM ref_partner_type WHERE code = 'CEDANT'),
        (SELECT id FROM ref_region WHERE code = 'AUT'), (SELECT id FROM ref_country WHERE code = 'US'),
        (SELECT id FROM ref_currency WHERE code = 'XOF'), (SELECT id FROM ref_rating WHERE code = 'A+'), TRUE, TRUE,
        TRUE, 'system');

-- Insert SUNU group partners
INSERT INTO ref_partner (code, name, short_name, partner_type_id, region_id, country_id, currency_id, rating_id,
                         is_reinsurer, is_inwards, is_outwards, parent_partner_id, created_by)
VALUES ('CI0C000015', 'Sunu Assurances Iard Côte d''Ivoire', 'Sunu Iard CI',
        (SELECT id FROM ref_partner_type WHERE code = 'CEDANT'), (SELECT id FROM ref_region WHERE code = 'CIMA'),
        (SELECT id FROM ref_country WHERE code = 'CI'), (SELECT id FROM ref_currency WHERE code = 'XOF'),
        (SELECT id FROM ref_rating WHERE code = 'N/A'), FALSE, TRUE, FALSE,
        (SELECT id FROM ref_partner WHERE code = 'CI0C000000'), 'system'),
       ('SN0C000001', 'Sunu Assurances Iard Senegal', 'Sunu Iard SN',
        (SELECT id FROM ref_partner_type WHERE code = 'CEDANT'), (SELECT id FROM ref_region WHERE code = 'CIMA'),
        (SELECT id FROM ref_country WHERE code = 'SN'), (SELECT id FROM ref_currency WHERE code = 'XOF'),
        (SELECT id FROM ref_rating WHERE code = 'N/A'), FALSE, TRUE, FALSE,
        (SELECT id FROM ref_partner WHERE code = 'CI0C000000'), 'system'),
       ('BJ0C000001', 'Sunu Assurances Iard Benin', 'Sunu Iard BJ',
        (SELECT id FROM ref_partner_type WHERE code = 'CEDANT'), (SELECT id FROM ref_region WHERE code = 'CIMA'),
        (SELECT id FROM ref_country WHERE code = 'BJ'), (SELECT id FROM ref_currency WHERE code = 'XOF'),
        (SELECT id FROM ref_rating WHERE code = 'N/A'), FALSE, TRUE, FALSE,
        (SELECT id FROM ref_partner WHERE code = 'CI0C000000'), 'system');


--changeset system:4-insert-location-data
--comment: Insertion des données de localisation
INSERT INTO ref_location (code, name, partner_id, city_id, reporting_currency_id, current_period_id,
                          locale, decimal_places, percentage_decimal_places, settlement_tolerance, uncovered_tolerance,
                          factoring_ind, default_bank_account, created_by)
VALUES ('L1', 'Siège Abidjan',
        (SELECT id FROM ref_partner WHERE code = 'CI0C000000'),
        (SELECT id FROM ref_city WHERE code = 'ABD'),
        (SELECT id FROM ref_currency WHERE code = 'XOF'),
        (SELECT id FROM ref_period WHERE year = 2024 AND month = 1), 'fr-FR', 2, 8, 5.00000, 0, FALSE, 1, 'system');

--changeset system:5-insert-division-data
--comment: Insertion des données de division
INSERT INTO ref_division (code, name, location_id, created_by)
VALUES ('F01', 'Facultative', (SELECT id FROM ref_location WHERE code = 'L1'), 'system'),
       ('T01', 'Traité', (SELECT id FROM ref_location WHERE code = 'L1'), 'system');



--changeset system:7-insert-profit-centre-data
--comment: Insertion des données de centres de profit
INSERT INTO ref_profit_center (code, name, name_fr, location_id, division_id, manager_id, created_by)
VALUES ('F1', 'Département Facultative', 'Département Facultative', (SELECT id FROM ref_location WHERE code = 'L1'),
        (SELECT id FROM ref_division WHERE code = 'F01'), (SELECT id FROM ref_user_detail WHERE username = 'admin'),
        'system'),
       ('T1', 'Département Traité', 'Département Traité', (SELECT id FROM ref_location WHERE code = 'L1'),
        (SELECT id FROM ref_division WHERE code = 'T01'), (SELECT id FROM ref_user_detail WHERE username = 'admin'),
        'system');


--changeset system:4-insert-missing-occupancy-groups
--comment: Insert missing occupancy groups from R1
INSERT INTO ref_occupancy_group (code, name, name_fr, name_en, name_ar, created_by)
VALUES ('N/A', 'N/A', 'N/A', 'N/A', 'غير محدد', 'system'),
       ('IND', 'Industrie', 'Industrie', 'Industry', 'الصناعة', 'system'),
       ('TRA', 'Transport', 'Transport', 'Transport', 'النقل', 'system'),
       ('CON', 'Construction', 'Construction', 'Construction', 'البناء', 'system'),
       ('TEC', 'Technologie', 'Technologie', 'Technology', 'التكنولوجيا', 'system'),
       ('SAN', 'Santé', 'Santé', 'Health', 'الصحة', 'system'),
       ('AGR', 'Agriculture', 'Agriculture', 'Agriculture', 'الزراعة', 'system'),
       ('SER', 'Services', 'Services', 'Services', 'الخدمات', 'system'),
       ('EME', 'Émergents', 'Émergents', 'Emerging', 'الناشئة', 'system');

--changeset system:5-insert-missing-occupancies
--comment: Insert missing occupancies from R1
INSERT INTO ref_occupancy (code, name, name_fr, name_en, name_ar, group_id, created_by)
VALUES ('0001', 'N/A', 'N/A', 'N/A', 'غير محدد', (SELECT id FROM ref_occupancy_group WHERE code = 'N/A'), 'system'),
       ('1001', 'Pétrole & Gaz', 'Pétrole & Gaz', 'Oil & Gas', 'النفط والغاز',
        (SELECT id FROM ref_occupancy_group WHERE code = 'IND'), 'system'),
       ('1002', 'Chimie/Pharmaceutique', 'Chimie/Pharmaceutique', 'Chemical/Pharmaceutical', 'الكيماويات/الأدوية',
        (SELECT id FROM ref_occupancy_group WHERE code = 'IND'), 'system'),
       ('1003', 'Métallurgie/Mines', 'Métallurgie/Mines', 'Metallurgy/Mining', 'المعادن/التعدين',
        (SELECT id FROM ref_occupancy_group WHERE code = 'IND'), 'system'),
       ('1101', 'Aviation', 'Aviation', 'Aviation', 'الطيران', (SELECT id FROM ref_occupancy_group WHERE code = 'TRA'),
        'system'),
       ('1102', 'Maritime', 'Maritime', 'Maritime', 'البحري', (SELECT id FROM ref_occupancy_group WHERE code = 'TRA'),
        'system'),
       ('1103', 'Automobile', 'Automobile', 'Automotive', 'السيارات',
        (SELECT id FROM ref_occupancy_group WHERE code = 'TRA'), 'system'),
       ('1201', 'BTP', 'BTP', 'Construction', 'البناء والأشغال العامة',
        (SELECT id FROM ref_occupancy_group WHERE code = 'CON'), 'system'),
       ('1202', 'Énergie', 'Énergie', 'Energy', 'الطاقة', (SELECT id FROM ref_occupancy_group WHERE code = 'CON'),
        'system'),
       ('1301', 'Télécoms/Data Centers', 'Télécoms/Data Centers', 'Telecom/Data Centers', 'الاتصالات/مراكز البيانات',
        (SELECT id FROM ref_occupancy_group WHERE code = 'TEC'), 'system'),
       ('1302', 'Spatial', 'Spatial', 'Space', 'الفضاء', (SELECT id FROM ref_occupancy_group WHERE code = 'TEC'),
        'system'),
       ('1401', 'Hôpitaux', 'Hôpitaux', 'Hospitals', 'المستشفيات',
        (SELECT id FROM ref_occupancy_group WHERE code = 'SAN'), 'system'),
       ('1402', 'Pharmacies', 'Pharmacies', 'Pharmacies', 'الصيدليات',
        (SELECT id FROM ref_occupancy_group WHERE code = 'SAN'), 'system'),
       ('1501', 'Agroalimentaire', 'Agroalimentaire', 'Agri-food', 'الصناعات الغذائية',
        (SELECT id FROM ref_occupancy_group WHERE code = 'AGR'), 'system'),
       ('1502', 'Sylviculture', 'Sylviculture', 'Forestry', 'الغابات',
        (SELECT id FROM ref_occupancy_group WHERE code = 'AGR'), 'system'),
       ('1601', 'Finance', 'Finance', 'Finance', 'المالية', (SELECT id FROM ref_occupancy_group WHERE code = 'SER'),
        'system'),
       ('1602', 'Tourisme', 'Tourisme', 'Tourism', 'السياحة', (SELECT id FROM ref_occupancy_group WHERE code = 'SER'),
        'system'),
       ('1701', 'Cyber', 'Cyber', 'Cyber', 'السيبراني', (SELECT id FROM ref_occupancy_group WHERE code = 'EME'),
        'system'),
       ('1702', 'Climatique', 'Climatique', 'Climate', 'المناخ',
        (SELECT id FROM ref_occupancy_group WHERE code = 'EME'), 'system');

--changeset system:6-insert-missing-arrangement-types
--comment: Insert missing arrangement types from R1
-- First insert the missing portfolio types
INSERT INTO ref_portfolio_type (code, name, name_fr, name_en, name_ar, created_by)
VALUES ('TREATY', 'Treaty', 'Traité', 'Treaty', 'معاهدة', 'system'),
       ('FACULTATIVE', 'Facultative', 'Facultative', 'Facultative', 'اختياري', 'system'),
       ('OTREATY', 'Other Treaty', 'Autre Traité', 'Other Treaty', 'معاهدة أخرى', 'system');

-- Insert missing contract types
INSERT INTO ref_contract_type (code, name, name_fr, name_en, name_ar, created_by)
VALUES ('PRORATA', 'Prorata', 'Prorata', 'Prorata', 'نسبي', 'system'),
       ('EXCESS', 'Excess', 'Excédent', 'Excess', 'فائض', 'system');

-- Insert missing processing types
INSERT INTO ref_processing_type (code, name, name_fr, name_en, name_ar, created_by)
VALUES ('STATEMENT', 'Statement', 'Relevé', 'Statement', 'كشف', 'system'),
       ('INSTALLMENT', 'Installment', 'Versement', 'Installment', 'قسط', 'system');

-- Insert missing business types
INSERT INTO ref_business_type (code, name, name_fr, name_en, name_ar, created_by)
VALUES ('I', 'Inward', 'Entrant', 'Inward', 'وارد', 'system'),
       ('R', 'Retrocession', 'Rétrocession', 'Retrocession', 'إعادة إسناد', 'system');

-- Now insert arrangement types
INSERT INTO ref_arrangement_type (code, name, name_fr, name_en, name_ar, portfolio_type_id, contract_type_id,
                                  processing_type_id, business_type_id, created_by)
VALUES ('A1', 'Quota Share', 'Quote-Part', 'Quota Share', 'حصة نسبية',
        (SELECT id FROM ref_portfolio_type WHERE code = 'TREATY'),
        (SELECT id FROM ref_contract_type WHERE code = 'PRORATA'),
        (SELECT id FROM ref_processing_type WHERE code = 'STATEMENT'),
        (SELECT id FROM ref_business_type WHERE code = 'I'),
        'system'),
       ('A2', 'Surplus', 'Surplus', 'Surplus', 'فائض',
        (SELECT id FROM ref_portfolio_type WHERE code = 'TREATY'),
        (SELECT id FROM ref_contract_type WHERE code = 'PRORATA'),
        (SELECT id FROM ref_processing_type WHERE code = 'STATEMENT'),
        (SELECT id FROM ref_business_type WHERE code = 'I'),
        'system'),
       ('A3', 'FacOb', 'FacOb', 'FacOb', 'اختياري إلزامي',
        (SELECT id FROM ref_portfolio_type WHERE code = 'TREATY'),
        (SELECT id FROM ref_contract_type WHERE code = 'PRORATA'),
        (SELECT id FROM ref_processing_type WHERE code = 'STATEMENT'),
        (SELECT id FROM ref_business_type WHERE code = 'I'),
        'system'),
       ('A4', 'Facultative', 'Facultative', 'Facultative', 'اختياري',
        (SELECT id FROM ref_portfolio_type WHERE code = 'FACULTATIVE'),
        (SELECT id FROM ref_contract_type WHERE code = 'PRORATA'),
        (SELECT id FROM ref_processing_type WHERE code = 'INSTALLMENT'),
        (SELECT id FROM ref_business_type WHERE code = 'I'),
        'system'),
       ('A5', 'Excess of Loss', 'Excédent de Sinistre', 'Excess of Loss', 'فائض الخسارة',
        (SELECT id FROM ref_portfolio_type WHERE code = 'TREATY'),
        (SELECT id FROM ref_contract_type WHERE code = 'EXCESS'),
        (SELECT id FROM ref_processing_type WHERE code = 'INSTALLMENT'),
        (SELECT id FROM ref_business_type WHERE code = 'I'),
        'system'),
       ('A6', 'Pool Common Account XL', 'Pool Compte Commun XL', 'Pool Common Account XL', 'تجمع حساب مشترك',
        (SELECT id FROM ref_portfolio_type WHERE code = 'TREATY'),
        (SELECT id FROM ref_contract_type WHERE code = 'EXCESS'),
        (SELECT id FROM ref_processing_type WHERE code = 'INSTALLMENT'),
        (SELECT id FROM ref_business_type WHERE code = 'I'),
        'system'),
       ('A7', 'Excess of loss Cover', 'Couverture Excédent de Sinistre', 'Excess of loss Cover', 'تغطية فائض الخسارة',
        (SELECT id FROM ref_portfolio_type WHERE code = 'OTREATY'),
        (SELECT id FROM ref_contract_type WHERE code = 'EXCESS'),
        (SELECT id FROM ref_processing_type WHERE code = 'INSTALLMENT'),
        (SELECT id FROM ref_business_type WHERE code = 'R'),
        'system'),
       ('A8', 'Quota Share Retro', 'Quote-Part Rétro', 'Quota Share Retro', 'حصة نسبية رجعية',
        (SELECT id FROM ref_portfolio_type WHERE code = 'OTREATY'),
        (SELECT id FROM ref_contract_type WHERE code = 'PRORATA'),
        (SELECT id FROM ref_processing_type WHERE code = 'STATEMENT'),
        (SELECT id FROM ref_business_type WHERE code = 'R'),
        'system'),
       ('A9', 'Surplus Retro', 'Surplus Rétro', 'Surplus Retro', 'فائض رجعي',
        (SELECT id FROM ref_portfolio_type WHERE code = 'OTREATY'),
        (SELECT id FROM ref_contract_type WHERE code = 'PRORATA'),
        (SELECT id FROM ref_processing_type WHERE code = 'STATEMENT'),
        (SELECT id FROM ref_business_type WHERE code = 'R'),
        'system'),
       ('A10', 'FacOb Retro', 'FacOb Rétro', 'FacOb Retro', 'اختياري إلزامي رجعي',
        (SELECT id FROM ref_portfolio_type WHERE code = 'OTREATY'),
        (SELECT id FROM ref_contract_type WHERE code = 'PRORATA'),
        (SELECT id FROM ref_processing_type WHERE code = 'STATEMENT'),
        (SELECT id FROM ref_business_type WHERE code = 'R'),
        'system');


--changeset system:7-insert-missing-users
--comment: Insert missing users from R1
-- First ensure we have the partner and location
UPDATE ref_partner
SET code = 'CI0C000000'
WHERE code = 'RAMSYS';

-- Insert additional users
--changeset system:6-insert-user-data
--comment: Insertion des données utilisateurs
INSERT INTO ref_user_detail (username, password_hash, first_name, last_name, email, title, role_id, location_id, created_by) VALUES
-- Initial users
('admin', 'admin123', 'System', 'Administrator', 'admin@ramsys.local', 'Administrator', (SELECT id FROM ref_role WHERE code = 'ADMIN'), (SELECT id FROM ref_location WHERE code = 'L1'), 'system'),
('demo', '$2a$10$dYJ.C6aJ.NlSflMCaA9S..xL9b2v2cfl2YJc5qBnvXLs2n2.7g9iS', 'Demo', 'User', 'demo@ramsys.local', 'Demo Account', (SELECT id FROM ref_role WHERE code = 'UDW'), (SELECT id FROM ref_location WHERE code = 'L1'), 'system'),

 ('ROL', '$2a$10$YZiRBJdGkAA.hash', 'Roland', 'OUEDRAOGO', 'roland.ouedraogo@sunu-group.com', 'Directeur General',
        (SELECT id FROM ref_role WHERE code = 'ADMIN'),
        (SELECT id FROM ref_location WHERE code = 'L1'),
        'system'),
       ('YDW', '$2a$10$YZiRBJdGkAA.hash', 'Yao Dodji', 'WUSINU', 'yao.wusinu@sunu-group.com',
        'Comptabilité Générale et Technique',
        (SELECT id FROM ref_role WHERE code = 'ADMIN'),
        (SELECT id FROM ref_location WHERE code = 'L1'),
        'system'),
       ('MAY', '$2a$10$YZiRBJdGkAA.hash', 'Papa Mass', 'YADD', 'mass.yadd@sunu-group.com', 'Souscription Prestations',
        (SELECT id FROM ref_role WHERE code = 'ADMIN'),
        (SELECT id FROM ref_location WHERE code = 'L1'),
        'system'),
       ('KSN', '$2a$10$YZiRBJdGkAA.hash', 'Kouakou Serge', 'N''GUESSAN', 'serge.kouakou@sunu-group.com',
        'Souscription Prestations',
        (SELECT id FROM ref_role WHERE code = 'ADMIN'),
        (SELECT id FROM ref_location WHERE code = 'L1'),
        'system'),
       ('KDL', '$2a$10$YZiRBJdGkAA.hash', 'Kodjinan Désiré Leon', 'DIEMELEHOU', 'leon.diemelehou@sunu-group.com',
        'Souscription Prestations',
        (SELECT id FROM ref_role WHERE code = 'ADMIN'),
        (SELECT id FROM ref_location WHERE code = 'L1'),
        'system'),
       ('MPY', '$2a$10$YZiRBJdGkAA.hash', 'Marie Paule', 'YAO', 'mariepaule.yao@sunu-group.com',
        'Comptabilité Générale et Technique',
        (SELECT id FROM ref_role WHERE code = 'ADMIN'),
        (SELECT id FROM ref_location WHERE code = 'L1'),
        'system'),
       ('YER', '$2a$10$YZiRBJdGkAA.hash', 'Yero', 'DIALLO', 'yero.diallo@sunu-group.com',
        'Comptabilité Générale et Technique',
        (SELECT id FROM ref_role WHERE code = 'ADMIN'),
        (SELECT id FROM ref_location WHERE code = 'L1'),
        'system'),
       ('PHT', '$2a$10$YZiRBJdGkAA.hash', 'Paul-Henri', 'TUHO', 'paulhenri.tuho@sunu-group.com', 'Direction IT',
        (SELECT id FROM ref_role WHERE code = 'ADMIN'),
        (SELECT id FROM ref_location WHERE code = 'L1'),
        'system'),
       ('EAT', '$2a$10$YZiRBJdGkAA.hash', 'Elhadji Abdou Aziz', 'THIONGANE',
        'elhadjiabdouaziz.thiongane@sunu-group.com', 'Direction IT',
        (SELECT id FROM ref_role WHERE code = 'ADMIN'),
        (SELECT id FROM ref_location WHERE code = 'L1'),
        'system'),
       ('NKN', '$2a$10$YZiRBJdGkAA.hash', 'Noelly', 'KONE', 'noelly.kone@sunu-group.com', 'Direction IT',
        (SELECT id FROM ref_role WHERE code = 'ADMIN'),
        (SELECT id FROM ref_location WHERE code = 'L1'),
        'system'),
       ('FAD', '$2a$10$YZiRBJdGkAA.hash', 'Felix', 'ADOU', 'felix.adou@sunu-group.com', 'Direction IT',
        (SELECT id FROM ref_role WHERE code = 'ADMIN'),
        (SELECT id FROM ref_location WHERE code = 'L1'),
        'system'),
       ('JGK', '$2a$10$YZiRBJdGkAA.hash', 'Joseph', 'Gbako', 'joseph.gbako@sunu-group.com', 'Direction IT',
        (SELECT id FROM ref_role WHERE code = 'ADMIN'),
        (SELECT id FROM ref_location WHERE code = 'L1'),
        'system');
--changeset system:7-otherUpdate
    UPDATE REF_USER_DETAIL set approval_authority_level=1;
UPDATE ref_partner_type set code='C' where code='CEDANT';
UPDATE  ref_partner_type set code='B' where code='BROKER';
UPDATE ref_partner_type set code='T' where code='OTHER';


--changeset system:8-insert-user-profit-centers
--comment: Link users to profit centers
INSERT INTO ref_user_profit_center (user_id, profit_center_id)
VALUES ((SELECT id FROM ref_user_detail WHERE username = 'admin'),
        (SELECT id FROM ref_profit_center WHERE code = 'F1')),
       ((SELECT id FROM ref_user_detail WHERE username = 'admin'),
        (SELECT id FROM ref_profit_center WHERE code = 'T1')),
       ((SELECT id FROM ref_user_detail WHERE username = 'demo'), (SELECT id FROM ref_profit_center WHERE code = 'F1')),
       ((SELECT id FROM ref_user_detail WHERE username = 'demo'), (SELECT id FROM ref_profit_center WHERE code = 'T1'));
