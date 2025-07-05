--liquibase formatted sql

--changeset system:1-create-geo-tables
--comment: Création des tables de référence géographiques (Région, Pays, Ville)
CREATE TABLE ref_region (
    id          BIGSERIAL PRIMARY KEY,
    code        VARCHAR(10) UNIQUE NOT NULL,
    name        VARCHAR(80) NOT NULL, -- Fallback/default name
    name_fr     VARCHAR(80),
    name_en     VARCHAR(80),
    name_ar     VARCHAR(80),
    is_active   BOOLEAN NOT NULL DEFAULT TRUE,
    version     INTEGER NOT NULL DEFAULT 0,
    created_at  TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_by  VARCHAR(50),
    updated_at  TIMESTAMP WITH TIME ZONE,
    updated_by  VARCHAR(50)
);

CREATE TABLE ref_country (
    id          BIGSERIAL PRIMARY KEY,
    code        VARCHAR(2) UNIQUE NOT NULL,
    name        VARCHAR(80) NOT NULL,
    name_fr     VARCHAR(80),
    name_en     VARCHAR(80),
    name_ar     VARCHAR(80),
    region_id   BIGINT NOT NULL REFERENCES ref_region(id),
    is_active   BOOLEAN NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_by  VARCHAR(50),
    updated_at  TIMESTAMP WITH TIME ZONE,
    updated_by  VARCHAR(50)
);

CREATE TABLE ref_city (
    id          BIGSERIAL PRIMARY KEY,
    code        VARCHAR(5) UNIQUE NOT NULL,
    name        VARCHAR(80) NOT NULL,
    name_fr     VARCHAR(80),
    name_en     VARCHAR(80),
    name_ar     VARCHAR(80),
    country_id  BIGINT NOT NULL REFERENCES ref_country(id) ON DELETE CASCADE,
    is_active   BOOLEAN NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_by  VARCHAR(50),
    updated_at  TIMESTAMP WITH TIME ZONE,
    updated_by  VARCHAR(50)
);

--changeset system:2-create-financial-tables
--comment: Création des tables de référence financières (Devise, Période, Taux de Change)
CREATE TABLE ref_currency (
    id          BIGSERIAL PRIMARY KEY,
    code        VARCHAR(3) UNIQUE NOT NULL,--isocode 4217
    name        VARCHAR(80) NOT NULL,
    name_fr     VARCHAR(80),
    name_en     VARCHAR(80),
    name_ar     VARCHAR(80),
    is_active   BOOLEAN NOT NULL DEFAULT TRUE,
    version     INTEGER NOT NULL DEFAULT 0,
    created_at  TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_by  VARCHAR(50),
    updated_at  TIMESTAMP WITH TIME ZONE,
    updated_by  VARCHAR(50)
);

CREATE TABLE ref_period (
    id                          BIGSERIAL PRIMARY KEY,
    year                        INTEGER NOT NULL,
    month                       INTEGER NOT NULL,
    name                        VARCHAR(50),
    start_date                  DATE NOT NULL,
    end_date                    DATE NOT NULL,
    is_current_processing       BOOLEAN NOT NULL DEFAULT FALSE,
    is_open_for_linkage         BOOLEAN NOT NULL DEFAULT FALSE,
    is_open_for_exchange_rates  BOOLEAN NOT NULL DEFAULT FALSE,
    is_open_for_bank_balance    BOOLEAN NOT NULL DEFAULT FALSE,
    is_active                   BOOLEAN NOT NULL DEFAULT TRUE,
    version                     INTEGER NOT NULL DEFAULT 0,
    created_at                  TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_by                  VARCHAR(50),
    updated_at                  TIMESTAMP WITH TIME ZONE,
    updated_by                  VARCHAR(50),
    UNIQUE (year, month)
);

CREATE TABLE ref_currency_exchange (
    id          BIGSERIAL PRIMARY KEY,
    period_id   BIGINT NOT NULL REFERENCES ref_period(id) ON DELETE CASCADE,
    currency_id BIGINT NOT NULL REFERENCES ref_currency(id) ON DELETE CASCADE,
    rate        NUMERIC(18, 8) NOT NULL,
    created_at  TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_by  VARCHAR(50),
    updated_at  TIMESTAMP WITH TIME ZONE,
    updated_by  VARCHAR(50),
    UNIQUE (period_id, currency_id)
);

