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
require_once CLASS_REALDIR . 'pages/admin/contents/LC_Page_Admin_Contents.php';

/**
 * コンテンツ管理 のページクラス(拡張).
 *
 * LC_Page_Admin_Contents をカスタマイズする場合はこのクラスを編集する.
 *
 * @package Page
 * @author LOCKON CO.,LTD.
 * @version $Id: LC_Page_Admin_Contents_Ex.php 22796 2013-05-02 09:11:36Z h_yoshimoto $
 */
class LC_Page_Admin_Contents_Ex extends LC_Page_Admin_Contents {

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
        if (USE_NEWS_IMAGE === true) {
            // ファイル管理クラス
            $this->objUpFile = new SC_UploadFile_Ex(IMAGE_TEMP_REALDIR, IMAGE_SAVE_REALDIR);
            $this->lfInitFile();
            $this->objUpFile->setHiddenFileList($_POST);
        }
        
        parent::action();
        
        if (USE_NEWS_IMAGE === true) {
            $objFormParam = new SC_FormParam_Ex();
            $this->lfInitParam($objFormParam);
            $objFormParam->setParam($_POST);
            $objFormParam->convParam();
            
            switch ($this->getMode()) {
                case "upload_image" :
                    
                    $this->arrForm = $objFormParam->getHashArray();
                    
                    // ファイル存在チェック
                    $this->arrErr = array($this->objUpFile->checkEXISTS("image"));
                    
                    // 画像保存処理
                    $this->arrErr["image"] = $this->objUpFile->makeTempFile("image", IMAGE_RENAME);
                    // 中、小画像生成
                    $this->lfMakeScaleImage($this->objUpFile, "image", "image");
                    
                    // アップロードファイル情報取得(Hidden用)
                    $this->arrHidden = $this->objUpFile->getHiddenFileList();
                    // 画像ファイル表示用データ取得
                    $this->arrFile = $this->objUpFile->getFormFileList(IMAGE_TEMP_URLPATH,
                            IMAGE_SAVE_URLPATH);
                    break;
                // 画像の削除
                case 'delete_image' :
                    $this->objUpFile->deleteFile('image');
                    $this->arrForm = $objFormParam->getHashArray();
                    
                    // アップロードファイル情報取得(Hidden用)
                    $this->arrHidden = $this->objUpFile->getHiddenFileList();
                    // 画像ファイル表示用データ取得
                    $this->arrFile = $this->objUpFile->getFormFileList(IMAGE_TEMP_URLPATH,
                            IMAGE_SAVE_URLPATH);
                    break;
                case 'search':
                    $this->objUpFile->setDBFileList($this->arrForm);
                    
                    // アップロードファイル情報取得(Hidden用)
                    $this->arrHidden = $this->objUpFile->getHiddenFileList();
                    // 画像ファイル表示用データ取得
                    $this->arrFile = $this->objUpFile->getFormFileList(IMAGE_TEMP_URLPATH,
                            IMAGE_SAVE_URLPATH);
                    break;
                case 'regist' :
                    if (! SC_Utils_Ex::isBlank($this->arrErr)) {
                        // アップロードファイル情報取得(Hidden用)
                        $this->arrHidden = $this->objUpFile->getHiddenFileList();
                        // 画像ファイル表示用データ取得
                        $this->arrFile = $this->objUpFile->getFormFileList(
                                IMAGE_TEMP_URLPATH, IMAGE_SAVE_URLPATH);
                    }
                    break;
            }
        }
    }

    function lfInitParam(&$objFormParam) {
        parent::lfInitParam($objFormParam);
        
        $objFormParam->addParam("save_image", "save_image", '', "", array());
        $objFormParam->addParam("temp_image", "temp_image", '', "", array());
    }

    function lfInitFile() {
        $this->objUpFile->addFile("画像", 'image', array('jpg','gif','png'), 
                IMAGE_SIZE, true, NEWS_IMAGE_WIDTH, NEWS_IMAGE_HEIGHT);
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
    function lfMakeScaleImage(&$objUpFile, $from_key, $to_key, $forced = false) {
        $arrImageKey = array_flip($objUpFile->keyname);
        $from_path = "";
        
        if ($objUpFile->temp_file[$arrImageKey[$from_key]]) {
            $from_path = $objUpFile->temp_dir . $objUpFile->temp_file[$arrImageKey[$from_key]];
        } elseif ($objUpFile->save_file[$arrImageKey[$from_key]]) {
            $from_path = $objUpFile->save_dir . $objUpFile->save_file[$arrImageKey[$from_key]];
        }
        
        if (file_exists($from_path)) {
            // 生成先の画像サイズを取得
            $to_w = $objUpFile->width[$arrImageKey[$to_key]];
            $to_h = $objUpFile->height[$arrImageKey[$to_key]];
            
            if ($forced)
                $objUpFile->save_file[$arrImageKey[$to_key]] = "";
            
            if (empty($objUpFile->temp_file[$arrImageKey[$to_key]]) && 
                    empty($objUpFile->save_file[$arrImageKey[$to_key]])) {
                // リネームする際は、自動生成される画像名に一意となるように、Suffixを付ける
                $dst_file = $objUpFile->lfGetTmpImageName(IMAGE_RENAME, "", 
                        $objUpFile->temp_file[$arrImageKey[$from_key]]);
                $path = $objUpFile->makeThumb($from_path, $to_w, $to_h, $dst_file);
                $objUpFile->temp_file[$arrImageKey[$to_key]] = basename($path);
            }
        }
    }

    /**
     * 新着記事のデータの登録を行う
     * 
     * @param Array $arrPost POSTデータの配列
     * @param Integer $member_id 登録した管理者のID
     */
    function lfNewsInsert($arrPost, $member_id) {
        $objQuery = $objQuery = & SC_Query_Ex::getSingletonInstance();
        
        // rankの最大+1を取得する
        $rank_max = $this->getRankMax();
        $rank_max = $rank_max + 1;
        
        $table = 'dtb_news';
        $sqlval = array();
        
        $arrRet = $this->objUpFile->getDBFileList();
        $sqlval = array_merge($sqlval, $arrRet);
        
        $news_id = $objQuery->nextVal('dtb_news_news_id');
        $sqlval['news_id'] = $news_id;
        $sqlval['news_date'] = $arrPost['news_date'];
        $sqlval['news_title'] = $arrPost['news_title'];
        $sqlval['creator_id'] = $member_id;
        $sqlval['news_url'] = $arrPost['news_url'];
        $sqlval['link_method'] = $arrPost['link_method'];
        $sqlval['news_comment'] = $arrPost['news_comment'];
        $sqlval['rank'] = $rank_max;
        $sqlval['create_date'] = 'CURRENT_TIMESTAMP';
        $sqlval['update_date'] = 'CURRENT_TIMESTAMP';
        
        $objQuery->insert($table, $sqlval);
        
        // 一時ファイルを本番ディレクトリに移動する
        $this->objUpFile->moveTempFile();
    }

    function lfNewsUpdate($arrPost, $member_id) {
        $objQuery = $objQuery = & SC_Query_Ex::getSingletonInstance();
        
        $table = 'dtb_news';
        $sqlval = array();
        
        $arrRet = $this->objUpFile->getDBFileList();
        $sqlval = array_merge($sqlval, $arrRet);
        
        $sqlval['news_date'] = $arrPost['news_date'];
        $sqlval['news_title'] = $arrPost['news_title'];
        $sqlval['creator_id'] = $member_id;
        $sqlval['news_url'] = $arrPost['news_url'];
        $sqlval['news_comment'] = $arrPost['news_comment'];
        $sqlval['link_method'] = $arrPost['link_method'];
        $sqlval['update_date'] = 'CURRENT_TIMESTAMP';
        $where = 'news_id = ?';
        $arrValIn = array($arrPost['news_id']);
        $objQuery->update($table, $sqlval, $where, $arrValIn);
        
        // 一時ファイルを本番ディレクトリに移動する
        $this->objUpFile->moveTempFile();
    }
}
