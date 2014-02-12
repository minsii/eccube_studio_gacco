<!--{*
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
*}-->

<form name="form1" id="form1" method="post" action="?">
<input type="hidden" name="<!--{$smarty.const.TRANSACTION_ID_NAME}-->" value="<!--{$transactionid}-->" />
<input type="hidden" name="mode" value="edit" />
<input type="hidden" name="contact_id" value="<!--{$arrForm.contact_id.value|h}-->" />
<!--{foreach key=key item=item from=$arrHidden}-->
    <!--{if is_array($item)}-->
        <!--{foreach item=c_item from=$item}-->
        <input type="hidden" name="<!--{$key|h}-->[]" value="<!--{$c_item|h}-->" />
        <!--{/foreach}-->
    <!--{else}-->
        <input type="hidden" name="<!--{$key|h}-->" value="<!--{$item|h}-->" />
    <!--{/if}-->
<!--{/foreach}-->
<div id="order" class="contents-main">
    <table class="form">
        <tr>
            <th>送信番号</th>
            <td><!--{$arrDisp.contact_id|h}--></td>
        </tr>
        <tr>
            <th>メール種類</th>
            <!--{assign var=contact_type value="`$arrDisp.contact_type`"}-->
            <td><!--{$arrCONTACT_TYPE[$contact_type]|h}--></td>
        </tr>
        <tr>
            <th>対応状況</th>
            <td>
                <!--{assign var=key value="status"}-->
                <span class="attention"><!--{$arrErr[$key]}--></span>
                <select name="<!--{$key}-->" style="<!--{$arrErr[$key]|sfGetErrorColor}-->">
                <!--{html_options options=$arrCONTACT_STATUS selected=$arrForm[$key].value|h}-->
                </select>
            </td>
        </tr>
        <tr>
            <th>送信日時</th>
            <td><!--{$arrDisp.create_date|sfDispDBDate}--></td>
        </tr>
        <tr>
            <th>メールアドレス</th>
            <td>
              <!--{$arrDisp.sender_email|h}-->
              <!--{if $arrDisp.customer_id}-->【会員番号:<!--{$arrDisp.customer_id}-->】<!--{/if}-->
            </td>
        </tr>
        <tr>
            <th>件名</th>
            <td><!--{$arrDisp.subject|h}--></td>
        </tr>
        <tr>
            <th>送信内容</th>
            <td><!--{$arrDisp.body|h|nl2br}--></td>
        </tr>
    </table>

    <div class="btn-area">
        <ul>
            <li><a class="btn-action" href="javascript:;" onclick="fnChangeAction('./contact_history.php'); fnModeSubmit('search','',''); return false;"><span class="btn-prev">検索結果へ戻る</span></a></li>
            <li><a class="btn-action" href="javascript:;" onclick="fnFormModeSubmit('form1', 'edit', '', ''); return false;"><span class="btn-next">この内容で登録する</span></a></li>
        </ul>
    </div>
</div>
</form>
