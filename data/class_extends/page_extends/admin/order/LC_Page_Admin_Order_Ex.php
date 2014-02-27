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
require_once CLASS_REALDIR . 'pages/admin/order/LC_Page_Admin_Order.php';

/**
 * 受注管理 のページクラス(拡張).
 *
 * LC_Page_Admin_Order をカスタマイズする場合はこのクラスを編集する.
 *
 * @package Page
 * @author LOCKON CO.,LTD.
 * @version $Id: LC_Page_Admin_Order_Ex.php 22796 2013-05-02 09:11:36Z h_yoshimoto $
 */
class LC_Page_Admin_Order_Ex extends LC_Page_Admin_Order {

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
                $this->doDelete('order_id = ?',
                                array($objFormParam->getValue('order_id')));
                // 削除後に検索結果を表示するため breakしない

            // 検索パラメーター生成後に処理実行するため breakしない
            case 'csv':
            case 'delete_all':

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

                    // 受注一覧のソートを設定する
                    $order_key = $_POST["sortkey"];
                    if(empty($order_key)) $order_key = "update_date";
                    $order = empty($_POST["sort"]) ? "DESC" : "ASC";
                    $order = "CASE WHEN {$order_key} IS NULL THEN 1 ELSE 0 END, ". $order_key. " ". $order;

                    /* -----------------------------------------------
                     * 処理を実行
                     * ----------------------------------------------- */
                    switch ($this->getMode()) {
                        // CSVを送信する。
                        case 'csv':
                            $this->doOutputCSV($where, $arrWhereVal, $order);

                            SC_Response_Ex::actionExit();
                            break;

                        // 全件削除(ADMIN_MODE)
                        case 'delete_all':
                            $this->doDelete($where, $arrWhereVal);
                            break;

                        // 検索実行
                        default:
                            // 行数の取得
                            $this->tpl_linemax = $this->getNumberOfLines($where, $arrWhereVal);
                            // ページ送りの処理
                            $page_max = SC_Utils_Ex::sfGetSearchPageMax($objFormParam->getValue('search_page_max'));
                            // ページ送りの取得
                            $objNavi = new SC_PageNavi_Ex($this->arrHidden['search_pageno'],
                                                          $this->tpl_linemax, $page_max,
                                                          'fnNaviSearchPage', NAVI_PMAX);
                            $this->arrPagenavi = $objNavi->arrPagenavi;

                            // 検索結果の取得
                            $this->arrResults = $this->findOrders($where, $arrWhereVal,
                                                                  $page_max, $objNavi->start_row, $order);
                            break;
                    }
                }
                break;
            default:
                break;
        }

    }
}
