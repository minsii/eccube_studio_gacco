/*######## SEO�Ǘ� ########*/
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

INSERT INTO  mtb_constants (id ,name ,rank ,remarks) VALUES ('USE_SEO',  'true',  (SELECT MAX(rank)+1 FROM mtb_constants),  'SEO�Ǘ��g�p�t���O|true:�g�p');

/*######################���_�E�����[�h���i�g�p�t���O�ǉ���######################*/
INSERT INTO mtb_constants(id, name, rank, remarks) VALUES('USE_DOWNLOAD_PRODUCT', 'false', (SELECT MAX(rank)+1 FROM mtb_constants), '�_�E�����[�h���i�g�p�t���O|true:�g�p����');

/*######## �x�����@�Ǘ� ########*/
INSERT INTO  mtb_constants (id ,name ,rank ,remarks) VALUES ('USE_PAYMENT_NOTE',  'true',  (SELECT MAX(rank)+1 FROM mtb_constants),  '�x�����@�����g�p�t���O|true:�g�p');


/*######## �ǉ��K�i ########*/
INSERT INTO mtb_constants(id, name, rank, remarks) VALUES('USE_EXTRA_CLASS', 'true', (SELECT MAX(rank)+1 FROM mtb_constants), '�ǉ��K�i�g�p�t���O|true:�g�p����');
INSERT INTO mtb_constants(id, name, rank, remarks) VALUES('MAX_EXTRA_CLASS', '5', (SELECT MAX(rank)+1 FROM mtb_constants), '�ǉ��K�i�o�^�ő吔');
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

INSERT INTO mtb_constants(id, name, rank, remarks) VALUES('USE_MULTIPLE_DELIV', 'false', (SELECT MAX(rank)+1 FROM mtb_constants), '�����z���g�p�t���O|true:�g�p����');
ALTER TABLE dtb_order_detail ADD COLUMN extra_info text;

/*######## �ڋq�@�l�Ǘ� ########*/
INSERT INTO  mtb_constants (id ,name ,rank ,remarks) VALUES ('USE_CUSTOMER_COMPANY',  'true',  (SELECT MAX(rank)+1 FROM mtb_constants),  '�ڋq�@�l�g�p�t���O|true:�g�p');
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

/*######## �ڋq�Ǘ���ʂɂ��͂���ꗗ�\�� ########*/
INSERT INTO  mtb_constants (id ,name ,rank ,remarks) VALUES ('USE_ADMIN_CUSTOMER_DELIV_LIST',  'true',  (SELECT MAX(rank)+1 FROM mtb_constants),  '�ڋq�Ǘ���ʂɂ��͂���ꗗ��\������t���O|true:�\��');


