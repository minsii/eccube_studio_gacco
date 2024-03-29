<?php
/*
 * This file is part of EC-CUBE
 *
 * Copyright(c) 2000-2012 LOCKON CO.,LTD. All Rights Reserved.
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
require_once CLASS_REALDIR . 'helper/SC_Helper_Mail.php';

/**
 * メール関連のヘルパークラス(拡張).
 *
 * LC_Helper_Mail をカスタマイズする場合はこのクラスを編集する.
 *
 * @package Helper
 * @author LOCKON CO.,LTD.
 * @version $Id:SC_Helper_DB_Ex.php 15532 2007-08-31 14:39:46Z nanasess $
 */
class SC_Helper_Mail_Ex extends SC_Helper_Mail {

	/* 受注完了メール送信 */
	function sfSendOrderMail($order_id, $template_id, $subject = "", $header = "", $footer = "", $send = true, $mime_flg = false, $fwd_flg = false) {

		$arrTplVar = new stdClass();
		$arrInfo = SC_Helper_DB_Ex::sfGetBasisData();
		$arrTplVar->arrInfo = $arrInfo;

		$objQuery =& SC_Query_Ex::getSingletonInstance();

		if($subject == "" && $header == "" && $footer == "") {
			// メールテンプレート情報の取得
			$where = "template_id = ?";
			$arrRet = $objQuery->select("subject, header, footer", "dtb_mailtemplate", $where, array($template_id));
			$arrTplVar->tpl_header = $arrRet[0]['header'];
			$arrTplVar->tpl_footer = $arrRet[0]['footer'];
			$tmp_subject = $arrRet[0]['subject'];
		} else {
			$arrTplVar->tpl_header = $header;
			$arrTplVar->tpl_footer = $footer;
			$tmp_subject = $subject;
		}

		// 受注情報の取得
		$where = 'order_id = ? AND del_flg = 0';
		$arrOrder = $objQuery->getRow('*', 'dtb_order', $where, array($order_id));

		if (empty($arrOrder)) {
			trigger_error("該当する受注が存在しない。(注文番号: $order_id)", E_USER_ERROR);
		}

		$where = 'order_id = ?';
		$objQuery->setOrder('order_detail_id');
		$arrTplVar->arrOrderDetail = $objQuery->select("*", "dtb_order_detail", $where, array($order_id));

		/*## 追加規格 ADD BEGIN ##*/
		if(USE_EXTRA_CLASS === true){
			if(is_array($arrTplVar->arrOrderDetail)){
				foreach($arrTplVar->arrOrderDetail as $no=>$row){
					if(!empty($row["extra_info"])){
						$arrTplVar->arrOrderDetail[$no]["extra_info"] = unserialize($row["extra_info"]);
					}
				}
			}
		}
		/*## 追加規格 ADD END ##*/

		$objProduct = new SC_Product_Ex();
		$objQuery->setOrder('shipping_id');
		$arrRet = $objQuery->select('*', 'dtb_shipping', 'order_id = ?', array($order_id));
		foreach ($arrRet as $key => $value) {
			$objQuery->setOrder('shipping_id');
			$arrItems = $objQuery->select('*', 'dtb_shipment_item', 'order_id = ? AND shipping_id = ?',
			array($order_id, $arrRet[$key]['shipping_id']));
			foreach ($arrItems as $arrDetail) {
				foreach ($arrDetail as $detailKey => $detailVal) {
					$arrRet[$key]['shipment_item'][$arrDetail['product_class_id']][$detailKey] = $detailVal;
				}

				$arrRet[$key]['shipment_item'][$arrDetail['product_class_id']]['productsClass'] =& $objProduct->getDetailAndProductsClass($arrDetail['product_class_id']);
			}
		}
		$arrTplVar->arrShipping = $arrRet;

		$arrTplVar->Message_tmp = $arrOrder['message'];

		// 会員情報の取得
		$customer_id = $arrOrder['customer_id'];
		$objQuery->setOrder('customer_id');
		$arrRet = $objQuery->select('point', "dtb_customer", "customer_id = ?", array($customer_id));
		$arrCustomer = isset($arrRet[0]) ? $arrRet[0] : "";

		$arrTplVar->arrCustomer = $arrCustomer;
		$arrTplVar->arrOrder = $arrOrder;

		//その他決済情報
		if($arrOrder['memo02'] != "") {
			$arrOther = unserialize($arrOrder['memo02']);

			foreach($arrOther as $other_key => $other_val){
				if(SC_Utils_Ex::sfTrim($other_val['value']) == ""){
					$arrOther[$other_key]['value'] = "";
				}
			}

			$arrTplVar->arrOther = $arrOther;
		}

		// 都道府県変換
		$arrTplVar->arrPref = $this->arrPref;

		$objCustomer = new SC_Customer_Ex();
		$arrTplVar->tpl_user_point = $objCustomer->getValue('point');

		$objMailView = null;
		if (SC_Display_Ex::detectDevice() == DEVICE_TYPE_MOBILE) {
			$objMailView = new SC_MobileView_Ex();
		} else {
			$objMailView = new SC_SiteView_Ex();
		}
		// メール本文の取得
		$objMailView->setPage($this->getPage());
		$objMailView->assignobj($arrTplVar);
		$body = $objMailView->fetch($this->arrMAILTPLPATH[$template_id]);

		// メール送信処理
		$objSendMail = new SC_SendMail_Ex();
		$bcc = $arrInfo['email01'];
		$from = $arrInfo['email03'];
		$error = $arrInfo['email04'];
		$tosubject = $this->sfMakeSubject($tmp_subject, $objMailView);

		$objSendMail->setItem('', $tosubject, $body, $from, $arrInfo['shop_name'], $from, $error, $error, $bcc);
		$objSendMail->setTo($arrOrder["order_email"], $arrOrder["order_name01"] . " ". $arrOrder["order_name02"] ." 様");

	    // 送信フラグ:trueの場合は、送信する。
        if ($send) {
            if ($objSendMail->sendMail()) {
                $this->sfSaveMailHistory($order_id, $template_id, $tosubject, $body);
            }
        }
        
    	/*## メール転送設定 ADD BEGIN ##*/
        if(USE_ORDER_MAIL_FWD === true){
        	if($fwd_flg && !empty($arrInfo["email01_fw"])){
        		$objSendMail_fw = new SC_SendMail_Ex();
        		$objSendMail_fw->setItem($arrInfo["email01_fw"], $tosubject, $body, $from, $arrInfo['shop_name'], $from, $error);
        		$objSendMail_fw->sendMail();
        	}
        }
    	/*## メール転送設定 ADD END ##*/

		return $objSendMail;
	}
	
