/*######## SEO管理 ########*/
ALTER TABLE dtb_pagelayout ADD COLUMN title text;
ALTER TABLE dtb_pagelayout ADD COLUMN h1 text;

ALTER TABLE dtb_products ADD COLUMN title text;
ALTER TABLE dtb_products ADD COLUMN h1 text;
ALTER TABLE dtb_products ADD COLUMN keyword text;
ALTER TABLE dtb_products ADD COLUMN description text;

ALTER TABLE dtb_category ADD COLUMN title text;
ALTER TABLE dtb_category ADD COLUMN h1 text;
ALTER TABLE dtb_category ADD COLUMN keyword text;
ALTER TABLE dtb_category ADD COLUMN description text;

INSERT INTO  mtb_constants (id ,name ,rank ,remarks) VALUES ('USE_SEO',  'true',  (SELECT MAX(rank)+1 FROM mtb_constants),  'SEO管理使用フラグ|true:使用');

/*######################■ダウンロード商品使用フラグ追加■######################*/
INSERT INTO mtb_constants(id, name, rank, remarks) VALUES('USE_DOWNLOAD_PRODUCT', 'false', (SELECT MAX(rank)+1 FROM mtb_constants), 'ダウンロード商品使用フラグ|true:使用する');

/*######## 支払方法管理 ########*/
INSERT INTO  mtb_constants (id ,name ,rank ,remarks) VALUES ('USE_PAYMENT_NOTE',  'true',  (SELECT MAX(rank)+1 FROM mtb_constants),  '支払方法説明使用フラグ|true:使用');


/*######## 追加規格 ########*/
INSERT INTO mtb_constants(id, name, rank, remarks) VALUES('USE_EXTRA_CLASS', 'true', (SELECT MAX(rank)+1 FROM mtb_constants), '追加規格使用フラグ|true:使用する');
INSERT INTO mtb_constants(id, name, rank, remarks) VALUES('MAX_EXTRA_CLASS', '5', (SELECT MAX(rank)+1 FROM mtb_constants), '追加規格登録最大数');
CREATE TABLE dtb_extra_class(
  extra_class_id serial,
  "name" text,
  url text,
  rank integer,
  creator_id integer NOT NULL,
  create_date timestamp without time zone NOT NULL DEFAULT now(),
  update_date timestamp without time zone NOT NULL,
  del_flg smallint NOT NULL DEFAULT 0,
  CONSTRAINT dtb_extra_class_pkey PRIMARY KEY (extra_class_id)
);

CREATE TABLE dtb_extra_classcategory(
  extra_classcategory_id serial,
  "name" text,
  extra_class_id integer NOT NULL,
  rank integer,
  creator_id integer NOT NULL,
  create_date timestamp without time zone NOT NULL DEFAULT now(),
  update_date timestamp without time zone NOT NULL,
  del_flg smallint NOT NULL DEFAULT 0,
  CONSTRAINT dtb_extra_classcategory_pkey PRIMARY KEY (extra_classcategory_id)
);

CREATE TABLE dtb_products_extra_class(
  product_extra_class_id serial,
  product_id integer NOT NULL,
  extra_class_id integer NOT NULL,
  creator_id integer NOT NULL,
  create_date timestamp without time zone NOT NULL DEFAULT now(),
  update_date timestamp without time zone NOT NULL,
  CONSTRAINT dtb_products_extra_class_pkey PRIMARY KEY (product_extra_class_id)
);

INSERT INTO mtb_constants(id, name, rank, remarks) VALUES('USE_MULTIPLE_DELIV', 'false', (SELECT MAX(rank)+1 FROM mtb_constants), '複数配送使用フラグ|true:使用する');
ALTER TABLE dtb_order_detail ADD COLUMN extra_info text;

/*######## 顧客法人管理 ########*/
INSERT INTO  mtb_constants (id ,name ,rank ,remarks) VALUES ('USE_CUSTOMER_COMPANY',  'true',  (SELECT MAX(rank)+1 FROM mtb_constants),  '顧客法人使用フラグ|true:使用');
ALTER TABLE dtb_customer ADD COLUMN company text;
ALTER TABLE dtb_customer ADD COLUMN company_kana text;
ALTER TABLE dtb_customer ADD COLUMN company_department text;

ALTER TABLE dtb_other_deliv ADD COLUMN company text;
ALTER TABLE dtb_other_deliv ADD COLUMN company_kana text;
ALTER TABLE dtb_other_deliv ADD COLUMN company_department text;

ALTER TABLE dtb_order ADD COLUMN order_company text;
ALTER TABLE dtb_order ADD COLUMN order_company_kana text;
ALTER TABLE dtb_order ADD COLUMN order_company_department text;

ALTER TABLE dtb_shipping ADD COLUMN shipping_company text;
ALTER TABLE dtb_shipping ADD COLUMN shipping_company_kana text;
ALTER TABLE dtb_shipping ADD COLUMN shipping_company_department text;

ALTER TABLE dtb_order_temp ADD COLUMN order_company text;
ALTER TABLE dtb_order_temp ADD COLUMN order_company_kana text;
ALTER TABLE dtb_order_temp ADD COLUMN order_company_department text;

/*######## 顧客管理画面にお届け先一覧表示 ########*/
INSERT INTO  mtb_constants (id ,name ,rank ,remarks) VALUES ('USE_ADMIN_CUSTOMER_DELIV_LIST',  'true',  (SELECT MAX(rank)+1 FROM mtb_constants),  '顧客管理画面にお届け先一覧を表示するフラグ|true:表示');

/*######################■配送ランク■######################*/
INSERT INTO mtb_constants(id, name, rank, remarks) VALUES('USE_DELIV_RANK', 'true', (SELECT MAX(rank)+1 FROM mtb_constants), '配送ランクを使用するフラグ|false:使用しない');
CREATE TABLE mtb_deliv_rank (
  id serial,
  "name" text,
  rank smallint NOT NULL DEFAULT 0,
  CONSTRAINT mtb_deliv_rank_pkey PRIMARY KEY (id)
);
INSERT INTO mtb_deliv_rank(name, rank) VALUES('配送ランクA', 0);
INSERT INTO mtb_deliv_rank(name, rank) VALUES('配送ランクB', 1);
INSERT INTO mtb_deliv_rank(name, rank) VALUES('配送ランクC', 1);
INSERT INTO mtb_deliv_rank(name, rank) VALUES('配送ランクD', 1);
INSERT INTO mtb_deliv_rank(name, rank) VALUES('配送ランクE', 1);

ALTER TABLE dtb_delivfee ADD COLUMN deliv_rank integer DEFAULT 1;
ALTER TABLE dtb_delivfee DROP CONSTRAINT dtb_delivfee_pkey;
ALTER TABLE dtb_delivfee ADD CONSTRAINT dtb_delivfee_pkey PRIMARY KEY (deliv_id,fee_id,deliv_rank);

ALTER TABLE dtb_products ADD COLUMN deliv_rank integer DEFAULT 1;
