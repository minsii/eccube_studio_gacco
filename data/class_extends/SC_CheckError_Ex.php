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

require_once CLASS_REALDIR . 'SC_CheckError.php';

class SC_CheckError_Ex extends SC_CheckError {

    /**
     * 複数項目を含んだ文字列をチェックする
     *
     * @param array $value 各要素は以下の通り。<br>
     *     [0]: 項目名<br>
     *     [1]: 判定対象を格納している配列キー
     *     [2]: 複数サブ文字列を区切る文字列
     *     [3]: サブ文字列のチェック1
     *     [4]: サブ文字列のチェック2
     *     ...
     * @return void
     */
	function MULTIPLE_SUB_CHECK($value) {
		if (isset($this->arrErr[$value[1]])) {
			return;
		}

		$value_param = array($value[0], $value[1]);
		$checks = array_slice($value, 3);
		
		$this->createParam($value_param);
		$str = $this->arrParam[$value[1]];
		
		if(!empty($str) && is_array($checks) && !empty($value["2"])){
			$subs = split($value["2"], $str);

			// サブ文字列を設定して、チェックする
			$i = 1;
			foreach($subs as $s){
				$s = trim($s);
				$this->arrParam[$value[1]] = $s;
				$this->doFunc(array($value[0]."(サブ{$i})", $value[1]), $checks);
				// エラーが発生したら中止する
				if (isset($this->arrErr[$value[1]])) {
					return;
				}
				$i++;
			}
		}
		// 値を回復
		$this->arrParam[$value[1]] = $str;
	}
	
	/**
	 * 下記フォーマットの日付文字列チェック
	 * YYYY/MM/DD
	 * YYYY-MM-DD
	 * 
	 * @param $value
	 */
	function DATE_STRING_CHECK($value){
		if (isset($this->arrErr[$value[1]]) || empty($value[1])) {
			return;
		}
		
		$err = false;
		
		list($y, $m, $d) = preg_split('/[\/]/', $this->arrParam[$value[1]]);
		if(empty($y) || empty($m) || empty($d)){
			$err = true;
		}
		else if(!checkdate($m, $d, $y)){
			$err = true;
		}
		
		if($err){
			$this->arrErr[$value[1]] = '※ ' . $value[0] . 'を正しく入力してください。<br />';
		}
	}
}
