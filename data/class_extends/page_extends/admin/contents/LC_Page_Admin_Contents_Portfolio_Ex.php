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
 * 事例管理 のページクラス(拡張).
 *
 * @package Page
 * @author m.si
 */
class LC_Page_Admin_Contents_Portfolio_Ex extends LC_Page_Admin_Ex {

	// }}}
	// {{{ functions

	/**
	 * Page を初期化する.
	 *
	 * @return void
	 */
	function init() {
		parent::init();
		$this->tpl_mainpage = 'contents/portfolio.tpl';
		$this->tpl_subno = 'portfolio';
		$this->tpl_mainno = 'contents';
		$this->tpl_maintitle = 'コンテンツ管理';
		$this->tpl_subtitle = '事例登録';
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
		if(USE_JIREI !== true){
			// エラーページの表示
			SC_Utils::sfDispError(AUTH_ERROR);
		}	
		
		$objDb = new SC_Helper_DB_Ex();

		$this->objFormParam = new SC_FormParam_Ex();
		$this->lfInitParam();
		$this->objFormParam->setParam($_POST);
		$this->objFormParam->convParam();

		// ファイル管理クラス
		$this->objUpFile = new SC_UploadFile_Ex(IMAGE_TEMP_REALDIR, IMAGE_SAVE_REALDIR);
		$this->lfInitFile();
        $this->objUpFile->setHiddenFileList($_POST);

		$portfolio_id = $this->objFormParam->getValue("portfolio_id");

		switch ($this->getMode()) {
			case 'register':
				$this->arrErr = $this->lfCheckError();
				if (SC_Utils_Ex::isBlank($this->arrErr)) {
					$this->lfRegisterPortfolio();
					// 一時ファイルを本番ディレクトリに移動する
					$this->objUpFile->moveTempFile();
				} else {
					$this->lfLoadTempForm($this->objFormParam->getHashArray());
				}

				break;
					
			case 'pre_edit':
				if(!empty($portfolio_id)){
					$arrPortfolio = $this->lfGetPortfoilo($portfolio_id);
					$this->objUpFile->setDBFileList($arrPortfolio);
					$this->lfLoadTempForm($arrPortfolio);
				}

				break;

			case 'delete':
				if(!empty($portfolio_id)) {
					// ランク付きレコードの削除(※処理負荷を考慮してレコードごと削除する。)
					$objDb->sfDeleteRankRecord("dtb_portfolio", "portfolio_id", $portfolio_id, "", true);
				}
				break;
			case 'up':
				$where = "del_flg = 0";
				$objDb->sfRankUp("dtb_portfolio", "portfolio_id",$portfolio_id, $where);
				break;
			case 'down':
				$where = "del_flg = 0";
				$objDb->sfRankDown("dtb_portfolio", "portfolio_id", $portfolio_id, $where);
				break;
				// 画像のアップロード
			case 'upload_image':
				// ファイル存在チェック
				$this->arrErr = array_merge((array)$this->arrErr, (array)$this->objUpFile->checkEXISTS($_POST['image_key']));
				// 画像保存処理
				$this->arrErr[$_POST['image_key']] = $this->objUpFile->makeTempFile($_POST['image_key'],IMAGE_RENAME);

				// 中、小画像生成
				$this->lfSetScaleImage();

				// POSTデータを引き継ぐ
				$this->lfLoadTempForm($this->objFormParam->getHashArray());
            	$this->tpl_onload .= "location.hash='#" . htmlspecialchars($_POST['image_key']) . "'";
     
				break;
				// 画像の削除
			case 'delete_image':
				$this->objUpFile->deleteFile($_POST['image_key']);
				// POSTデータを引き継ぐ
				$this->lfLoadTempForm($this->objFormParam->getHashArray());
				$this->tpl_onload .= "location.hash='#" . htmlspecialchars($_POST['image_key']) . "'";
				break;
			default:
				break;
		}

		// 事例カテゴリリストを取得
		$this->arrCategory = $this->lfListPortfolioCat();

		// 事例リストを取得
		$this->arrList = $this->lfListPortfolio();
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
		$portfolio_id = $this->objFormParam->getValue("portfolio_id");
		if (empty($portfolio_id)) $portfolio_id = "0";

		// 重複チェック
		if(!isset($objErr->arrErr['portfolio_name'])) {
			$objQuery = & SC_Query_Ex::getSingletonInstance();

			// 編集中のレコード以外に同じ名称が存在する場合
			$where = "portfolio_name = ? AND portfolio_id <> ?";
			if ($objQuery->count("dtb_portfolio", $where, array($array['portfolio_name'], $portfolio_id))) {
				$objErr->arrErr['portfolio_name'] = "※ 既に同じ内容の登録が存在します。<br>";
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
		$this->objFormParam->addParam("portfolio_id", 'portfolio_id');
		$this->objFormParam->addParam("search_portfolio_category_id", 'search_portfolio_category_id');
		$this->objFormParam->addParam("事例タイトル", "portfolio_name", STEXT_LEN, "KVa", array("EXIST_CHECK","SPTAB_CHECK","MAX_LENGTH_CHECK"));
		$this->objFormParam->addParam("事例詳細", "portfolio_info", LLTEXT_LEN, "KVa", array("SPTAB_CHECK","MAX_LENGTH_CHECK"));
		$this->objFormParam->addParam("事例カテゴリ", "portfolio_category_id", INT_LEN, "n",  array("EXIST_CHECK", "NUM_CHECK"));
		$this->objFormParam->addParam("htmlタイトル", "title", MTEXT_LEN, "KVa", array("SPTAB_CHECK","MAX_LENGTH_CHECK"));
		$this->objFormParam->addParam("metaタグ(description)", "description", MTEXT_LEN, "KVa", array("SPTAB_CHECK","MAX_LENGTH_CHECK"));
		$this->objFormParam->addParam("metaタグ(keyword)", "keyword", MTEXT_LEN, "KVa", array("SPTAB_CHECK","MAX_LENGTH_CHECK"));
		$this->objFormParam->addParam("h1テキスト", "h1", MTEXT_LEN, "KVa", array("SPTAB_CHECK","MAX_LENGTH_CHECK"));
		$this->objFormParam->addParam("save_portfolio_main_image", "save_portfolio_main_image", '', "", array());
		$this->objFormParam->addParam("temp_portfolio_main_image", "temp_portfolio_main_image", '', "", array());
		
	}

	/**
	 * アップロードファイルパラメーター情報の初期化
	 * - 画像ファイル用
	 *
	 * @return void
	 */
	function lfInitFile() {
		$this->objUpFile->addFile("事例一覧用画像", 'portfolio_main_image', array('jpg', 'gif', 'png'),IMAGE_SIZE, true, JIREI_IMAGE_WIDTH, JIREI_IMAGE_HEIGHT);
	}

	function lfLoadTempForm($array){
		$this->arrForm['portfolio_id'] = $array['portfolio_id'];
		$this->arrForm['portfolio_name'] = $array['portfolio_name'];
		$this->arrForm['portfolio_info'] = $array['portfolio_info'];
		$this->arrForm['portfolio_category_id'] = $array['portfolio_category_id'];
		$this->arrForm['title'] = $array['title'];
		$this->arrForm['description'] = $array['description'];
		$this->arrForm['keyword'] = $array['keyword'];
		$this->arrForm['h1'] = $array['h1'];
		
        // アップロードファイル情報取得(Hidden用)
        $this->arrForm['arrHidden'] = $this->objUpFile->getHiddenFileList();

        // 画像ファイル表示用データ取得
        $this->arrForm['arrFile'] = $this->objUpFile->getFormFileList(IMAGE_TEMP_URLPATH, IMAGE_SAVE_URLPATH);
	}

	/**
	 * 縮小した画像をセットする
	 *
	 * @param object $objUpFile SC_UploadFileインスタンス
	 * @param string $image_key 画像ファイルキー
	 * @return void
	 */
	function lfSetScaleImage(&$objUpFile, $image_key){
		$this->lfMakeScaleImage($objUpFile, $image_key, $image_key);
	}

	/**
	 * 縮小画像生成
	 *
	 * @param object $objUpFile SC_UploadFileインスタンス
	 * @param string $from_key 元画像ファイルキー
	 * @param string $to_key 縮小画像ファイルキー
	 * @param boolean $forced
	 * @return void
	 */
	function lfMakeScaleImage(&$objUpFile, $from_key, $to_key, $forced = false){
		$arrImageKey = array_flip($objUpFile->keyname);
		$from_path = "";

		if($objUpFile->temp_file[$arrImageKey[$from_key]]) {
			$from_path = $objUpFile->temp_dir . $objUpFile->temp_file[$arrImageKey[$from_key]];
		} elseif($objUpFile->save_file[$arrImageKey[$from_key]]){
			$from_path = $objUpFile->save_dir . $objUpFile->save_file[$arrImageKey[$from_key]];
		}

		if(file_exists($from_path)) {
			// 生成先の画像サイズを取得
			$to_w = $objUpFile->width[$arrImageKey[$to_key]];
			$to_h = $objUpFile->height[$arrImageKey[$to_key]];

			if($forced) $objUpFile->save_file[$arrImageKey[$to_key]] = "";

			if(empty($objUpFile->temp_file[$arrImageKey[$to_key]])
			&& empty($objUpFile->save_file[$arrImageKey[$to_key]])) {
				// リネームする際は、自動生成される画像名に一意となるように、Suffixを付ける
				$dst_file = $objUpFile->lfGetTmpImageName(IMAGE_RENAME, "", $objUpFile->temp_file[$arrImageKey[$from_key]]) . $this->lfGetAddSuffix($to_key);
				$path = $objUpFile->makeThumb($from_path, $to_w, $to_h, $dst_file);
				$objUpFile->temp_file[$arrImageKey[$to_key]] = basename($path);
			}
		}
	}

	// リネームする際は、自動生成される画像名に一意となるように、Suffixを付ける
	function lfGetAddSuffix($to_key){
		if( IMAGE_RENAME === true ){ return ; }

		// 自動生成される画像名
		$dist_name = "";
		switch($to_key){
			case "portfolio_main_image":
				$dist_name = '_m';
				break;
			default:
			$arrRet = explode('sub_image', $to_key);
			$dist_name = '_sub' .$arrRet[1];
			break;
		}
		return $dist_name;
	}

	// 事例一覧の取得
	function lfListPortfolio() {
		$objQuery =& SC_Query_Ex::getSingletonInstance();

		$arrval = array();
		$where = "";

		//カテゴリで絞り込み
		$portfolio_category_id = $this->objFormParam->getValue("search_portfolio_category_id");
		if(!empty($portfolio_category_id)){
			$where .= "portfolio_category_id=? AND ";
			$arrval[] = $portfolio_category_id;
		}

		$col = "*";
		$where .= "del_flg = 0";
		$objQuery->setoption("ORDER BY rank DESC");
		$arrRet = $objQuery->select($col, "dtb_portfolio", $where, $arrval);
		return $arrRet;
	}

	// 事例カテゴリ一覧の取得
	function lfListPortfolioCat() {
		$arrCategory = array();
		$objQuery =& SC_Query_Ex::getSingletonInstance();

		$col = "*";
		$where = "del_flg = 0";
		$objQuery->setoption("ORDER BY rank DESC");
		$arrRet = $objQuery->select($col, "dtb_portfolio_category", $where);
		
		foreach($arrRet as $row){
			$arrCategory[$row["portfolio_category_id"]] = $row['portfolio_category_name'];
		}
		return $arrCategory;
	}

	// 事例詳細の取得
	function lfGetPortfoilo($portfolio_id){
		$objQuery =& SC_Query_Ex::getSingletonInstance();
		$arrRet = array();

		$col = "*";
		$where = "portfolio_id = ? AND del_flg = 0";
		$arrRet = $objQuery->select($col, "dtb_portfolio", $where, array($portfolio_id));
		if(is_array($arrRet) && is_array($arrRet[0]))
		$arrRet = $arrRet[0];

		return $arrRet;
	}

	// 事例の新規追加
	function lfRegisterPortfolio(){
		$portfolio_id = $this->objFormParam->getValue("portfolio_id");
		$objQuery =& SC_Query_Ex::getSingletonInstance();
		$objQuery->begin(); // トランザクションの開始

		// 入力データを渡す。
		$arrColumn = $objQuery->listTableFields('dtb_portfolio');
		$sqlval = SC_Utils_Ex::sfArrayIntersectKeys($this->objFormParam->getHashArray(), $arrColumn);
		$sqlval['creator_id'] = $_SESSION['member_id'];

		//画像追加
		$arrRet = $this->objUpFile->getDBFileList();
		$sqlval = array_merge($sqlval, $arrRet);
		
		// INSERTの実行
		if(empty($portfolio_id)){
			// 最大のランクを取得する。
			$rank = $objQuery->max("rank", "dtb_portfolio");
			if ( empty($rank) ) {
				$rank = 1;
			} else {
				$rank += 1;
			}
			$sqlval['rank'] = $rank;
			unset($sqlval["portfolio_id"]);
			
			$objQuery->insert("dtb_portfolio", $sqlval);
		}
		// UPDATEの実行
		else{
			$sqlval['update_date'] = "now()";
			$where = "portfolio_id = ? AND del_flg = 0";
			$objQuery->update("dtb_portfolio", $sqlval, $where, array($portfolio_id));
		}

		$objQuery->commit();    // トランザクションの終了
	}

}
?>
