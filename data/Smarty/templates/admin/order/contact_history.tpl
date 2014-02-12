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

<div class="contents-main">
<form name="search_form" id="search_form" method="post" action="?">
<input type="hidden" name="<!--{$smarty.const.TRANSACTION_ID_NAME}-->" value="<!--{$transactionid}-->" />
<input type="hidden" name="mode" value="search" />
    <h2>検索条件設定</h2>
    <!--{* 検索条件設定テーブルここから *}-->
    <table>
        <tr>
            <th>送信番号</th>
            <td>
                <!--{assign var=key1 value="search_contact_id1"}-->
                <!--{assign var=key2 value="search_contact_id2"}-->
                <span class="attention"><!--{$arrErr[$key1]}--></span>
                <span class="attention"><!--{$arrErr[$key2]}--></span>
                <input type="text" name="<!--{$key1}-->" value="<!--{$arrForm[$key1].value|h}-->" maxlength="<!--{$arrForm[$key1].length}-->" style="<!--{$arrErr[$key1]|sfGetErrorColor}-->" size="6" class="box6" />
                ～
                <input type="text" name="<!--{$key2}-->" value="<!--{$arrForm[$key2].value|h}-->" maxlength="<!--{$arrForm[$key2].length}-->" style="<!--{$arrErr[$key2]|sfGetErrorColor}-->" size="6" class="box6" />
            </td>
        </tr>
        <tr>
            <th>メール種別</th>
            <td>
                <!--{assign var=key value="search_contact_type"}-->
                <span class="attention"><!--{$arrErr[$key]}--></span>
                <select name="<!--{$key}-->" style="<!--{$arrErr[$key]|sfGetErrorColor}-->">
                <option value="">選択してください</option>
                <!--{html_options options=$arrCONTACT_TYPE selected=$arrForm[$key].value}-->
                </select>
            </td>
        </tr>
        <tr>
            <th>対応状況</th>
            <td>
                <!--{assign var=key value="search_status"}-->
                <span class="attention"><!--{$arrErr[$key]}--></span>
                <select name="<!--{$key}-->" style="<!--{$arrErr[$key]|sfGetErrorColor}-->">
                <option value="">選択してください</option>
                <!--{html_options options=$arrCONTACT_STATUS selected=$arrForm[$key].value}-->
                </select>
            </td>
        </tr>
    </table>

    <div class="btn">
        <p class="page_rows">検索結果表示件数
        <!--{assign var=key value="search_page_max"}-->
        <span class="attention"><!--{$arrErr[$key]}--></span>
        <select name="<!--{$arrForm[$key].keyname}-->" style="<!--{$arrErr[$key]|sfGetErrorColor}-->">
        <!--{html_options options=$arrPageMax selected=$arrForm[$key].value}-->
        </select> 件</p>
        <div class="btn-area">
            <ul>
                <li><a class="btn-action" href="javascript:;" onclick="fnFormModeSubmit('search_form', 'search', '', ''); return false;"><span class="btn-next">この条件で検索する</span></a></li>
            </ul>
        </div>
    </div>
    <!--検索条件設定テーブルここまで-->
</form>

<!--{if count($arrErr) == 0 and ($smarty.post.mode == 'search' or $smarty.post.mode == 'delete')}-->

<!--★★検索結果一覧★★-->
<form name="form1" id="form1" method="post" action="?">
<input type="hidden" name="<!--{$smarty.const.TRANSACTION_ID_NAME}-->" value="<!--{$transactionid}-->" />
<input type="hidden" name="mode" value="search" />
<input type="hidden" name="contact_id" value="" />
<!--{foreach key=key item=item from=$arrHidden}-->
    <!--{if is_array($item)}-->
        <!--{foreach item=c_item from=$item}-->
        <input type="hidden" name="<!--{$key|h}-->[]" value="<!--{$c_item|h}-->" />
        <!--{/foreach}-->
    <!--{else}-->
        <input type="hidden" name="<!--{$key|h}-->" value="<!--{$item|h}-->" />
    <!--{/if}-->
<!--{/foreach}-->
    <h2>検索結果一覧</h2>
        <div class="btn">
        <span class="attention"><!--検索結果数--><!--{$tpl_linemax}-->件</span>&nbsp;が該当しました。
    </div>
    <!--{if count($arrResults) > 0}-->

    <!--{include file=$tpl_pager}-->

    <!--{* 検索結果表示テーブル *}-->
        <table class="list">
        <col width="8%" />
        <col width="10%" />
        <col width="10%" />
        <col width="10%" />
        <col width="32%" />
        <col width="20%" />
        <col width="5%" />
        <col width="5%" />

        <tr>
            <th>送信番号</th>
            <th>送信日時</th>
            <th>メール種別</th>
            <th>対応状況</th>
            <th>件名</th>
            <th>メールアドレス</th>
            <th>詳細</th>
            <th>削除</th>
        </tr>

        <!--{section name=cnt loop=$arrResults}-->
        <!--{assign var=status value="`$arrResults[cnt].status`"}-->
        <!--{assign var=contact_type value="`$arrResults[cnt].contact_type`"}-->
        <tr style="background:<!--{$arrCONTACT_STATUS_COLOR[$status]}-->;">
            <td class="center"><!--{$arrResults[cnt].contact_id|h}--></td>
            <td class="center"><!--{$arrResults[cnt].create_date|sfDispDBDate}--></td>
            <td class="center"><!--{$arrCONTACT_TYPE[$contact_type]|h}--></td>
            <td class="center"><!--{$arrCONTACT_STATUS[$status]|h}--></td>
            <td class="center"><!--{$arrResults[cnt].subject|h}--></td>
            <td class="center"><!--{$arrResults[cnt].sender_email|h}-->
              <!--{if $arrResults[cnt].customer_id}--><br />【会員番号:<!--{$arrResults[cnt].customer_id}-->】<!--{/if}-->
            </td>
            <td class="center"><a href="?" onclick="fnChangeAction('./contact_history_edit.php'); fnModeSubmit('pre_edit', 'contact_id', '<!--{$arrResults[cnt].contact_id}-->'); return false;"><span class="icon_edit">編集</span></a></td>
            <td class="center"><a href="?" onclick="fnModeSubmit('delete', 'contact_id', '<!--{$arrResults[cnt].contact_id}-->'); return false;"><span class="icon_delete">削除</span></a></td>
        </tr>
        <!--{/section}-->

    </table>
    <!--{* 検索結果表示テーブル *}-->

    <!--{/if}-->

</form>
<!--{/if}-->
</div>
