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

/*######################■商品問い合わせ■######################*/
INSERT INTO mtb_constants(id, name, rank, remarks) VALUES('USE_PRODUCT_CONTACT', 'true', (SELECT MAX(rank)+1 FROM mtb_constants), '商品問い合わせ使用フラグ');
/*######################■事例問い合わせ■######################*/
INSERT INTO mtb_constants(id, name, rank, remarks) VALUES('USE_JIREI_CONTACT', 'false', (SELECT MAX(rank)+1 FROM mtb_constants), '事例問い合わせ使用フラグ');

/*######## カテゴリお勧め商品 ########*/
CREATE TABLE dtb_category_recommend (
  category_recommend_id serial,
  category_id INT NOT NULL,
  product_id INT NOT NULL,
  rank INT NOT NULL,
  PRIMARY KEY (category_recommend_id)
);
ALTER TABLE dtb_category_recommend ADD COLUMN comment text;
INSERT INTO mtb_constants(id, name, rank, remarks) VALUES('CATEGORY_RECOMMEND_PRODUCT_MAX', '1', (SELECT MAX(rank)+1 FROM mtb_constants), 'カテゴリおすすめ商品最大登録数|数値:最大登録数|false:使用しない');

/*######## カテゴリ追加情報 ########*/
INSERT INTO mtb_constants(id, name, rank, remarks) VALUES('USE_CATEGORY_INFO', 'true', (SELECT MAX(rank)+1 FROM mtb_constants), 'カテゴリ追加情報使用フラグ|true:使用する');
INSERT INTO mtb_constants(id, name, rank, remarks) VALUES('CAT_MAINIMAGE_WIDTH', '600', (SELECT MAX(rank)+1 FROM mtb_constants), 'カテゴリ画像幅');
INSERT INTO mtb_constants(id, name, rank, remarks) VALUES('CAT_MAINIMAGE_HEIGHT', '600', (SELECT MAX(rank)+1 FROM mtb_constants), 'カテゴリ画像縦');
INSERT INTO mtb_constants(id, name, rank, remarks) VALUES('PRODUCT_LIST_MAX', '4', (SELECT MAX(rank)+1 FROM mtb_constants), '商品一覧最大表示数');

ALTER TABLE dtb_category ADD COLUMN category_info text;
ALTER TABLE dtb_category ADD COLUMN category_main_image_alt text;
ALTER TABLE dtb_category ADD COLUMN category_main_image text;

/*######################■商品支払方法指定■######################*/
INSERT INTO mtb_constants(id, name, rank, remarks) VALUES('USE_PRODUCT_PAYMENT', 'false', (SELECT MAX(rank)+1 FROM mtb_constants), '商品の支払方法指定を使用するフラグ|false:使用しない');
CREATE TABLE dtb_product_payment
(
  product_id integer NOT NULL,
  payment_id integer NOT NULL,
  CONSTRAINT dtb_product_payment_pkey PRIMARY KEY (product_id, payment_id)
);

/*######################■商品配送方法指定■######################*/
INSERT INTO mtb_constants(id, name, rank, remarks) VALUES('USE_PRODUCT_DELIV', 'true', (SELECT MAX(rank)+1 FROM mtb_constants), '商品の配送方法指定を使用するフラグ|false:使用しない');
CREATE TABLE dtb_product_deliv
(
  product_id integer NOT NULL,
  deliv_id integer NOT NULL,
  CONSTRAINT dtb_product_deliv_pkey PRIMARY KEY (product_id, deliv_id)
);

/*######################■商品一括並び替え■######################*/
INSERT INTO mtb_constants(id, name, rank, remarks) VALUES('USE_PRODUCT_BULK_RANK', 'true', (SELECT MAX(rank)+1 FROM mtb_constants), '商品一括並び替えを使用するフラグ|false:使用しない');

/*######################■商品並び替えで表示件数指定■######################*/
INSERT INTO mtb_constants(id, name, rank, remarks) VALUES('USE_PRODUCT_RANK_PMAX', 'true', (SELECT MAX(rank)+1 FROM mtb_constants), '商品並び替えで表示件数指定を使用するフラグ|false:使用しない');

