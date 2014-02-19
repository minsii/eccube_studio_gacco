<?php
/*
 * This file is part of EC-CUBE
 *
 * Copyright(c) 2000-2011 LOCKON CO.,LTD. All Rights Reserved.
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
require_once CLASS_EX_REALDIR . 'page_extends/admin/LC_Page_Admin_Ex.php';

/**
 * 事例カテゴリ管理 のページクラス(拡張).
 *
 * @package Page
 * @author m.si
 */
class LC_Page_Admin_Contents_Portfolio_Category_Ex extends LC_Page_Admin_Ex {

	// }}}
	// {{{ functions

	/**
	 * Page を初期化する.
	 *
	 * @return void
	 */
	function init() {
		parent::init();
		$this->tpl_mainpage = 'contents/portfolio_category.tpl';
		$this->tpl_subno = 'portfolio_category';
		$this->tpl_mainno = 'contents';
		$this->tpl_maintitle = 'コンテンツ管理';
		$this->tpl_subtitle = '事例カテゴリ登録';
	}

	/**
	 * Page のプロセス.
	 *
	 * @return void
	 */
	function process() {
		$this->action();
		$this->sendResponse();
	}

	/**
	 * Page のアクション.
	 *
	 * @return void
	 */
	function action() {
		if(USE_JIREI !== true){print_r(USE_JIREI);exit;
			// エラーページの表示
			SC_Utils::sfDispError(AUTH_ERROR);
		}		
		$objDb = new SC_Helper_DB_Ex();

		$this->objFormParam = new SC_FormParam_Ex();
		$this->lfInitParam();
		$this->objFormParam->setParam($_POST);
		$this->objFormParam->convParam();

		$portfolio_category_id = $this->objFormParam->getValue("portfolio_category_id");

		switch ($this->getMode()) {
			case 'register':
				$this->arrErr = $this->lfCheckError();
				if (SC_Utils_Ex::isBlank($this->arrErr)) {
					$this->lfRegisterPortfolioCat();
				} else {
					$this->arrForm = $this->objFormParam->getHashArray();
				}
				break;
					
			case 'pre_edit':
				if(!empty($portfolio_category_id)){
					$arrPortfolioCat = $this->lfGetPortfoiloCat($portfolio_category_id);
					$this->lfLoadTempForm($arrPortfolioCat);
				}
				break;

			case 'delete':
				if(!empty($portfolio_category_id)) {
					// ランク付きレコードの削除(※処理負荷を考慮してレコードごと削除する。)
					$objDb->sfDeleteRankRecord("dtb_portfolio_category", "portfolio_category_id", $portfolio_category_id, "", true);
				}
				break;
			case 'up':
				$where = "del_flg = 0";
				$objDb->sfRankUp("dtb_portfolio_category", "portfolio_category_id",$portfolio_category_id, $where);
				break;
			case 'down':
				$where = "del_flg = 0";
				$objDb->sfRankDown("dtb_portfolio_category", "portfolio_category_id", $portfolio_category_id, $where);
				break;
			default:
				break;
		}
		
		// 事例カテゴリリストを取得
		$this->arrList = $this->lfListPortfolioCat();
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
	 * 入力されたパラメーターのエラーチェックを行う。
	 *
	 * @param Object $objFormParam
	 * @return Array エラー内容
	 */
	function lfCheckError(){
		$array = $this->objFormParam->getHashArray();
		$objErr = new SC_CheckError_Ex($array);
		$objErr->arrErr = $this->objFormParam->checkError();

		// 新規作成の場合、idを0とする
		$portfolio_category_id = $this->objFormParam->getValue("portfolio_category_id");
		if (empty($portfolio_category_id)) $portfolio_category_id = "0";

		// 重複チェック
		if(!isset($objErr->arrErr['portfolio_category_name'])) {
			$objQuery = & SC_Query_Ex::getSingletonInstance();

			// 編集中のレコード以外に同じ名称が存在する場合
			$where = "portfolio_category_name = ? AND portfolio_category_id <> ?";
			if ($objQuery->count("dtb_portfolio_category", $where, array($array['portfolio_category_name'], $portfolio_category_id))) {
				$objErr->arrErr['portfolio_category_name'] = "※ 既に同じ内容の登録が存在します。<br>";
			}
		}

		return $objErr->arrErr;
	}

	/**
	 * パラメーターの初期化を行う
	 *
	 * @param Object $objFormParam
	 */
	function lfInitParam(){
		$this->objFormParam->addParam("portfolio_category_id", 'portfolio_category_id');
		$this->objFormParam->addParam("事例カテゴリ名", "portfolio_category_name", STEXT_LEN, "KVa", array("EXIST_CHECK","SPTAB_CHECK","MAX_LENGTH_CHECK"));
		$this->objFormParam->addParam("フリースペース-上部", "portfolio_category_info", LLTEXT_LEN, "KVa", array("SPTAB_CHECK","MAX_LENGTH_CHECK"));
		$this->objFormParam->addParam("フリースペース-下部", "portfolio_category_info2", LLTEXT_LEN, "KVa", array("SPTAB_CHECK","MAX_LENGTH_CHECK"));

		$this->objFormParam->addParam("htmlタイトル", "title", MTEXT_LEN, "KVa", array("SPTAB_CHECK","MAX_LENGTH_CHECK"));
		$this->objFormParam->addParam("metaタグ(description)", "description", MTEXT_LEN, "KVa", array("SPTAB_CHECK","MAX_LENGTH_CHECK"));
		$this->objFormParam->addParam("metaタグ(keyword)", "keyword", MTEXT_LEN, "KVa", array("SPTAB_CHECK","MAX_LENGTH_CHECK"));
		$this->objFormParam->addParam("h1テキスト", "h1", MTEXT_LEN, "KVa", array("SPTAB_CHECK","MAX_LENGTH_CHECK"));
	}

	function lfLoadTempForm($array){
		$this->arrForm['portfolio_category_id'] = $array['portfolio_category_id'];
		$this->arrForm['portfolio_category_name'] = $array['portfolio_category_name'];
		$this->arrForm['portfolio_category_info'] = $array['portfolio_category_info'];
		$this->arrForm['portfolio_category_info2'] = $array['portfolio_category_info2'];
		$this->arrForm['title'] = $array['title'];
		$this->arrForm['description'] = $array['description'];
		$this->arrForm['keyword'] = $array['keyword'];
		$this->arrForm['h1'] = $array['h1'];
	}

	// 事例カテゴリ一覧の取得
	function lfListPortfolioCat() {
		$arrCategory = array();
		$objQuery =& SC_Query_Ex::getSingletonInstance();

		$col = "*";
		$where = "del_flg = 0";
		$objQuery->setoption("ORDER BY rank DESC");
		$arrRet = $objQuery->select($col, "dtb_portfolio_category", $where);
		
		return $arrRet;
	}

	// 事例カテゴリ詳細の取得
	function lfGetPortfoiloCat($portfolio_category_id){
		$objQuery =& SC_Query_Ex::getSingletonInstance();
		$arrRet = array();

		$col = "*";
		$where = "portfolio_category_id = ? AND del_flg = 0";
		$arrRet = $objQuery->select($col, "dtb_portfolio_category", $where, array($portfolio_category_id));
		if(is_array($arrRet) && is_array($arrRet[0]))
		$arrRet = $arrRet[0];

		return $arrRet;
	}

	// 事例の新規追加
	function lfRegisterPortfolioCat(){
		$portfolio_category_id = $this->objFormParam->getValue("portfolio_category_id");
		$objQuery =& SC_Query_Ex::getSingletonInstance();
		$objQuery->begin(); // トランザクションの開始

		// 入力データを渡す。
		$sqlval = $this->objFormParam->getHashArray();
		$sqlval['creator_id'] = $_SESSION['member_id'];
		unset($sqlval["portfolio_category_id"]);
		
		// INSERTの実行
		if(empty($portfolio_category_id)){
			// 最大のランクを取得する。
			$rank = $objQuery->max("rank", "dtb_portfolio_category");
			if ( empty($rank) ) {
				$rank = 1;
			} else {
				$rank += 1;
			}
			$sqlval['rank'] = $rank;
			$objQuery->insert("dtb_portfolio_category", $sqlval);
		}
		// UPDATEの実行
		else{
			$where = "portfolio_category_id = ? AND del_flg = 0";
			$sqlval['update_date'] = "now()";
			$objQuery->update("dtb_portfolio_category", $sqlval, $where, array($portfolio_category_id));
		}

		$objQuery->commit();    // トランザクションの終了
	}
}
?>
