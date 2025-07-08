
ALTER TABLE IF EXISTS ramsys_r1.ref_profit_centre DROP CONSTRAINT IF EXISTS FK5_REF_PROFIT_CENTRE;
ALTER TABLE IF EXISTS ramsys_r1.ref_user_detail DROP CONSTRAINT IF EXISTS FK9_REF_USER_DETAIL;

DROP TABLE IF EXISTS ramsys_r1.ref_role_function CASCADE;
DROP TABLE IF EXISTS ramsys_r1.ref_role_group CASCADE;
DROP TABLE IF EXISTS ramsys_r1.ref_group_function CASCADE;
DROP TABLE IF EXISTS ramsys_r1.ref_group CASCADE;
DROP TABLE IF EXISTS ramsys_r1.ref_function CASCADE;
DROP TABLE IF EXISTS ramsys_r1.ref_user_profit_centre CASCADE;
DROP TABLE IF EXISTS ramsys_r1.ref_user_detail CASCADE;
DROP TABLE IF EXISTS ramsys_r1.ref_profit_centre CASCADE;
DROP TABLE IF EXISTS ramsys_r1.ref_role CASCADE;
DROP TABLE IF EXISTS ramsys_r1.ref_division CASCADE;
DROP TABLE IF EXISTS ramsys_r1.ref_location CASCADE;
DROP TABLE IF EXISTS ramsys_r1.ref_currency_exchange CASCADE;
DROP TABLE IF EXISTS ramsys_r1.ref_period CASCADE;
DROP TABLE IF EXISTS ramsys_r1.ref_insured CASCADE;
DROP TABLE IF EXISTS ramsys_r1.ref_type_of_arrangement CASCADE;
DROP TABLE IF EXISTS ramsys_r1.ref_occupancy CASCADE; 
DROP TABLE IF EXISTS ramsys_r1.ref_partner CASCADE;
DROP TABLE IF EXISTS ramsys_r1.ref_city CASCADE;
DROP TABLE IF EXISTS ramsys_r1.ref_country CASCADE;
DROP TABLE IF EXISTS ramsys_r1.ref_region CASCADE;
DROP TABLE IF EXISTS ramsys_r1.ref_currency CASCADE;

---------------------------------------------------------------------------------------------------------------------------------------

 

CREATE OR REPLACE FUNCTION ramsys_r1.T2_ON_UPDATE()
    RETURNS TRIGGER AS $$
BEGIN
    NEW.DATE_TIME_UPDATED := NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

ALTER function ramsys_r1.T1_ON_INSERT OWNER TO user_owner_r1;
ALTER function ramsys_r1.T2_ON_UPDATE OWNER TO user_owner_r1;

---------------------------------------------------------------------------------------------------------------------

CREATE TABLE ramsys_r1.ref_role	(	oid 				integer 				NOT NULL,
									role_code 			character varying(8) 	NOT NULL,
									role_description 	character varying(80),
									date_time_created 	timestamp with time zone,
									user_created 		character varying(10),
									date_time_updated 	timestamp with time zone,
									user_updated 		character varying(10),
									CONSTRAINT FK1_REF_ROLE_UNIQUE UNIQUE (role_code),
									CONSTRAINT FK2_REF_ROLE_UNIQUE UNIQUE (oid,role_code)
								);

ALTER TABLE ramsys_r1.ref_role OWNER TO user_owner_r1;
ALTER TABLE ONLY ramsys_r1.ref_role ADD CONSTRAINT ref_role_pkey PRIMARY KEY (oid);

CREATE SEQUENCE ramsys_r1.ref_role_oid_seq
AS integer
START WITH 1
INCREMENT BY 1
NO MINVALUE
NO MAXVALUE
CACHE 1;

ALTER SEQUENCE ramsys_r1.ref_role_oid_seq OWNER TO user_owner_r1;
ALTER SEQUENCE ramsys_r1.ref_role_oid_seq OWNED BY ramsys_r1.ref_role.oid;
ALTER TABLE ONLY ramsys_r1.ref_role ALTER COLUMN oid SET DEFAULT nextval('ramsys_r1.ref_role_oid_seq'::regclass);

CREATE TRIGGER T1_ref_role
BEFORE INSERT ON ramsys_r1.ref_role
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T1_ON_INSERT();

CREATE TRIGGER T2_ref_role
BEFORE UPDATE ON ramsys_r1.ref_role
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T2_ON_UPDATE();

INSERT INTO ramsys_r1.ref_role (role_code, role_description, user_created)
VALUES	('ADMIN','Administrateur','admin'),
		('ENQ','Interrogation','admin'),
		('UDW','Souscripteur','admin'),
		('ACC','Comptabilite','admin'),
		('CLM','Gestionnaire Sinistre','admin'),
		('FIN','Gestionnaire Finance','admin'),
		('UDW_MNG','Souscripteur Senior','admin'),
		('ACC_MNG','Comptable Senior','admin'),
		('MNG','Gestionnaire','admin');		
		
---------------------------------------------------------------------------------------------------------------------

CREATE TABLE ramsys_r1.ref_group	(	oid 				integer 				NOT NULL,
										group_code 			character varying(8) 	NOT NULL,
										group_title 		character varying(40),
										group_sequence 		integer,
										group_description 	character varying(300),
										group_icone 		character varying(10),
										date_time_created 	timestamp with time zone,
										user_created 		character varying(10),
										date_time_updated 	timestamp with time zone,
										user_updated 		character varying(10),
										CONSTRAINT FK1_REF_GROUP_UNIQUE UNIQUE (group_code),
										CONSTRAINT FK2_REF_GROUP_UNIQUE UNIQUE (oid,group_code)
									);

ALTER TABLE ramsys_r1.ref_group OWNER TO user_owner_r1;
ALTER TABLE ONLY ramsys_r1.ref_group ADD CONSTRAINT ref_group_pkey PRIMARY KEY (oid);

CREATE SEQUENCE ramsys_r1.ref_group_oid_seq
AS integer
START WITH 1
INCREMENT BY 1
NO MINVALUE
NO MAXVALUE
CACHE 1;

ALTER SEQUENCE ramsys_r1.ref_group_oid_seq OWNER TO user_owner_r1;
ALTER SEQUENCE ramsys_r1.ref_group_oid_seq OWNED BY ramsys_r1.ref_group.oid;
ALTER TABLE ONLY ramsys_r1.ref_group ALTER COLUMN oid SET DEFAULT nextval('ramsys_r1.ref_group_oid_seq'::regclass);

CREATE TRIGGER T1_ref_group
BEFORE INSERT ON ramsys_r1.ref_group
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T1_ON_INSERT();

CREATE TRIGGER T2_ref_group
BEFORE UPDATE ON ramsys_r1.ref_group
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T2_ON_UPDATE(); 

INSERT INTO ramsys_r1.ref_group (group_code,group_title,group_sequence,user_created)
VALUES	('UWR_MGT','Souscription',1,'admin'),
		('PRM_ACC','Prime & Compte Technique',2,'admin'),
		('CLM_MGT','Gestion de Sinistre',3,'admin'),
		('FIN_MGT','Finance',4,'admin'),
		('ENQ_ALL','Interrogation',5,'admin'),
		('REP_ALL','Reporting',6,'admin'),
		('REF_TAB','Tables de Références',7,'admin'),
		('ADM_MGR','Administration',8,'admin');
	
---------------------------------------------------------------------------------------------------------------------
	
CREATE TABLE ramsys_r1.ref_function	(	oid 					integer 				NOT NULL,
										function_code 			character varying(8) 	NOT NULL,
										function_title 			character varying(40),
										function_type 			character varying(4),
										function_description 	character varying(300),
										function_sequence 		integer,
										processing_type 		character varying(9),
										contract_status 		character varying(9),
										portfolio_type 			character varying(9),
										date_time_created 		timestamp WITH TIME ZONE,
										user_created 			character varying(10),
										date_time_updated 		timestamp WITH TIME ZONE,
										user_updated 			character varying(10),
										CONSTRAINT FK1_REF_FUNCTION_UNIQUE UNIQUE (function_code),
										CONSTRAINT FK2_REF_FUNCTION_UNIQUE UNIQUE (oid,function_code)
									);

ALTER TABLE ramsys_r1.ref_function OWNER TO user_owner_r1;
ALTER TABLE ONLY ramsys_r1.ref_function ADD CONSTRAINT ref_function_pkey PRIMARY KEY (oid);

CREATE SEQUENCE ramsys_r1.ref_function_oid_seq
AS integer
START WITH 1
INCREMENT BY 1
NO MINVALUE
NO MAXVALUE
CACHE 1;

ALTER SEQUENCE ramsys_r1.ref_function_oid_seq OWNER TO user_owner_r1;
ALTER SEQUENCE ramsys_r1.ref_function_oid_seq OWNED BY ramsys_r1.ref_function.oid;
ALTER TABLE ONLY ramsys_r1.ref_function ALTER COLUMN oid SET DEFAULT nextval('ramsys_r1.ref_function_oid_seq'::regclass);

CREATE TRIGGER T1_ref_function
BEFORE INSERT ON ramsys_r1.ref_function
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T1_ON_INSERT();

CREATE TRIGGER T2_ref_function
BEFORE UPDATE ON ramsys_r1.ref_function
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T2_ON_UPDATE();

INSERT INTO ramsys_r1.ref_function (FUNCTION_CODE, FUNCTION_TITLE, FUNCTION_TYPE, function_sequence, user_created)
VALUES	('MNT_CTR','Maintenance Police','M',10,'admin'),
		('REF_PRT','Partenaires','M',70,'admin'),
		('REF_INS','Assurés','M',71,'admin');
		
---------------------------------------------------------------------------------------------------------------------
	
CREATE TABLE ramsys_r1.ref_group_function	(	oid 				integer 				NOT NULL,
												oid_group 			integer 				NOT NULL,
												oid_function 		integer 				NOT NULL,
												group_code			character varying(8) 	NOT NULL,
												function_code 		character varying(8) 	NOT NULL,
												date_time_created 	timestamp WITH time zone,
												user_created 		character varying(10),
												date_time_updated 	timestamp WITH time zone,
												user_updated 		character varying(10),
												CONSTRAINT FK1_REF_GROUP_FUNCTION_UNIQUE UNIQUE (oid_group,oid_function),
												CONSTRAINT FK2_REF_GROUP_FUNCTION_UNIQUE UNIQUE (group_code,function_code)
											);

ALTER TABLE ramsys_r1.ref_group_function OWNER TO user_owner_r1;
ALTER TABLE ONLY ramsys_r1.ref_group_function ADD CONSTRAINT ref_group_function_pkey PRIMARY KEY (oid);

CREATE SEQUENCE ramsys_r1.ref_group_function_oid_seq
AS integer
START WITH 1
INCREMENT BY 1
NO MINVALUE
NO MAXVALUE
CACHE 1;

ALTER SEQUENCE ramsys_r1.ref_group_function_oid_seq OWNER TO user_owner_r1;
ALTER SEQUENCE ramsys_r1.ref_group_function_oid_seq OWNED BY ramsys_r1.ref_group_function.oid;
ALTER TABLE ONLY ramsys_r1.ref_group_function ALTER COLUMN oid SET DEFAULT nextval('ramsys_r1.ref_group_function_oid_seq'::regclass);

ALTER TABLE ONLY ramsys_r1.ref_group_function ADD CONSTRAINT FK3_REF_GROUP_FUNCTION FOREIGN KEY (oid_function,function_code) REFERENCES ramsys_r1.ref_function(oid,function_code);
ALTER TABLE ONLY ramsys_r1.ref_group_function ADD CONSTRAINT FK4_REF_GROUP_FUNCTION FOREIGN KEY (oid_group,group_code) REFERENCES ramsys_r1.ref_group(oid,group_code);


CREATE TRIGGER T1_ref_group_function
BEFORE INSERT ON ramsys_r1.ref_group_function
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T1_ON_INSERT();

CREATE TRIGGER T2_ref_group_function
BEFORE UPDATE ON ramsys_r1.ref_group_function
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T2_ON_UPDATE(); 

INSERT INTO ramsys_r1.ref_group_function (oid_group,oid_function,group_code,function_code,user_created)
VALUES	((select oid from ramsys_r1.ref_group where group_code = 'UWR_MGT'),(select oid from ramsys_r1.ref_function where function_code = 'MNT_CTR'),'UWR_MGT','MNT_CTR','admin'),
		((select oid from ramsys_r1.ref_group where group_code = 'REF_TAB'),(select oid from ramsys_r1.ref_function where function_code = 'REF_PRT'),'REF_TAB','REF_PRT','admin'),
		((select oid from ramsys_r1.ref_group where group_code = 'REF_TAB'),(select oid from ramsys_r1.ref_function where function_code = 'REF_INS'),'REF_TAB','REF_INS','admin');
		
---------------------------------------------------------------------------------------------------------------------
	
CREATE TABLE ramsys_r1.ref_role_group	(	oid 				integer 				NOT NULL,
											oid_role 			integer 				NOT NULL,
											oid_group 			integer 				NOT NULL,
											group_sequence 		integer,
											role_code 			character varying(8) 	NOT NULL,
											group_code 			character varying(8) 	NOT NULL,
											date_time_created 	timestamp with time zone,
											user_created 		character varying(10),
											date_time_updated 	timestamp with time zone,
											user_updated 		character varying(10),
											CONSTRAINT FK1_REF_ROLE_GROUP_UNIQUE UNIQUE (oid_role,oid_group),
											CONSTRAINT FK2_REF_ROLE_GROUP_UNIQUE UNIQUE (role_code,group_code)
										);

ALTER TABLE ramsys_r1.ref_role_group OWNER TO user_owner_r1;
ALTER TABLE ONLY ramsys_r1.ref_role_group ADD CONSTRAINT ref_role_group_pkey PRIMARY KEY (oid);

create index IDX1_REF_ROLE_GROUP on ramsys_r1.ref_role_group (OID_GROUP);
create index IDX2_REF_ROLE_GROUP on ramsys_r1.ref_role_group (OID_ROLE,OID_GROUP);
create index IDX3_REF_ROLE_GROUP on ramsys_r1.ref_role_group (OID_ROLE);