/*######################■顧客お届け先FAX■######################*/
INSERT INTO  mtb_constants (id ,name ,rank ,remarks) VALUES ('USE_OTHER_DELIV_FAX',  'true',  (SELECT MAX(rank)+1 FROM mtb_constants),  '顧客お届け先FAX使用フラグ|true:使用');

/*######################■商品マスタ一覧で公開状態変更■######################*/
INSERT INTO  mtb_constants (id ,name ,rank ,remarks) VALUES ('USE_PRODUCT_MASTER_DISP_EDIT',  'true',  (SELECT MAX(rank)+1 FROM mtb_constants),  '商品マスタ一覧で公開状態変更機能を使用するフラグ|true:使用');

/*######################■商品マスタ一覧で規格表示■######################*/
INSERT INTO  mtb_constants (id ,name ,rank ,remarks) VALUES ('USE_PRODUCT_MASTER_SHOW_CLASS',  'true',  (SELECT MAX(rank)+1 FROM mtb_constants),  '商品マスタ一覧で規格表示機能を使用するフラグ|true:使用');

/*######################■商品マスタ一覧で在庫変更■######################*/
INSERT INTO  mtb_constants (id ,name ,rank ,remarks) VALUES ('USE_PRODUCT_MASTER_STOCK_EDIT',  'true',  (SELECT MAX(rank)+1 FROM mtb_constants),  '商品マスタ一覧で在庫変更機能を使用するフラグ|true:使用');

/*######## サイトHTML化 ########*/
INSERT INTO mtb_constants (id ,name ,rank ,remarks) VALUES ('P_LIST_URLPATH',  'ROOT_URLPATH."products/list.php?category_id=%p"',  (SELECT MAX(rank)+1 FROM mtb_constants),  '商品一覧HTML出力');
UPDATE mtb_constants SET name='ROOT_URLPATH. "products/detail.php?product_id=%p"' WHERE id='P_DETAIL_URLPATH';

/*######################■商品非課税指定■######################*/
ALTER TABLE dtb_products ADD COLUMN taxfree integer DEFAULT 0;
ALTER TABLE dtb_order_detail ADD COLUMN taxfree integer DEFAULT 0;
INSERT INTO  mtb_constants (id ,name ,rank ,remarks) VALUES ('USE_TAXFREE_PRODUCT',  'true',  (SELECT MAX(rank)+1 FROM mtb_constants),  '商品非課税機能を使用するフラグ|true:使用');

/*######################■記念日登録■######################*/
CREATE TABLE dtb_anniversary (
    anniversary_id serial,
    customer_id integer NOT NULL,
    dt_month integer NOT NULL,
    dt_day integer NOT NULL,
    name text NOT NULL,
    event_id  integer,
    memo text,
    del_flg integer DEFAULT 0,
    rank integer NOT NULL,
    create_date timestamp without time zone NOT NULL DEFAULT now(),
    update_date timestamp without time zone NOT NULL,
    CONSTRAINT dtb_anniversary_pkey PRIMARY KEY (anniversary_id)
);

CREATE TABLE mtb_anniversary_event (
  id smallint NOT NULL,
  "name" text,
  rank smallint NOT NULL DEFAULT 0,
  CONSTRAINT mtb_anniversary_event_pkey PRIMARY KEY (id)
);

INSERT INTO mtb_anniversary_event (id, name, rank) VALUES (1, '誕生日', 0);
INSERT INTO mtb_anniversary_event (id, name, rank) VALUES (2, '結婚記念日', 1);
INSERT INTO mtb_anniversary_event (id, name, rank) VALUES (3, 'その他', 2);

INSERT INTO dtb_pagelayout VALUES (10, (SELECT MAX(page_id)+1 FROM dtb_pagelayout WHERE device_type_id=10), 'MYページ/記念日登録', 'mypage/anniversary.php', 'mypage/anniversary', 1, 1, 2, NULL, NULL, NULL, NULL, 'now()', 'now()', NULL, NULL);