CREATE TABLE ref_rating (
    id          BIGSERIAL PRIMARY KEY,
    code        VARCHAR(4) UNIQUE NOT NULL,
    name        VARCHAR(80) NOT NULL,
    name_fr     VARCHAR(80),
    name_en     VARCHAR(80),
    name_ar     VARCHAR(80),
    description VARCHAR(255),
    numeric_value INTEGER,
    is_active   BOOLEAN NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_by  VARCHAR(50),
    updated_at  TIMESTAMP WITH TIME ZONE,
    updated_by  VARCHAR(50)
);

--changeset system:3-create-business-partner-tables
--comment: Création des tables de référence pour les partenaires et les assurés
CREATE TABLE ref_partner_type (
    id          BIGSERIAL PRIMARY KEY,
    code        VARCHAR(20) UNIQUE NOT NULL,
    name        VARCHAR(80) NOT NULL,
    name_fr     VARCHAR(80),
    name_en     VARCHAR(80),
    name_ar     VARCHAR(80),
    is_active   BOOLEAN NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_by  VARCHAR(50),
    updated_at  TIMESTAMP WITH TIME ZONE,
    updated_by  VARCHAR(50)
);

CREATE TABLE ref_partner (
    id                      BIGSERIAL PRIMARY KEY,
    code                    VARCHAR(10) UNIQUE NOT NULL,
    name                    VARCHAR(100) NOT NULL,
    short_name              VARCHAR(32) NOT NULL,
    comment                 TEXT,
    partner_type_id         BIGINT NOT NULL REFERENCES ref_partner_type(id),
    region_id               BIGINT NOT NULL REFERENCES ref_region(id),
    country_id              BIGINT NOT NULL REFERENCES ref_country(id),
    currency_id             BIGINT NOT NULL REFERENCES ref_currency(id),
    is_active               BOOLEAN NOT NULL DEFAULT TRUE,
    -- ContactInfo embedded fields
    contact_genre           VARCHAR(5),
    contact_name            VARCHAR(32),
    telephone               VARCHAR(20),
    fax                     VARCHAR(20),
    prefix_mail             VARCHAR(32),
    domaine                 VARCHAR(32),
    -- FinancialInfo embedded fields
    rating_id               BIGINT REFERENCES ref_rating(id),
    scoring                 INTEGER,
    bank_name               VARCHAR(100),
    bank_iban               VARCHAR(30),
    swift                   VARCHAR(10),
    -- AddressInfo embedded fields
    address                 TEXT,
    area                    VARCHAR(40),
    road                    VARCHAR(40),
    building                VARCHAR(40),
    flat                    VARCHAR(40),
    gps_code                VARCHAR(12),
    -- Hierarchy
    parent_partner_id       BIGINT REFERENCES ref_partner(id),
    -- Business capabilities
    is_reinsurer            BOOLEAN DEFAULT FALSE,
    is_inwards              BOOLEAN DEFAULT FALSE,
    is_outwards             BOOLEAN DEFAULT FALSE,
    type_other              VARCHAR(32),
    -- Audit fields
    created_at              TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_by              VARCHAR(50),
    updated_at              TIMESTAMP WITH TIME ZONE,
    updated_by              VARCHAR(50),
    -- Contrainte métier : type_other obligatoire si partner_type = 'OTHER'
    CONSTRAINT chk_partner_type_other CHECK (
        (partner_type_id IN (SELECT id FROM ref_partner_type WHERE code = 'OTHER') AND type_other IS NOT NULL AND TRIM(type_other) != '')
        OR
        (partner_type_id NOT IN (SELECT id FROM ref_partner_type WHERE code = 'OTHER'))
    )
);