ALTER TABLE ONLY ramsys_r1.ref_role_group ADD CONSTRAINT FK3_REF_ROLE_GROUP FOREIGN KEY (oid_role,role_code) REFERENCES ramsys_r1.ref_role(oid,role_code);
ALTER TABLE ONLY ramsys_r1.ref_role_group ADD CONSTRAINT FK4_REF_ROLE_GROUP FOREIGN KEY (oid_group,group_code) REFERENCES ramsys_r1.ref_group(oid,group_code);


CREATE SEQUENCE ramsys_r1.ref_role_group_oid_seq
AS integer
START WITH 1
INCREMENT BY 1
NO MINVALUE
NO MAXVALUE
CACHE 1;

ALTER SEQUENCE ramsys_r1.ref_role_group_oid_seq OWNER TO user_owner_r1;
ALTER SEQUENCE ramsys_r1.ref_role_group_oid_seq OWNED BY ramsys_r1.ref_role_group.oid;
ALTER TABLE ONLY ramsys_r1.ref_role_group ALTER COLUMN oid SET DEFAULT nextval('ramsys_r1.ref_role_group_oid_seq'::regclass);

CREATE TRIGGER T1_ref_role_group
BEFORE INSERT ON ramsys_r1.ref_role_group
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T1_ON_INSERT();

CREATE TRIGGER T2_ref_role_group
BEFORE UPDATE ON ramsys_r1.ref_role_group
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T2_ON_UPDATE();

INSERT INTO ramsys_r1.ref_role_group (oid_role,oid_group,group_sequence,role_code,group_code,user_created)
VALUES	((select oid from ramsys_r1.ref_role where role_code = 'ADMIN'),(select oid from ramsys_r1.ref_group where group_code = 'UWR_MGT'),1,'ADMIN','UWR_MGT','admin'),
		((select oid from ramsys_r1.ref_role where role_code = 'ADMIN'),(select oid from ramsys_r1.ref_group where group_code = 'PRM_ACC'),2,'ADMIN','PRM_ACC','admin'),
		((select oid from ramsys_r1.ref_role where role_code = 'ADMIN'),(select oid from ramsys_r1.ref_group where group_code = 'CLM_MGT'),3,'ADMIN','CLM_MGT','admin'),
		((select oid from ramsys_r1.ref_role where role_code = 'ADMIN'),(select oid from ramsys_r1.ref_group where group_code = 'FIN_MGT'),4,'ADMIN','FIN_MGT','admin'),
		((select oid from ramsys_r1.ref_role where role_code = 'ADMIN'),(select oid from ramsys_r1.ref_group where group_code = 'ENQ_ALL'),5,'ADMIN','ENQ_ALL','admin'),
		((select oid from ramsys_r1.ref_role where role_code = 'ADMIN'),(select oid from ramsys_r1.ref_group where group_code = 'REP_ALL'),6,'ADMIN','REP_ALL','admin'),
		((select oid from ramsys_r1.ref_role where role_code = 'ADMIN'),(select oid from ramsys_r1.ref_group where group_code = 'REF_TAB'),7,'ADMIN','REF_TAB','admin'),
		((select oid from ramsys_r1.ref_role where role_code = 'ADMIN'),(select oid from ramsys_r1.ref_group where group_code = 'ADM_MGR'),8,'ADMIN','ADM_MGR','admin');

---------------------------------------------------------------------------------------------------------------------

CREATE TABLE ramsys_r1.ref_role_function	(	oid 				integer NOT NULL,
												oid_role 			integer NOT NULL,
												oid_function 		integer NOT NULL,
												role_code 			character varying(8) 	NOT NULL,
												function_code 		character varying(8) 	NOT NULL,
												date_time_created 	timestamp with time zone,
												user_created 		character varying(10),
												date_time_updated 	timestamp with time zone,
												user_updated 		character varying(10),
												CONSTRAINT FK1_REF_ROLE_FUNCTION_UNIQUE UNIQUE (oid_role,oid_function),
												CONSTRAINT FK2_REF_ROLE_FUNCTION_UNIQUE UNIQUE (role_code,function_code)
											);

ALTER TABLE ramsys_r1.ref_role_function OWNER TO user_owner_r1;
ALTER TABLE ONLY ramsys_r1.ref_role_function ADD CONSTRAINT ref_role_function_pkey PRIMARY KEY (oid);

CREATE SEQUENCE ramsys_r1.ref_role_function_oid_seq
AS integer
START WITH 1
INCREMENT BY 1
NO MINVALUE
NO MAXVALUE
CACHE 1;

ALTER SEQUENCE ramsys_r1.ref_role_function_oid_seq OWNER TO user_owner_r1;
ALTER SEQUENCE ramsys_r1.ref_role_function_oid_seq OWNED BY ramsys_r1.ref_role_function.oid;
ALTER TABLE ONLY ramsys_r1.ref_role_function ALTER COLUMN oid SET DEFAULT nextval('ramsys_r1.ref_role_function_oid_seq'::regclass);

ALTER TABLE ONLY ramsys_r1.ref_role_function ADD CONSTRAINT FK3_REF_ROLE_FUNCTION FOREIGN KEY (oid_role,role_code) REFERENCES ramsys_r1.ref_role(oid,role_code);
ALTER TABLE ONLY ramsys_r1.ref_role_function ADD CONSTRAINT FK4_REF_ROLE_FUNCTION FOREIGN KEY (oid_function,function_code) REFERENCES ramsys_r1.ref_function(oid,function_code);


CREATE TRIGGER T1_ref_role_function
BEFORE INSERT ON ramsys_r1.ref_role_function
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T1_ON_INSERT();

CREATE TRIGGER T2_ref_role_function
BEFORE UPDATE ON ramsys_r1.ref_role_function
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T2_ON_UPDATE();

INSERT INTO ramsys_r1.ref_role_function (oid_role,oid_function,role_code,function_code,user_created)
VALUES	((select oid from ramsys_r1.ref_role where role_code = 'ADMIN'),(select oid from ramsys_r1.ref_function where function_code = 'MNT_CTR'),'ADMIN','MNT_CTR','admin'),
		((select oid from ramsys_r1.ref_role where role_code = 'ADMIN'),(select oid from ramsys_r1.ref_function where function_code = 'REF_PRT'),'ADMIN','REF_PRT','admin'),
		((select oid from ramsys_r1.ref_role where role_code = 'ADMIN'),(select oid from ramsys_r1.ref_function where function_code = 'REF_INS'),'ADMIN','REF_INS','admin');
		
---------------------------------------------------------------------------------------------------------------------

CREATE TABLE ramsys_r1.ref_period	(	oid 						integer 	NOT NULL,
										year 						integer 	NOT NULL,
										month 						integer 	NOT NULL,
										start_date 					date,
										description 				character varying(32),
										current_period_indicator 	boolean,
										linkage_ind 				boolean,
										exchange_ind 				boolean,
										bank_balance_ind 			boolean,
										date_time_created 			timestamp with time zone,
										user_created 				character varying(10),
										date_time_updated 			timestamp with time zone,
										user_updated 				character varying(10),
										CONSTRAINT FK1_PERIOD_UNIQUE UNIQUE (year,month)
									);

ALTER TABLE ramsys_r1.ref_period OWNER TO user_owner_r1;

ALTER TABLE ramsys_r1.ref_period ALTER COLUMN current_period_indicator SET DATA TYPE INTEGER USING current_period_indicator::INTEGER;
ALTER TABLE ramsys_r1.ref_period ALTER COLUMN linkage_ind SET DATA TYPE INTEGER USING linkage_ind::INTEGER;
ALTER TABLE ramsys_r1.ref_period ALTER COLUMN exchange_ind SET DATA TYPE INTEGER USING exchange_ind::INTEGER;
ALTER TABLE ramsys_r1.ref_period ALTER COLUMN bank_balance_ind SET DATA TYPE INTEGER USING bank_balance_ind::INTEGER;
ALTER TABLE ONLY ramsys_r1.ref_period ADD CONSTRAINT ref_period_pkey PRIMARY KEY (oid);

CREATE SEQUENCE ramsys_r1.ref_period_oid_seq
AS integer
START WITH 1
INCREMENT BY 1
NO MINVALUE
NO MAXVALUE
CACHE 1;

ALTER SEQUENCE ramsys_r1.ref_period_oid_seq OWNER TO user_owner_r1;
ALTER SEQUENCE ramsys_r1.ref_period_oid_seq OWNED BY ramsys_r1.ref_period.oid;
ALTER TABLE ONLY ramsys_r1.ref_period ALTER COLUMN oid SET DEFAULT nextval('ramsys_r1.ref_period_oid_seq'::regclass);

CREATE TRIGGER T1_ref_period
BEFORE INSERT ON ramsys_r1.ref_period
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T1_ON_INSERT();

CREATE TRIGGER T2_ref_period
BEFORE UPDATE ON ramsys_r1.ref_period
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T2_ON_UPDATE();

INSERT INTO ramsys_r1.ref_period (YEAR, MONTH, START_DATE,CURRENT_PERIOD_INDICATOR, LINKAGE_IND, EXCHANGE_IND, BANK_BALANCE_IND,USER_CREATED) 
VALUES	(2024,1,'2024-01-01',0,1,1,1,'admin'),
		(2024,2,'2024-01-01',0,1,1,1,'admin'),
		(2024,3,'2024-01-01',0,1,1,1,'admin'),
		(2024,4,'2024-01-01',0,1,1,1,'admin'),
		(2024,5,'2024-01-01',0,1,1,1,'admin'),
		(2024,6,'2024-01-01',0,1,1,1,'admin'),
		(2024,7,'2024-01-01',0,1,1,1,'admin'),
		(2024,8,'2024-01-01',0,1,1,1,'admin'),
		(2024,9,'2024-01-01',0,1,1,1,'admin'),
		(2024,10,'2024-01-01',0,1,1,1,'admin'),
		(2024,11,'2024-01-01',0,1,1,1,'admin'),
		(2024,12,'2024-12-31',0,1,1,1,'admin'),
		(2025,1,'2025-01-01',1,0,0,0,'admin'),
		(2025,2,NULL,NULL,0,0,0,'admin');

---------------------------------------------------------------------------------------------------------------------

CREATE TABLE ramsys_r1.ref_region	(	oid 				integer 				NOT NULL,
										region_description 	character varying(40) 	NOT NULL,
										date_time_created 	timestamp with time zone,
										user_created 		character varying(10),
										date_time_updated 	timestamp with time zone,
										user_updated 		character varying(10),
										CONSTRAINT FK1_REF_REGION_UNIQUE UNIQUE (region_description)
									);

ALTER TABLE ramsys_r1.ref_region OWNER TO user_owner_r1;

ALTER TABLE ONLY ramsys_r1.ref_region ADD CONSTRAINT ref_region_pkey PRIMARY KEY (oid);

CREATE SEQUENCE ramsys_r1.ref_region_oid_seq
AS integer
START WITH 1
INCREMENT BY 1
NO MINVALUE
NO MAXVALUE
CACHE 1;

ALTER SEQUENCE ramsys_r1.ref_region_oid_seq OWNER TO user_owner_r1;
ALTER SEQUENCE ramsys_r1.ref_region_oid_seq OWNED BY ramsys_r1.ref_region.oid;
ALTER TABLE ONLY ramsys_r1.ref_region ALTER COLUMN oid SET DEFAULT nextval('ramsys_r1.ref_region_oid_seq'::regclass);

CREATE TRIGGER T1_ref_region
BEFORE INSERT ON ramsys_r1.ref_region
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T1_ON_INSERT();

CREATE TRIGGER T2_ref_region
BEFORE UPDATE ON ramsys_r1.ref_region
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T2_ON_UPDATE();


INSERT INTO ramsys_r1.ref_region (region_description,user_created)
VALUES	('N/A','admin'),
		('CIMA','admin'),
		('Hors CIMA Anglophone','admin'),
		('Hors CIMA Francophone','admin'),
		('Autre','admin'),
		('Monde Entier','admin'); 
	
---------------------------------------------------------------------------------------------------------------------

CREATE TABLE ramsys_r1.ref_country	(	oid 				integer 				NOT NULL,
										oid_region 			integer 				NOT NULL,
										country_code 		character varying(2) 	NOT NULL,
										country_description	character varying(80) 	NOT NULL,		
										date_time_created 	timestamp with time zone,
										user_created 		character varying(10),
										date_time_updated 	timestamp with time zone,
										user_updated 		character varying(10),
										CONSTRAINT FK1_REF_COUNTRY_UNIQUE UNIQUE (country_code),
										CONSTRAINT FK2_REF_COUNTRY_UNIQUE UNIQUE (oid,country_code),
										CONSTRAINT FK3_REF_COUNTRY_UNIQUE UNIQUE (oid_region,country_code)
									);

ALTER TABLE ramsys_r1.ref_country OWNER TO user_owner_r1;
ALTER TABLE ONLY ramsys_r1.ref_country ADD CONSTRAINT ref_country_pkey PRIMARY KEY (oid);

CREATE SEQUENCE ramsys_r1.ref_country_oid_seq
AS integer
START WITH 1
INCREMENT BY 1
NO MINVALUE
NO MAXVALUE
CACHE 1;

ALTER SEQUENCE ramsys_r1.ref_country_oid_seq OWNER TO user_owner_r1;
ALTER SEQUENCE ramsys_r1.ref_country_oid_seq OWNED BY ramsys_r1.ref_country.oid;
ALTER TABLE ONLY ramsys_r1.ref_country ALTER COLUMN oid SET DEFAULT nextval('ramsys_r1.ref_country_oid_seq'::regclass);

CREATE TRIGGER T1_ref_country
BEFORE INSERT ON ramsys_r1.ref_country
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T1_ON_INSERT();

CREATE TRIGGER T2_ref_country
BEFORE UPDATE ON ramsys_r1.ref_country
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T2_ON_UPDATE();

