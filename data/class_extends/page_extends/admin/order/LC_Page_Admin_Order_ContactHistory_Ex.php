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
 * 問い合わせ履歴管理 のページクラス(拡張).
 *
 * LC_Page_Admin_Order_ContactHistory_Ex をカスタマイズする場合はこのクラスを編集する.
 *
 * @package Page
 * @author min.si
 */
class LC_Page_Admin_Order_ContactHistory_Ex extends LC_Page_Admin_Ex {

    // {{{ functions

    /**
     * Page を初期化する.
     *
     * @return void
     */
    function init() {
        parent::init();
        $this->tpl_mainpage = 'order/contact_history.tpl';
        $this->tpl_mainno = 'order';
        $this->tpl_subno = 'contact_history';
        $this->tpl_pager = 'pager.tpl';
        $this->tpl_maintitle = '問い合わせ履歴';
        $this->tpl_subtitle = '問い合わせ履歴';

        $masterData = new SC_DB_MasterData_Ex();
        $this->arrCONTACT_TYPE = $masterData->getMasterData('mtb_contact_type');
        $this->arrCONTACT_STATUS = $masterData->getMasterData('mtb_contact_status');
        $this->arrCONTACT_STATUS_COLOR = $masterData->getMasterData('mtb_contact_status_color');
		$this->arrPageMax = $masterData->getMasterData('mtb_page_max');
		
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
    	$this->arrHidden = $objFormParam->getSearchArray();
    	$this->arrForm = $objFormParam->getFormParamList();

    	switch ($this->getMode()) {
    		// 削除
    		case 'delete':
    			$this->doDelete('contact_id = ?',
    			array($objFormParam->getValue('contact_id')));
    			// 削除後に検索結果を表示するため breakしない

    			// 検索パラメーターの生成
    		case 'search':
    			$objFormParam->convParam();
    			$objFormParam->trimParam();
    			$this->arrErr = $this->lfCheckError($objFormParam);
    			$arrParam = $objFormParam->getHashArray();

    			if (count($this->arrErr) == 0) {
    				$where = 'del_flg = 0';
    				$arrWhereVal = array();
    				foreach ($arrParam as $key => $val) {
    					if ($val == '') {
    						continue;
    					}
    					$this->buildQuery($key, $where, $arrWhereVal, $objFormParam);
    				}

    				$order = 'update_date DESC';

    				// 行数の取得
    				$this->tpl_linemax = $this->getNumberOfLines($where, $arrWhereVal);
    				// ページ送りの処理
    				$page_max = SC_Utils_Ex::sfGetSearchPageMax($objFormParam->getValue('search_page_max'));
    				// ページ送りの取得
    				$objNavi = new SC_PageNavi_Ex($this->arrHidden['search_pageno'],
    					$this->tpl_linemax, $page_max,'fnNaviSearchPage', NAVI_PMAX);
    				$this->arrPagenavi = $objNavi->arrPagenavi;

    				// 検索結果の取得
    				$this->arrResults = $this->findOrders($where, $arrWhereVal,
    				$page_max, $objNavi->start_row, $order);
    			}
    			break;
    		default:
    			break;
    	}

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
     * パラメーター情報の初期化を行う.
     *
     * @param SC_FormParam $objFormParam SC_FormParam インスタンス
     * @return void
     */
    function lfInitParam(&$objFormParam) {
        $objFormParam->addParam('送信番号1', 'search_contact_id1', INT_LEN, 'n', array('MAX_LENGTH_CHECK', 'NUM_CHECK'));
        $objFormParam->addParam('注文番号2', 'search_contact_id2', INT_LEN, 'n', array('MAX_LENGTH_CHECK', 'NUM_CHECK'));
        $objFormParam->addParam('メール種別', 'search_contact_type', INT_LEN, 'n', array('MAX_LENGTH_CHECK', 'NUM_CHECK'));
        $objFormParam->addParam('対応状況', 'search_status', INT_LEN, 'n', array('MAX_LENGTH_CHECK', 'NUM_CHECK'));
        $objFormParam->addParam('ページ送り番号','search_pageno', INT_LEN, 'n', array('MAX_LENGTH_CHECK', 'NUM_CHECK'));
     	$objFormParam->addParam('表示件数', 'search_page_max', INT_LEN, 'n', array('MAX_LENGTH_CHECK', 'NUM_CHECK'));
        
        $objFormParam->addParam('送信番号', 'contact_id', INT_LEN, 'n', array('MAX_LENGTH_CHECK', 'NUM_CHECK'));
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

        // 相関チェック
        $objErr->doFunc(array('送信番号1', '送信番号2', 'contact_id1', 'contact_id2'), array('GREATER_CHECK'));

        return $objErr->arrErr;
    }

    /**
     * クエリを構築する.
     *
     * 検索条件のキーに応じた WHERE 句と, クエリパラメーターを構築する.
     * クエリパラメーターは, SC_FormParam の入力値から取得する.
     *
     * 構築内容は, 引数の $where 及び $arrValues にそれぞれ追加される.
     *
     * @param string $key 検索条件のキー
     * @param string $where 構築する WHERE 句
     * @param array $arrValues 構築するクエリパラメーター
     * @param SC_FormParam $objFormParam SC_FormParam インスタンス
     * @return void
     */
    function buildQuery($key, &$where, &$arrValues, &$objFormParam) {
        $dbFactory = SC_DB_DBFactory_Ex::getInstance();
        switch ($key) {

            case 'search_contact_id1':
                $where .= ' AND contact_id >= ?';
                $arrValues[] = sprintf('%d', $objFormParam->getValue($key));
                break;
            case 'search_contact_id2':
                $where .= ' AND contact_id <= ?';
                $arrValues[] = sprintf('%d', $objFormParam->getValue($key));
                break;
            case 'search_contact_type':
                $where.= ' AND contact_type = ?';
                $arrValues[] = $objFormParam->getValue($key);
                break;
            case 'search_status':
                $where.= ' AND status = ?';
                $arrValues[] = $objFormParam->getValue($key);
                break;
            default:
                break;
        }
    }

    /**
     * 問い合わせ履歴を削除する.
     *
     * @param string $where 削除対象の WHERE 句
     * @param array $arrParam 削除対象の値
     * @return void
     */
    function doDelete($where, $arrParam = array()) {
        $objQuery =& SC_Query_Ex::getSingletonInstance();
        $sqlval['del_flg']     = 1;
        $sqlval['update_date'] = 'CURRENT_TIMESTAMP';
        $objQuery->update('dtb_contact_history', $sqlval, $where, $arrParam);
    }
    
    /**
     * 検索結果の行数を取得する.
     *
     * @param string $where 検索条件の WHERE 句
     * @param array $arrValues 検索条件のパラメーター
     * @return integer 検索結果の行数
     */
    function getNumberOfLines($where, $arrValues) {
        $objQuery =& SC_Query_Ex::getSingletonInstance();
        return $objQuery->count('dtb_contact_history', $where, $arrValues);
    }

    /**
     * 問い合わせ履歴を検索する.
     *
     * @param string $where 検索条件の WHERE 句
     * @param array $arrValues 検索条件のパラメーター
     * @param integer $limit 表示件数
     * @param integer $offset 開始件数
     * @param string $order 検索結果の並び順
     * @return array 受注の検索結果
     */
    function findOrders($where, $arrValues, $limit, $offset, $order) {
        $objQuery =& SC_Query_Ex::getSingletonInstance();
        $objQuery->setLimitOffset($limit, $offset);
        $objQuery->setOrder($order);
        return $objQuery->select('*', 'dtb_contact_history', $where, $arrValues);
    }
}
