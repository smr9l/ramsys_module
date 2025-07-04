--liquibase formatted sql

--changeset tradi:1-create-geo-tables
--comment: Création des tables de référence géographiques (Région, Pays, Ville)
CREATE TABLE ref_region (
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(80) NOT NULL, -- Fallback/default name
    name_fr     VARCHAR(80),
    name_en     VARCHAR(80),
    name_ar     VARCHAR(80),
    is_active   BOOLEAN NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by  VARCHAR(50),
    updated_at  TIMESTAMPTZ,
    updated_by  VARCHAR(50)
);

CREATE TABLE ref_country (
    id          SERIAL PRIMARY KEY,
    code        VARCHAR(2) UNIQUE NOT NULL,
    name        VARCHAR(80) NOT NULL,
    name_fr     VARCHAR(80),
    name_en     VARCHAR(80),
    name_ar     VARCHAR(80),
    region_id   INTEGER NOT NULL REFERENCES ref_region(id),
    is_active   BOOLEAN NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by  VARCHAR(50),
    updated_at  TIMESTAMPTZ,
    updated_by  VARCHAR(50)
);

CREATE TABLE ref_city (
    id          SERIAL PRIMARY KEY,
    code        VARCHAR(5) UNIQUE NOT NULL,
    name        VARCHAR(80) NOT NULL,
    name_fr     VARCHAR(80),
    name_en     VARCHAR(80),
    name_ar     VARCHAR(80),
    country_id  INTEGER NOT NULL REFERENCES ref_country(id) ON DELETE CASCADE,
    is_active   BOOLEAN NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by  VARCHAR(50),
    updated_at  TIMESTAMPTZ,
    updated_by  VARCHAR(50)
);

--changeset tradi:2-create-financial-tables
--comment: Création des tables de référence financières (Devise, Période, Taux de Change)
CREATE TABLE ref_currency (
    id          SERIAL PRIMARY KEY,
    code        VARCHAR(3) UNIQUE NOT NULL,--isocode 4217
    name        VARCHAR(80) NOT NULL,
    name_fr     VARCHAR(80),
    name_en     VARCHAR(80),
    name_ar     VARCHAR(80),
    is_active   BOOLEAN NOT NULL DEFAULT TRUE,
    version     INTEGER NOT NULL DEFAULT 0,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by  VARCHAR(50),
    updated_at  TIMESTAMPTZ,
    updated_by  VARCHAR(50)
);

CREATE TABLE ref_period (
    id                          SERIAL PRIMARY KEY,
    year                        INTEGER NOT NULL,
    month                       INTEGER NOT NULL,
    name                        VARCHAR(50),
    start_date                  DATE NOT NULL,
    end_date                    DATE NOT NULL,
    is_current_processing       BOOLEAN NOT NULL DEFAULT FALSE,
    is_open_for_linkage         BOOLEAN NOT NULL DEFAULT FALSE,
    is_open_for_exchange_rates  BOOLEAN NOT NULL DEFAULT FALSE,
    is_open_for_bank_balance    BOOLEAN NOT NULL DEFAULT FALSE,
    created_at                  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by                  VARCHAR(50),
    UNIQUE (year, month)
);

CREATE TABLE ref_currency_exchange (
    id          SERIAL PRIMARY KEY,
    period_id   INTEGER NOT NULL REFERENCES ref_period(id) ON DELETE CASCADE,
    currency_id INTEGER NOT NULL REFERENCES ref_currency(id) ON DELETE CASCADE,
    rate        NUMERIC(18, 8) NOT NULL,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by  VARCHAR(50),
    updated_at  TIMESTAMPTZ,
    updated_by  VARCHAR(50),
    UNIQUE (period_id, currency_id)
);

--changeset tradi:3-create-business-partner-tables
--comment: Création des tables de référence pour les partenaires et les assurés
CREATE TABLE ref_partner_type (
    id          SERIAL PRIMARY KEY,
    code        VARCHAR(20) UNIQUE NOT NULL,
    name        VARCHAR(80) NOT NULL,
    name_fr     VARCHAR(80),
    name_en     VARCHAR(80),
    name_ar     VARCHAR(80),
    is_active   BOOLEAN NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by  VARCHAR(50),
    updated_at  TIMESTAMPTZ,
    updated_by  VARCHAR(50)
);

