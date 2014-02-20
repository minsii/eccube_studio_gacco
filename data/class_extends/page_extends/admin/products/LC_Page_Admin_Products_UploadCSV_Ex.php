<?php
/*
 * This file is part of EC-CUBE
 *
 * Copyright(c) 2000-2012 LOCKON CO.,LTD. All Rights Reserved.
 *
 * http://www.lockon.co.jp/
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 */

// {{{ requires
require_once CLASS_REALDIR . 'pages/admin/products/LC_Page_Admin_Products_UploadCSV.php';

/**
 * CSV アップロード のページクラス(拡張).
 *
 * LC_Page_Admin_Products_UploadCSV をカスタマイズする場合はこのクラスを編集する.
 *
 * @package Page
 * @author LOCKON CO.,LTD.
 * @version $$Id: LC_Page_Admin_Products_UploadCSV_Ex.php 21867 2012-05-30 07:37:01Z nakanishi $$
 */
class LC_Page_Admin_Products_UploadCSV_Ex extends LC_Page_Admin_Products_UploadCSV {

	// }}}
	// {{{ functions

	/**
	 * Page を初期化する.
	 *
	 * @return void
	 */
	function init() {
		parent::init();
	}

	/**
	 * Page のプロセス.
	 *
	 * @return void
	 */
	function process() {
		parent::process();
	}

	/**
	 * デストラクタ.
	 *
	 * @return void
	 */
	function destroy() {
		parent::destroy();
	}


	/**
	 * 商品登録を行う.
	 *
	 * FIXME: 商品登録の実処理自体は、LC_Page_Admin_Products_Productと共通化して欲しい。
	 *
	 * @param SC_Query $objQuery SC_Queryインスタンス
	 * @param string|integer $line 処理中の行数
	 * @return void
	 */
	function lfRegistProduct($objQuery, $line = '', &$objFormParam) {
		$objProduct = new SC_Product_Ex();
		// 登録データ対象取得
		$arrList = $objFormParam->getHashArray();
		// 登録時間を生成(DBのCURRENT_TIMESTAMPだとcommitした際、すべて同一の時間になってしまう)
		$arrList['update_date'] = $this->lfGetDbFormatTimeWithLine($line);

		// 商品登録情報を生成する。
		// 商品テーブルのカラムに存在しているもののうち、Form投入設定されていないデータは上書きしない。
		$sqlval = SC_Utils_Ex::sfArrayIntersectKeys($arrList, $this->arrProductColumn);

		// 必須入力では無い項目だが、空文字では問題のある特殊なカラム値の初期値設定
		$sqlval = $this->lfSetProductDefaultData($sqlval);

		if ($sqlval['product_id'] != '') {
			// 同じidが存在すればupdate存在しなければinsert
			$where = 'product_id = ?';
			$product_exists = $objQuery->exists('dtb_products', $where, array($sqlval['product_id']));
			if ($product_exists) {
				$objQuery->update('dtb_products', $sqlval, $where, array($sqlval['product_id']));
			} else {
				$sqlval['create_date'] = $arrList['update_date'];
				// INSERTの実行
				$objQuery->insert('dtb_products', $sqlval);
				// シーケンスの調整
				$seq_count = $objQuery->currVal('dtb_products_product_id');
				if ($seq_count < $sqlval['product_id']) {
					$objQuery->setVal('dtb_products_product_id', $sqlval['product_id'] + 1);
				}
			}
			$product_id = $sqlval['product_id'];
		} else {
			// 新規登録
			$sqlval['product_id'] = $objQuery->nextVal('dtb_products_product_id');
			$product_id = $sqlval['product_id'];
			$sqlval['create_date'] = $arrList['update_date'];
			// INSERTの実行
			$objQuery->insert('dtb_products', $sqlval);
		}
		
		// カテゴリ登録
		if (isset($arrList['category_ids'])) {
			$arrCategory_id = explode(',', $arrList['category_ids']);
			$this->objDb->updateProductCategories($arrCategory_id, $product_id);
		}
		// 商品ステータス登録
		if (isset($arrList['product_statuses'])) {
			$arrStatus_id = explode(',', $arrList['product_statuses']);
			$objProduct->setProductStatus($product_id, $arrStatus_id);
		}

		/*## 追加規格 ADD BEGIN ##*/
		if(USE_EXTRA_CLASS === true || isset($arrList['extra_class_id'])){
			$arrExtraClass_id = explode(',', $arrList['extra_class_id']);
			$this->lfRegisterExtraClass($objQuery, $arrExtraClass_id, $product_id);
		}
		/*## 追加規格 ADD END ##*/

		/*## 商品支払方法指定 ADD BEGIN ##*/
		if(USE_PRODUCT_PAYMENT === true || isset($arrList['payment_id'])){
			$arrPayment_id = explode(',', $arrList['payment_id']);
			$objProduct->setProductPayment($objQuery, $arrPayment_id, $product_id);
		}
		/*## 商品支払方法指定 ADD END ##*/

		/*## 商品配送方法指定 ADD BEGIN ##*/
		if(USE_PRODUCT_DELIV === true || isset($arrList['deliv_id'])){
			$arrDeliv_id = explode(',', $arrList['deliv_id']);
			$objProduct->setProductDeliv($objQuery, $arrDeliv_id, $product_id);
		}
		/*## 商品配送方法指定 ADD END ##*/

		/*## 規格商品CSV登録のバグ修正 ADD BEGIN ##*/
		if(empty($arrList['classcategory_id1'])) $arrList['classcategory_id1'] = 0;
		if(empty($arrList['classcategory_id2'])) $arrList['classcategory_id2'] = 0;
    	/*## 規格商品CSV登録のバグ修正 ADD END ##*/
		
		// 商品規格情報を登録する
		$this->lfRegistProductClass($objQuery, $arrList, $product_id, $arrList['product_class_id']);

		/*## 規格商品CSV登録のバグ修正 ADD BEGIN ##*/
		$this->lfRegisterDummyProductClass($objQuery, $arrList, $product_id, $product_class_id);
		/*## 規格商品CSV登録のバグ修正 ADD END ##*/
		
		// 関連商品登録
		$this->lfRegistReccomendProducts($objQuery, $arrList, $product_id);
	}

