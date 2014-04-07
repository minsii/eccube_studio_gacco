<?php
require_once CLASS_EX_REALDIR . 'page_extends/LC_Page_Ex.php';

/**
 * 修理フォーム のページクラス
 * LC_Page_Repair をカスタマイズする場合はこのクラスを編集する.
 * 
 * @package Page
 * @author m.si
 */
class LC_Page_Repair_Ex extends LC_Page_Ex {
    
    // }}}
    // {{{ functions
    
    /**
     * Page を初期化する.
     * 
     * @return void
     */
    function init() {
        parent::init();
        
        $this->tpl_title = '修理フォーム(入力ページ)';
        $this->tpl_page_category = 'repair';
        $this->httpCacheControl('nocache');
        
        $masterData = new SC_DB_MasterData_Ex();
        $this->arrPREF = $masterData->getMasterData('mtb_pref');
        $this->arrREPAIR_TYPE = $masterData->getMasterData('mtb_repair_type');
    }

    /**
     * Page のプロセス.
     * 
     * @return void
     */
    function process() {
        parent::process();
        $this->action();
        $this->sendResponse();
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
        // ファイル管理クラス
        $this->objUpFile = new SC_UploadFile_Ex(IMAGE_TEMP_REALDIR, IMAGE_SAVE_REALDIR);
        $this->lfInitFile();
        $this->objUpFile->setHiddenFileList($_POST);
        
        $objFormParam = new SC_FormParam_Ex();
        $this->lfInitParam($objFormParam);
        $objFormParam->setParam($_POST);
        
        $this->arrData = isset($_SESSION['customer']) ? $_SESSION['customer'] : '';

        switch ($this->getMode()) {
            case 'confirm' :
                // エラーチェック
                $objFormParam->convParam();
                $objFormParam->toLower('email');
                $objFormParam->toLower('email02');
                $this->arrErr = $this->lfCheckError($objFormParam);
                // 入力値の取得
                $this->arrForm = $objFormParam->getHashArray();
                
                if (SC_Utils_Ex::isBlank($this->arrErr)) {
                    // エラー無しで完了画面
                    $this->tpl_mainpage = 'repair/confirm.tpl';
                    $this->tpl_title = '修理フォーム(確認ページ)';
                }
                
                break;
            
            case 'return' :
                $this->arrForm = $objFormParam->getHashArray();
                break;
            
            case 'complete' :
                $this->arrErr = $this->lfCheckError($objFormParam);
                $this->arrForm = $objFormParam->getHashArray();
                if (SC_Utils_Ex::isBlank($this->arrErr)) {
                    // 一時ファイルを本番ディレクトリに移動する
                    $arrDBFile = $this->objUpFile->getDBFileList();
                    $this->objUpFile->moveTempFile();
                    $this->arrForm = array_merge($this->arrForm, $arrDBFile);
                    
                    $this->lfSendMail($this);
                    
                    // 完了ページへ移動する
                    SC_Response_Ex::sendRedirect('complete.php');
                    SC_Response_Ex::actionExit();
                } else {
                    SC_Utils_Ex::sfDispSiteError(CUSTOMER_ERROR);
                    SC_Response_Ex::actionExit();
                }
                break;
            // 画像のアップロード
            case 'upload_image':
                $this->arrForm = $objFormParam->getHashArray();
                // ファイル存在チェック
                $this->arrErr = $this->lfCheckError($objFormParam);
                $this->arrErr = array_merge((array) $this->arrErr, (array) $this->objUpFile->checkEXISTS($_POST['image_key']));
                // 画像保存処理
                $this->arrErr["image"] = $this->objUpFile->makeTempFile("image", IMAGE_RENAME);
                
                if (SC_Utils_Ex::isBlank($this->arrErr)) {
                    $this->lfMakeScaleImage($this->objUpFile, "image", "image");
                }
                break;
            // 画像の削除
            case 'delete_image' :
                $this->objUpFile->deleteFile("image");
                $this->arrForm = $objFormParam->getHashArray();
                break;
            default:
            	/*## 商品問い合わせ ADD BEGIN ##*/
                $objFormParam->setParam($_GET);
                $objFormParam->convParam();
                $this->arrForm = $objFormParam->getHashArray();
                /* ## 商品問い合わせ ADD END ## */
                break;
        }

        // アップロードファイル情報取得(Hidden用)
        $this->arrHidden = $this->objUpFile->getHiddenFileList();
        // 画像ファイル表示用データ取得
        $this->arrFile = $this->objUpFile->getFormFileList(IMAGE_TEMP_URLPATH, IMAGE_SAVE_URLPATH);
    }