INSERT INTO ramsys_r1.ref_country (COUNTRY_CODE,COUNTRY_DESCRIPTION,OID_REGION,USER_CREATED)
VALUES	('NN','N/A',1,'admin'),
		('DZ','Algérie',5,'admin'),
		('LY','Libye',5,'admin'),
		('MA','Maroc',5,'admin'),
		('TN','Tunisie',5,'admin'),
		('CV','Cap-Vert',5,'admin'),
		('TD','Tchad',5,'admin'),
		('DJ','Djibouti',5,'admin'),
		('EG','Égypte',5,'admin'),
		('GQ','Guinée équatoriale',5,'admin'),
		('ER','Érythrée',5,'admin'),
		('ET','Éthiopie',5,'admin'),
		('GM','Gambie',5,'admin'),
		('GW','Guinée-Bissau',5,'admin'),
		('KE','Kenya',5,'admin'),
		('MG','Madagascar',5,'admin'),
		('MW','Malawi',5,'admin'),
		('MZ','Mozambique',5,'admin'),
		('NA','Namibie',5,'admin'),
		('RW','Rwanda',5,'admin'),
		('SL','Sierra Leone',5,'admin'),
		('SO','Somalie',5,'admin'),
		('ZA','Afrique du Sud',5,'admin'),
		('SS','Soudan du Sud',5,'admin'),
		('SD','Soudan',5,'admin'),
		('TZ','Tanzanie',5,'admin'),
		('UG','Ouganda',5,'admin'),
		('ZM','Zambie',5,'admin'),
		('ZW','Zimbabwe',5,'admin'),
		('BE','Belgique',5,'admin'),
		('CY','Chypre',5,'admin'),
		('CZ','République tchèque',5,'admin'),
		('FI','Finlande',5,'admin'),
		('FR','France',5,'admin'),
		('DE','Allemagne',5,'admin'),
		('GB','Royaume-Uni',5,'admin'),
		('GR','Grèce',5,'admin'),
		('IE','Irlande',5,'admin'),
		('IT','Italie',5,'admin'),
		('LU','Luxembourg',5,'admin'),
		('MC','Monaco',5,'admin'),
		('NL','Pays-Bas',5,'admin'),
		('PL','Pologne',5,'admin'),
		('PT','Portugal',5,'admin'),
		('RO','Roumanie',5,'admin'),
		('RU','Russie',5,'admin'),
		('RS','Serbie',5,'admin'),
		('SK','Slovaquie',5,'admin'),
		('SI','Slovénie',5,'admin'),
		('ES','Espagne',5,'admin'),
		('SE','Suède',5,'admin'),
		('CH','Suisse',5,'admin'),
		('VA','Vatican',5,'admin'),
		('BH','Bahrain',5,'admin'),
		('IQ','Irak',5,'admin'),
		('JO','Jordanie',5,'admin'),
		('KW','Koweït',5,'admin'),
		('LB','Liban',5,'admin'),
		('OM','Oman',5,'admin'),
		('QA','Qatar',5,'admin'),
		('SA','Arabie saoudite',5,'admin'),
		('SY','Syrie',5,'admin'),
		('AE','Émirats arabes unis',5,'admin'),
		('YE','Yémen',5,'admin'),
		('AF','Afghanistan',5,'admin'),
		('AZ','Azerbaïdjan',5,'admin'),
		('BD','Bangladesh',5,'admin'),
		('CN','Chine',5,'admin'),
		('HK','Hong Kong',5,'admin'),
		('IN','Inde',5,'admin'),
		('ID','Indonésie',5,'admin'),
		('IR','Iran',5,'admin'),
		('JP','Japon',5,'admin'),
		('KR','Corée du Sud',5,'admin'),
		('MY','Malaisie',5,'admin'),
		('PH','Philippines',5,'admin'),
		('SG','Singapour',5,'admin'),
		('LK','Sri Lanka',5,'admin'),
		('TW','Taiwan',5,'admin'),
		('TJ','Tajikistan',5,'admin'),
		('TH','Thaïlande',5,'admin'),
		('TR','Turquie',5,'admin'),
		('TM','Turkmenistan',5,'admin'),
		('UZ','Uzbekistan',5,'admin'),
		('AL','Albanie',5,'admin'),
		('AD','Andorre',5,'admin'),
		('AO','Angola',5,'admin'),
		('AI','Anguilla',5,'admin'),
		('AG','Antigua-et-Barbuda',5,'admin'),
		('AR','Argentine',5,'admin'),
		('AM','Arménie',5,'admin'),
		('AU','Australie',5,'admin'),
		('AT','Autriche',5,'admin'),
		('BS','Bahamas',5,'admin'),
		('BB','Barbados',5,'admin'),
		('BM','Bermudes',5,'admin'),
		('BW','Botswana',5,'admin'),
		('BN','Brunei Darussalam',5,'admin'),
		('BI','Burundi',5,'admin'),
		('CA','Canada',5,'admin'),
		('KM','Comores',5,'admin'),
		('CR','Costa Rica',5,'admin'),
		('CU','Cuba',5,'admin'),
		('FJ','Fiji',5,'admin'),
		('GT','Guatemala',5,'admin'),
		('HT','Haiti',5,'admin'),
		('HN','Honduras',5,'admin'),
		('HU','Hongrie',5,'admin'),
		('LA','Laos',5,'admin'),
		('LS','Lesotho',5,'admin'),
		('MV','Maldives',5,'admin'),
		('MU','Maurice',5,'admin'),
		('YT','Mayotte',5,'admin'),
		('MX','Mexique',5,'admin'),
		('ME','Montenegro',5,'admin'),
		('MM','Myanmar',5,'admin'),
		('NP','Nepal',5,'admin'),
		('AN','Antilles néerlandaises',5,'admin'),
		('NZ','Nouvelle-Zélande',5,'admin'),
		('NI','Nicaragua',5,'admin'),
		('NO','Norvège',5,'admin'),
		('PW','Palau',5,'admin'),
		('PA','Panama',5,'admin'),
		('PR','Puerto Rico',5,'admin'),
		('RE','La Réunion',5,'admin'),
		('VC','Saint Vincent & Grenadines',5,'admin'),
		('SM','San Marino',5,'admin'),
		('ST','Sao Tomé-et-Principe',5,'admin'),
		('SC','Seychelles',5,'admin'),
		('SR','Suriname',5,'admin'),
		('SZ','Eswatini',5,'admin'),
		('TK','Tokelau',5,'admin'),
		('TO','Tonga',5,'admin'),
		('UA','Ukraine',5,'admin'),
		('US','États-Unis',5,'admin'),
		('VE','Venezuela',5,'admin'),
		('W0','Monde Entier',6,'admin'),
		('W1','Monde Entier sauf États-Unis',6,'admin'),
		('AA','Afrique',5,'admin'),
		('MR','Mauritanie',4,'admin'),
		('CD','République démocratique du Congo',4,'admin'),
		('GN','Guinée',4,'admin'),
		('GH','Ghana',3,'admin'),
		('LR','Libéria',3,'admin'),
		('NG','Nigeria',3,'admin'),
		('BJ','Bénin',2,'admin'),
		('BF','Burkina Faso',2,'admin'),
		('CM','Cameroun',2,'admin'),
		('CF','République centrafricaine',2,'admin'),
		('CG','Congo',2,'admin'),
		('GA','Gabon',2,'admin'),
		('CI','Côte d''Ivoire',2,'admin'),
		('ML','Mali',2,'admin'),
		('NE','Niger',2,'admin'),
		('SN','Sénégal',2,'admin'),
		('TG','Togo',2,'admin');

---------------------------------------------------------------------------------------------------------------------
	
CREATE TABLE ramsys_r1.ref_city	(	oid 				integer 				NOT NULL,
									oid_country 		integer 				NOT NULL,
									country_code 		character varying(2) 	NOT NULL,
									city_code 			character varying(3) 	NOT NULL,
									city_description	character varying(80) 	NOT NULL,
									date_time_created 	timestamp with time zone,
									user_created 		character varying(10),
									date_time_updated 	timestamp with time zone,
									user_updated 		character varying(10),
									CONSTRAINT FK1_REF_CITY_UNIQUE UNIQUE (city_code),
									CONSTRAINT FK2_REF_CITY_UNIQUE UNIQUE (oid,city_code),
									CONSTRAINT FK3_REF_CITY_UNIQUE UNIQUE (oid_country,country_code)
								);

ALTER TABLE ramsys_r1.ref_city OWNER TO user_owner_r1;

ALTER TABLE ONLY ramsys_r1.ref_city ADD CONSTRAINT ref_city_pkey PRIMARY KEY (oid);

create index IDX1_REF_CITY on ramsys_r1.ref_city (OID_COUNTRY);

CREATE SEQUENCE ramsys_r1.ref_city_oid_seq
AS integer
START WITH 1
INCREMENT BY 1
NO MINVALUE
NO MAXVALUE
CACHE 1;

ALTER SEQUENCE ramsys_r1.ref_city_oid_seq OWNER TO user_owner_r1;
ALTER SEQUENCE ramsys_r1.ref_city_oid_seq OWNED BY ramsys_r1.ref_city.oid;
ALTER TABLE ONLY ramsys_r1.ref_city ALTER COLUMN oid SET DEFAULT nextval('ramsys_r1.ref_city_oid_seq'::regclass);

ALTER TABLE ONLY ramsys_r1.ref_city ADD CONSTRAINT FK4_REF_CITY FOREIGN KEY (oid_country,country_code) REFERENCES ramsys_r1.ref_country(oid,country_code);

CREATE TRIGGER T1_ref_city
BEFORE INSERT ON ramsys_r1.ref_city
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T1_ON_INSERT();

CREATE TRIGGER T2_ref_city
BEFORE UPDATE ON ramsys_r1.ref_city
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T2_ON_UPDATE(); 

INSERT INTO ramsys_r1.ref_city (oid_country,country_code,city_code,city_description,user_created)
VALUES	((select oid from ramsys_r1.ref_country where country_code = 'MA'),'MA','CAS','Casablanca','admin'),
		((select oid from ramsys_r1.ref_country where country_code = 'CI'),'CI','ABD','Abidjan','admin');
	
---------------------------------------------------------------------------------------------------------------------

CREATE TABLE ramsys_r1.ref_currency	(	oid 					integer 				NOT NULL,
										currency_code 			character varying(3) 	NOT NULL,
										currency_description	character varying(45) 	NOT NULL,
										currency_acceptance 	boolean,
										version 				integer 				NOT NULL,
										date_time_created 		timestamp with time zone,
										user_created 			character varying(10),
										date_time_updated 		timestamp with time zone,
										user_updated 			character varying(10),
										CONSTRAINT FK1_REF_CURRENCY_UNIQUE UNIQUE (currency_code),
										CONSTRAINT FK2_REF_CURRENCY_UNIQUE UNIQUE (oid,currency_code)
									);
						
ALTER TABLE ramsys_r1.ref_currency OWNER TO user_owner_r1;
ALTER TABLE ONLY ramsys_r1.ref_currency ADD CONSTRAINT ref_currency_pkey PRIMARY KEY (oid);
ALTER TABLE ramsys_r1.ref_currency ALTER COLUMN currency_acceptance SET DATA TYPE INTEGER USING currency_acceptance::INTEGER;

CREATE SEQUENCE ramsys_r1.ref_currency_oid_seq
AS integer
START WITH 1
INCREMENT BY 1
NO MINVALUE
NO MAXVALUE
CACHE 1;

ALTER SEQUENCE ramsys_r1.ref_currency_oid_seq OWNER TO user_owner_r1;
ALTER SEQUENCE ramsys_r1.ref_currency_oid_seq OWNED BY ramsys_r1.ref_currency.oid;
ALTER TABLE ONLY ramsys_r1.ref_currency ALTER COLUMN oid SET DEFAULT nextval('ramsys_r1.ref_currency_oid_seq'::regclass);

CREATE TRIGGER T1_ref_currency
BEFORE INSERT ON ramsys_r1.ref_currency
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T1_ON_INSERT();

CREATE TRIGGER T2_ref_currency
BEFORE UPDATE ON ramsys_r1.ref_currency
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T2_ON_UPDATE();