CREATE TABLE ref_partner (
    id                      SERIAL PRIMARY KEY,
    code                    VARCHAR(10) UNIQUE NOT NULL,
    name                    VARCHAR(100) NOT NULL,
    short_name              VARCHAR(32) NOT NULL,
    contact_genre           VARCHAR(5),                                                             -- rma ou scr .
    partner_type_id         INTEGER NOT NULL REFERENCES ref_partner_type(id), --Type de partenaire (cedante, courtier, Other.)
    is_reinsurer            BOOLEAN DEFAULT FALSE,
    is_inwards              BOOLEAN DEFAULT FALSE,
    is_outwards             BOOLEAN DEFAULT FALSE,
    region_id               INTEGER NOT NULL REFERENCES ref_region(id),
    country_id              INTEGER NOT NULL REFERENCES ref_country(id),
    currency_id             INTEGER NOT NULL REFERENCES ref_currency(id),
    comment                 TEXT,
    parent_partner_id       INTEGER REFERENCES ref_partner(id),
    is_active               BOOLEAN NOT NULL DEFAULT TRUE,
    version                 INTEGER NOT NULL DEFAULT 0,
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by              VARCHAR(50),
    updated_at              TIMESTAMPTZ,
    updated_by              VARCHAR(50)
);

CREATE TABLE ref_occupancy_group (
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(80) UNIQUE NOT NULL,
    name_fr     VARCHAR(80),
    name_en     VARCHAR(80),
    name_ar     VARCHAR(80),
    is_active   BOOLEAN NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by  VARCHAR(50)
);

CREATE TABLE ref_occupancy (
    id          SERIAL PRIMARY KEY,
    code        VARCHAR(4) UNIQUE NOT NULL,
    name        VARCHAR(80) NOT NULL,
    name_fr     VARCHAR(80),
    name_en     VARCHAR(80),
    name_ar     VARCHAR(80),
    group_id    INTEGER NOT NULL REFERENCES ref_occupancy_group(id),
    is_active   BOOLEAN NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by  VARCHAR(50),
    updated_at  TIMESTAMPTZ,
    updated_by  VARCHAR(50)
);

CREATE TABLE ref_insured_type (
    id          SERIAL PRIMARY KEY,
    code        VARCHAR(20) UNIQUE NOT NULL,
    name        VARCHAR(80) NOT NULL,
    name_fr     VARCHAR(80),
    name_en     VARCHAR(80),
    name_ar     VARCHAR(80),
    is_active   BOOLEAN NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by  VARCHAR(50)
);

CREATE TABLE ref_insured (
    id                      SERIAL PRIMARY KEY,
    name                    VARCHAR(150) NOT NULL,
    short_name              VARCHAR(40) NOT NULL,
    insured_type_id         INTEGER REFERENCES ref_insured_type(id),
    occupancy_id            INTEGER NOT NULL REFERENCES ref_occupancy(id),
    country_id              INTEGER NOT NULL REFERENCES ref_country(id),
    city_id                 INTEGER REFERENCES ref_city(id),
    partner_id              INTEGER REFERENCES ref_partner(id),
    is_active               BOOLEAN NOT NULL DEFAULT TRUE,
    version                 INTEGER NOT NULL DEFAULT 0,
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by              VARCHAR(50),
    updated_at              TIMESTAMPTZ,
    updated_by              VARCHAR(50)
     --mbr of laction .. nonbre de site . a jouter .
);
CREATE TABLE ramsys_r1.ref_insured
(
    id                  SERIAL PRIMARY KEY,
    name                VARCHAR(150) NOT NULL,
    short_name          VARCHAR(40)  NOT NULL,
    contact_genre       VARCHAR(5),
    contact_name        VARCHAR(40),
    insured_type        VARCHAR(40), -- TODO: Migrer vers ref_insured_type
    occupancy_id        INTEGER      NOT NULL REFERENCES ramsys_r1.ref_occupancy (id),
    region_id           INTEGER      NOT NULL REFERENCES ramsys_r1.ref_region (id),
    country_id          INTEGER      NOT NULL REFERENCES ramsys_r1.ref_country (id),
    city_id             INTEGER REFERENCES ramsys_r1.ref_city (id),
    number_of_locations INTEGER,
    main_address        TEXT,
    area                VARCHAR(40),
    road                VARCHAR(40),
    building            VARCHAR(40),
    flat                VARCHAR(40),
    telephone           VARCHAR(20),
    fax                 VARCHAR(20),
    prefix_mail         VARCHAR(40),
    domaine             VARCHAR(40),
    gps_code            VARCHAR(12) UNIQUE,
    comment             TEXT,
    partner_id          INTEGER REFERENCES ramsys_r1.ref_partner (id),
    version             INTEGER      NOT NULL DEFAULT 0,
    is_active           BOOLEAN      NOT NULL DEFAULT TRUE,
    created_at          TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    created_by          VARCHAR(50),
    updated_at          TIMESTAMPTZ,
    updated_by          VARCHAR(50)
);

