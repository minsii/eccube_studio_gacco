<!--{*
/*
 * This file is part of EC-CUBE
 *
 * Copyright(c) 2000-2010 LOCKON CO.,LTD. All Rights Reserved.
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
*}-->

<!--▼CONTENTS-->
<div id="mypagecolumn">
  <h2 class="title"><img src="<!--{$TPL_DIR}-->img/mypage/title.jpg" width="700" height="40" alt="MYページ" /></h2>
<!--{include file=$tpl_navi}-->
  <div id="mycontentsarea">
    <h3>記念日登録</h3>
    <p>誕生日や記念日など、大切な日を登録しておくと、その日の<!--{$smarty.const.ANNI_REMINDER_DAY_BEFORE}-->日前にお知らせメールが届きます。<br />
最大<!--{$smarty.const.ANNIVERSARY_ADDR_MAX}-->件まで登録出来ますので、大切な日のリマインダーサービスとしてご活用ください。</p>

    <form name="form1" method="post" action="<!--{$smarty.server.PHP_SELF|escape}-->" >
      <input type="hidden" name="mode" value="update" />
      <input type="hidden" name="anniversary_id" value="<!--{$arrForm.anniversary_id}-->" />
      <input type="hidden" name="<!--{$smarty.const.TRANSACTION_ID_NAME}-->" value="<!--{$transactionid}-->" />
        
      <!--{if $tpl_linemax < 20 || $is_edit_mode}-->
      <!--▼登録フォーム-->
      <table summary="記念日登録">
        <th>日付 <span class="attention">*</span></th> 
        <td>
          <div class="attention"><!--{$arrErr.dt_month}--><!--{$arrErr.dt_day}--></div>
          <select name="dt_month" <!--{if $arrErr.dt_month}--><!--{sfSetErrorStyle}--><!--{/if}-->>
              <option value="" selected="selected">------</option>
              <!--{html_options options=$arrMonth selected=$arrForm.dt_month" }-->
          </select>月
          <select name="dt_day" <!--{if $arrErr.dt_day}--><!--{sfSetErrorStyle}--><!--{/if}-->>
              <option value="" selected="selected">----</option>
              <!--{html_options options=$arrDay selected=$arrForm.dt_day}-->
          </select>日
        </td> 
      </tr> 
      <tr> 
        <th nowrap>相手のお名前 <span class="attention">*</span></th> 
        <td>
          <div class="attention"><!--{$arrErr.name}--></div>
          <input type="text" name="name" size="30" value="<!--{$arrForm.name}-->" />
        </td> 
      </tr> 
      <tr> 
        <th>イベント</th> 
        <td>
          <div class="attention"><!--{$arrErr.event_id}--></div>
          <select name="event_id">
              <option value="">▼選択してください</option> 
              <!--{html_options options=$arrEvent selected=$arrForm.event_id}-->
          </select> 
        </td> 
      </tr> 
      <tr> 
        <th>コメント</th> 
        <td>
          <div class="attention"><!--{$arrErr.memo}--></div>
          <textarea name="memo" cols="50" rows="4"><!--{$arrForm.memo}--></textarea>
        </td> 
      </tr> 
      </table> 
      <div class="form-buttons" style="padding:5px 10px;text-align:center;"><input style="color:#FFFFFF;background-color:#EC0000;width:140px;padding:5px 10px;font-size:16px; font-weight:bold;border:0px;" type="submit" value="登 録"/> </div> 
      <!--▲登録フォーム-->
      <!--{/if}-->

      <h3 style="margin-top:30px;">登録済みの記念日</h3> 
      <p style="padding:10px;"><!--{$tpl_linemax}-->件登録されています</p> 
      <!--{if $tpl_linemax}-->
      <!--▼一覧-->
      <table summary="記念日登録"> 
        <col width="10%" />
        <col width="10%" />
        <col width="10%" />
        <col width="60%" />
        <col width="5%" />
        <col width="5%" />
        <tr> 
          <th>日付</th> 
          <th>お名前</th> 
          <th>イベント</th> 
          <th>メモ</th>  
          <th colspan="2">操作</th> 
        </tr> 

        <!--{section name=data loop=$arrList}-->
        <!--{assign var=anniversary value=$arrList[data]}-->
        <tr bgcolor="#ffffff"> 
          <td nowrap class="alignC"><!--{$anniversary.dt_month|escape}-->月<!--{$anniversary.dt_day|escape}-->日</td> 
          <td nowrap class="alignC"><!--{$anniversary.name|escape}--></td> 
          <td nowrap class="alignC"><!--{$arrEvent[$anniversary.event_id]|escape}--></td> 
          <td class="alignC"><!--{$anniversary.memo|escape|nl2br}--></td> 
          <td><input type="button" value="編集" onclick="fnModeSubmit('pre_edit', 'anniversary_id', <!--{$anniversary.anniversary_id|escape}-->); return false;" /></td> 
          <td><input type="button" value="削除" onclick="fnModeSubmit('delete', 'anniversary_id', <!--{$anniversary.anniversary_id|escape}-->); return false;" /></td> 
        </tr> 
        <!--{/section}-->
      </table>
      <!--▲一覧-->
      <!--{/if}-->
    </form>
  </div>
</div>
<!--▲CONTENTS-->