INSERT INTO ramsys_r1.ref_currency (CURRENCY_CODE, CURRENCY_DESCRIPTION, CURRENCY_ACCEPTANCE, USER_CREATED,Version)
VALUES	('NN','N/A',0,'admin',0),		
		('AED','Dirham des Émirats arabes unis - AED',0,'admin',0),
		('AFN','Afghani afghan - AFN',0,'admin',0),
		('ALL','Lek albanais - ALL',0,'admin',0),
		('AMD','Dram arménien - AMD',0,'admin',0),
		('ANG','Florin antillais - ANG',0,'admin',0),
		('AOA','Kwanza angolais - AOA',0,'admin',0),
		('ARS','Peso argentin - ARS',0,'admin',0),
		('AUD','Dollar australien - AUD',0,'admin',0),
		('AWG','Florin arubais - AWG',0,'admin',0),
		('AZN','Manat azerbaïdjanais - AZN',0,'admin',0),
		('BAM','Mark convertible de Bosnie-Herzégovine - BAM',0,'admin',0),
		('BBD','Dollar barbadien - BBD',0,'admin',0),
		('BDT','Taka bangladais - BDT',0,'admin',0),
		('BGN','Lev bulgare - BGN',0,'admin',0),
		('BHD','Dinar bahreïni - BHD',0,'admin',0),
		('BIF','Franc burundais - BIF',0,'admin',0),
		('BMD','Dollar bermudien - BMD',0,'admin',0),
		('BND','Dollar brunéien - BND',0,'admin',0),
		('BOB','Boliviano bolivien - BOB',0,'admin',0),
		('BRL','Réal brésilien - BRL',0,'admin',0),
		('BSD','Dollar bahaméen - BSD',0,'admin',0),
		('BTN','Ngultrum bhoutanais - BTN',0,'admin',0),
		('BWP','Pula botswanais - BWP',0,'admin',0),
		('BYN','Rouble biélorusse - BYN',0,'admin',0),
		('BZD','Dollar bélizien - BZD',0,'admin',0),
		('CAD','Dollar canadien - CAD',0,'admin',0),
		('CDF','Franc congolais - CDF',0,'admin',0),
		('CHF','Franc suisse - CHF',0,'admin',0),
		('CLP','Peso chilien - CLP',0,'admin',0),
		('CNY','Yuan chinois - CNY',0,'admin',0),
		('COP','Peso colombien - COP',0,'admin',0),
		('CRC','Colón costaricain - CRC',0,'admin',0),
		('CUC','Peso cubain convertible - CUC',0,'admin',0),
		('CUP','Peso cubain - CUP',0,'admin',0),
		('CVE','Escudo cap-verdien - CVE',0,'admin',0),
		('CZK','Couronne tchèque - CZK',0,'admin',0),
		('DJF','Franc djiboutien - DJF',0,'admin',0),
		('DKK','Couronne danoise - DKK',0,'admin',0),
		('DOP','Peso dominicain - DOP',0,'admin',0),
		('DZD','Dinar algérien - DZD',0,'admin',0),
		('EGP','Livre égyptienne - EGP',0,'admin',0),
		('ERN','Nakfa érythréen - ERN',0,'admin',0),
		('ETB','Birr éthiopien - ETB',0,'admin',0),
		('EUR','Euro - EUR',0,'admin',0),
		('FJD','Dollar fidjien - FJD',0,'admin',0),
		('FKP','Livre des îles Falkland - FKP',0,'admin',0),
		('GBP','Livre sterling - GBP',0,'admin',0),
		('GEL','Lari géorgien - GEL',0,'admin',0),
		('GHS','Cedi ghanéen - GHS',0,'admin',0),
		('GIP','Livre de Gibraltar - GIP',0,'admin',0),
		('GMD','Dalasi gambien - GMD',0,'admin',0),
		('GNF','Franc guinéen - GNF',1,'admin',0),
		('GTQ','Quetzal guatémaltèque - GTQ',0,'admin',0),
		('GYD','Dollar guyanien - GYD',0,'admin',0),
		('HKD','Dollar de Hong Kong - HKD',0,'admin',0),
		('HNL','Lempira hondurien - HNL',0,'admin',0),
		('HRK','Kuna croate - HRK',0,'admin',0),
		('HTG','Gourde haïtienne - HTG',0,'admin',0),
		('HUF','Forint hongrois - HUF',0,'admin',0),
		('IDR','Roupie indonésienne - IDR',0,'admin',0),
		('ILS','Shekel israélien - ILS',0,'admin',0),
		('INR','Roupie indienne - INR',0,'admin',0),
		('IQD','Dinar irakien - IQD',0,'admin',0),
		('IRR','Rial iranien - IRR',0,'admin',0),
		('ISK','Couronne islandaise - ISK',0,'admin',0),
		('JMD','Dollar jamaïcain - JMD',0,'admin',0),
		('JOD','Dinar jordanien - JOD',0,'admin',0),
		('JPY','Yen japonais - JPY',0,'admin',0),
		('KES','Shilling kényan - KES',0,'admin',0),
		('KGS','Som kirghize - KGS',0,'admin',0),
		('KHR','Riel cambodgien - KHR',0,'admin',0),
		('KMF','Franc comorien - KMF',0,'admin',0),
		('KPW','Won nord-coréen - KPW',0,'admin',0),
		('KRW','Won sud-coréen - KRW',0,'admin',0),
		('KWD','Dinar koweïtien - KWD',0,'admin',0),
		('KYD','Dollar des îles Caïmans - KYD',0,'admin',0),
		('KZT','Tenge kazakh - KZT',0,'admin',0),
		('LAK','Kip laotien - LAK',0,'admin',0),
		('LBP','Livre libanaise - LBP',0,'admin',0),
		('LKR','Roupie srilankaise - LKR',0,'admin',0),
		('LRD','Dollar libérien - LRD',0,'admin',0),
		('LSL','Loti lesothan - LSL',0,'admin',0),
		('LYD','Dinar libyen - LYD',0,'admin',0),
		('MAD','Dirham marocain - MAD',0,'admin',0),
		('MDL','Leu moldave - MDL',0,'admin',0),
		('MGA','Ariary malgache - MGA',0,'admin',0),
		('MKD','Denar macédonien - MKD',0,'admin',0),
		('MMK','Kyat birman - MMK',0,'admin',0),
		('MNT','Tugrik mongol - MNT',0,'admin',0),
		('MOP','Pataca macanaise - MOP',0,'admin',0),
		('MRU','Ouguiya mauritanienne - MRU',1,'admin',0),
		('MUR','Roupie mauricienne - MUR',0,'admin',0),
		('MVR','Rufiyaa maldivienne - MVR',0,'admin',0),
		('MWK','Kwacha malawien - MWK',0,'admin',0),
		('MXN','Peso mexicain - MXN',0,'admin',0),
		('MYR','Ringgit malaisien - MYR',0,'admin',0),
		('MZN','Metical mozambicain - MZN',0,'admin',0),
		('NAD','Dollar namibien - NAD',0,'admin',0),
		('NGN','Naira nigérian - NGN',0,'admin',0),
		('NIO','Córdoba nicaraguayen - NIO',0,'admin',0),
		('NOK','Couronne norvégienne - NOK',0,'admin',0),
		('NPR','Roupie népalaise - NPR',0,'admin',0),
		('NZD','Dollar néo-zélandais - NZD',0,'admin',0),
		('OMR','Rial omanais - OMR',0,'admin',0),
		('PAB','Balboa panaméen - PAB',0,'admin',0),
		('PEN','Sol péruvien - PEN',0,'admin',0),
		('PGK','Kina papou-néo-guinéen - PGK',0,'admin',0),
		('PHP','Peso philippin - PHP',0,'admin',0),
		('PKR','Roupie pakistanaise - PKR',0,'admin',0),
		('PLN','Złoty polonais - PLN',0,'admin',0),
		('PYG','Guarani paraguayen - PYG',0,'admin',0),
		('QAR','Riyal qatari - QAR',0,'admin',0),
		('RON','Leu roumain - RON',0,'admin',0),
		('RSD','Dinar serbe - RSD',0,'admin',0),
		('RUB','Rouble russe - RUB',0,'admin',0),
		('RWF','Franc rwandais - RWF',0,'admin',0),
		('SAR','Riyal saoudien - SAR',0,'admin',0),
		('SBD','Dollar des îles Salomon - SBD',0,'admin',0),
		('SCR','Roupie seychelloise - SCR',0,'admin',0),
		('SDG','Livre soudanaise - SDG',0,'admin',0),
		('SEK','Couronne suédoise - SEK',0,'admin',0),
		('SGD','Dollar de Singapour - SGD',0,'admin',0),
		('SHP','Livre de Sainte-Hélène - SHP',0,'admin',0),
		('SLL','Leone sierra-léonais - SLL',0,'admin',0),
		('SOS','Shilling somalien - SOS',0,'admin',0),
		('SRD','Dollar surinamais - SRD',0,'admin',0),
		('SSP','Livre sud-soudanaise - SSP',0,'admin',0),
		('STN','Dobra santoméen - STN',0,'admin',0),
		('SVC','Colón salvadorien - SVC',0,'admin',0),
		('SYP','Livre syrienne - SYP',0,'admin',0),
		('SZL','Lilangeni swazi - SZL',0,'admin',0),
		('THB','Baht thaïlandais - THB',0,'admin',0),
		('TJS','Somoni tadjik - TJS',0,'admin',0),
		('TMT','Manat turkmène - TMT',0,'admin',0),
		('TND','Dinar tunisien - TND',0,'admin',0),
		('TOP','Paanga tongan - TOP',0,'admin',0),
		('TRY','Livre turque - TRY',0,'admin',0),
		('TTD','Dollar trinidadien - TTD',0,'admin',0),
		('TWD','Dollar taïwanais - TWD',0,'admin',0),
		('TZS','Shilling tanzanien - TZS',0,'admin',0),
		('UAH','Hryvnia ukrainienne - UAH',0,'admin',0),
		('UGX','Shilling ougandais - UGX',0,'admin',0),
		('USD','Dollar américain - USD',1,'admin',0),
		('UYU','Peso uruguayen - UYU',0,'admin',0),
		('UZS','Sum ouzbek - UZS',0,'admin',0),
		('VES','Bolívar vénézuélien - VES',0,'admin',0),
		('VND','Dong vietnamien - VND',0,'admin',0),
		('VUV','Vatu vanuatuan - VUV',0,'admin',0),
		('WST','Tala samoan - WST',0,'admin',0),
		('XAF','Franc CFA (BEAC) - XAF',1,'admin',0),
		('XCD','Dollar des Caraïbes orientales - XCD',0,'admin',0),
		('XOF','Franc CFA (BCEAO) - XOF',1,'admin',0),
		('XPF','Franc CFP - XPF',0,'admin',0),
		('YER','Rial yéménite - YER',0,'admin',0),
		('ZAR','Rand sud-africain - ZAR',0,'admin',0),
		('ZMW','Kwacha zambien - ZMW',0,'admin',0);

---------------------------------------------------------------------------------------------------------------------

CREATE TABLE ramsys_r1.ref_currency_exchange	(	oid 				integer 		NOT NULL,
													year 				integer 		NOT NULL,
													month 				integer 		NOT NULL,
													oid_currency 		integer 		NOT NULL,
													currency_code 		character varying(3) 	NOT NULL,
													currency_rate 		numeric(15,5),
													oid_period 			integer 		NOT NULL,
													date_time_created 	timestamp with time zone,
													user_created 		character varying(10),
													date_time_updated 	timestamp with time zone,
													user_updated 		character varying(10),
													CONSTRAINT FK1_REF_CURRENCY_EXCHANGE_UNIQUE UNIQUE (year,month,oid_currency,currency_code)
											);

ALTER TABLE ramsys_r1.ref_currency_exchange OWNER TO user_owner_r1;

ALTER TABLE ONLY ramsys_r1.ref_currency_exchange ADD CONSTRAINT ref_currency_exchange_pkey PRIMARY KEY (oid);

CREATE SEQUENCE ramsys_r1.ref_currency_exchange_oid_seq
AS integer
START WITH 1
INCREMENT BY 1
NO MINVALUE
NO MAXVALUE
CACHE 1;

ALTER SEQUENCE ramsys_r1.ref_currency_exchange_oid_seq OWNER TO user_owner_r1;
ALTER SEQUENCE ramsys_r1.ref_currency_exchange_oid_seq OWNED BY ramsys_r1.ref_currency_exchange.oid;
ALTER TABLE ONLY ramsys_r1.ref_currency_exchange ALTER COLUMN oid SET DEFAULT nextval('ramsys_r1.ref_currency_exchange_oid_seq'::regclass);

ALTER TABLE ONLY ramsys_r1.ref_currency_exchange ADD CONSTRAINT FK2_CURRENCY_EXCHANGE_CURRENCY FOREIGN KEY (oid_currency,currency_code) REFERENCES ramsys_r1.ref_currency(oid,currency_code);

create index IDX1_REF_CURRENCY_RATE on ramsys_r1.ref_currency_exchange (OID_CURRENCY);
create index IDX2_REF_CURRENCY_RATE on ramsys_r1.ref_currency_exchange (OID_PERIOD);

CREATE TRIGGER T1_ref_currency_exchange 
BEFORE INSERT ON ramsys_r1.ref_currency_exchange
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T1_ON_INSERT();

CREATE TRIGGER T2_ref_currency_exchange
BEFORE UPDATE ON ramsys_r1.ref_currency_exchange
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T2_ON_UPDATE(); 

INSERT INTO ramsys_r1.ref_currency_exchange (YEAR, MONTH, OID_CURRENCY, CURRENCY_CODE, CURRENCY_RATE, OID_PERIOD, USER_CREATED)
VALUES	(2024,1,(select oid from ramsys_r1.ref_currency where CURRENCY_CODE = 'GNF'),'GNF',17,1,'admin'),
		(2024,1,(select oid from ramsys_r1.ref_currency where CURRENCY_CODE = 'MRU'),'MRU',0.06,1,'admin'),
		(2024,1,(select oid from ramsys_r1.ref_currency where CURRENCY_CODE = 'USD'),'USD',0.00162,1,'admin'),
		(2024,1,(select oid from ramsys_r1.ref_currency where CURRENCY_CODE = 'XAF'),'XAF',1,1,'admin'),
		(2024,1,(select oid from ramsys_r1.ref_currency where CURRENCY_CODE = 'XOF'),'XOF',1,1,'admin'),
		(2024,12,(select oid from ramsys_r1.ref_currency where CURRENCY_CODE = 'GNF'),'GNF',17,12,'admin'),
		(2024,12,(select oid from ramsys_r1.ref_currency where CURRENCY_CODE = 'MRU'),'MRU',0.06,12,'admin'),
		(2024,12,(select oid from ramsys_r1.ref_currency where CURRENCY_CODE = 'USD'),'USD',0.00162,12,'admin'),
		(2024,12,(select oid from ramsys_r1.ref_currency where CURRENCY_CODE = 'XAF'),'XAF',1,12,'admin'),
		(2024,12,(select oid from ramsys_r1.ref_currency where CURRENCY_CODE = 'XOF'),'XOF',1,12,'admin'),
		(2025,1,(select oid from ramsys_r1.ref_currency where CURRENCY_CODE = 'GNF'),'GNF',17,1,'admin'),
		(2025,1,(select oid from ramsys_r1.ref_currency where CURRENCY_CODE = 'MRU'),'MRU',0.06,1,'admin'),
		(2025,1,(select oid from ramsys_r1.ref_currency where CURRENCY_CODE = 'USD'),'USD',0.00162,1,'admin'),
		(2025,1,(select oid from ramsys_r1.ref_currency where CURRENCY_CODE = 'XAF'),'XAF',1,1,'admin'),
		(2025,1,(select oid from ramsys_r1.ref_currency where CURRENCY_CODE = 'XOF'),'XOF',1,1,'admin');
			