	/*## 問い合わせ履歴管理 ADD BEGIN ##*/
    // DBに登録されたテンプレートの内容を取得する
    function sfGetTemplateMail($template_id, &$objPage) {

        $objQuery =& SC_Query_Ex::getSingletonInstance();
        // メールテンプレート情報の取得
        $where = 'template_id = ?';
        $arrRet = $objQuery->select('subject, header, footer', 'dtb_mailtemplate', $where, array($template_id));
        $objPage->tpl_header = $arrRet[0]['header'];
        $objPage->tpl_footer = $arrRet[0]['footer'];
        $tmp_subject = $arrRet[0]['subject'];

        $arrInfo = SC_Helper_DB_Ex::sfGetBasisData();

        $objMailView = new SC_SiteView_Ex();
        $objMailView->setPage($this->getPage());
        // メール本文の取得
        $objMailView->assignobj($objPage);
        $body = $objMailView->fetch($this->arrMAILTPLPATH[$template_id]);
        $tosubject = $this->sfMakeSubject($tmp_subject, $objMailView);

        return array("subject" => $tosubject, "body" => $body);
    }
    
    // 問い合わせメール配信履歴への登録
    function sfSaveContactHistory($to, $subject, $body, $customer_id = null, $contact_type=1, $attachments = array()) {
        $sqlval = array();
        $sqlval['contact_type'] = $contact_type;
        $sqlval['status'] = 1;
        if(!empty($customer_id)){
        	$sqlval['customer_id'] = $customer_id;
        }
        $sqlval['sender_email'] = $to;
        $sqlval['subject'] = $subject;
        $sqlval['body'] = $body;
        /*## MIMEメール対応 ADD BEGIN ##*/
        if(USE_MIME_MAIL === true &&
            is_array($attachments) && count($attachments) > 0){
            $sqlval['attachment'] = serialize($attachments);
        }
        /*## MIMEメール対応 ADD END ##*/
        
        $sqlval['create_date'] = 'now()';
        $sqlval['update_date'] = 'now()';
        
        $objQuery =& SC_Query_Ex::getSingletonInstance();
        $objQuery->insert('dtb_contact_history', $sqlval);
    }
    /*## 問い合わせ履歴管理 ADD END ##*/
    
    /* DBに登録されたテンプレートメールの送信 */
    function sfSendTemplateMail($to, $to_name, $template_id, &$objPage, $from_address = '', $from_name = '', $reply_to = '', $bcc = '',
            $attachments = array()) {
    
        $objQuery =& SC_Query_Ex::getSingletonInstance();
        // メールテンプレート情報の取得
        $where = 'template_id = ?';
        $arrRet = $objQuery->select('subject, header, footer', 'dtb_mailtemplate', $where, array($template_id));
        $objPage->tpl_header = $arrRet[0]['header'];
        $objPage->tpl_footer = $arrRet[0]['footer'];
        $tmp_subject = $arrRet[0]['subject'];
    
        $arrInfo = SC_Helper_DB_Ex::sfGetBasisData();
    
        $objMailView = new SC_SiteView_Ex();
        $objMailView->setPage($this->getPage());
        // メール本文の取得
        $objMailView->assignobj($objPage);
        $body = $objMailView->fetch($this->arrMAILTPLPATH[$template_id]);
    
        // メール送信処理
        $objSendMail = new SC_SendMail_Ex();
        if ($from_address == '') $from_address = $arrInfo['email03'];
        if ($from_name == '') $from_name = $arrInfo['shop_name'];
        if ($reply_to == '') $reply_to = $arrInfo['email03'];
        $error = $arrInfo['email04'];
        $tosubject = $this->sfMakeSubject($tmp_subject, $objMailView);
    
        $objSendMail->setItem('', $tosubject, $body, $from_address, $from_name, $reply_to, $error, $error, $bcc);
        $objSendMail->setTo($to, $to_name);
        
        /*## MIMEメール対応 ADD BEGIN ##*/
        if(USE_MIME_MAIL === true &&
            is_array($attachments) && count($attachments) > 0){
            foreach ( $attachments as $a ) {
                $objSendMail->addAttachment($a);
            }
            $ret = $objSendMail->sendMimeMail();
            return $ret;
        }
        /*## MIMEメール対応 ADD END ##*/
        
        $objSendMail->sendMail();    // メール送信
    }
}
?>