-- a
--changeset tradi:4-create-arrangement-tables
--comment: Création des tables de référence pour les arrangements (structure complète)
CREATE TABLE ref_arrangement_portfolio_type (
    id      SERIAL PRIMARY KEY,
    code    VARCHAR(20) UNIQUE NOT NULL,
    name    VARCHAR(80) NOT NULL,
    name_fr VARCHAR(80),
    name_en VARCHAR(80),
    name_ar VARCHAR(80)
);

CREATE TABLE ref_arrangement_contract_type (
    id      SERIAL PRIMARY KEY,
    code    VARCHAR(20) UNIQUE NOT NULL,
    name    VARCHAR(80) NOT NULL,
    name_fr VARCHAR(80),
    name_en VARCHAR(80),
    name_ar VARCHAR(80)
);

CREATE TABLE ref_arrangement_processing_type (
    id      SERIAL PRIMARY KEY,
    code    VARCHAR(20) UNIQUE NOT NULL,
    name    VARCHAR(80) NOT NULL,
    name_fr VARCHAR(80),
    name_en VARCHAR(80),
    name_ar VARCHAR(80)
);

CREATE TABLE ref_arrangement_business_type (
    id      SERIAL PRIMARY KEY,
    code    VARCHAR(20) UNIQUE NOT NULL,
    name    VARCHAR(80) NOT NULL,
    name_fr VARCHAR(80),
    name_en VARCHAR(80),
    name_ar VARCHAR(80)
);

CREATE TABLE ref_arrangement_type (
    id                      SERIAL PRIMARY KEY,
    code                    VARCHAR(8) UNIQUE NOT NULL,
    name                    VARCHAR(80) NOT NULL,
    name_fr                 VARCHAR(80),
    name_en                 VARCHAR(80),
    name_ar                 VARCHAR(80),
    portfolio_type_id       INTEGER NOT NULL REFERENCES ref_arrangement_portfolio_type(id),
    contract_type_id        INTEGER NOT NULL REFERENCES ref_arrangement_contract_type(id),
    processing_type_id      INTEGER NOT NULL REFERENCES ref_arrangement_processing_type(id),
    business_type_id        INTEGER NOT NULL REFERENCES ref_arrangement_business_type(id),
    is_active               BOOLEAN NOT NULL DEFAULT TRUE,
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by              VARCHAR(50),
    updated_at              TIMESTAMPTZ,
    updated_by              VARCHAR(50)
);


--changeset tradi:5-create-auth-tables
--comment: Création des tables pour les droits et habilitations (Rôles, Groupes, Fonctions)
CREATE TABLE ref_role (
    id          SERIAL PRIMARY KEY,
    code        VARCHAR(8) UNIQUE NOT NULL,
    name        VARCHAR(80) NOT NULL,
    name_fr     VARCHAR(80),
    name_en     VARCHAR(80),
    name_ar     VARCHAR(80),
    is_active   BOOLEAN NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by  VARCHAR(50),
    updated_at  TIMESTAMPTZ,
    updated_by  VARCHAR(50)
);

