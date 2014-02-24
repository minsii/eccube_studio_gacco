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
require_once CLASS_REALDIR . 'pages/admin/basis/LC_Page_Admin_Basis.php';

/**
 * 店舗基本情報 のページクラス(拡張).
 *
 * LC_Page_Admin_Basis をカスタマイズする場合はこのクラスを編集する.
 *
 * @package Page
 * @author LOCKON CO.,LTD.
 * @version $Id: LC_Page_Admin_Basis_Ex.php 22796 2013-05-02 09:11:36Z h_yoshimoto $
 */
class LC_Page_Admin_Basis_Ex extends LC_Page_Admin_Basis {

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
    
    
    // 基本情報用のカラムを取り出す。
    function lfGetCol() {
        $arrCol = parent::lfGetCol();
        
    	/*## メール転送設定 ADD BEGIN ##*/
    	if(USE_ORDER_MAIL_FWD === true){
    		$arrCol[] = "email01_fw";
    	}
    	if(USE_CONTACT_MAIL_FWD === true){
    		$arrCol[] = "email02_fw";
    	}
    	/*## メール転送設定 ADD END ##*/
    	
        return $arrCol;
    }
    
    function lfInitParam(&$objFormParam, $post) {
		parent::lfInitParam($objFormParam, $post);
		
    	/*## メール転送設定 ADD BEGIN ##*/
    	if(USE_ORDER_MAIL_FWD === true){
    		$objFormParam->addParam('商品注文受付(転送)メールアドレス', 'email01_fw', null, 'a', array());
    	}
    	if(USE_CONTACT_MAIL_FWD === true){
    		$objFormParam->addParam('問い合わせ受付(転送)メールアドレス', 'email02_fw', null, 'a', array());
    	}
    	/*## メール転送設定 ADD END ##*/
    }
    

    // 入力エラーチェック
    function lfCheckError(&$objFormParam) {
        $arrErr = parent::lfCheckError($objFormParam);
        
        $post = $objFormParam->getHashArray();
        $objErr = new SC_CheckError_Ex($post);

        /*## メール転送設定 ADD BEGIN ##*/
        if(USE_ORDER_MAIL_FWD === true && !empty($post["email01_fw"])){
        	$objErr->doFunc(array('商品注文受付(転送)メールアドレス', 'email01_fw', ',', 'EXIST_CHECK', 'EMAIL_CHECK', 'EMAIL_CHAR_CHECK'), array('MULTIPLE_SUB_CHECK'));
        }
        if(USE_CONTACT_MAIL_FWD === true && !empty($post["email02_fw"])){
        	$objErr->doFunc(array('問い合わせ受付(転送)メールアドレス', 'email02_fw', ',' ,'EXIST_CHECK', 'EMAIL_CHECK', 'EMAIL_CHAR_CHECK'), array('MULTIPLE_SUB_CHECK'));
        }
        /*## メール転送設定 ADD END ##*/

        return array_merge((array)$arrErr, (array)$objErr->arrErr);
    }
}