INSERT INTO mtb_mail_template VALUES ((SELECT MAX(id)+1 FROM mtb_mail_template), '記念日お知らせメール', (SELECT MAX(rank)+1 FROM mtb_mail_template));
INSERT INTO mtb_mail_tpl_path VALUES ((SELECT id FROM mtb_mail_template WHERE name='記念日お知らせメール'), 'mail_templates/anni_reminder_mail.tpl', (SELECT MAX(rank)+1 FROM mtb_mail_tpl_path));


INSERT INTO mtb_constants (id ,name ,rank ,remarks) VALUES ('USE_ANNIVERSARY',  'true',  (SELECT MAX(rank)+1 FROM mtb_constants),  '記念日登録使用フラグ|true:使用');
INSERT INTO mtb_constants (id, name, rank, remarks) VALUES ('ANNIVERSARY_MAX', '20', (SELECT MAX(rank)+1 FROM mtb_constants), '記念日登録最大数');
INSERT INTO mtb_constants (id ,name ,rank ,remarks) VALUES ('ANNI_REMINDER_MAIL_TPL', (SELECT id FROM mtb_mail_template WHERE name='記念日お知らせメール'), (SELECT MAX(rank)+1 FROM mtb_constants), '記念日リマインダメールテンプレートID|falseに設定した場合はリマインダ機能を無効にする');
INSERT INTO mtb_constants (id ,name ,rank ,remarks) VALUES ('ANNI_REMINDER_DAY_BEFORE', '10', (SELECT MAX(rank)+1 FROM mtb_constants), '記念日リマインダの通知日(記念日の何日前)');

/*######################■問い合わせ履歴管理■######################*/
INSERT INTO mtb_constants (id ,name ,rank ,remarks) VALUES ('USE_CONTACT_HISTORY',  'true',  (SELECT MAX(rank)+1 FROM mtb_constants),  '問い合わせ履歴管理使用フラグ|true:使用');

CREATE TABLE dtb_contact_history(
    contact_id serial,
    contact_type integer DEFAULT 1,
    status integer DEFAULT 1,
    customer_id integer,
    sender_email text,
    subject text,
    body text,
    attachment text,
    del_flg integer DEFAULT 0,
    create_date timestamp without time zone NOT NULL DEFAULT now(),
    update_date timestamp without time zone NOT NULL,
    CONSTRAINT dtb_contact_history_pkey PRIMARY KEY (contact_id)
);


CREATE TABLE mtb_contact_type (
  id smallint NOT NULL,
  "name" text,
  rank smallint NOT NULL DEFAULT 0,
  CONSTRAINT mtb_contact_type_pkey PRIMARY KEY (id)
);

INSERT INTO mtb_contact_type (id, name, rank) VALUES (1, '問い合わせ', 0);
INSERT INTO mtb_contact_type (id, name, rank) VALUES (2, '修理', 1);


CREATE TABLE mtb_contact_status (
  id smallint NOT NULL,
  "name" text,
  rank smallint NOT NULL DEFAULT 0,
  CONSTRAINT mtb_contact_status_pkey PRIMARY KEY (id)
);

INSERT INTO mtb_contact_status (id, name, rank) VALUES (1, '新規受付', 0);
INSERT INTO mtb_contact_status (id, name, rank) VALUES (2, '処理中', 1);
INSERT INTO mtb_contact_status (id, name, rank) VALUES (3, '対応済み', 2);

CREATE TABLE mtb_contact_status_color (
  id smallint NOT NULL,
  "name" text,
  rank smallint NOT NULL DEFAULT 0,
  CONSTRAINT mtb_contact_status_color_pkey PRIMARY KEY (id)
);

INSERT INTO mtb_contact_status_color (id, name, rank) VALUES (1, '#FFFFFF', 0);
INSERT INTO mtb_contact_status_color (id, name, rank) VALUES (2, '#BFDFFF', 1);
INSERT INTO mtb_contact_status_color (id, name, rank) VALUES (3, '#C9C9C9', 2);