CREATE TABLE ref_group (
    id                      SERIAL PRIMARY KEY,
    code                    VARCHAR(8) UNIQUE NOT NULL,
    name                    VARCHAR(40) NOT NULL,
    name_fr                 VARCHAR(40),
    name_en                 VARCHAR(40),
    name_ar                 VARCHAR(40),

    sequence_in_menu        INTEGER,
    description VARCHAR(300),
    icon                    VARCHAR(10),
    is_active               BOOLEAN NOT NULL DEFAULT TRUE,
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by              VARCHAR(50),
    updated_at              TIMESTAMPTZ,
    updated_by              VARCHAR(50)
);

CREATE TABLE ref_function_type (
    id SERIAL PRIMARY KEY,
    code VARCHAR(10) UNIQUE NOT NULL,
    name VARCHAR(80) NOT NULL,
    name_fr VARCHAR(80),
    name_en VARCHAR(80),
    name_ar VARCHAR(80)
);

CREATE TABLE ref_function (
    id                      SERIAL PRIMARY KEY,
    code                    VARCHAR(8) UNIQUE NOT NULL,
    name_fr                 VARCHAR(40),
    name_en                 VARCHAR(40),
    name_ar                 VARCHAR(40),
     description          VARCHAR(300),

    group_id                INTEGER NOT NULL REFERENCES ref_group(id),
    sequence_in_group       INTEGER,
    function_type_id        INTEGER REFERENCES ref_function_type(id),
    is_active               BOOLEAN NOT NULL DEFAULT TRUE,
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by              VARCHAR(50),
    updated_at              TIMESTAMPTZ,
    updated_by              VARCHAR(50)
);

CREATE TABLE ref_role_function (
    role_id                 INTEGER NOT NULL REFERENCES ref_role(id) ON DELETE CASCADE,
    function_id             INTEGER NOT NULL REFERENCES ref_function(id) ON DELETE CASCADE,
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by              VARCHAR(50),

    PRIMARY KEY (role_id, function_id)
);

CREATE TABLE ref_role_group (
    role_id                 INTEGER NOT NULL REFERENCES ref_role(id) ON DELETE CASCADE,
    group_id                INTEGER NOT NULL REFERENCES ref_group(id) ON DELETE CASCADE,
    sequence_in_menu        INTEGER,
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by              VARCHAR(50),
    updated_at              TIMESTAMPTZ,
    updated_by              VARCHAR(50),
    PRIMARY KEY (role_id, group_id)
);


--changeset tradi:6-create-organizational-tables
--comment: Création des tables organisationnelles (Location, Division, Utilisateur, Centre de Profit)
-- NOTE: ref_user_detail and ref_profit_centre have a circular dependency on manager_id.
-- We create user table first, then profit_centre, then add the foreign key from profit_centre to user.

CREATE TABLE ref_location (
    id                          SERIAL PRIMARY KEY,
    code                        VARCHAR(2) UNIQUE NOT NULL,
    partner_id                  INTEGER NOT NULL REFERENCES ref_partner(id),
    city_id                     INTEGER REFERENCES ref_city(id),
    reporting_currency_id       INTEGER NOT NULL REFERENCES ref_currency(id),
    starting_year               INTEGER NOT NULL,
    current_period_id           INTEGER REFERENCES ref_period(id),
    locale                      VARCHAR(10) NOT NULL DEFAULT 'fr-FR',
    decimal_places              SMALLINT NOT NULL DEFAULT 2,
    percentage_decimal_places   SMALLINT DEFAULT 5,
    settlement_tolerance        NUMERIC(15,5) NOT NULL DEFAULT 5.00000,
    uncovered_tolerance         NUMERIC(15,5) DEFAULT 0,
    is_factoring_enabled        BOOLEAN NOT NULL DEFAULT FALSE,
    financial_partner_id        INTEGER REFERENCES ref_partner(id),
    default_bank_account        INTEGER, -- TODO: Should reference a future ref_bank_account table
    environment_name            VARCHAR(40),
    is_active                   BOOLEAN NOT NULL DEFAULT TRUE,
    created_at                  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by                  VARCHAR(50),
    updated_at                  TIMESTAMPTZ,
    updated_by                  VARCHAR(50)
);