CREATE TABLE ref_occupancy_group (
    id          BIGSERIAL PRIMARY KEY,
    code        VARCHAR(10) UNIQUE NOT NULL,
    name        VARCHAR(80) NOT NULL,
    name_fr     VARCHAR(80),
    name_en     VARCHAR(80),
    name_ar     VARCHAR(80),
    is_active   BOOLEAN NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_by  VARCHAR(50),
    updated_at  TIMESTAMP WITH TIME ZONE,
    updated_by  VARCHAR(50)
);

CREATE TABLE ref_occupancy (
    id          BIGSERIAL PRIMARY KEY,
    code        VARCHAR(4) UNIQUE NOT NULL,
    name        VARCHAR(80) NOT NULL,
    name_fr     VARCHAR(80),
    name_en     VARCHAR(80),
    name_ar     VARCHAR(80),
    group_id    BIGINT NOT NULL REFERENCES ref_occupancy_group(id),
    is_active   BOOLEAN NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_by  VARCHAR(50),
    updated_at  TIMESTAMP WITH TIME ZONE,
    updated_by  VARCHAR(50)
);

--changeset system:4-create-arrangement-tables
--comment: Création des tables de référence pour les arrangements
CREATE TABLE ref_processing_type (
    id          BIGSERIAL PRIMARY KEY,
    code        VARCHAR(20) UNIQUE NOT NULL,
    name        VARCHAR(80) NOT NULL,
    name_fr     VARCHAR(80),
    name_en     VARCHAR(80),
    name_ar     VARCHAR(80),
    is_active   BOOLEAN NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_by  VARCHAR(50),
    updated_at  TIMESTAMP WITH TIME ZONE,
    updated_by  VARCHAR(50)
);

CREATE TABLE ref_portfolio_type (
    id          BIGSERIAL PRIMARY KEY,
    code        VARCHAR(20) UNIQUE NOT NULL,
    name        VARCHAR(80) NOT NULL,
    name_fr     VARCHAR(80),
    name_en     VARCHAR(80),
    name_ar     VARCHAR(80),
    is_active   BOOLEAN NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_by  VARCHAR(50),
    updated_at  TIMESTAMP WITH TIME ZONE,
    updated_by  VARCHAR(50)
);

CREATE TABLE ref_business_type (
    id          BIGSERIAL PRIMARY KEY,
    code        VARCHAR(20) UNIQUE NOT NULL,
    name        VARCHAR(80) NOT NULL,
    name_fr     VARCHAR(80),
    name_en     VARCHAR(80),
    name_ar     VARCHAR(80),
    is_active   BOOLEAN NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_by  VARCHAR(50),
    updated_at  TIMESTAMP WITH TIME ZONE,
    updated_by  VARCHAR(50)
);

CREATE TABLE ref_contract_type (
    id          BIGSERIAL PRIMARY KEY,
    code        VARCHAR(20) UNIQUE NOT NULL,
    name        VARCHAR(80) NOT NULL,
    name_fr     VARCHAR(80),
    name_en     VARCHAR(80),
    name_ar     VARCHAR(80),
    is_active   BOOLEAN NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_by  VARCHAR(50),
    updated_at  TIMESTAMP WITH TIME ZONE,
    updated_by  VARCHAR(50)
);

CREATE TABLE ref_arrangement_type (
    id                      BIGSERIAL PRIMARY KEY,
    code                    VARCHAR(20) UNIQUE NOT NULL,
    name                    VARCHAR(80) NOT NULL,
    name_fr                 VARCHAR(80),
    name_en                 VARCHAR(80),
    name_ar                 VARCHAR(80),
    portfolio_type_id       BIGINT NOT NULL REFERENCES ref_portfolio_type(id),
    contract_type_id        BIGINT NOT NULL REFERENCES ref_contract_type(id),
    processing_type_id      BIGINT NOT NULL REFERENCES ref_processing_type(id),
    business_type_id        BIGINT NOT NULL REFERENCES ref_business_type(id),
    is_active               BOOLEAN NOT NULL DEFAULT TRUE,
    created_at              TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_by              VARCHAR(50),
    updated_at              TIMESTAMP WITH TIME ZONE,
    updated_by              VARCHAR(50)
);