/*######################■事例集■######################*/
INSERT INTO mtb_constants (id ,name ,rank ,remarks) VALUES ('USE_JIREI',  'true',  (SELECT MAX(rank)+1 FROM mtb_constants),  '事例集使用フラグ|true:使用');
INSERT INTO mtb_constants (id ,name ,rank ,remarks) VALUES ('JIREI_IMAGE_WIDTH',  '500',  (SELECT MAX(rank)+1 FROM mtb_constants),  '事例画像幅');
INSERT INTO mtb_constants (id ,name ,rank ,remarks) VALUES ('JIREI_IMAGE_HEIGHT',  '500',  (SELECT MAX(rank)+1 FROM mtb_constants),  '事例画像縦');
INSERT INTO mtb_constants(id, name, rank, remarks) VALUES('JIREI_LIST_MAX', '6', (SELECT MAX(rank)+1 FROM mtb_constants), '事例一覧最大表示数');

DROP TABLE IF EXISTS dtb_portfolio;
CREATE TABLE dtb_portfolio (
    portfolio_id serial NOT NULL,
    portfolio_name text,
    rank INT,
    creator_id INT NOT NULL,
    create_date timestamp without time zone NOT NULL DEFAULT now(),
    update_date timestamp without time zone NOT NULL DEFAULT now(),
    del_flg smallint DEFAULT 0 NOT NULL,
    portfolio_main_image text,
    portfolio_info text,
    portfolio_category_id INT,
    title text,
    description text,
    keyword text,
    h1 text,
    CONSTRAINT dtb_portfolio_pkey PRIMARY KEY (portfolio_id)
);

DROP TABLE IF EXISTS dtb_portfolio_category;
CREATE TABLE dtb_portfolio_category (
    portfolio_category_id serial NOT NULL,
    portfolio_category_name text,
    rank INT,
    creator_id INT NOT NULL,
    create_date timestamp without time zone NOT NULL DEFAULT now(),
    update_date timestamp without time zone NOT NULL DEFAULT now(),
    del_flg smallint DEFAULT 0 NOT NULL,
    portfolio_category_main_image text,
    portfolio_category_info text,
    portfolio_category_info2 text,
    title text,
    description text,
    keyword text,
    h1 text,
    CONSTRAINT dtb_portfolio_category_pkey PRIMARY KEY (portfolio_category_id)
);

/*######################■商品マスタ一覧で発送日目安管理■######################*/
INSERT INTO mtb_constants (id ,name ,rank ,remarks) VALUES ('USE_PRODUCT_MASTER_EDIT_DELIV_DATE',  'true',  (SELECT MAX(rank)+1 FROM mtb_constants),  '商品マスタ一覧で発送日目安管理フラグ|true:使用');

/*######################■商品規格単位で発送日目安管理■######################*/
INSERT INTO mtb_constants (id ,name ,rank ,remarks) VALUES ('USE_DELIV_DATE_PER_PRODUCT_CLASS',  'true',  (SELECT MAX(rank)+1 FROM mtb_constants),  '商品規格単位で発送日目安管理フラグ|true:使用');
ALTER TABLE dtb_products_class ADD COLUMN deliv_date_id integer;

UPDATE dtb_products SET deliv_date_id=null;
ALTER TABLE dtb_products DROP COLUMN deliv_date_id;

/*######################■商品カスタマイズ■######################*/
ALTER TABLE dtb_products_class ADD COLUMN custom_made smallint NOT NULL DEFAULT 0;
ALTER TABLE dtb_products ADD COLUMN size text;
ALTER TABLE dtb_products ADD COLUMN weight text;
ALTER TABLE dtb_products ADD COLUMN material text;
ALTER TABLE dtb_products ADD COLUMN service text;
ALTER TABLE dtb_products ADD COLUMN packing text;
ALTER TABLE dtb_products ADD COLUMN attention text;

/*######################■メール転送■######################*/
INSERT INTO mtb_constants (id ,name ,rank ,remarks) VALUES ('USE_ORDER_MAIL_FWD',  'true',  (SELECT MAX(rank)+1 FROM mtb_constants),  '注文メール自動転送フラグ|true:使用');
INSERT INTO mtb_constants (id ,name ,rank ,remarks) VALUES ('USE_CONTACT_MAIL_FWD',  'true',  (SELECT MAX(rank)+1 FROM mtb_constants),  '問い合わせメール自動転送フラグ|true:使用');
ALTER TABLE dtb_baseinfo ADD COLUMN email01_fw text;
ALTER TABLE dtb_baseinfo ADD COLUMN email02_fw text;