CREATE TABLE ref_division (
    id          SERIAL PRIMARY KEY,
    code        VARCHAR(3) UNIQUE NOT NULL,
    name        VARCHAR(40) NOT NULL,
    name_fr     VARCHAR(40),
    name_en     VARCHAR(40),
    name_ar     VARCHAR(40),
    location_id INTEGER NOT NULL REFERENCES ref_location(id) ON DELETE CASCADE,
    is_active   BOOLEAN NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by  VARCHAR(50),
    updated_at  TIMESTAMPTZ,
    updated_by  VARCHAR(50)
);

CREATE TABLE ref_user_detail (
    id                      SERIAL PRIMARY KEY,
    username                VARCHAR(40) UNIQUE NOT NULL,
    email                   VARCHAR(100) UNIQUE,
    password_hash           VARCHAR(100),
    first_name              VARCHAR(50),
    last_name               VARCHAR(50),
    title                   VARCHAR(40),
    location_id             INTEGER NOT NULL REFERENCES ref_location(id),
    division_id             INTEGER REFERENCES ref_division(id),
    role_id                 INTEGER NOT NULL REFERENCES ref_role(id),
    manager_id              INTEGER REFERENCES ref_user_detail(id),
    is_active               BOOLEAN NOT NULL DEFAULT TRUE,
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by              VARCHAR(50),
    updated_at              TIMESTAMPTZ,
    updated_by              VARCHAR(50)
);

CREATE TABLE ref_profit_centre (
    id          SERIAL PRIMARY KEY,
    code        VARCHAR(2) UNIQUE NOT NULL,
    name        VARCHAR(40) NOT NULL,
    name_fr     VARCHAR(40),
    name_en     VARCHAR(40),
    name_ar     VARCHAR(40),
    location_id INTEGER NOT NULL REFERENCES ref_location(id) ON DELETE CASCADE,
    division_id INTEGER NOT NULL REFERENCES ref_division(id) ON DELETE CASCADE,
    manager_id  INTEGER REFERENCES ref_user_detail(id), -- Nullable to break circular dependency
    is_active   BOOLEAN NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by  VARCHAR(50),
    updated_at  TIMESTAMPTZ,
    updated_by  VARCHAR(50)
);

CREATE TABLE ref_user_profit_centre (
    user_id                 INTEGER NOT NULL REFERENCES ref_user_detail(id) ON DELETE CASCADE,
    profit_centre_id        INTEGER NOT NULL REFERENCES ref_profit_centre(id) ON DELETE CASCADE,
    is_primary              BOOLEAN NOT NULL DEFAULT FALSE,
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by              VARCHAR(50),
    PRIMARY KEY (user_id, profit_centre_id)
);

--changeset tradi:7-create-indexes
--comment: Création des index pour améliorer les performances des requêtes
CREATE INDEX idx_ref_country_region ON ref_country(region_id);
CREATE INDEX idx_ref_city_country ON ref_city(country_id);
CREATE INDEX idx_ref_partner_type ON ref_partner(partner_type_id);
CREATE INDEX idx_ref_partner_location ON ref_partner(country_id, region_id);
CREATE INDEX idx_ref_occupancy_group ON ref_occupancy(group_id);
CREATE INDEX idx_ref_insured_location ON ref_insured(country_id);
CREATE INDEX idx_ref_function_group ON ref_function(group_id);
CREATE INDEX idx_ref_division_location ON ref_division(location_id);
CREATE INDEX idx_ref_user_detail_manager ON ref_user_detail(manager_id);
CREATE INDEX idx_ref_profit_centre_manager ON ref_profit_centre(manager_id); 