    /**
     * お問い合わせ入力時のパラメーター情報の初期化を行う.
     * 
     * @param SC_FormParam $objFormParam SC_FormParam インスタンス
     * @return void
     */
    function lfInitParam(&$objFormParam) {
        $objFormParam->addParam('お名前(姓)', 'name01', STEXT_LEN, 'KVa', array('EXIST_CHECK','SPTAB_CHECK','MAX_LENGTH_CHECK'));
        $objFormParam->addParam('お名前(名)', 'name02', STEXT_LEN, 'KVa', array('EXIST_CHECK','SPTAB_CHECK','MAX_LENGTH_CHECK'));
        $objFormParam->addParam('お名前(フリガナ・姓)', 'kana01', STEXT_LEN, 'KVCa', array('EXIST_CHECK','SPTAB_CHECK','MAX_LENGTH_CHECK','KANA_CHECK'));
        $objFormParam->addParam('お名前(フリガナ・名)', 'kana02', STEXT_LEN, 'KVCa', array('EXIST_CHECK','SPTAB_CHECK','MAX_LENGTH_CHECK','KANA_CHECK'));
        $objFormParam->addParam('郵便番号1', 'zip01', ZIP01_LEN, 'n', array('SPTAB_CHECK','NUM_CHECK','NUM_COUNT_CHECK'));
        $objFormParam->addParam('郵便番号2', 'zip02', ZIP02_LEN, 'n', array('SPTAB_CHECK','NUM_CHECK','NUM_COUNT_CHECK'));
        $objFormParam->addParam('都道府県', 'pref', INT_LEN, 'n', array('MAX_LENGTH_CHECK','NUM_CHECK'));
        $objFormParam->addParam('住所1', 'addr01', MTEXT_LEN, 'KVa', array('SPTAB_CHECK','MAX_LENGTH_CHECK'));
        $objFormParam->addParam('住所2', 'addr02', MTEXT_LEN, 'KVa', array('SPTAB_CHECK','MAX_LENGTH_CHECK'));
        $objFormParam->addParam('電話番号1', 'tel01', TEL_ITEM_LEN, 'n', array('EXIST_CHECK','NUM_CHECK','MAX_LENGTH_CHECK'));
        $objFormParam->addParam('電話番号2', 'tel02', TEL_ITEM_LEN, 'n', array('EXIST_CHECK','NUM_CHECK','MAX_LENGTH_CHECK'));
        $objFormParam->addParam('電話番号3', 'tel03', TEL_ITEM_LEN, 'n', array('EXIST_CHECK','NUM_CHECK','MAX_LENGTH_CHECK'));
        $objFormParam->addParam('メールアドレス', 'email', null, 'KVa', array('EXIST_CHECK','EMAIL_CHECK','EMAIL_CHAR_CHECK'));
        $objFormParam->addParam('メールアドレス(確認)', 'email02', null, 'KVa', array('EXIST_CHECK','EMAIL_CHECK','EMAIL_CHAR_CHECK'));
        
        $objFormParam->addParam('商品名', 'product_name', STEXT_LEN, 'KVa', array('MAX_LENGTH_CHECK'));
        $objFormParam->addParam('ご購入年月日（年）', 'buy_year', 4, 'n', array('NUM_CHECK','MAX_LENGTH_CHECK'), '', false);
        $objFormParam->addParam('ご購入年月日（月）', 'buy_month', 2, 'n', array('NUM_CHECK','MAX_LENGTH_CHECK'), '', false);
        $objFormParam->addParam('ご購入年月日（日）', 'buy_date', 2, 'n', array('NUM_CHECK','MAX_LENGTH_CHECK'), '', false);
        $objFormParam->addParam('修理内容', 'repair_type', INT_LEN, 'n', array('MAX_LENGTH_CHECK','NUM_CHECK'));
        $objFormParam->addParam('修理状態・ご要望等', 'contents', MLTEXT_LEN, 'KVa', array('EXIST_CHECK','MAX_LENGTH_CHECK'));
        $objFormParam->addParam("save_image", "save_image", '', "", array());
        $objFormParam->addParam("temp_image", "temp_image", '', "", array());
        
        /* ## 顧客法人管理 ADD BEGIN ## */
        if (constant("USE_CUSTOMER_COMPANY") === true) {
            $objFormParam->addParam('法人名', 'company', SMTEXT_LEN, 'KVa', array('SPTAB_CHECK','MAX_LENGTH_CHECK'));
            $objFormParam->addParam('法人名(フリガナ)', 'company_kana', STEXT_LEN, 'KVCa', array('SPTAB_CHECK','MAX_LENGTH_CHECK','KANA_CHECK'));
        }
    }