--changeset system:5-create-auth-tables
--comment: Création des tables pour les droits et habilitations (Rôles, Groupes, Fonctions)

CREATE TABLE ref_group (
    id                      BIGSERIAL PRIMARY KEY,
    code                    VARCHAR(20) UNIQUE NOT NULL,
    name                    VARCHAR(80) NOT NULL,
    name_fr                 VARCHAR(80),
    name_en                 VARCHAR(80),
    name_ar                 VARCHAR(80),
    description_fr          VARCHAR(255),
    description_en          VARCHAR(255),
    description_ar          VARCHAR(255),
    is_active               BOOLEAN NOT NULL DEFAULT TRUE,
    created_at              TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_by              VARCHAR(50),
    updated_at              TIMESTAMP WITH TIME ZONE,
    updated_by              VARCHAR(50)
);

CREATE TABLE ref_function_type (
    id                      BIGSERIAL PRIMARY KEY,
    code                    VARCHAR(20) UNIQUE NOT NULL,
    name                    VARCHAR(80) NOT NULL,
    name_fr                 VARCHAR(80),
    name_en                 VARCHAR(80),
    name_ar                 VARCHAR(80),
    is_active               BOOLEAN NOT NULL DEFAULT TRUE,
    created_at              TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_by              VARCHAR(50),
    updated_at              TIMESTAMP WITH TIME ZONE,
    updated_by              VARCHAR(50)
);

CREATE TABLE ref_role (
    id                      BIGSERIAL PRIMARY KEY,
    code                    VARCHAR(20) UNIQUE NOT NULL,
    name                    VARCHAR(80) NOT NULL,
    name_fr                 VARCHAR(80),
    name_en                 VARCHAR(80),
    name_ar                 VARCHAR(80),
    is_active               BOOLEAN NOT NULL DEFAULT TRUE,
    created_at              TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_by              VARCHAR(50),
    updated_at              TIMESTAMP WITH TIME ZONE,
    updated_by              VARCHAR(50)
);

CREATE TABLE ref_function (
    id                      BIGSERIAL PRIMARY KEY,
    code                    VARCHAR(20) UNIQUE NOT NULL,
    name_fr                 VARCHAR(80) NOT NULL,
    name_en                 VARCHAR(80),
    name_ar                 VARCHAR(80),
    description_fr          VARCHAR(255),
    description_en          VARCHAR(255),
    description_ar          VARCHAR(255),
    group_id                BIGINT REFERENCES ref_group(id),
    sequence_in_group       INTEGER,
    function_type_id        BIGINT REFERENCES ref_function_type(id),
    is_active               BOOLEAN NOT NULL DEFAULT TRUE,
    created_at              TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_by              VARCHAR(50),
    updated_at              TIMESTAMP WITH TIME ZONE,
    updated_by              VARCHAR(50)
);

CREATE TABLE ref_role_function (
    id                      BIGSERIAL PRIMARY KEY,
    role_id                 BIGINT NOT NULL REFERENCES ref_role(id) ON DELETE CASCADE,
    function_id             BIGINT NOT NULL REFERENCES ref_function(id) ON DELETE CASCADE,
    is_active               BOOLEAN NOT NULL DEFAULT TRUE,
    created_at              TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_by              VARCHAR(50),
    updated_at              TIMESTAMP WITH TIME ZONE,
    updated_by              VARCHAR(50),
    unique  (role_id, function_id)
);

