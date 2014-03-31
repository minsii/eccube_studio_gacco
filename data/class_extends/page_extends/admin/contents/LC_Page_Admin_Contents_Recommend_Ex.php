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
require_once CLASS_REALDIR . 'pages/admin/contents/LC_Page_Admin_Contents_Recommend.php';

/**
 * おすすめ商品管理 のページクラス(拡張).
 *
 * LC_Page_Admin_Contents_Recommend をカスタマイズする場合はこのクラスを編集する.
 *
 * @package Page
 * @author LOCKON CO.,LTD.
 * @version $Id: LC_Page_Admin_Contents_Recommend_Ex.php 22796 2013-05-02 09:11:36Z h_yoshimoto $
 */
class LC_Page_Admin_Contents_Recommend_Ex extends LC_Page_Admin_Contents_Recommend {

    // }}}
    // {{{ functions

    /**
     * Page を初期化する.
     *
     * @return void
     */
    function init() {
        parent::init();
        
        /* ## トップおすすめ商品 ADD BEGIN ## */
        $masterData = new SC_DB_MasterData_Ex();
        if (USE_RECOMMEND_KIND === true) {
            $this->arrRECOMMEND_KIND_NAME = $masterData->getMasterData("mtb_recommend_kind_name");
            $this->arrRECOMMEND_KIND_NUM = $masterData->getMasterData("mtb_recommend_kind_num");
            
            $max = 0;
            $this->arrRECOMMEND_KIND_LOOP_MAX = array();
            foreach ( $this->arrRECOMMEND_KIND_NUM as $id => $num ) {
                $max += $num;
                $this->arrRECOMMEND_KIND_LOOP_MAX[$id] = $max;
            }
        }
        /* ## トップおすすめ商品 ADD END ## */
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

    function action() {
        parent::action();

        /* ## トップおすすめ商品 ADD BEGIN ## */
        if (USE_RECOMMEND_KIND === true && ! empty($_POST["rank"])) {
            $this->tpl_onload .= "location.hash='#pdct_" . $_POST["rank"] . "';";
        }
        /* ## トップおすすめ商品 ADD END ## */
    }
}