    function lfCheckError(&$objFormParam) {
        $arrValues = $objFormParam->getHashArray();
        $objErr = new SC_CheckError_Ex($arrValues);
        $arrErr = $objFormParam->checkError();
        
        $objErr->doFunc(array('ご購入年月日','buy_year','buy_month','buy_date'), array('CHECK_DATE'));
        if (! SC_Utils_Ex::isBlank($objErr->arrErr)) {
            $arrErr = array_merge($arrErr, $objErr->arrErr);
        }
        return $arrErr;
    }
    
    /**
     * アップロードファイルパラメーター情報の初期化
     * - 画像ファイル用
     * 
     * @return void
     */
    function lfInitFile() {
        $this->objUpFile->addFile("修理アクセサリー画像", 'image', array('jpg','gif','png'), IMAGE_SIZE, true);
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
     * メールの送信を行う。
     * 
     * @return void
     */
    function lfSendMail(&$objPage) {
        $CONF = SC_Helper_DB_Ex::sfGetBasisData();
        $objPage->tpl_shopname = $CONF['shop_name'];
        $objPage->tpl_infoemail = $CONF['email02'];
        $helperMail = new SC_Helper_Mail_Ex();
        $helperMail->setPage($this);
        $attachments = array();
        if (! empty($this->arrForm["image"])) {
            $attachments[] = rtrim(IMAGE_SAVE_REALDIR, '/') 
                .'/' . $this->arrForm["image"];
        }

        $helperMail->sfSendTemplateMail(
            $objPage->arrForm['email'],            // to
            $objPage->arrForm['name01'] .' 様',    // to_name
            REPAIR_MAIL_TPL,                                // template_id
            $objPage,                                       // objPage
            $CONF['email03'],                               // from_address
            $CONF['shop_name'],                             // from_name
            $CONF['email02'],                               // reply_to
            $CONF['email02']                                // bcc
            , $attachments
        );
        
        /* ## メール転送設定 ADD BEGIN ## */
        if(USE_CONTACT_MAIL_FWD === true && !empty($CONF["email02_fw"])){
        	$helperMail->sfSendTemplateMail(
        	$CONF["email02_fw"],            // to
        	"",    // to_name
        	REPAIR_MAIL_TPL,                                 // template_id
        	$objPage,                                       // objPage
        	$CONF['email03'],                               // from_address
        	$CONF['shop_name'],                             // from_name
        	$CONF['email02']                               // reply_to
        	, ""
        	, $attachments
        	);
        }
        /* ## メール転送設定 ADD END ## */
        
        /*## 問い合わせ履歴管理 ADD BEGIN ##*/
        if (USE_CONTACT_HISTORY === true) {
            $customer_id = null;
            $objCustomer = new SC_Customer_Ex();
            if ($objCustomer->isLoginSuccess(true) === true) {
                $customer_id = $objCustomer->getValue('customer_id');
            }
            $arrMail = $helperMail->sfGetTemplateMail(REPAIR_MAIL_TPL, $objPage);
            var_dump($arrMail);
            $helperMail->sfSaveContactHistory($objPage->arrForm['email'], 
                    $arrMail["subject"], $arrMail["body"], $customer_id, "2", $attachments);
        }
        /* ## 問い合わせ履歴管理 ADD END ## */
    }

}
