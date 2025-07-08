--liquibase formatted sql

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

--changeset system:2-insert-function-data
--comment: Insertion des données de fonctions
INSERT INTO ref_function (code, name_fr, description_fr, created_by)
VALUES ('MNT_CTR', 'Maintenance Police', 'Maintenance des polices', 'system'),
       ('REF_PRT', 'Partenaires', 'Gestion des partenaires', 'system'),
       ('REF_INS', 'Assurés', 'Gestion des assurés', 'system');

--changeset system:2a-insert-role-function-data
--comment: Insertion des données de référence de base
INSERT INTO ref_role_function (role_id, function_id, created_by)
VALUES ((SELECT id FROM ref_role WHERE code = 'ADMIN'), (SELECT id FROM ref_function WHERE code = 'MNT_CTR'), 'system'),
       ((SELECT id FROM ref_role WHERE code = 'ADMIN'), (SELECT id FROM ref_function WHERE code = 'REF_PRT'), 'system'),
       ((SELECT id FROM ref_role WHERE code = 'ADMIN'), (SELECT id FROM ref_function WHERE code = 'REF_INS'), 'system');

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

-- Insert basic period
INSERT INTO ref_period (year, month, name, start_date, end_date, created_by)
VALUES (2024, 1, 'Janvier 2024', '2024-01-01', '2024-01-31', 'system');

-- Insert partner types
INSERT INTO ref_partner_type (code, name, name_fr, name_en, name_ar, created_by)
VALUES ('C', 'Cédant', 'Cédant', 'Cedant', 'المتنازل', 'system'),
       ('B', 'Courtier', 'Courtier', 'Broker', 'وسيط', 'system'),
       ('T', 'Autre', 'Autre', 'Other', 'أخرى', 'system');

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

-- Insert basic partner (using existing region after inserts above)
INSERT INTO ref_partner (code, name, short_name, partner_type_id, region_id, country_id, currency_id, created_by)
VALUES ('RAMSYS', 'RAMSYS Insurance', 'RAMSYS',
        (SELECT id FROM ref_partner_type WHERE code = 'OTHER'),
        (SELECT id FROM ref_region WHERE code = 'AUT'),
        (SELECT id FROM ref_country WHERE code = 'CI'),
        (SELECT id FROM ref_currency WHERE code = 'XOF'),
        'system');

--changeset system:4-insert-location-data
--comment: Insertion des données de localisation
INSERT INTO ref_location (code, name, partner_id, city_id, reporting_currency_id, starting_year, current_period_id,
                          locale, decimal_places, percentage_decimal_places, settlement_tolerance, uncovered_tolerance,
                          is_factoring_enabled, default_bank_account, created_by)
VALUES ('L1', 'Siège Abidjan',
        (SELECT id FROM ref_partner WHERE code = 'RAMSYS'),
        (SELECT id FROM ref_city WHERE code = 'ABD'),
        (SELECT id FROM ref_currency WHERE code = 'XOF'),
        2024,
        (SELECT id FROM ref_period WHERE year = 2024 AND month = 1), 'fr-FR', 2, 8, 5.00000, 0, FALSE, 1, 'system');

--changeset system:5-insert-division-data
--comment: Insertion des données de division
INSERT INTO ref_division (code, name, location_id, created_by)
VALUES ('F01', 'Facultative', (SELECT id FROM ref_location WHERE code = 'L1'), 'system'),
       ('T01', 'Traité', (SELECT id FROM ref_location WHERE code = 'L1'), 'system');

--changeset system:6-insert-user-data
--comment: Insertion des données utilisateurs
INSERT INTO ref_user_detail (username, password_hash, first_name, last_name, email, created_by)
VALUES ('admin', 'admin123', 'System', 'Administrator',
        'admin@ramsys.local', 'system'),
       ('demo', '$2a$10$DemoPasswordHash1234567890123456789012345678901234', 'Demo', 'User', 'demo@ramsys.local',
        'system');

--changeset system:7-insert-profit-centre-data
--comment: Insertion des données de centres de profit
INSERT INTO ref_profit_center (code, name, name_fr, location_id, division_id, manager_id, created_by)
VALUES ('F1', 'Département Facultative', 'Département Facultative', (SELECT id FROM ref_location WHERE code = 'L1'),
        (SELECT id FROM ref_division WHERE code = 'F01'), (SELECT id FROM ref_user_detail WHERE username = 'admin'),
        'system'),
       ('T1', 'Département Traité', 'Département Traité', (SELECT id FROM ref_location WHERE code = 'L1'),
        (SELECT id FROM ref_division WHERE code = 'T01'), (SELECT id FROM ref_user_detail WHERE username = 'admin'),
        'system');
