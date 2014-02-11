<?php
/*
 * This file is part of EC-CUBE
 *
 * Copyright(c) 2000-2010 LOCKON CO.,LTD. All Rights Reserved.
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
require_once CLASS_EX_REALDIR . 'page_extends/mypage/LC_Page_AbstractMypage_Ex.php';

/**
 * 記念日登録 のページクラス(拡張).
 *
 * @package Page
 * @author m.si
 */
class LC_Page_Mypage_Anniversary_Ex extends LC_Page_AbstractMypage_Ex {

	// }}}
	// {{{ functions

	/**
	 * Page を初期化する.
	 *
	 * @return void
	 */
	function init() {
		parent::init();
		
		$this->tpl_subtitle = '記念日登録';
        $this->tpl_mypageno = 'anniversary';
        
        $objDate = new SC_Date_Ex();
		$this->arrMonth = $objDate->getMonth();
		$this->arrDay = $objDate->getDay();
		
		$masterData = new SC_DB_MasterData_Ex();
		$this->arrEvent = $masterData->getMasterData("mtb_anniversary_event");
		
        $this->httpCacheControl('nocache');
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
     * Page のプロセス
     * @return void
     */
    function action() {

        $objCustomer = new SC_Customer_Ex();
        $customerId = $objCustomer->getValue('customer_id');

		$mode = isset($_POST['mode']) ? $_POST['mode'] : '';
		
		$this->initParam();
		$this->objForm->setParam($_POST);
		$this->objForm->convParam();
		
		switch($mode) {
			//削除要求
			case 'delete':
				$this->arrForm = $this->objForm->getHashArray();

				$arrErr = $this->lfDeleteErrorCheck();
				
				if (is_array($arrErr) && count($arrErr)){
					SC_Utils_Ex::sfDispSiteError(CUSTOMER_ERROR);
					exit;
				}
				$this->lfDeleteAnniversary($customerId);
				break;
				//更新
			case 'update':
				$this->arrForm = $this->objForm->getHashArray();

				$this->arrErr = $this->objForm->checkError();
				if (!count($this->arrErr)){
					$this->lfRegistData($customerId);
					$this->arrForm = array();//reset
				}
				break;
				//編集要求		
			case 'pre_edit':
				$this->is_edit_mode = 1;
				$this->arrForm = $this->lfGetAnniversary($customerId);
				if(!is_array($this->arrForm)){
					SC_Utils_Ex::sfDispSiteError(CUSTOMER_ERROR);
					exit;
				}
				break;

			default:
				break;
		}

		// 記念日一覧情報取得
		$this->lfGetAnniversaryList($customerId);
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
	 * フォームパラメータの初期化
	 *
	 * @return SC_FormParam
	 */
	function initParam() {
		$objForm = new SC_FormParam();
		$objForm->addParam('記念日ID', 'anniversary_id', INT_LEN, '', array('NUM_CHECK'));
		$objForm->addParam('日付(月)', 'dt_month', INT_LEN, '', array('SELECT_CHECK', 'NUM_CHECK'));
		$objForm->addParam('日付(日)', 'dt_day', INT_LEN, '', array('SELECT_CHECK', 'NUM_CHECK'));
		$objForm->addParam('お名前', 'name', STEXT_LEN, '', array('EXIST_CHECK', 'MAX_LENGTH_CHECK'));
		$objForm->addParam('イベント', 'event_id', INT_LEN, '', array('NUM_CHECK'));
		$objForm->addParam('メモ', 'memo', MTEXT_LEN, '', array('MAX_LENGTH_CHECK'));
		
		$this->objForm = $objForm;
	}

	function lfDeleteErrorCheck(){
		$array = $this->objForm->getHashArray();
		$objErr = new SC_CheckError($array);
			
		$objErr->doFunc(array("記念日ID", "anniversary_id"), array("EXIST_CHECK"));

		return $objErr->arrErr;
	}

	/**
	 * 記念日情報を取得する
	 *
	 * @param $customerId
	 * @return array
	 */
	function lfGetAnniversary($customerId){
		$objQuery = new SC_Query();

		$arrval = array($this->objForm->getValue('anniversary_id'), $customerId);
		$result = $objQuery->select("*", "dtb_anniversary", "anniversary_id = ? AND customer_id = ? AND del_flg = 0", $arrval);

		return $result[0];
	}

	/**
	 * 顧客の記念日情報一覧を取得する
	 *
	 * @param $customerId
	 * @return array
	 */
	function lfGetAnniversaryList($customerId){
		$objQuery = new SC_Query();
		$where = "customer_id = ? AND del_flg = 0";
		$arrval = array($customerId);

		$this->tpl_linemax = $objQuery->count("dtb_anniversary", $where, $arrval);

		$objQuery->setOrder('rank');
		$this->arrList = $objQuery->select("*", "dtb_anniversary", $where, $arrval);
	}

	/**
	 * 記念日情報を削除する
	 *
	 * @param $anniversary_id
	 */
	function lfDeleteAnniversary($anniversary_id){
		$objQuery = new SC_Query();

		$sqlval = array("del_flg" => 1);
		$objQuery->update("dtb_anniversary", $sqlval, "anniversary_id = ?", array($this->objForm->getValue('anniversary_id')));
	}

	/**
	 * 記念日情報を登録する
	 *
	 * @param $customerId
	 */
	function lfRegistData($customerId){
		$array = $this->objForm->getDbArray();
		$objQuery = new SC_Query();

		$sqlval = array();
		$sqlval["customer_id"] = $customerId;
		$sqlval["dt_month"] = $array["dt_month"];
		$sqlval["dt_day"] = $array["dt_day"];
		$sqlval["name"] = $array["name"];
		$sqlval["event_id"] = $array["event_id"];
		$sqlval["memo"] = $array["memo"];

		//- insert
		if(empty($array["anniversary_id"])){
			//get rank
			$sqlval["rank"] = $objQuery->getOne("SELECT MAX(rank)+1 FROM dtb_anniversary WHERE customer_id=?", array($customerId));
			if(empty($sqlval["rank"])) $sqlval["rank"] = '1';//first
				
			$sqlval["create_date"] = "now()";
			$sqlval["update_date"] = "now()";
			$objQuery->insert("dtb_anniversary", $sqlval);
		}
		//- update
		else{
			$sqlval["update_date"] = "now()";
			$objQuery->update("dtb_anniversary", $sqlval, "anniversary_id = ?", array($array["anniversary_id"]));
		}
	}
}
?>