/*######################■会員情報カスタマイズ■######################*/
CREATE TABLE mtb_footsize (
  id smallint NOT NULL,
  "name" text,
  rank smallint NOT NULL DEFAULT 0,
  CONSTRAINT mtb_footsize_pkey PRIMARY KEY (id)
);
INSERT INTO mtb_footsize(id, name, rank) VALUES(1, '21', 0);
INSERT INTO mtb_footsize(id, name, rank) VALUES((SELECT MAX(id)+1 FROM mtb_footsize), '21.5', (SELECT MAX(rank)+1 FROM mtb_footsize));
INSERT INTO mtb_footsize(id, name, rank) VALUES((SELECT MAX(id)+1 FROM mtb_footsize), '22', (SELECT MAX(rank)+1 FROM mtb_footsize));
INSERT INTO mtb_footsize(id, name, rank) VALUES((SELECT MAX(id)+1 FROM mtb_footsize), '22.5', (SELECT MAX(rank)+1 FROM mtb_footsize));
INSERT INTO mtb_footsize(id, name, rank) VALUES((SELECT MAX(id)+1 FROM mtb_footsize), '23', (SELECT MAX(rank)+1 FROM mtb_footsize));
INSERT INTO mtb_footsize(id, name, rank) VALUES((SELECT MAX(id)+1 FROM mtb_footsize), '23.5', (SELECT MAX(rank)+1 FROM mtb_footsize));
INSERT INTO mtb_footsize(id, name, rank) VALUES((SELECT MAX(id)+1 FROM mtb_footsize), '24', (SELECT MAX(rank)+1 FROM mtb_footsize));
INSERT INTO mtb_footsize(id, name, rank) VALUES((SELECT MAX(id)+1 FROM mtb_footsize), '24.5', (SELECT MAX(rank)+1 FROM mtb_footsize));
INSERT INTO mtb_footsize(id, name, rank) VALUES((SELECT MAX(id)+1 FROM mtb_footsize), '25', (SELECT MAX(rank)+1 FROM mtb_footsize));
INSERT INTO mtb_footsize(id, name, rank) VALUES((SELECT MAX(id)+1 FROM mtb_footsize), '25.5', (SELECT MAX(rank)+1 FROM mtb_footsize));
INSERT INTO mtb_footsize(id, name, rank) VALUES((SELECT MAX(id)+1 FROM mtb_footsize), '26', (SELECT MAX(rank)+1 FROM mtb_footsize));
INSERT INTO mtb_footsize(id, name, rank) VALUES((SELECT MAX(id)+1 FROM mtb_footsize), '26.5', (SELECT MAX(rank)+1 FROM mtb_footsize));
INSERT INTO mtb_footsize(id, name, rank) VALUES((SELECT MAX(id)+1 FROM mtb_footsize), '27', (SELECT MAX(rank)+1 FROM mtb_footsize));
INSERT INTO mtb_footsize(id, name, rank) VALUES((SELECT MAX(id)+1 FROM mtb_footsize), '27.5', (SELECT MAX(rank)+1 FROM mtb_footsize));
INSERT INTO mtb_footsize(id, name, rank) VALUES((SELECT MAX(id)+1 FROM mtb_footsize), '28', (SELECT MAX(rank)+1 FROM mtb_footsize));
INSERT INTO mtb_footsize(id, name, rank) VALUES((SELECT MAX(id)+1 FROM mtb_footsize), '28.5', (SELECT MAX(rank)+1 FROM mtb_footsize));
INSERT INTO mtb_footsize(id, name, rank) VALUES((SELECT MAX(id)+1 FROM mtb_footsize), '29', (SELECT MAX(rank)+1 FROM mtb_footsize));

ALTER TABLE dtb_customer ADD COLUMN footsize integer;