	/*## 追加規格 ADD BEGIN ##*/
	/**
	 * 追加規格の更新を行う.
	 *
	 * @param $objFormParam
	 */
	function lfRegisterExtraClass($objQuery, $arrExtraClass_id, $product_id) {
		if(empty($product_id) || count($arrExtraClass_id) <= 0){
			return false;
		}

		$sqlval = array();
		$sqlval['creator_id'] = $_SESSION['member_id'];
		$sqlval['create_date'] = 'CURRENT_TIMESTAMP';
		$sqlval['update_date'] = 'CURRENT_TIMESTAMP';
		$sqlval['product_id'] = $product_id;

		// 全部の追加規格を削除してから、入力を全部新規挿入する
		$objQuery->delete("dtb_products_extra_class", "product_id=?", array($product_id));
		foreach($arrExtraClass_id as $extraClass_id){
			if(empty($extraClass_id))
			continue;
			$sqlval["extra_class_id"] = $extraClass_id;
			$objQuery->insert("dtb_products_extra_class", $sqlval);
		}
	}
	/*## 追加規格 ADD END ##*/
	
	/*## 規格商品CSV登録のバグ修正 ADD BEGIN ##*/
	function lfRegisterDummyProductClass($objQuery, $arrList, $product_id, $product_class_id){

		// 商品規格更新の場合、何もしない
		if ($product_class_id != '') return;
		
		// 規格なし商品規格（=ダミー規格）が新規登録された場合、何もしない

		// 規格あり商品規格が新規登録された場合
		if($arrList["classcategory_id1"] > 0){
			$dummy_where = "product_id=? AND classcategory_id1=0 AND classcategory_id2=0";
			$dummy_product_class_id = $objQuery->get("product_class_id", "dtb_products_class", $dummy_where, array($product_id));

			// - 最初記録の場合、ダミー規格も登録する
			if (empty($dummy_product_class_id)) {
				// 配列の添字を定義
				$checkArray = array('product_code', 'stock', 'stock_unlimited', 'price01', 'price02', 'sale_limit', 'deliv_fee', 'point_rate' ,'product_type_id', 'down_filename', 'down_realfilename');
				$sqlval = SC_Utils_Ex::sfArrayIntersectKeys($arrList, $checkArray);
				$sqlval = SC_Utils_Ex::arrayDefineIndexes($sqlval, $checkArray);
				$sqlval['stock_unlimited'] = $sqlval['stock_unlimited'] ? UNLIMITED_FLG_UNLIMITED : UNLIMITED_FLG_LIMITED;
				$sqlval['creator_id'] = strlen($_SESSION['member_id']) >= 1 ? $_SESSION['member_id'] : '0';
				$sqlval['del_flg'] = 1;
				$sqlval['product_id'] = $product_id;

				if(empty($sqlval['product_type_id'])) unset($sqlval['product_type_id']);
					
				$sqlval['product_class_id'] = $objQuery->nextVal('dtb_products_class_product_class_id');
				$sqlval['create_date'] = 'CURRENT_TIMESTAMP';
				$sqlval['update_date'] = 'CURRENT_TIMESTAMP';
				// INSERTの実行
				$objQuery->insert('dtb_products_class', $sqlval);
			}
			// - 追加記録(規格なし商品→規格追加も含む)の場合、ダミー規格を隠す
			else {
				$sqlval['product_class_id'] = $dummy_product_class_id;
				$sqlval['del_flg'] = 1;
				$sqlval['update_date'] = 'CURRENT_TIMESTAMP';
				// UPDATEの実行
				$objQuery->update('dtb_products_class', $sqlval, 'product_class_id = ?', array($sqlval['product_class_id']));
			}
		}
	}
	/*## 規格商品CSV登録のバグ修正 ADD END ##*/
	
