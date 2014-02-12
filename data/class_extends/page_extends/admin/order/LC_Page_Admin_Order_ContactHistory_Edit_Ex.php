<?php
/*
 * This file is part of EC-CUBE
 *
 * Copyright(c) 2000-2013 LOCKON CO.,LTD. All Rights Reserved.
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
 * 問い合わせ履歴編集画面 のページクラス(拡張).
 *
 * LC_Page_Admin_Order_ContactHistory_Edit_Ex をカスタマイズする場合はこのクラスを編集する.
 *
 * @package Page
 * @author min.si
 */
class LC_Page_Admin_Order_ContactHistory_Edit_Ex extends LC_Page_Admin_Ex {

    // {{{ functions

    /**
     * Page を初期化する.
     *
     * @return void
     */
    function init() {
        parent::init();
        $this->tpl_mainpage = 'order/contact_history_edit.tpl';
        $this->tpl_mainno = 'order';
        $this->tpl_subno = 'contact_history_edit';
        $this->tpl_pager = 'pager.tpl';
        $this->tpl_maintitle = '問い合わせ履歴編集';
        $this->tpl_subtitle = '問い合わせ履歴編集';

        $masterData = new SC_DB_MasterData_Ex();
        $this->arrCONTACT_TYPE = $masterData->getMasterData('mtb_contact_type');
        $this->arrCONTACT_STATUS = $masterData->getMasterData('mtb_contact_status');
        $this->arrCONTACT_STATUS_COLOR = $masterData->getMasterData('mtb_contact_status_color');
		
        $this->httpCacheControl('nocache');
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

    	$objFormParam = new SC_FormParam_Ex();
    	$this->lfInitParam($objFormParam);
    	$objFormParam->setParam($_POST);
    	$objFormParam->convParam();
    	
    	$this->arrHidden = $objFormParam->getSearchArray();
    	$this->arrForm = $objFormParam->getFormParamList();
    	$contact_id = $objFormParam->getValue('contact_id');
    	
    	switch ($this->getMode()) {
    		case 'pre_edit':
    			break;
    		case 'edit':
    			$this->arrErr = $this->lfCheckError($objFormParam);
    			if (SC_Utils_Ex::isBlank($this->arrErr)) {
    				$message = '問い合わせ履歴を編集しました。';
    				$this->doUpdate($contact_id, $objFormParam);
    				$this->tpl_onload = "window.alert('" . $message . "');";
    			}
    			break;
    		default:
    			break;
    	}
    	
    	$this->arrDisp = $this->getContactDetail($contact_id);
    	
    	// フォームを更新する
    	$objFormParam->setParam($this->arrDisp);
    	$objFormParam->convParam();
    	$this->arrForm = $objFormParam->getFormParamList();
    }

    /**
     * デストラクタ.
     *
     * @return void
     */
    function destroy() {
        parent::destroy();
    }

    function doUpdate($contact_id, &$objFormParam){
    	$sqlval = array();
    	$sqlval['status'] = $objFormParam->getValue('status');
     	$sqlval['update_date'] = 'now()';

    	$objQuery =& SC_Query_Ex::getSingletonInstance();
    	$objQuery->update("dtb_contact_history", $sqlval, "contact_id=? AND del_flg=0", array($contact_id));
    }
    
    function getContactDetail($contact_id){
    	$objQuery =& SC_Query_Ex::getSingletonInstance();
    	return $objQuery->getRow("*", "dtb_contact_history", "contact_id=? AND del_flg=0", array($contact_id));
    }
    
    /**
     * パラメーター情報の初期化を行う.
     *
     * @param SC_FormParam $objFormParam SC_FormParam インスタンス
     * @return void
     */
    function lfInitParam(&$objFormParam) {        
        $objFormParam->addParam('送信番号', 'contact_id', INT_LEN, 'n', array('MAX_LENGTH_CHECK', 'NUM_CHECK'));
        $objFormParam->addParam('対応状況', 'status', INT_LEN, 'n', array('MAX_LENGTH_CHECK', 'NUM_CHECK'));
        
        $objFormParam->addParam('送信番号1', 'search_contact_id1', INT_LEN, 'n', array('MAX_LENGTH_CHECK', 'NUM_CHECK'));
        $objFormParam->addParam('注文番号2', 'search_contact_id2', INT_LEN, 'n', array('MAX_LENGTH_CHECK', 'NUM_CHECK'));
        $objFormParam->addParam('メール種別', 'search_contact_type', INT_LEN, 'n', array('MAX_LENGTH_CHECK', 'NUM_CHECK'));
        $objFormParam->addParam('対応状況', 'search_status', INT_LEN, 'n', array('MAX_LENGTH_CHECK', 'NUM_CHECK'));
        $objFormParam->addParam('ページ送り番号','search_pageno', INT_LEN, 'n', array('MAX_LENGTH_CHECK', 'NUM_CHECK'));
        $objFormParam->addParam('表示件数', 'search_page_max', INT_LEN, 'n', array('MAX_LENGTH_CHECK', 'NUM_CHECK'));
    }

    /**
     * 入力内容のチェックを行う.
     *
     * @param SC_FormParam $objFormParam SC_FormParam インスタンス
     * @return void
     */
    function lfCheckError(&$objFormParam) {
        $objErr = new SC_CheckError_Ex($objFormParam->getHashArray());
        $objErr->arrErr = $objFormParam->checkError();

        return $objErr->arrErr;
    }
}
