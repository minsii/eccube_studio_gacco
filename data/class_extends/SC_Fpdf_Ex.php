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

require_once CLASS_REALDIR . 'SC_Fpdf.php';

class SC_Fpdf_Ex extends SC_Fpdf {
    /**
     * 備考の出力を行う
     *
     * @param string $str 入力文字列
     * @return string 変更後の文字列
     */
    function setEtcData() {
        $this->Cell(0, 10, '', 0, 1, 'C', 0, '');
        
        if (strlen($this->arrData['etc1']) || strlen($this->arrData['etc2']) 
            || strlen($this->arrData['etc3'])) {
            $this->SetFont('Gothic', 'B', 9);
            $this->MultiCell(0, 6, '＜ 備考 ＞', 'T', 2, 'L', 0, '');
            $this->SetFont('SJIS', '', 8);
            $text = SC_Utils_Ex::rtrim($this->arrData['etc1'] . "\n" . $this->arrData['etc2'] . "\n" . $this->arrData['etc3']);
            $this->MultiCell(0, 4, $text, '', 2, 'L', 0, '');
        }
        if (strlen($this->arrData['attention'])) {
            $this->SetFont('Gothic', 'B', 9);
            $this->MultiCell(0, 6, '＜ 注意事項 ＞', 'T', 2, 'L', 0, '');
            $this->MultiCell(0, 4, $this->arrData['attention'], '', 2, 'L', 0, '');
        }
    }
}
