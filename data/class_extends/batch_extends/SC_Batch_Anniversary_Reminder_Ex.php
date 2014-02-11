<?php
/**
 * 記念日通知バッチクラス(拡張).
 *
 * SC_Batch_Anniversary_Reminder_Ex をカスタマイズする場合はこのクラスを編集する.
 *
 * @package Batch
 * @author simin
 * @version $Id$
 */
class SC_Batch_Anniversary_Reminder_Ex {

	/**
	 * コンストラクタ.
	 *
	 * @param array $argv コマンドライン用引数.
	 *                    指定しない場合は, 内部関数が実行されない.
	 */
	function SC_Batch_Anniversary_Reminder_Ex($argv = "") {
		if(defined("USE_ANNIVERSARY") && USE_ANNIVERSARY === true){
			$this->debug = 1;

			$masterData = new SC_DB_MasterData_Ex();
			$this->arrEvent = $masterData->getMasterData("mtb_anniversary_event");

			if (!empty($argv)) {
				$this->execute($argv);
			}
		}
	}

	/**
	 * バッチ処理を実行する.
	 *
	 * @param mixed $argv コマンドライン引数
	 * @return void
	 */
	function execute($argv = "") {
		if(defined("ANNI_REMINDER_MAIL_TPL") && ANNI_REMINDER_MAIL_TPL != false){
			GC_Utils_Ex::gfPrintLog("LOADING BATCH SC_Batch_Anniversary_Reminder_Ex");

			$arrReminderDay = $this->lfGetReminderDay();
			if(empty($arrReminderDay)){
				GC_Utils_Ex::gfPrintLog(">>記念日通知日取得エラー");
				return;
			}

			GC_Utils_Ex::gfPrintLog(">>対象記念日: {$arrReminderDay["mon"]}/{$arrReminderDay["mday"]}");

			$arrAnniList = $this->lfGetAnniversaryList($arrReminderDay);
			$cnt = count($arrAnniList);
			GC_Utils_Ex::gfPrintLog(">>取得記念日件数: {$cnt}件");

			$send_cnt = $this->lfSendMail($arrAnniList);
			GC_Utils_Ex::gfPrintLog(">>送信件数: {$send_cnt}件");

			GC_Utils_Ex::gfPrintLog("BATCH SC_Batch_Anniversary_Reminder_Ex COMPLETE");
		}
	}

	/**
	 * 記念日が設定日数後の記念日情報一覧を取得する
	 *
	 * @param $customerId
	 * @return array
	 */
	function lfGetAnniversaryList($arrReminderDay){
		$arrAnniList = array();

		$objQuery = new SC_Query();
		$where = "T1.dt_month = ? AND T1.dt_day = ? AND T1.del_flg = 0";
		$arrval = array($arrReminderDay["mon"], $arrReminderDay["mday"]);

		$objQuery->setOrder('rank');
		$cols = "DISTINCT T1.*, T2.name01, T2.name02, T2.email";
		$from = "dtb_anniversary T1 INNER JOIN dtb_customer T2 USING(customer_id)";
		$arrAnniList = $objQuery->select($cols, $from, $where, $arrval);

		return $arrAnniList;
	}


	function lfGetReminderDay(){
		$arrReminderDay = null;
		// デフォルトは10日後
		$day = defined("ANNI_REMINDER_DAY_BEFORE")? intval(ANNI_REMINDER_DAY_BEFORE) : 10;

		if($this->debug){
			GC_Utils_Ex::gfPrintLog(">>{$day}日後の記念日を取得します");
		}

		// 今日より設定日数後を取得
		$today = time();
		$dayTime = strtotime("+{$day} day", $today);

		if($dayTime && $dayTime != -1){
			$arrReminderDay = getdate($dayTime);
		}

		return $arrReminderDay;
	}

	function lfSendMail($arrAnniList){
		$helperMail = new SC_Helper_Mail_Ex();
		$CONF = SC_Helper_DB_Ex::sfGetBasisData();
		$this->tpl_shopname=$CONF['shop_name'];
		$this->tpl_infoemail = $CONF['email02'];

		$send_cnt = 0;
		if(is_array($arrAnniList)){
			foreach($arrAnniList as $arrAnni){
				$this->arrAnni = $arrAnni;

				// メール送信処理
				$to = $arrAnni['email'];
				$to_name = $arrAnni['name01']." 様";
				if(!empty($to)){
					$helperMail->sfSendTemplateMail($to, $to_name, ANNI_REMINDER_MAIL_TPL, $this, $CONF["email03"], $CONF["shop_name"], $CONF["email02"]);
					$send_cnt++;

					if($this->debug){
						GC_Utils_Ex::gfPrintLog(">>TO[{$arrAnni['email']}]送信完了 (記念日[{$arrAnni["anniversary_id"]}] {$arrAnni["dt_month"]}-{$arrAnni["dt_day"]})");
					}
				}

			}
		}
		return $send_cnt;
	}

}
?>
