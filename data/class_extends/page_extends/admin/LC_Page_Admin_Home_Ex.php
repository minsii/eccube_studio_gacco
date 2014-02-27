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
require_once CLASS_REALDIR . 'pages/admin/LC_Page_Admin_Home.php';

/**
 * 管理画面ホーム のページクラス(拡張).
 *
 * LC_Page_Admin_Home をカスタマイズする場合はこのクラスを編集する.
 *
 * @package Page
 * @author LOCKON CO.,LTD.
 * @version $Id: LC_Page_Admin_Home_Ex.php 22796 2013-05-02 09:11:36Z h_yoshimoto $
 */
class LC_Page_Admin_Home_Ex extends LC_Page_Admin_Home {

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
    
    function action(){
    	parent::action();
    	
    	/*## 店舗作成予定日 ADD BEGIN ##*/
    	if(USE_ORDER_MAKE_DATE === true){
    		$this->arrMakeOrder = $this->lfGetMakeOrder();
    		$this->make_order_num = count($this->arrMakeOrder);
    	}
    	/*## 店舗作成予定日 ADD END ##*/
    	
    	$this->new_order_num = count($this->arrNewOrder);
    }
    
    /*## 店舗作成予定日 ADD BEGIN ##*/
    /**
     * 本日制作受注一覧の取得
     *
     */
    function lfGetMakeOrder() {
        $objQuery =& SC_Query_Ex::getSingletonInstance();

        $sql = <<< __EOS__
            SELECT
                ord.order_id,
                ord.customer_id,
                ord.order_name01 AS name01,
                ord.order_name02 AS name02,
                ord.total,
                ord.create_date,
                (SELECT
                    det.product_name
                FROM
                    dtb_order_detail AS det
                WHERE
                    ord.order_id = det.order_id
                ORDER BY det.order_detail_id
                LIMIT 1
                ) AS product_name
            FROM (
                SELECT
                    order_id,
                    customer_id,
                    order_name01,
                    order_name02,
                    total,
                    create_date,
                    make_date
                FROM
                    dtb_order AS ord
                WHERE
                    del_flg = 0 AND make_date = ?
                ORDER BY
                    create_date DESC LIMIT 10 OFFSET 0
            ) AS ord
__EOS__;
        $arrOrder = $objQuery->getAll($sql, array(date("Y-m-d")));

        return $arrOrder;
    }
    /*## 店舗作成予定日 ADD END ##*/
}
