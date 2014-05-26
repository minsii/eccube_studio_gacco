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
require_once CLASS_REALDIR . 'pages/frontparts/bloc/LC_Page_FrontParts_Bloc_Recommend.php';

/**
 * Recommend のページクラス(拡張).
 *
 * LC_Page_FrontParts_Bloc_Recommend をカスタマイズする場合はこのクラスを編集する.
 *
 * @package Page
 * @author LOCKON CO.,LTD.
 * @version $Id: LC_Page_FrontParts_Bloc__Ex.php -1   $
 */
class LC_Page_FrontParts_Bloc_Recommend_Ex extends LC_Page_FrontParts_Bloc_Recommend {
    
    /* ## トップおすすめ商品 ADD BEGIN ## */
    var $rank_min;
    var $rank_max;
    /*## トップおすすめ商品 ADD END ##*/
    
    
    // }}}
    // {{{ functions

    /**
     * Page を初期化する.
     *
     * @return void
     */
    function init() {
        parent::init();
        
        $masterData = new SC_DB_MasterData_Ex();
        /*## トップおすすめ商品 ADD BEGIN ##*/
        if(USE_RECOMMEND_KIND === true){
            $this->arrRECOMMEND_KIND_NUM = $masterData->getMasterData("mtb_recommend_kind_num");
        }
        /*## トップおすすめ商品 ADD END ##*/
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
        
        // 基本情報を渡す
        $objSiteInfo = SC_Helper_DB_Ex::sfGetBasisData();
        $this->arrInfo = $objSiteInfo->data;
        
        // おすすめ商品表示
        $this->arrBestProducts1 = $this->lfGetRanking(1);
        $this->arrBestProducts2 = $this->lfGetRanking(2);
    }
    
    /**
     * おすすめ商品検索.
     * 
     * @return array $arrBestProducts 検索結果配列
     */
    function lfGetRanking($rcmd_kind_id) {
        $objQuery = & SC_Query_Ex::getSingletonInstance();
        $objProduct = new SC_Product_Ex();
            
        // 最小ランクと最大ランクを取得
        $id = 1;
        $this->rank_min = 1;
        while ( $id < $rcmd_kind_id )
            $this->rank_min += $this->arrRECOMMEND_KIND_NUM[$id++];
        $this->rank_max = $this->rank_min + $this->arrRECOMMEND_KIND_NUM[$rcmd_kind_id];
        
        // おすすめ商品取得
        $col = 'best_id, category_id, rank, product_id, title, comment, create_date, update_date';
        $table = 'dtb_best_products';
        
        /* ## トップおすすめ商品 ADD BEGIN ## */
        $arrval = array();
        $where = " rank >= ? AND rank < ? AND ";
        $arrval[] = $this->rank_min;
        $arrval[] = $this->rank_max;
        /* ## トップおすすめ商品 ADD END ## */
        
        $where .= 'del_flg = 0';
        $objQuery->setOrder('rank');
        
        $objQuery->setLimit(RECOMMEND_NUM);
        
        $arrBestProducts = $objQuery->select($col, $table, $where, $arrval);
        
        $objQuery = & SC_Query_Ex::getSingletonInstance();
        if (count($arrBestProducts) > 0) {
            // 商品一覧を取得
            // where条件生成&セット
            $arrProductId = array();
            $where = 'product_id IN (';
            foreach ( $arrBestProducts as $key => $val ) {
                $arrProductId[] = $val['product_id'];
            }
            // 取得
            $arrTmp = $objProduct->getListByProductIds($objQuery, $arrProductId);
            foreach ( $arrTmp as $key => $arrRow ) {
                $arrProductList[$arrRow['product_id']] = $arrRow;
                $arrProductList[$arrRow['product_id']]["status"] = array();
            }
            
            /* ## トップおすすめ商品 ADD BEGIN ## */
            // 商品ステータス
            $arrTmp = $objProduct->getProductStatus($arrProductId);
            foreach ( $arrTmp as $id => $status ) {
                $arrProductList[$id]["status"] = $status;
            }
            /* ## トップおすすめ商品 ADD END ## */
            
            // おすすめ商品情報にマージ
            foreach ( array_keys($arrBestProducts) as $key ) {
                $arrRow = & $arrBestProducts[$key];
                if (isset($arrProductList[$arrRow['product_id']])) {
                    $arrRow = array_merge($arrRow, $arrProductList[$arrRow['product_id']]);
                } else {
                    // 削除済み商品は除外
                    unset($arrBestProducts[$key]);
                }
            }
        }
        return $arrBestProducts;
    }
}