---------------------------------------------------------------------------------------------------------------------

CREATE TABLE ramsys_r1.ref_partner	(	oid 				integer 				NOT NULL,
										partner_code 		character varying(10) 	NOT NULL,
										partner_name 		character varying(100) 	NOT NULL,
										partner_short_name 	character varying(32) 	NOT NULL,
										contact_genre 		character varying(5),
										contact_name 		character varying(32),
										partner_type 		character varying(15),
										type_other 			character varying(32),
										reinsurer 			boolean,
										inwards 			boolean,
										outwards 			boolean,
										oid_region 			integer 				NOT NULL,
										oid_country 		integer 				NOT NULL,
										adress 				text,
										rating 				character varying(4),
										scoring 			integer,
										telephone 			character varying(20),
										fax 				character varying(20),
										prefix_mail 		character varying(32),
										domaine 			character varying(32),
										bank_name 			character varying(100),
										oid_currency 		integer 				NOT NULL,
										bank_iban			character varying(30),
										swift 				character varying(10),
										comment 			text,
										version 			integer 				NOT NULL,
										partner_group 		character varying(10),
										date_time_created 	timestamp with time zone,
										user_created 		character varying(10),
										date_time_updated 	timestamp with time zone,
										user_updated 		character varying(10),
										CONSTRAINT FK1_REF_PARTNER_UNIQUE UNIQUE (partner_code),
										CONSTRAINT FK2_REF_PARTNER_UNIQUE UNIQUE (partner_name),
										CONSTRAINT FK3_REF_PARTNER_UNIQUE UNIQUE (oid,partner_name)
										);
							
ALTER TABLE ramsys_r1.ref_partner OWNER TO user_owner_r1;						
ALTER TABLE ramsys_r1.ref_partner ALTER COLUMN reinsurer SET DATA TYPE INTEGER USING reinsurer::INTEGER;
ALTER TABLE ramsys_r1.ref_partner ALTER COLUMN inwards SET DATA TYPE INTEGER USING inwards::INTEGER;
ALTER TABLE ramsys_r1.ref_partner ALTER COLUMN outwards SET DATA TYPE INTEGER USING outwards::INTEGER;
ALTER TABLE ONLY ramsys_r1.ref_partner ADD CONSTRAINT ref_partner_pkey PRIMARY KEY (oid);

CREATE SEQUENCE ramsys_r1.ref_partner_oid_seq
AS integer
START WITH 1
INCREMENT BY 1
NO MINVALUE
NO MAXVALUE
CACHE 1;

ALTER SEQUENCE ramsys_r1.ref_partner_oid_seq OWNER TO user_owner_r1;
ALTER SEQUENCE ramsys_r1.ref_partner_oid_seq OWNED BY ramsys_r1.ref_partner.oid;
ALTER TABLE ONLY ramsys_r1.ref_partner ALTER COLUMN oid SET DEFAULT nextval('ramsys_r1.ref_partner_oid_seq'::regclass);

ALTER TABLE ONLY ramsys_r1.ref_partner ADD CONSTRAINT FK4_REF_PARTNER FOREIGN KEY (oid_region) REFERENCES ramsys_r1.ref_region(oid);
ALTER TABLE ONLY ramsys_r1.ref_partner ADD CONSTRAINT FK5_REF_PARTNER FOREIGN KEY (oid_currency) REFERENCES ramsys_r1.ref_currency(oid);
ALTER TABLE ONLY ramsys_r1.ref_partner ADD CONSTRAINT FK6_REF_PARTNER FOREIGN KEY (oid_country) REFERENCES ramsys_r1.ref_country(oid);

create index IDX1_REF_PARTNER on ramsys_r1.ref_partner (OID_COUNTRY);
create index IDX2_REF_PARTNER on ramsys_r1.ref_partner (OID_CURRENCY);
create index IDX3_REF_PARTNER on ramsys_r1.ref_partner (OID_REGION, OID_COUNTRY, OID_CURRENCY);
create index IDX4_REF_PARTNER on ramsys_r1.ref_partner (OID_REGION);

CREATE TRIGGER T1_ref_partner
BEFORE INSERT ON ramsys_r1.ref_partner
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T1_ON_INSERT();

CREATE TRIGGER T2_ref_partner
BEFORE UPDATE ON ramsys_r1.ref_partner
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T2_ON_UPDATE();	

