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
require_once CLASS_REALDIR . 'SC_SendMail.php';

/**
 * メール送信クラス(拡張).
 *
 * SC_SendMail をカスタマイズする場合はこのクラスを使用する.
 *
 * @package
 * @author LOCKON CO.,LTD.
 * @version $Id: SC_SendMail_Ex.php 22796 2013-05-02 09:11:36Z h_yoshimoto $
 */
class SC_SendMail_Ex extends SC_SendMail {
	/*## 送信結果一時保存 ADD BEGIN ##*/
	var $send_result;
	var $org_subject;
	var $org_body;
	var $org_to;

	// 件名の設定
	function setSubject($subject) {
		$this->org_subject = $subject;
		parent::setSubject($subject);
	}

	// 本文の設定
	function setBody($body) {
		$this->org_body = $body;
		parent::setBody($body);
	}

	// 宛先の設定
	function setTo($to, $to_name = '') {
		$this->org_to = '"'. $to_name. '"'. "<$to>";
		parent::setTo($to, $to_name);
	}
        
	/**
	 * TXTメール送信を実行する.
	 *
	 * 設定された情報を利用して, メールを送信する.
	 *
	 * @return void
	 */
	function sendMail($isHtml = false) {
		if(defined("LOCAL_SEND_MAIL_HISTORY_FILE_PATH") && 
			LOCAL_SEND_MAIL_HISTORY_FILE_PATH != false){
				$mail =
"
======================================================================= BEGIN ======
FROM: {$this->from}
TO: {$this->org_to}
BCC: {$this->bcc}
REPLY-TO: {$this->replay_to}
SUBJECT: {$this->org_subject}
BODY:
------------------------------------------------------------------------------- 
{$this->org_body}
======================================================================= END ======
";
			GC_Utils_Ex::gfPrintLog($mail, LOCAL_SEND_MAIL_HISTORY_FILE_PATH, false);
		}
			
		return parent::sendMail($isHtml);
	}
	/*## 送信結果一時保存 ADD END ##*/
}
