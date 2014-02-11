#!/usr/bin/env php
<?php
/**
 * 記念日リマインダ送信スクリプト
 */

$require_php_dir = realpath(dirname( __FILE__));
define('DATA_REALDIR', $require_php_dir. '/../');
require_once($require_php_dir . "/../require_base.php");
require_once(CLASS_EX_REALDIR . "batch_extends/SC_Batch_Anniversary_Reminder_Ex.php");

$batch = new SC_Batch_Anniversary_Reminder_Ex();
$batch->execute();
?>