INSERT INTO ramsys_r1.ref_partner (partner_code,PARTNER_NAME,PARTNER_SHORT_NAME,CONTACT_GENRE,CONTACT_NAME,PARTNER_TYPE,TYPE_OTHER,REINSURER,INWARDS,OUTWARDS,OID_REGION,OID_COUNTRY,ADRESS,RATING,SCORING,OID_CURRENCY,Version,PARTNER_GROUP,user_created)
values 	('CI0C000000','Sunu Réassurance','Sunu Ré','N/A','','Cedant',NULL,'1','0','0',(select oid_region from ramsys_r1.ref_country where country_code = 'CI'),(select oid from ramsys_r1.ref_country where country_code = 'CI'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,NULL,'admin'),
		('AE0B000001','Gallagher Reinsurance','Gallagher Re','N/A','','Broker',NULL,'0','1','1',(select oid_region from ramsys_r1.ref_country where country_code = 'AE'),(select oid from ramsys_r1.ref_country where country_code = 'AE'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,NULL,'admin'),
		('CD0C000001','ZEP Re (PTA Reinsurance Company) RDC','Zep Re','N/A','','Cedant',NULL,'1','1','1',(select oid_region from ramsys_r1.ref_country where country_code = 'CD'),(select oid from ramsys_r1.ref_country where country_code = 'CD'),'','B++','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,NULL,'admin'),
		('CD0C000002','Sunu Assurances Iard RDC','Sunu Iard RDC','N/A','','Cedant',NULL,'0','1','0',(select oid_region from ramsys_r1.ref_country where country_code = 'CD'),(select oid from ramsys_r1.ref_country where country_code = 'CD'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,'CI0C000000','admin'),
		('CH0C000001','Swiss Reinsurance','Swiss Re','N/A','','Cedant',NULL,'1','1','1',(select oid_region from ramsys_r1.ref_country where country_code = 'CH'),(select oid from ramsys_r1.ref_country where country_code = 'CH'),'','A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,NULL,'admin'),
		('MR0C000001','Sunu Assurances Iard Mauritanie','Sunu Iard Mauritanie','N/A','','Cedant',NULL,'0','1','0',(select oid_region from ramsys_r1.ref_country where country_code = 'MR'),(select oid from ramsys_r1.ref_country where country_code = 'MR'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,'CI0C000000','admin'),
		('MR0C000002','Sunu Assurances Vie Mauritanie','Sunu Vie Mauritanie','N/A','','Cedant',NULL,'0','1','0',(select oid_region from ramsys_r1.ref_country where country_code = 'MR'),(select oid from ramsys_r1.ref_country where country_code = 'MR'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,'CI0C000000','admin'),
		('CI0B000001','AMGS Abidjan','AMGS','N/A','','Broker',NULL,'0','1','1',(select oid_region from ramsys_r1.ref_country where country_code = 'CI'),(select oid from ramsys_r1.ref_country where country_code = 'CI'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,null,'admin'),
		('CI0B000002','AMRE Abidjan','AMRE','N/A','','Broker',NULL,'0','1','1',(select oid_region from ramsys_r1.ref_country where country_code = 'CI'),(select oid from ramsys_r1.ref_country where country_code = 'CI'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,null,'admin'),
		('CI0B000003','Chedid Re Abidjan','Chedid Re','N/A','','Broker',NULL,'0','1','1',(select oid_region from ramsys_r1.ref_country where country_code = 'CI'),(select oid from ramsys_r1.ref_country where country_code = 'CI'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,null,'admin'),
		('CI0B000004','Reinsurance Solutions Abidjan','Reinsurance Solutions','N/A','','Broker',NULL,'0','1','1',(select oid_region from ramsys_r1.ref_country where country_code = 'CI'),(select oid from ramsys_r1.ref_country where country_code = 'CI'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,null,'admin'),
		('CI0C000005','Africa Re Abidjan','Africa Re','N/A','','Cedant',NULL,'1','1','1',(select oid_region from ramsys_r1.ref_country where country_code = 'CI'),(select oid from ramsys_r1.ref_country where country_code = 'CI'),'','A-','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,null,'admin'),
		('CI0C000006','Aveni Re Abidjan','Aveni Re','N/A','','Cedant',NULL,'1','1','1',(select oid_region from ramsys_r1.ref_country where country_code = 'CI'),(select oid from ramsys_r1.ref_country where country_code = 'CI'),'','A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,null,'admin'),
		('CI0C000007','CICA Reinsurance Abidjan','CICA Re','N/A','','Cedant',NULL,'1','1','1',(select oid_region from ramsys_r1.ref_country where country_code = 'CI'),(select oid from ramsys_r1.ref_country where country_code = 'CI'),'','B+','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,null,'admin'),
		('CI0C000008','Continental Reinsurance Abidjan','Continental Re','N/A','','Cedant',NULL,'1','1','1',(select oid_region from ramsys_r1.ref_country where country_code = 'CI'),(select oid from ramsys_r1.ref_country where country_code = 'CI'),'','B+','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,null,'admin'),
		('CI0C000009','Kenya Reinsurance Abidjan','Kenya Re','N/A','','Cedant',NULL,'1','1','1',(select oid_region from ramsys_r1.ref_country where country_code = 'CI'),(select oid from ramsys_r1.ref_country where country_code = 'CI'),'','AA+','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,null,'admin'),
		('CI0C000010','NCA Reinsurance Abidjan','NCA Re','N/A','','Cedant',NULL,'1','1','1',(select oid_region from ramsys_r1.ref_country where country_code = 'CI'),(select oid from ramsys_r1.ref_country where country_code = 'CI'),'','BB+','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,null,'admin'),
		('CI0C000011','Société Commerciale Cabonaise de Réassurance Abidjan','SCG Re','N/A','','Cedant',NULL,'1','1','1',(select oid_region from ramsys_r1.ref_country where country_code = 'CI'),(select oid from ramsys_r1.ref_country where country_code = 'CI'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,null,'admin'),
		('CI0C000012','Seychelles Reinsurance Abidjan','Seychelles Re','N/A','','Cedant',NULL,'1','1','1',(select oid_region from ramsys_r1.ref_country where country_code = 'CI'),(select oid from ramsys_r1.ref_country where country_code = 'CI'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,null,'admin'),
		('CI0C000013','Waica Reinsurance Abidjan','Waica Re','N/A','','Cedant',NULL,'1','1','1',(select oid_region from ramsys_r1.ref_country where country_code = 'CI'),(select oid from ramsys_r1.ref_country where country_code = 'CI'),'','B','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,null,'admin'),
		('CI0C000014','ZEP Re (PTA Reinsurance Company) Abidjan','ZEP Re','N/A','','Cedant',NULL,'1','1','1',(select oid_region from ramsys_r1.ref_country where country_code = 'CI'),(select oid from ramsys_r1.ref_country where country_code = 'CI'),'','B++','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,null,'admin'),
		('BF0C000001','Sunu Assurances Iard Burkina Faso','Sunu Iard Burkina Faso','N/A','','Cedant',NULL,'0','1','0',(select oid_region from ramsys_r1.ref_country where country_code = 'BF'),(select oid from ramsys_r1.ref_country where country_code = 'BF'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,'CI0C000000','admin'),
		('CF0C000001','Sunu Assurances Iard Centrafrique','Sunu Iard Centrafrique','N/A','','Cedant',NULL,'0','1','0',(select oid_region from ramsys_r1.ref_country where country_code = 'CF'),(select oid from ramsys_r1.ref_country where country_code = 'CF'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,'CI0C000000','admin'),
		('CG0C000001','Sunu Assurances Iard Congo','Sunu Iard Congo','N/A','','Cedant',NULL,'0','1','0',(select oid_region from ramsys_r1.ref_country where country_code = 'CG'),(select oid from ramsys_r1.ref_country where country_code = 'CG'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,'CI0C000000','admin'),
		('GN0C000001','Sunu Assurances Iard Guinée','Sunu Assurances Iard Guinée','N/A','','Cedant',NULL,'0','1','0',(select oid_region from ramsys_r1.ref_country where country_code = 'GN'),(select oid from ramsys_r1.ref_country where country_code = 'GN'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,'CI0C000000','admin'),
		('NE0C000001','Sunu Assurances Iard Niger','Sunu Assurances Iard Niger','N/A','','Cedant',NULL,'0','1','0',(select oid_region from ramsys_r1.ref_country where country_code = 'NE'),(select oid from ramsys_r1.ref_country where country_code = 'NE'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,'CI0C000000','admin'),
		('SN0C000001','Sunu Assurances Iard Senegal','Sunu Iard Senegal','N/A','','Cedant',NULL,'0','1','0',(select oid_region from ramsys_r1.ref_country where country_code = 'SN'),(select oid from ramsys_r1.ref_country where country_code = 'SN'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,'CI0C000000','admin'),
		('BF0C000002','Sunu Assurances Vie Burkina Faso','Sunu Vie Burkina Faso','N/A','','Cedant',NULL,'0','1','0',(select oid_region from ramsys_r1.ref_country where country_code = 'BF'),(select oid from ramsys_r1.ref_country where country_code = 'BF'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,'CI0C000000','admin'),
		('GN0C000002','Sunu Assurances Vie Guinée','Sunu Vie Guinée','N/A','','Cedant',NULL,'0','1','0',(select oid_region from ramsys_r1.ref_country where country_code = 'GN'),(select oid from ramsys_r1.ref_country where country_code = 'GN'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,'CI0C000000','admin'),
		('NE0C000002','Sunu Assurances Vie Niger','Sunu Vie Niger','N/A','','Cedant',NULL,'0','1','0',(select oid_region from ramsys_r1.ref_country where country_code = 'NE'),(select oid from ramsys_r1.ref_country where country_code = 'NE'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,'CI0C000000','admin'),
		('SN0C000002','Sunu Assurances Vie Senegal','Sunu Vie Senegal','N/A','','Cedant',NULL,'0','1','0',(select oid_region from ramsys_r1.ref_country where country_code = 'SN'),(select oid from ramsys_r1.ref_country where country_code = 'SN'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,'CI0C000000','admin'),
		('CM0C000001','CICA Reinsurance Douala','CICA Re','N/A','','Cedant',NULL,'1','1','1',(select oid_region from ramsys_r1.ref_country where country_code = 'CM'),(select oid from ramsys_r1.ref_country where country_code = 'CM'),'','B+','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,null,'admin'),
		('DE0C000001','Munich Re','Munich Re','N/A',NULL,'Cedant',NULL,'1','1','1',(select oid_region from ramsys_r1.ref_country where country_code = 'DE'),(select oid from ramsys_r1.ref_country where country_code = 'DE'),NULL,'AA','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,null,'admin'),
		('BJ0C000001','Sunu Assurances Iard Benin','Sunu Iard Benin','N/A','','Cedant',NULL,'0','1','0',(select oid_region from ramsys_r1.ref_country where country_code = 'BJ'),(select oid from ramsys_r1.ref_country where country_code = 'BJ'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,'CI0C000000','admin'),
		('BJ0C000002','Sunu Assurances Vie Benin','Sunu Vie Benin','N/A','','Cedant',NULL,'0','1','0',(select oid_region from ramsys_r1.ref_country where country_code = 'BJ'),(select oid from ramsys_r1.ref_country where country_code = 'BJ'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,'CI0C000000','admin'),
		('FR0C000001','Compagnie Centrale de Réassurance - France','CCR','N/A','','Cedant',NULL,'1','1','1',(select oid_region from ramsys_r1.ref_country where country_code = 'FR'),(select oid from ramsys_r1.ref_country where country_code = 'FR'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,null,'admin'),
		('GB0C000001','Neema Via AM First','AM First','N/A','','Cedant',NULL,'1','1','1',(select oid_region from ramsys_r1.ref_country where country_code = 'GB'),(select oid from ramsys_r1.ref_country where country_code = 'GB'),'','A-','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,null,'admin'),
		('GB0C000002','Speciality MGA via PVI Re','PVI Re','N/A','','Cedant',NULL,'1','1','1',(select oid_region from ramsys_r1.ref_country where country_code = 'GB'),(select oid from ramsys_r1.ref_country where country_code = 'GB'),'','B++','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,null,'admin'),
		('CM0C000002','Sunu Assurances Iard Cameroun','Sunu Iard Cameroun','N/A','','Cedant',NULL,'0','1','0',(select oid_region from ramsys_r1.ref_country where country_code = 'CM'),(select oid from ramsys_r1.ref_country where country_code = 'CM'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,'CI0C000000','admin'),
		('ML0C000001','Sunu Assurances Iard Mali','Sunu Iard Mali','N/A','','Cedant',NULL,'0','1','0',(select oid_region from ramsys_r1.ref_country where country_code = 'ML'),(select oid from ramsys_r1.ref_country where country_code = 'ML'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,'CI0C000000','admin'),
		('CM0C000003','Sunu Assurances Vie Cameroun','Sunu Vie Cameroun','N/A','','Cedant',NULL,'0','1','0',(select oid_region from ramsys_r1.ref_country where country_code = 'CM'),(select oid from ramsys_r1.ref_country where country_code = 'CM'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,'CI0C000000','admin'),
		('GH0C000001','Ghana Reinsurace PLC','Ghana Re','N/A','','Cedant',NULL,'1','1','1',(select oid_region from ramsys_r1.ref_country where country_code = 'GH'),(select oid from ramsys_r1.ref_country where country_code = 'GH'),'','BB','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,null,'admin'),
		('GH0C000002','W-Safe','W-Safe','N/A','','Cedant',NULL,'1','1','1',(select oid_region from ramsys_r1.ref_country where country_code = 'GH'),(select oid from ramsys_r1.ref_country where country_code = 'GH'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,null,'admin'),
		('MA0C000001','Société Centrale de Réassurance','SCR','N/A',NULL,'Cedant',NULL,'1','1','1',(select oid_region from ramsys_r1.ref_country where country_code = 'MA'),(select oid from ramsys_r1.ref_country where country_code = 'MA'),NULL,'B++','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,null,'admin'),
		('CI0C000015','Sunu Assurances Iard Côte d''Ivoire','Sunu Iard Côte d''Ivoire','N/A','','Cedant',NULL,'0','1','0',(select oid_region from ramsys_r1.ref_country where country_code = 'CI'),(select oid from ramsys_r1.ref_country where country_code = 'CI'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,'CI0C000000','admin'),
		('CI0C000016','Sunu Assurances Vie Côte d''Ivoire','Sunu Vie Côte d''Ivoire','N/A','','Cedant',NULL,'0','1','0',(select oid_region from ramsys_r1.ref_country where country_code = 'CI'),(select oid from ramsys_r1.ref_country where country_code = 'CI'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,'CI0C000000','admin'),
		('MU0B000001','ARC Assurance','ARC','N/A','','Cedant',NULL,'1','1','1',(select oid_region from ramsys_r1.ref_country where country_code = 'MU'),(select oid from ramsys_r1.ref_country where country_code = 'MU'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,null,'admin'),
		('SN0C000003','Société sénégalaise de Réassurances','Sen Re','N/A','','Cedant',NULL,'1','1','1',(select oid_region from ramsys_r1.ref_country where country_code = 'SN'),(select oid from ramsys_r1.ref_country where country_code = 'SN'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,null,'admin'),
		('GA0C000001','Sunu Assurances Iard Gabon','Sunu Iard Gabon','N/A','','Cedant',NULL,'0','1','0',(select oid_region from ramsys_r1.ref_country where country_code = 'GA'),(select oid from ramsys_r1.ref_country where country_code = 'GA'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,'CI0C000000','admin'),
		('GA0C000002','Sunu Assurances Vie Gabon','Sunu Vie Gabon','N/A','','Cedant',NULL,'0','1','0',(select oid_region from ramsys_r1.ref_country where country_code = 'GA'),(select oid from ramsys_r1.ref_country where country_code = 'GA'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,'CI0C000000','admin'),
		('TG0C000001','Sunu Assurances Iard Togo','Sunu Iard Togo','N/A','','Cedant',NULL,'0','1','0',(select oid_region from ramsys_r1.ref_country where country_code = 'TG'),(select oid from ramsys_r1.ref_country where country_code = 'TG'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,'CI0C000000','admin'),
		('TG0C000002','Sunu Assurances Vie Togo','Sunu Vie Togo','N/A','','Cedant',NULL,'0','1','0',(select oid_region from ramsys_r1.ref_country where country_code = 'TG'),(select oid from ramsys_r1.ref_country where country_code = 'TG'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,'CI0C000000','admin'),
		('TG0C000003','CICA Reinsurance Lomé','CICA Re','N/A','','Cedant',NULL,'1','1','1',(select oid_region from ramsys_r1.ref_country where country_code = 'TG'),(select oid from ramsys_r1.ref_country where country_code = 'TG'),'','B+','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,null,'admin'),
		('US0C000001','American International Group','AIG','N/A','','Cedant',NULL,'1','1','1',(select oid_region from ramsys_r1.ref_country where country_code = 'US'),(select oid from ramsys_r1.ref_country where country_code = 'US'),'','A+','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,null,'admin'),
		('US0C000002','Southern Pacific Insurance Corporation','SOPAC','N/A','','Cedant',NULL,'1','1','1',(select oid_region from ramsys_r1.ref_country where country_code = 'US'),(select oid from ramsys_r1.ref_country where country_code = 'US'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,null,'admin'),
		('LR0C000001','Sunu Assurances Liberia','Sunu Liberia','N/A','','Cedant',NULL,'0','1','0',(select oid_region from ramsys_r1.ref_country where country_code = 'LR'),(select oid from ramsys_r1.ref_country where country_code = 'LR'),'','N/A','0',(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),0,'CI0C000000','admin');

---------------------------------------------------------------------------------------------------------------------

CREATE TABLE ramsys_r1.ref_occupancy	(	oid 							integer 				NOT NULL,
											occupancy_code					character varying(4) 	NOT NULL,
											occupancy_group_desccription	character varying(40) 	NOT NULL,
											occupancy_desccription 			character varying(40) 	NOT NULL,
											date_time_created 				timestamp with time zone,
											user_created 					character varying(10),
											date_time_updated 				timestamp with time zone,
											user_updated 					character varying(10),
											CONSTRAINT FK1_REF_OCCUPANCY_UNIQUE UNIQUE (occupancy_code),
											CONSTRAINT FK2_REF_OCCUPANCY_UNIQUE UNIQUE (occupancy_group_desccription,occupancy_desccription)
										);

ALTER TABLE ramsys_r1.ref_occupancy OWNER TO user_owner_r1;

ALTER TABLE ONLY ramsys_r1.ref_occupancy ADD CONSTRAINT ref_occupancy_pkey PRIMARY KEY (oid);

CREATE SEQUENCE ramsys_r1.ref_occupancy_oid_seq
AS integer
START WITH 1
INCREMENT BY 1
NO MINVALUE
NO MAXVALUE
CACHE 1;

ALTER SEQUENCE ramsys_r1.ref_occupancy_oid_seq OWNER TO user_owner_r1;
ALTER SEQUENCE ramsys_r1.ref_occupancy_oid_seq OWNED BY ramsys_r1.ref_occupancy.oid;
ALTER TABLE ONLY ramsys_r1.ref_occupancy ALTER COLUMN oid SET DEFAULT nextval('ramsys_r1.ref_occupancy_oid_seq'::regclass);

CREATE TRIGGER T1_ref_occupancy
BEFORE INSERT ON ramsys_r1.ref_occupancy
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T1_ON_INSERT();

CREATE TRIGGER T2_ref_occupancy
BEFORE UPDATE ON ramsys_r1.ref_occupancy
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T2_ON_UPDATE();

INSERT INTO ramsys_r1.ref_occupancy (occupancy_code,occupancy_group_desccription,occupancy_desccription,user_created)
VALUES	('0001','N/A','N/A','admin'),
		('1001','Industrie','Pétrole & Gaz','admin'),
		('1002','Industrie','Chimie/Pharmaceutique','admin'),
		('1003','Industrie','Métallurgie/Mines','admin'),
		('1101','Transport','Aviation','admin'),
		('1102','Transport','Maritime','admin'),
		('1103','Transport','Automobile','admin'),	
		('1201','Construction','BTP','admin'),
		('1202','Construction','Énergie','admin'),
		('1301','Technologie','Télécoms/Data Centers','admin'),			
		('1302','Technologie','Spatial','admin'),				
		('1401','Santé','Hôpitaux','admin'),			
		('1402','Santé','Pharmacies','admin'),								
		('1501','Agriculture','Agroalimentaire','admin'),			
		('1502','Agriculture','Sylviculture','admin'),						
		('1601','Services','Finance','admin'),		
		('1602','Services','Tourisme','admin'),					
		('1701','Émergents','Cyber','admin'),			
		('1702','Émergents','Climatique','admin');			
	
---------------------------------------------------------------------------------------------------------------------

CREATE TABLE ramsys_r1.ref_type_of_arrangement	(	oid 							integer 				NOT NULL,
													type_of_arrangement_code 		character varying(8) 	NOT NULL,
													type_of_arrangement_description character varying(32),
													include_portfolio 				character varying(32),
													include_type_of_contact 		character varying(32),
													include_processing 				character varying(32),
													include_type_of_business 		character varying(32),
													include_insured 				character varying(40) 	NOT NULL,
													date_time_created 				timestamp with time zone,
													user_created 					character varying(10),
													date_time_updated 				timestamp with time zone,
													user_updated 					character varying(10),
													CONSTRAINT FK1_REF_TYPE_OF_ARRANGEMENT_UNIQUE UNIQUE (type_of_arrangement_code),
													CONSTRAINT FK2_REF_TYPE_OF_ARRANGEMENT_UNIQUE UNIQUE (type_of_arrangement_description)
											);

ALTER TABLE ramsys_r1.ref_type_of_arrangement OWNER TO user_owner_r1;

ALTER TABLE ONLY ramsys_r1.ref_type_of_arrangement ADD CONSTRAINT ref_type_of_arrangement_pkey PRIMARY KEY (oid);

CREATE SEQUENCE ramsys_r1.ref_type_of_arrangement_oid_seq
AS integer
START WITH 1
INCREMENT BY 1
NO MINVALUE
NO MAXVALUE
CACHE 1;

ALTER SEQUENCE ramsys_r1.ref_type_of_arrangement_oid_seq OWNER TO user_owner_r1;
ALTER SEQUENCE ramsys_r1.ref_type_of_arrangement_oid_seq OWNED BY ramsys_r1.ref_type_of_arrangement.oid;
ALTER TABLE ONLY ramsys_r1.ref_type_of_arrangement ALTER COLUMN oid SET DEFAULT nextval('ramsys_r1.ref_type_of_arrangement_oid_seq'::regclass);

CREATE TRIGGER T1_ref_type_of_arrangement
BEFORE INSERT ON ramsys_r1.ref_type_of_arrangement
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T1_ON_INSERT();

CREATE TRIGGER T2_ref_type_of_arrangement
BEFORE UPDATE ON ramsys_r1.ref_type_of_arrangement
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T2_ON_UPDATE();

INSERT INTO ramsys_r1.ref_type_of_arrangement (TYPE_OF_ARRANGEMENT_CODE, TYPE_OF_ARRANGEMENT_DESCRIPTION, INCLUDE_PORTFOLIO, INCLUDE_TYPE_OF_CONTACT, INCLUDE_PROCESSING, INCLUDE_TYPE_OF_BUSINESS, INCLUDE_INSURED, USER_CREATED)
VALUES	('A1','Quota Share','Treaty','Prorata','Statement','I','Quota Share','admin'),
		('A2','SurPlus','Treaty','Prorata','Statement','I','SurPlus','admin'),
		('A3','FacOb','Treaty','Prorata','Statement','I','FacOb','admin'),
		('A4','Facultative','Facultative','Prorata','Installment','I','Facultative','admin'),
		('A5','Excess of Loss','Treaty','Excess','Installment','I','Excess of Loss','admin'),
		('A6','Pool Common Account XL','Treaty','Excess','Installment','I','Pool Common Account XL','admin'),
		('A7','Excess of loss Cover','OTreaty','Excess','Installment','R','Excess of loss Cover','admin'),
		('A8','Quota Share Retro','OTreaty','Prorata','Statement','R','Quota Share Retro','admin'),
		('A9','SurPlus Retro','OTreaty','Prorata','Statement','R','SurPlus Retro','admin'),
		('A10','FacOb Retro','OTreaty','Prorata','Statement','R','FacOb Retro','admin');

---------------------------------------------------------------------------------------------------------------------
	
CREATE TABLE ramsys_r1.ref_insured	(	oid 				integer 				NOT NULL,
										insured_name 		character varying(150) 	NOT NULL,
										insured_short_name 	character varying(40) 	NOT NULL,
										contact_genre 		character varying(5),
										contact_name 		character varying(40),
										insured_type 		character varying(40),
										oid_occupancy 		integer 				NOT NULL,
										oid_region 			integer 				NOT NULL,
										oid_country 		integer 				NOT NULL,
										oid_city 			integer,
										nbr_of_location 	integer,
										main_adress 		text,
										area 				character varying(40),
										road 				character varying(40),
										building 			character varying(40),
										flat 				character varying(40),
										telephone 			character varying(20),
										fax 				character varying(20),
										prefix_mail 		character varying(40),
										domaine 			character varying(40),
										GPS_CODE			character varying(12),
										comment 			text,
										oid_partner 		integer,
										version 			integer 				NOT NULL,
										date_time_created 	timestamp with time zone,
										user_created 		character varying(10),
										date_time_updated 	timestamp with time zone,
										user_updated 		character varying(10),
										CONSTRAINT FK1_REF_INSURED_UNIQUE UNIQUE (insured_name),
										CONSTRAINT FK2_REF_INSURED_UNIQUE UNIQUE (GPS_CODE)
								);

ALTER TABLE ramsys_r1.ref_insured OWNER TO user_owner_r1;
ALTER TABLE ONLY ramsys_r1.ref_insured ADD CONSTRAINT ref_insured_pkey PRIMARY KEY (oid);

CREATE SEQUENCE ramsys_r1.ref_insured_oid_seq
AS integer
START WITH 1
INCREMENT BY 1
NO MINVALUE
NO MAXVALUE
CACHE 1;

ALTER SEQUENCE ramsys_r1.ref_insured_oid_seq OWNER TO user_owner_r1;
ALTER SEQUENCE ramsys_r1.ref_insured_oid_seq OWNED BY ramsys_r1.ref_insured.oid;
ALTER TABLE ONLY ramsys_r1.ref_insured ALTER COLUMN oid SET DEFAULT nextval('ramsys_r1.ref_insured_oid_seq'::regclass);

ALTER TABLE ONLY ramsys_r1.ref_insured ADD CONSTRAINT FK3_REF_INSURED FOREIGN KEY (oid_country) REFERENCES ramsys_r1.ref_country(oid);
ALTER TABLE ONLY ramsys_r1.ref_insured ADD CONSTRAINT FK4_REF_INSURED FOREIGN KEY (oid_occupancy) REFERENCES ramsys_r1.ref_occupancy(oid);
ALTER TABLE ONLY ramsys_r1.ref_insured ADD CONSTRAINT FK5_REF_INSURED FOREIGN KEY (oid_region) REFERENCES ramsys_r1.ref_region(oid);
ALTER TABLE ONLY ramsys_r1.ref_insured ADD CONSTRAINT FK6_REF_INSURED FOREIGN KEY (oid_partner) REFERENCES ramsys_r1.ref_partner(oid);
ALTER TABLE ONLY ramsys_r1.ref_insured ADD CONSTRAINT FK7_REF_INSURED FOREIGN KEY (oid_city) REFERENCES ramsys_r1.ref_city(oid);

create index IDX1_ref_insured on ramsys_r1.ref_insured (OID_PARTNER);
create index IDX2_ref_insured on ramsys_r1.ref_insured (OID_CITY);
create index IDX3_ref_insured on ramsys_r1.ref_insured (OID_COUNTRY);
create index IDX4_ref_insured on ramsys_r1.ref_insured (OID_OCCUPANCY);
create index IDX5_ref_insured on ramsys_r1.ref_insured (OID_REGION);

CREATE TRIGGER T1_ref_insured
BEFORE INSERT ON ramsys_r1.ref_insured
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T1_ON_INSERT();

CREATE TRIGGER T2_ref_insured
BEFORE UPDATE ON ramsys_r1.ref_insured
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T2_ON_UPDATE();

---------------------------------------------------------------------------------------------------------------------
	
CREATE TABLE ramsys_r1.ref_location	(	oid 				factoring_ind			integer 				NOT NULL,
										location_code 					character varying(2) 	NOT NULL,
										oid_patner						integer,
										partner_code 					character varying(10),
										compagny_name 					character varying(40),
										compagny_short_name				character varying(10),
										oid_city 						integer,
										city_description				character varying(40),		
										oid_rep_currency				integer,
										compagny_reporting_currency 	character varying(3),
										starting_year 					integer,
										current_processing_year 		integer,
										current_processing_month 		integer,
										separator_dec 					character varying(1),
										separator_mil 					character varying(1),
										local_format 					character varying(10),
										nbr_decimal 					character varying(2) 	NOT NULL,
										prc_decimal 					character varying(2),
										settlement_gainloss_tolerance 	numeric(15,5) 			NOT NULL,
										factoring_ind 					boolean 				NOT NULL,
										financial_partner_code 			character varying(10),
										nbr_finance 					character varying(2) 	NOT NULL,
										uncovered_tolerence 			integer,
										default_bank_account 			integer					NOT NULL,
										environment_name 				character varying(40)	NOT NULL,
										date_time_created 				timestamp with time zone,
										user_created 					character varying(10),
										date_time_updated 				timestamp with time zone,
										user_updated 					character varying(10),
										CONSTRAINT FK1_REF_LOCATION_UNIQUE UNIQUE (location_code),
										CONSTRAINT FK2_REF_LOCATION_UNIQUE UNIQUE (oid_patner,partner_code),
										CONSTRAINT FK3_REF_LOCATION_UNIQUE UNIQUE (oid,location_code)
									);

ALTER TABLE ramsys_r1.ref_location OWNER TO user_owner_r1;
ALTER TABLE ramsys_r1.ref_location ALTER COLUMN factoring_ind SET DATA TYPE INTEGER USING factoring_ind::INTEGER;
ALTER TABLE ONLY ramsys_r1.ref_location ADD CONSTRAINT ref_location_pkey PRIMARY KEY (oid);

CREATE SEQUENCE ramsys_r1.ref_location_oid_seq
AS integer
START WITH 1
INCREMENT BY 1
NO MINVALUE
NO MAXVALUE
CACHE 1;

ALTER SEQUENCE ramsys_r1.ref_location_oid_seq OWNER TO user_owner_r1;
ALTER SEQUENCE ramsys_r1.ref_location_oid_seq OWNED BY ramsys_r1.ref_location.oid;
ALTER TABLE ONLY ramsys_r1.ref_location ALTER COLUMN oid SET DEFAULT nextval('ramsys_r1.ref_location_oid_seq'::regclass);

ALTER TABLE ONLY ramsys_r1.ref_location ADD CONSTRAINT FK3_REF_LOCATION FOREIGN KEY (oid_patner,compagny_name) REFERENCES ramsys_r1.ref_partner(oid,partner_name);

CREATE TRIGGER T1_ref_location
BEFORE INSERT ON ramsys_r1.ref_location
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T1_ON_INSERT();

CREATE TRIGGER T2_ref_location
BEFORE UPDATE ON ramsys_r1.ref_location
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T2_ON_UPDATE();

INSERT INTO ramsys_r1.ref_location (LOCATION_CODE,oid_patner,partner_code,compagny_name,compagny_short_name,
oid_city,city_description,oid_rep_currency,compagny_reporting_currency,
STARTING_YEAR,CURRENT_PROCESSING_YEAR,CURRENT_PROCESSING_MONTH,SEPARATOR_DEC,SEPARATOR_MIL,LOCAL_FORMAT,NBR_DECIMAL,PRC_DECIMAL,SETTLEMENT_GAINLOSS_TOLERANCE,FACTORING_IND,FINANCIAL_PARTNER_CODE,NBR_FINANCE,UNCOVERED_TOLERENCE,default_bank_account,environment_name,user_created)
VALUES	('L1',(select oid from ramsys_r1.ref_partner where partner_code ='CI0C000000'),'CI0C000000','Sunu Réassurance','Sunu Ré',
(select oid from ramsys_r1.ref_city where city_code = 'ABD'),(select city_description from ramsys_r1.ref_city where city_code = 'ABD'),
(select oid from ramsys_r1.ref_currency where currency_code = 'XOF'),'XOF',
2025,2025,1,',',' ','fr_FR','2','5',5.00000,0,'CI0C000000','5',0,1,'Test','admin');

---------------------------------------------------------------------------------------------------------------------

CREATE TABLE ramsys_r1.ref_division	(	oid 				integer 				NOT NULL,
										division_code 		character varying(3) 	NOT NULL,
										oid_location		integer,
										location_code 		character varying(2),
										division_name 		character varying(40),
										date_time_created 	timestamp with time zone,
										user_created 		character varying(10),
										date_time_updated 	timestamp with time zone,
										user_updated 		character varying(10),
										CONSTRAINT FK1_REF_DIVISION_UNIQUE UNIQUE (division_code),
										CONSTRAINT FK2_REF_DIVISION_UNIQUE UNIQUE (oid,division_code)
									);

ALTER TABLE ramsys_r1.ref_division OWNER TO user_owner_r1;
ALTER TABLE ONLY ramsys_r1.ref_division ADD CONSTRAINT ref_division_pkey PRIMARY KEY (oid);

CREATE SEQUENCE ramsys_r1.ref_division_oid_seq
AS integer
START WITH 1
INCREMENT BY 1
NO MINVALUE
NO MAXVALUE
CACHE 1;

ALTER SEQUENCE ramsys_r1.ref_division_oid_seq OWNER TO user_owner_r1;
ALTER SEQUENCE ramsys_r1.ref_division_oid_seq OWNED BY ramsys_r1.ref_division.oid;
ALTER TABLE ONLY ramsys_r1.ref_division ALTER COLUMN oid SET DEFAULT nextval('ramsys_r1.ref_division_oid_seq'::regclass);

ALTER TABLE ONLY ramsys_r1.ref_division ADD CONSTRAINT FK2_REF_DIVISION FOREIGN KEY (oid_location,location_code) REFERENCES ramsys_r1.ref_location(oid,location_code);

CREATE TRIGGER T1_ref_division
BEFORE INSERT ON ramsys_r1.ref_division
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T1_ON_INSERT();

CREATE TRIGGER T2_ref_division
BEFORE UPDATE ON ramsys_r1.ref_division
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T2_ON_UPDATE();
	
INSERT INTO ramsys_r1.ref_division (division_code,oid_location,location_code,division_name,user_created)
values 	('F01',(select oid from ramsys_r1.ref_location where location_code = 'L1'),'L1','Facultative','admin'),
		('T01',(select oid from ramsys_r1.ref_location where location_code = 'L1'),'L1','Traité','admin');

---------------------------------------------------------------------------------------------------------------------

CREATE TABLE ramsys_r1.ref_user_detail	(	oid 						integer 				NOT NULL,
											username 					character varying(40)	NOT NULL,
											oid_location 				integer,
											oid_division 				integer,
											oid_profit_center 			integer,
											acces_level 				integer,
											office_location 			character varying(40),
											telephone_extension 		character varying(5),
											password 					character varying(100),
											user_title 					character varying(40),
											approval_authority_level	integer,
											user_class 					integer,
											oid_role 					integer,
											email_adress 				character varying(100),
											telephone_no 				character varying(40),
											fax_no 						character varying(100),
											compagny_department 		character varying(100),
											manager_id 					character varying(3),
											division_code 				character varying(3),
											location_code 				character varying(2),
											profit_centre_code 			character varying(2),
											role_code 					character varying(8),
											date_time_created 			timestamp with time zone,
											user_created 				character varying(10),
											date_time_updated 			timestamp with time zone,
											user_updated 				character varying(10),
											CONSTRAINT FK1_REF_USER_DETAIL_UNIQUE UNIQUE (username),
											CONSTRAINT FK2_REF_USER_DETAIL_UNIQUE UNIQUE (oid,username),
											CONSTRAINT FK3_REF_USER_DETAIL_UNIQUE UNIQUE (oid_location,location_code),
											CONSTRAINT FK4_REF_USER_DETAIL_UNIQUE UNIQUE (oid_division,division_code),
											CONSTRAINT FK5_REF_USER_DETAIL_UNIQUE UNIQUE (oid_profit_center,profit_centre_code)
										);

ALTER TABLE ramsys_r1.ref_user_detail OWNER TO user_owner_r1;
ALTER TABLE ONLY ramsys_r1.ref_user_detail ADD CONSTRAINT ref_user_detail_pkey PRIMARY KEY (oid);

CREATE SEQUENCE ramsys_r1.ref_user_detail_oid_seq
AS integer
START WITH 1
INCREMENT BY 1
NO MINVALUE
NO MAXVALUE
CACHE 1;

ALTER SEQUENCE ramsys_r1.ref_user_detail_oid_seq OWNER TO user_owner_r1;
ALTER SEQUENCE ramsys_r1.ref_user_detail_oid_seq OWNED BY ramsys_r1.ref_user_detail.oid;
ALTER TABLE ONLY ramsys_r1.ref_user_detail ALTER COLUMN oid SET DEFAULT nextval('ramsys_r1.ref_user_detail_oid_seq'::regclass);

ALTER TABLE ONLY ramsys_r1.ref_user_detail ADD CONSTRAINT FK6_REF_USER_DETAIL FOREIGN KEY (oid_role,role_code) REFERENCES ramsys_r1.ref_role(oid,role_code);
ALTER TABLE ONLY ramsys_r1.ref_user_detail ADD CONSTRAINT FK7_REF_USER_DETAIL FOREIGN KEY (oid_division,division_code) REFERENCES ramsys_r1.ref_division(oid,division_code);
ALTER TABLE ONLY ramsys_r1.ref_user_detail ADD CONSTRAINT FK8_REF_USER_DETAIL FOREIGN KEY (oid_location,location_code) REFERENCES ramsys_r1.ref_location(oid,location_code);


create index IDX1_REF_USER_DETAIL on ramsys_r1.ref_user_detail (OID_DIVISION);
create index IDX2_REF_USER_DETAIL on ramsys_r1.ref_user_detail (OID_LOCATION);
create index IDX3_REF_USER_DETAIL on ramsys_r1.ref_user_detail (OID_ROLE);

CREATE TRIGGER T1_ref_user_detail
BEFORE INSERT ON ramsys_r1.ref_user_detail
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T1_ON_INSERT();

CREATE TRIGGER T2_ref_user_detail
BEFORE UPDATE ON ramsys_r1.ref_user_detail
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T2_ON_UPDATE();	

INSERT INTO ramsys_r1.ref_user_detail (OID_LOCATION,OFFICE_LOCATION,USERNAME,PASSWORD,USER_TITLE,APPROVAL_AUTHORITY_LEVEL,role_code,OID_ROLE,EMAIL_ADRESS,TELEPHONE_NO,COMPAGNY_DEPARTMENT,USER_CREATED)
VALUES	((select oid from ramsys_r1.ref_location where location_code = 'L1'),'Abidjan', 'admin', 'YZiRBJdGkAA=','Administrator', '1',(select role_code from ramsys_r1.ref_role where oid = 1), 1, 'felix.adou@sunu-group.com',NULL,'Direction IT', 'admin'),
		((select oid from ramsys_r1.ref_location where location_code = 'L1'),'Abidjan', 'demo', 'YZiRBJdGkAA=','Compte Demo', '1',(select role_code from ramsys_r1.ref_role where oid = 1), 1, 'felix.adou@sunu-group.com','PSSWD = 123456','Direction IT', 'admin'),
		((select oid from ramsys_r1.ref_location where location_code = 'L1'),'Abidjan', 'ROL', 'YZiRBJdGkAA=','Roland OUEDRAOGO', '1',(select role_code from ramsys_r1.ref_role where oid = 1), 1, 'roland.ouedraogo@sunu-group.com',NULL,'Directeur General', 'admin'),
		((select oid from ramsys_r1.ref_location where location_code = 'L1'),'Abidjan', 'YDW', 'YZiRBJdGkAA=','Yao Dodji WUSINU', '1',(select role_code from ramsys_r1.ref_role where oid = 1), 1, 'yao.wusinu@sunu-group.com',null,'Comptabilité Générale et Technique', 'admin'),
		((select oid from ramsys_r1.ref_location where location_code = 'L1'),'Abidjan', 'MAY', 'YZiRBJdGkAA=','Papa Mass YADD', '1',(select role_code from ramsys_r1.ref_role where oid = 1), 1, 'mass.yadd@sunu-group.com',null,'Souscription  Prestations', 'admin'),
		((select oid from ramsys_r1.ref_location where location_code = 'L1'),'Abidjan', 'KSN', 'YZiRBJdGkAA=','Kouakou Serge N''GUESSAN', '1',(select role_code from ramsys_r1.ref_role where oid = 1), 1, 'serge.kouakou@sunu-group.com',null,'Souscription  Prestations', 'admin'),
		((select oid from ramsys_r1.ref_location where location_code = 'L1'),'Abidjan', 'KDL', 'YZiRBJdGkAA=','Kodjinan Désiré Leon DIEMELEHOU', '1',(select role_code from ramsys_r1.ref_role where oid = 1), 1, 'leon.diemelehou@sunu-group.com',null,'Souscription  Prestations', 'admin'),
		((select oid from ramsys_r1.ref_location where location_code = 'L1'),'Abidjan', 'MPY', 'YZiRBJdGkAA=','Marie Paule YAO', '1',(select role_code from ramsys_r1.ref_role where oid = 1), 1, 'mariepaule.yao@sunu-group.com',null,'Comptabilité Générale et Technique', 'admin'),
		((select oid from ramsys_r1.ref_location where location_code = 'L1'),'Abidjan', 'YER', 'YZiRBJdGkAA=','Yero DIALLO', '1',(select role_code from ramsys_r1.ref_role where oid = 1), 1, 'yero.diallo@sunu-group.com',null,'Comptabilité Générale et Technique', 'admin'),
		((select oid from ramsys_r1.ref_location where location_code = 'L1'),'Abidjan', 'PHT', 'YZiRBJdGkAA=','Paul-Henri TUHO', '1',(select role_code from ramsys_r1.ref_role where oid = 1), 1, 'paulhenri.tuho@sunu-group.com',null,'Direction IT', 'admin'),
		((select oid from ramsys_r1.ref_location where location_code = 'L1'),'Abidjan', 'EAT', 'YZiRBJdGkAA=','Elhadji Abdou Aziz THIONGANE', '1',(select role_code from ramsys_r1.ref_role where oid = 1), 1, 'elhadjiabdouaziz.thiongane@sunu-group.com',null,'Direction IT', 'admin'),
		((select oid from ramsys_r1.ref_location where location_code = 'L1'),'Abidjan', 'NKN', 'YZiRBJdGkAA=','Noelly KONE', '1',(select role_code from ramsys_r1.ref_role where oid = 1), 1, 'noelly.kone@sunu-group.com',null,'Direction IT', 'admin'),
		((select oid from ramsys_r1.ref_location where location_code = 'L1'),'Abidjan', 'FAD', 'YZiRBJdGkAA=','Felix ADOU', '1',(select role_code from ramsys_r1.ref_role where oid = 1), 1, 'felix.adou@sunu-group.com',null,'Direction IT', 'admin'),
		((select oid from ramsys_r1.ref_location where location_code = 'L1'),'Abidjan', 'JGK', 'YZiRBJdGkAA=','Joseph Gbako', '1',(select role_code from ramsys_r1.ref_role where oid = 1), 1, 'joseph.gbako@sunu-group.com',null,'Direction IT', 'admin');

---------------------------------------------------------------------------------------------------------------------

CREATE TABLE ramsys_r1.ref_profit_centre	(	oid 				integer 				NOT NULL,
												oid_location 		integer 				NOT NULL,
												oid_division		integer					NOT NULL,
												oid_user 			integer 				NOT NULL,
												profit_centre_code 	character varying(2) 	NOT NULL,
												profit_centre_name 	character varying(40),
												location_code 		character varying(2),
												division_code 		character varying(3),
												username 			character varying(40),
												pc_manager_id 		character varying(3),
												date_time_created 	timestamp with time zone,
												user_created 		character varying(10),
												date_time_updated 	timestamp with time zone,
												user_updated 		character varying(10),
												CONSTRAINT FK1_REF_PROFIT_CENTRE_UNIQUE UNIQUE (profit_centre_code),
												CONSTRAINT FK2_REF_PROFIT_CENTRE_UNIQUE UNIQUE (oid,profit_centre_code)
											);

ALTER TABLE ramsys_r1.ref_profit_centre OWNER TO user_owner_r1;
ALTER TABLE ONLY ramsys_r1.ref_profit_centre ADD CONSTRAINT ref_profit_centre_pkey PRIMARY KEY (oid);

CREATE SEQUENCE ramsys_r1.ref_profit_centre_oid_seq
AS integer
START WITH 1
INCREMENT BY 1
NO MINVALUE
NO MAXVALUE
CACHE 1;

ALTER SEQUENCE ramsys_r1.ref_profit_centre_oid_seq OWNER TO user_owner_r1;

ALTER SEQUENCE ramsys_r1.ref_profit_centre_oid_seq OWNED BY ramsys_r1.ref_profit_centre.oid;
ALTER TABLE ONLY ramsys_r1.ref_profit_centre ALTER COLUMN oid SET DEFAULT nextval('ramsys_r1.ref_profit_centre_oid_seq'::regclass);

ALTER TABLE ONLY ramsys_r1.ref_profit_centre ADD CONSTRAINT FK3_REF_PROFIT_CENTRE FOREIGN KEY (oid_location,location_code) REFERENCES ramsys_r1.ref_location(oid,location_code);
ALTER TABLE ONLY ramsys_r1.ref_profit_centre ADD CONSTRAINT FK4_REF_PROFIT_CENTRE FOREIGN KEY (oid_division,division_code) REFERENCES ramsys_r1.ref_division(oid,division_code);



create index IDX1_REF_PROFIT_CENTRE on ramsys_r1.ref_profit_centre (OID_LOCATION);
create index IDX2_REF_PROFIT_CENTRE on ramsys_r1.ref_profit_centre (OID_USER);

CREATE TRIGGER T1_ref_profit_centre
BEFORE INSERT ON ramsys_r1.ref_profit_centre
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T1_ON_INSERT();

CREATE TRIGGER T2_ref_profit_centre
BEFORE UPDATE ON ramsys_r1.ref_profit_centre
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T2_ON_UPDATE();

INSERT INTO ramsys_r1.ref_profit_centre (OID_LOCATION,oid_division,OID_USER,location_code,division_code,username,PROFIT_CENTRE_CODE,PROFIT_CENTRE_NAME,USER_CREATED)
VALUES	((select oid from ramsys_r1.ref_location where location_code = 'L1'),(select oid from ramsys_r1.ref_division where division_code = 'F01'),(select oid from ramsys_r1.ref_user_detail where username  = 'admin'),'L1','F01','admin','F1','Département Facultative','admin'),
		((select oid from ramsys_r1.ref_location where location_code = 'L1'),(select oid from ramsys_r1.ref_division where division_code = 'T01'),(select oid from ramsys_r1.ref_user_detail where username  = 'admin'),'L1','T01','admin','T1','Département Traité','admin');

---------------------------------------------------------------------------------------------------------------------

CREATE TABLE ramsys_r1.ref_user_profit_centre	(	oid 				integer 				NOT NULL,
													oid_user 			integer 				NOT NULL,
													oid_profit_centre 	integer 				NOT NULL,
													location_code 		character varying(2),
													username 			character varying(40)	NOT NULL,
													profit_centre_code 	character varying(2) 	NOT NULL,
													date_time_created 	timestamp with time zone,
													user_created 		character varying(10),
													date_time_updated 	timestamp with time zone,
													user_updated 		character varying(10),
													CONSTRAINT FK1_REF_USER_PROFIT_CENTRE_UNIQUE UNIQUE (username ,profit_centre_code),
													CONSTRAINT FK2_REF_USER_PROFIT_CENTRE_UNIQUE UNIQUE (oid_user,oid_profit_centre)
												);

ALTER TABLE ramsys_r1.ref_user_profit_centre OWNER TO user_owner_r1;
ALTER TABLE ONLY ramsys_r1.ref_user_profit_centre ADD CONSTRAINT ref_user_profit_centre_pkey PRIMARY KEY (oid);

CREATE SEQUENCE ramsys_r1.ref_user_profit_centre_oid_seq
AS integer
START WITH 1
INCREMENT BY 1
NO MINVALUE
NO MAXVALUE
CACHE 1;

ALTER SEQUENCE ramsys_r1.ref_user_profit_centre_oid_seq OWNER TO user_owner_r1;
ALTER SEQUENCE ramsys_r1.ref_user_profit_centre_oid_seq OWNED BY ramsys_r1.ref_user_profit_centre.oid;
ALTER TABLE ONLY ramsys_r1.ref_user_profit_centre ALTER COLUMN oid SET DEFAULT nextval('ramsys_r1.ref_user_profit_centre_oid_seq'::regclass);

ALTER TABLE ONLY ramsys_r1.ref_user_profit_centre ADD CONSTRAINT FK3_REF_USER_PROFIT_CENTRE FOREIGN KEY (oid_user,username) REFERENCES ramsys_r1.ref_user_detail(oid,username);

CREATE TRIGGER T1_ref_user_profit_centre
BEFORE INSERT ON ramsys_r1.ref_user_profit_centre
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T1_ON_INSERT();

CREATE TRIGGER T2_ref_user_profit_centre
BEFORE UPDATE ON ramsys_r1.ref_user_profit_centre
FOR EACH ROW
EXECUTE FUNCTION ramsys_r1.T2_ON_UPDATE();

INSERT INTO ramsys_r1.ref_user_profit_centre (oid_user,oid_profit_centre,location_code,username,profit_centre_code,user_created)
VALUES	((select oid from ramsys_r1.ref_user_detail where username = 'admin'),(select oid from ramsys_r1.ref_profit_centre where profit_centre_code = 'F1'),'L1','admin','F1','admin'),
		((select oid from ramsys_r1.ref_user_detail where username = 'admin'),(select oid from ramsys_r1.ref_profit_centre where profit_centre_code = 'T1'),'L1','admin','T1','admin');
		

--création des contraintes différées---------------------------------------------------------------------------------

ALTER TABLE ONLY ramsys_r1.ref_profit_centre ADD CONSTRAINT FK5_REF_PROFIT_CENTRE FOREIGN KEY (oid_user) REFERENCES ramsys_r1.ref_user_detail(oid);
ALTER TABLE ONLY ramsys_r1.ref_user_detail ADD CONSTRAINT FK9_REF_USER_DETAIL FOREIGN KEY (oid_profit_center,profit_centre_code) REFERENCES ramsys_r1.ref_profit_centre(oid,profit_centre_code);