--changeset system:6-create-organizational-tables
--comment: Création des tables organisationnelles (Location, Division, Utilisateur, Centre de Profit)
CREATE TABLE ref_location (
    id                          BIGSERIAL PRIMARY KEY,
    code                        VARCHAR(2) UNIQUE NOT NULL,
    name                        VARCHAR(100) NOT NULL,
    partner_id                  BIGINT NOT NULL REFERENCES ref_partner(id),
    city_id                     BIGINT REFERENCES ref_city(id),
    reporting_currency_id       BIGINT NOT NULL REFERENCES ref_currency(id),
    starting_year               INTEGER NOT NULL,
    current_period_id           BIGINT REFERENCES ref_period(id),
    locale                      VARCHAR(10) NOT NULL DEFAULT 'fr-FR',
    decimal_places              SMALLINT NOT NULL DEFAULT 2,
    percentage_decimal_places   SMALLINT DEFAULT 8,
    settlement_tolerance        NUMERIC(15,5) NOT NULL DEFAULT 5.00000,
    uncovered_tolerance         NUMERIC(15,5) DEFAULT 0,
    is_factoring_enabled        BOOLEAN NOT NULL DEFAULT FALSE,
    financial_partner_id        BIGINT REFERENCES ref_partner(id),
    default_bank_account        INTEGER,
    is_active                   BOOLEAN NOT NULL DEFAULT TRUE,
    created_at                  TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_by                  VARCHAR(50),
    updated_at                  TIMESTAMP WITH TIME ZONE,
    updated_by                  VARCHAR(50)
);

CREATE TABLE ref_division (
    id          BIGSERIAL PRIMARY KEY,
    code        VARCHAR(10) UNIQUE NOT NULL,
    name        VARCHAR(80) NOT NULL,
    location_id BIGINT NOT NULL REFERENCES ref_location(id),
    is_active   BOOLEAN NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_by  VARCHAR(50),
    updated_at  TIMESTAMP WITH TIME ZONE,
    updated_by  VARCHAR(50)
);

CREATE TABLE ref_user_detail (
    id                      BIGSERIAL PRIMARY KEY,
    username                VARCHAR(50) UNIQUE NOT NULL,
    password_hash           VARCHAR(255) NOT NULL,
    email                   VARCHAR(100) UNIQUE,
    first_name              VARCHAR(50) NOT NULL,
    last_name               VARCHAR(50) NOT NULL,
    title                   VARCHAR(100),
    role_id                 BIGINT REFERENCES ref_role(id),
    location_id             BIGINT,
    division_id             BIGINT,
    manager_id              BIGINT REFERENCES ref_user_detail(id),
    language                VARCHAR(10),
    locale                  VARCHAR(10),
    is_active               BOOLEAN NOT NULL DEFAULT TRUE,
    version                 INTEGER NOT NULL DEFAULT 0,
    created_at              TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_by              VARCHAR(50),
    updated_at              TIMESTAMP WITH TIME ZONE,
    updated_by              VARCHAR(50)
);

CREATE TABLE ref_profit_center (
    id          BIGSERIAL PRIMARY KEY,
    code        VARCHAR(2) UNIQUE NOT NULL,
    name        VARCHAR(40) NOT NULL,
    name_fr     VARCHAR(40),
    name_en     VARCHAR(40),
    name_ar     VARCHAR(40),
    location_id BIGINT NOT NULL REFERENCES ref_location(id),
    division_id BIGINT NOT NULL REFERENCES ref_division(id),
    manager_id  BIGINT REFERENCES ref_user_detail(id),
    is_active   BOOLEAN NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_by  VARCHAR(50),
    updated_at  TIMESTAMP WITH TIME ZONE,
    updated_by  VARCHAR(50)
);

CREATE TABLE ref_user_profit_center (
    user_id                 BIGINT NOT NULL REFERENCES ref_user_detail(id) ON DELETE CASCADE,
    profit_center_id        BIGINT NOT NULL REFERENCES ref_profit_center(id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, profit_center_id)
);

--changeset system:7-create-indexes
--comment: Création des index pour améliorer les performances des requêtes
CREATE INDEX idx_ref_country_region ON ref_country(region_id);
CREATE INDEX idx_ref_city_country ON ref_city(country_id);
CREATE INDEX idx_ref_partner_type ON ref_partner(partner_type_id);
CREATE INDEX idx_ref_partner_rating ON ref_partner(rating_id);
CREATE INDEX idx_ref_partner_location ON ref_partner(country_id, region_id);
CREATE INDEX idx_ref_occupancy_group ON ref_occupancy(group_id);
CREATE INDEX idx_ref_division_location ON ref_division(location_id);
CREATE INDEX idx_ref_user_detail_manager ON ref_user_detail(manager_id);
CREATE INDEX idx_ref_profit_center_manager ON ref_profit_center(manager_id);
