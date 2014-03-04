DELETE FROM dtb_csv WHERE csv_id=1;                        
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'product_id' , '商品ID' , '1' , '3' , '1' , 'NOW()' , 'NOW()' , 'n' , 'INT_LEN' , 'NUM_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'product_class_id' , '商品規格ID' , '2' , '3' , '1' , 'NOW()' , 'NOW()' , 'n' , 'INT_LEN' , 'NUM_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'classcategory_id1' , '親規格分類ID' , '3' , '3' , '1' , 'NOW()' , 'NOW()' , 'n' , 'INT_LEN' , 'NUM_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'classcategory_id2' , '規格分類ID' , '4' , '3' , '1' , 'NOW()' , 'NOW()' , 'n' , 'INT_LEN' , 'NUM_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'parent_classcategory_name' , '親規格分類名' , '5' , '2' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'STEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'classcategory_name' , '規格分類名' , '6' , '2' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'STEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , '(SELECT ARRAY_TO_STRING(ARRAY(SELECT extra_class_id FROM dtb_products_extra_class WHERE dtb_products_extra_class.product_id = prdcls.product_id ORDER BY dtb_products_extra_class.product_extra_class_id), '','')) as extra_class_id' , '追加規格ID' , '7' , '1' , '1' , 'NOW()' , 'NOW()' , 'n' , 'STEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , '(SELECT ARRAY_TO_STRING(ARRAY(SELECT dtb_extra_class.name FROM dtb_products_extra_class LEFT JOIN dtb_extra_class ON dtb_products_extra_class.extra_class_id=dtb_extra_class.extra_class_id WHERE dtb_products_extra_class.product_id = prdcls.product_id ORDER BY dtb_products_extra_class.product_extra_class_id), '','')) as extra_class_name' , '追加規格名' , '8' , '2' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'LTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'name' , '商品名' , '9' , '1' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'STEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK,EXIST_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'status' , '表示ステータス(公開・非公開)' , '10' , '1' , '1' , 'NOW()' , 'NOW()' , 'n' , 'INT_LEN' , 'NUM_CHECK,MAX_LENGTH_CHECK,EXIST_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , '(SELECT ARRAY_TO_STRING(ARRAY(SELECT product_status_id FROM dtb_product_status WHERE dtb_product_status.product_id = prdcls.product_id and del_flg = 0 ORDER BY dtb_product_status.product_status_id), '','')) as product_statuses' , '商品ステータス' , '11' , '1' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'STEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , '(SELECT ARRAY_TO_STRING(ARRAY(SELECT name FROM dtb_product_status LEFT JOIN mtb_status ON  dtb_product_status.product_status_id = mtb_status.id  WHERE dtb_product_status.product_id = prdcls.product_id and del_flg = 0 ORDER BY dtb_product_status.product_status_id), '','')) as product_status_names' , '商品ステータス名' , '12' , '2' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'LTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , '(SELECT ARRAY_TO_STRING(ARRAY(SELECT deliv_id FROM dtb_product_deliv WHERE dtb_product_deliv.product_id = prdcls.product_id ORDER BY dtb_product_deliv.deliv_id), '','')) as deliv_id' , '配送方法ID' , '13' , '1' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'STEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , '(SELECT ARRAY_TO_STRING(ARRAY(SELECT name FROM dtb_product_deliv LEFT JOIN dtb_deliv ON dtb_product_deliv.deliv_id=dtb_deliv.deliv_id WHERE dtb_product_deliv.product_id = prdcls.product_id ORDER BY dtb_product_deliv.deliv_id), '','')) as deliv_name' , '配送方法名' , '14' , '2' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'LTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'product_code' , '商品コード' , '15' , '1' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'STEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'stock' , '在庫数' , '16' , '1' , '1' , 'NOW()' , 'NOW()' , 'n' , 'AMOUNT_LEN' , 'NUM_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'stock_unlimited' , '在庫無制限フラグ' , '17' , '1' , '1' , 'NOW()' , 'NOW()' , 'n' , 'INT_LEN' , 'NUM_CHECK,MAX_LENGTH_CHECK,EXIST_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'custom_made' , '受注フラグ' , '18' , '1' , '1' , 'NOW()' , 'NOW()' , 'n' , 'INT_LEN' , 'NUM_CHECK,MAX_LENGTH_CHECK,EXIST_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'price01' , '通常価格' , '19' , '1' , '1' , 'NOW()' , 'NOW()' , 'n' , 'PRICE_LEN' , 'NUM_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'price02' , '販売価格' , '20' , '1' , '1' , 'NOW()' , 'NOW()' , 'n' , 'PRICE_LEN' , 'NUM_CHECK,MAX_LENGTH_CHECK,EXIST_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'deliv_fee' , '送料' , '21' , '1' , '1' , 'NOW()' , 'NOW()' , 'n' , 'PRICE_LEN' , 'NUM_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'point_rate' , 'ポイント付与率' , '22' , '1' , '1' , 'NOW()' , 'NOW()' , 'n' , 'PERCENTAGE_LEN' , 'NUM_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'deliv_rank' , '配送ランク' , '23' , '1' , '1' , 'NOW()' , 'NOW()' , 'n' , 'AMOUNT_LEN' , 'NUM_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'deliv_date_id' , '発送日目安ID' , '24' , '1' , '1' , 'NOW()' , 'NOW()' , 'n' , 'INT_LEN' , 'NUM_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'sale_limit' , '購入制限数' , '25' , '1' , '1' , 'NOW()' , 'NOW()' , 'n' , 'AMOUNT_LEN' , 'NUM_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'size' , '大きさ' , '26' , '1' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'MTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'weight' , '重さ' , '27' , '1' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'MTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'material' , '使用素材' , '28' , '1' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'MTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'service' , '各種サービス' , '29' , '1' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'MTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'packing' , '梱包仕様' , '30' , '1' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'MTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'attention' , '商品の注意' , '31' , '1' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'MTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'title' , 'ページタイトル' , '32' , '1' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'STEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'h1' , 'H1テキスト' , '33' , '1' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'STEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'description' , 'メタタグ:Description' , '34' , '1' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'STEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'keyword' , 'メタタグ:Keywords' , '35' , '1' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'STEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'main_list_comment' , '一覧-メインコメント' , '36' , '1' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'MTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK,EXIST_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'main_comment' , '詳細-メインコメント1' , '37' , '1' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'LLTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK,EXIST_CHECK,HTML_TAG_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'comment2' , '詳細-メインコメント2' , '38' , '1' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'LLTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK,HTML_TAG_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'comment4' , '詳細-メインコメント3' , '39' , '1' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'LLTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK,HTML_TAG_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'comment5' , '詳細-メインコメント4' , '40' , '1' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'LLTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK,HTML_TAG_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'comment6' , '詳細-メインコメント5' , '41' , '1' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'LLTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK,HTML_TAG_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'main_list_image' , '一覧-メイン画像' , '42' , '1' , '1' , 'NOW()' , 'NOW()' , '' , 'LTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK,FILE_EXISTS' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'main_image' , '詳細-メイン画像' , '43' , '1' , '1' , 'NOW()' , 'NOW()' , '' , 'LTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK,FILE_EXISTS' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'main_large_image' , '詳細-メイン拡大画像 ' , '44' , '1' , '1' , 'NOW()' , 'NOW()' , '' , 'LTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK,FILE_EXISTS' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'sub_title1' , '詳細-サブタイトル(1)' , '45' , '1' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'STEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'sub_comment1' , '詳細-サブコメント(1)' , '46' , '1' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'LLTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK,HTML_TAG_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'sub_image1' , '詳細-サブ画像(1)' , '47' , '1' , '1' , 'NOW()' , 'NOW()' , '' , 'LTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK,FILE_EXISTS' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'sub_large_image1' , '詳細-サブ拡大画像(1)' , '48' , '1' , '1' , 'NOW()' , 'NOW()' , '' , 'LTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK,FILE_EXISTS' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'sub_title2' , '詳細-サブタイトル(2)' , '49' , '1' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'STEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'sub_comment2' , '詳細-サブコメント(2)' , '50' , '1' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'LLTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'sub_image2' , '詳細-サブ画像(2)' , '51' , '1' , '1' , 'NOW()' , 'NOW()' , '' , 'LTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK,FILE_EXISTS' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'sub_large_image2' , '詳細-サブ拡大画像(2)' , '52' , '1' , '1' , 'NOW()' , 'NOW()' , '' , 'LTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK,FILE_EXISTS' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'sub_title3' , '詳細-サブタイトル(3)' , '53' , '1' , '1' , 'NOW()' , 'NOW()' , '' , 'STEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'sub_comment3' , '詳細-サブコメント(3)' , '54' , '1' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'LLTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'sub_image3' , '詳細-サブ画像(3)' , '55' , '1' , '1' , 'NOW()' , 'NOW()' , '' , 'LTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK,FILE_EXISTS' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'sub_large_image3' , '詳細-サブ拡大画像(3)' , '56' , '1' , '1' , 'NOW()' , 'NOW()' , '' , 'LTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK,FILE_EXISTS' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'sub_title4' , '詳細-サブタイトル(4)' , '57' , '1' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'STEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'sub_comment4' , '詳細-サブコメント(4)' , '58' , '1' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'LLTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'sub_image4' , '詳細-サブ画像(4)' , '59' , '1' , '1' , 'NOW()' , 'NOW()' , '' , 'LTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK,FILE_EXISTS' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'sub_large_image4' , '詳細-サブ拡大画像(4)' , '60' , '1' , '1' , 'NOW()' , 'NOW()' , '' , 'LTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK,FILE_EXISTS' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'sub_title5' , '詳細-サブタイトル(5)' , '61' , '1' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'STEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'sub_comment5' , '詳細-サブコメント(5)' , '62' , '1' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'LLTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'sub_image5' , '詳細-サブ画像(5)' , '63' , '1' , '1' , 'NOW()' , 'NOW()' , '' , 'LTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK,FILE_EXISTS' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'sub_large_image5' , '詳細-サブ拡大画像(5)' , '64' , '1' , '1' , 'NOW()' , 'NOW()' , '' , 'LTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK,FILE_EXISTS' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , '(SELECT recommend_product_id FROM dtb_recommend_products WHERE prdcls.product_id = dtb_recommend_products.product_id ORDER BY rank DESC, recommend_product_id DESC limit 1 offset 0) AS recommend_product_id1' , '関連商品ID(1)' , '65' , '1' , '1' , 'NOW()' , 'NOW()' , 'n' , 'INT_LEN' , 'NUM_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , '(SELECT comment FROM dtb_recommend_products WHERE prdcls.product_id = dtb_recommend_products.product_id ORDER BY rank DESC, recommend_product_id DESC limit 1 offset 0) AS recommend_comment1' , '関連商品コメント(1)' , '66' , '1' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'LLTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , '(SELECT recommend_product_id FROM dtb_recommend_products WHERE prdcls.product_id = dtb_recommend_products.product_id ORDER BY rank DESC, recommend_product_id DESC limit 1 offset 1) AS recommend_product_id2' , '関連商品ID(2)' , '67' , '1' , '1' , 'NOW()' , 'NOW()' , 'n' , 'INT_LEN' , 'NUM_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , '(SELECT comment FROM dtb_recommend_products WHERE prdcls.product_id = dtb_recommend_products.product_id ORDER BY rank DESC, recommend_product_id DESC limit 1 offset 1) AS recommend_comment2' , '関連商品コメント(2)' , '68' , '1' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'LLTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , '(SELECT recommend_product_id FROM dtb_recommend_products WHERE prdcls.product_id = dtb_recommend_products.product_id ORDER BY rank DESC, recommend_product_id DESC limit 1 offset 2) AS recommend_product_id3' , '関連商品ID(3)' , '69' , '1' , '1' , 'NOW()' , 'NOW()' , 'n' , 'INT_LEN' , 'NUM_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , '(SELECT comment FROM dtb_recommend_products WHERE prdcls.product_id = dtb_recommend_products.product_id ORDER BY rank DESC, recommend_product_id DESC limit 1 offset 2) AS recommend_comment3' , '関連商品コメント(3)' , '70' , '1' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'LLTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , '(SELECT recommend_product_id FROM dtb_recommend_products WHERE prdcls.product_id = dtb_recommend_products.product_id ORDER BY rank DESC, recommend_product_id DESC limit 1 offset 3) AS recommend_product_id4' , '関連商品ID(4)' , '71' , '1' , '1' , 'NOW()' , 'NOW()' , 'n' , 'INT_LEN' , 'NUM_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , '(SELECT comment FROM dtb_recommend_products WHERE prdcls.product_id = dtb_recommend_products.product_id ORDER BY rank DESC, recommend_product_id DESC limit 1 offset 3) AS recommend_comment4' , '関連商品コメント(4)' , '72' , '1' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'LLTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , '(SELECT recommend_product_id FROM dtb_recommend_products WHERE prdcls.product_id = dtb_recommend_products.product_id ORDER BY rank DESC, recommend_product_id DESC limit 1 offset 4) AS recommend_product_id5' , '関連商品ID(5)' , '73' , '1' , '1' , 'NOW()' , 'NOW()' , 'n' , 'INT_LEN' , 'NUM_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , '(SELECT comment FROM dtb_recommend_products WHERE prdcls.product_id = dtb_recommend_products.product_id ORDER BY rank DESC, recommend_product_id DESC limit 1 offset 4) AS recommend_comment5' , '関連商品コメント(5)' , '74' , '1' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'LLTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , '(SELECT recommend_product_id FROM dtb_recommend_products WHERE prdcls.product_id = dtb_recommend_products.product_id ORDER BY rank DESC, recommend_product_id DESC limit 1 offset 5) AS recommend_product_id6' , '関連商品ID(6)' , '75' , '1' , '1' , 'NOW()' , 'NOW()' , 'n' , 'INT_LEN' , 'NUM_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , '(SELECT comment FROM dtb_recommend_products WHERE prdcls.product_id = dtb_recommend_products.product_id ORDER BY rank DESC, recommend_product_id DESC limit 1 offset 5) AS recommend_comment6' , '関連商品コメント(6)' , '76' , '1' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'LLTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , 'del_flg' , '削除フラグ' , '77' , '1' , '1' , 'NOW()' , 'NOW()' , 'n' , 'INT_LEN' , 'NUM_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , '(SELECT ARRAY_TO_STRING(ARRAY(SELECT category_id FROM dtb_product_categories WHERE dtb_product_categories.product_id = prdcls.product_id ORDER BY dtb_product_categories.rank),  '','')) as category_ids' , 'カテゴリID' , '78' , '1' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'STEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK' );
INSERT INTO dtb_csv VALUES( (SELECT MAX(no)+1 FROM dtb_csv) , '1' , '(SELECT ARRAY_TO_STRING(ARRAY(SELECT category_name FROM dtb_product_categories LEFT JOIN dtb_category ON dtb_product_categories.category_id = dtb_category.category_id WHERE dtb_product_categories.product_id = prdcls.product_id ORDER BY dtb_product_categories.rank),  '','')) as category_names' , 'カテゴリ名' , '79' , '2' , '1' , 'NOW()' , 'NOW()' , 'KVa' , 'LTEXT_LEN' , 'SPTAB_CHECK,MAX_LENGTH_CHECK' );