	 /**
     * このフォーム特有の複雑な入力チェックを行う.
     *
     * @param array 確認対象データ
     * @param array エラー配列
     * @return array エラー配列
     */
    function lfCheckErrorDetail($item, $arrErr) {
    	$arrErr = parent::lfCheckErrorDetail($item, $arrErr);
    	
    	/*## 規格商品CSV登録のバグ修正 ADD BEGIN ##*/
    	// 商品規格を新規登録の場合
    	if($item['product_class_id'] == '' && !count($arrErr)){
    		if(empty($item['classcategory_id1'])) $item['classcategory_id1'] = 0;
    		if(empty($item['classcategory_id2'])) $item['classcategory_id2'] = 0;
    		
    		// 親規格チェック
    		if($item['classcategory_id1'] == '' &&  !empty($item['classcategory_id2'])){
    			$arrErr['classcategory_id1'] = '※ 規格分類ID指定時には親規格分類IDの指定が必須です。';
    		}

    		$objQuery =& SC_Query_Ex::getSingletonInstance();
    		$item["class_id1"] = 0;
    		$item["class_id2"] = 0;
    		
    		if(!empty($item['classcategory_id1'])){
    			$item["class_id1"] = $objQuery->getOne("SELECT class_id FROM dtb_classcategory WHERE classcategory_id=?", array($item['classcategory_id1']));
    		}
    		if(!empty($item['classcategory_id2'])){
    			$item["class_id2"] = $objQuery->getOne("SELECT class_id FROM dtb_classcategory WHERE classcategory_id=?", array($item['classcategory_id2']));
    		}
    				
    		// 規格存在チェック
    		if(empty($arrErr['classcategory_id1']) && !empty($item['classcategory_id1']) && empty($item["class_id1"])){
    			$arrErr['classcategory_id1'] = "※ 指定の親規格分類ID({$item['classcategory_id1']})は、登録されていません。";
    		}
    		if(empty($arrErr['classcategory_id2']) && !empty($item['classcategory_id2']) && empty($item["class_id2"])){
    			$arrErr['classcategory_id2'] = "※ 指定の規格分類ID({$item['classcategory_id2']})は、登録されていません。";
    		}
    		
    		// 規格重複チェック
    		if(!empty($item["class_id1"]) && $item["class_id1"] == $item["class_id2"]){
    			$arrErr['classcategory_id2'] = "※ 親規格({$item["class_id1"]})と規格({$item["class_id2"]})は、同じ値を使用できません。";
    		}
    		
			// 既存規格がある場合
    		if($item["product_id"] > 0 && !count($arrErr) &&  
    		$this->objDb->sfIsRecord('dtb_products_class', 'product_id', (array)$item['product_id'], 'classcategory_id1<>0')){

    			// 重複された規格分類組合せチェック
    			if ($this->objDb->sfIsRecord('dtb_products_class',
    				'product_id, classcategory_id1, classcategory_id2',	
    					array($item['product_id'],$item['classcategory_id1'], $item['classcategory_id2']))){
    				$arrErr['product_class_id'] = "※ 指定の規格分類組合せ({$item['classcategory_id1']}, {$item['classcategory_id2']})は、既に登録されています。";
    			}
    			
    			// 既存規格組合せと一致するチェック
    			if(!count($arrErr)){
    				 
    				$from = <<< __EOS__
	(SELECT T11.product_id, T12.class_id AS class_id1
		FROM dtb_products_class T11 LEFT JOIN dtb_classcategory T12 ON T12.classcategory_id = T11.classcategory_id1
		WHERE T11.product_id=? AND T11.del_flg=0 AND T11.classcategory_id1<>0
	) AS T1 JOIN
	(SELECT T11.product_id, T12.class_id AS class_id2
		FROM dtb_products_class T11 LEFT JOIN dtb_classcategory T12 ON T12.classcategory_id = T11.classcategory_id2
		WHERE T11.product_id=? AND T11.del_flg=0 AND T11.classcategory_id1<>0
	) AS T2 ON T1.product_id =  T2.product_id
__EOS__;
    				$arrExistClassId = $objQuery->getRow("DISTINCT class_id1, class_id2", $from, "", array($item['product_id'], $item['product_id']));
    				if(empty($arrExistClassId["class_id1"])) $arrExistClassId["class_id1"] = 0;
    				if(empty($arrExistClassId["class_id2"])) $arrExistClassId["class_id2"] = 0;
    				 
    				if($arrExistClassId["class_id1"] > 0 &&
    					($arrExistClassId["class_id1"] != $item["class_id1"] || 
    						$arrExistClassId["class_id2"] != $item["class_id2"])){
    					$arrErr['classcategory_id1'] = "※ 既に別の規格組合せ({$arrExistClassId["class_id1"]}, {$arrExistClassId["class_id2"]})を登録されています。";
    				}
    			}
    		}
    	}
    	/*## 規格商品CSV登録のバグ修正 ADD END ##*/

    	return $arrErr;
    }
	
}
