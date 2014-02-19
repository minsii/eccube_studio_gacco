<!--{*
/*
 * This file is part of EC-CUBE
 *
 * Copyright(c) 2000-2011 LOCKON CO.,LTD. All Rights Reserved.
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
<script type="text/javascript">
<!--
$(function(){
    var oFCKeditor = new FCKeditor() ;
    oFCKeditor.BasePath = '<!--{$TPL_URLPATH}-->js/fckeditor/' ;
    oFCKeditor.Height='320';
    oFCKeditor.InstanceName = 'portfolio_category_info';
    oFCKeditor.ToolbarSet = 'ECCUBEcat';
    oFCKeditor.ReplaceTextarea() ;

    var oFCKeditor2 = new FCKeditor() ;
    oFCKeditor2.BasePath = '<!--{$TPL_URLPATH}-->js/fckeditor/' ;
    oFCKeditor2.Height='320';
    oFCKeditor2.InstanceName = 'portfolio_category_info2';
    oFCKeditor2.ToolbarSet = 'ECCUBEcat';
    oFCKeditor2.ReplaceTextarea() ;
});

// target の子要素を選択状態にする
function selectAll(target) {
    $('#' + target).children().attr({selected: true});
}
//-->
</script>


<div id="admin-contents" class="contents-main">
    <form name="form1" id="form1" method="post" action="?">
    <input type="hidden" name="<!--{$smarty.const.TRANSACTION_ID_NAME}-->" value="<!--{$transactionid}-->" />
    <input type="hidden" name="mode" value="edit">
    <input type="hidden" name="portfolio_category_id" value="<!--{$arrForm.portfolio_category_id}-->">
    <input type="hidden" name="image_key" value="">
    <input type="hidden" name="temp_portfolio_category_main_image" value="<!--{$arrForm.portfolio_category_main_image}-->">

    <!--{* ▼登録テーブルここから *}-->
      <table>
          <tr>
              <td><span class="attention"><!--{$arrErr.portfolio_category_name}--></span>
                  事例カテゴリ名<span class="attention"> *</span>
                  <input type="text" name="portfolio_category_name" value="<!--{$arrForm.portfolio_category_name|escape}-->" size="30" class="box30" maxlength="<!--{$smarty.const.STEXT_LEN}-->"/><span class="attention"> (上限<!--{$smarty.const.STEXT_LEN}-->文字)
              </td>
          </tr>
          <tr>
          <tr>
              <td>フリースペース-上部<textarea name="portfolio_category_info" id="portfolio_category_info" cols="60" rows="10"><!--{$arrForm.portfolio_category_info|escape}--></textarea><br />
                  <span class="attention"> (上限<!--{$smarty.const.LLTEXT_LEN}-->文字)</span>
              </td>
          </tr>
          <tr>
              <td>フリースペース-下部<textarea name="portfolio_category_info2" id="portfolio_category_info2" cols="60" rows="10"><!--{$arrForm.portfolio_category_info2|escape}--></textarea><br />
                  <span class="attention"> (上限<!--{$smarty.const.LLTEXT_LEN}-->文字)</span>
              </td>
          </tr>

          <tr>
              <td>ページタイトル
                  <span class="attention"><!--{$arrErr.title}--></span>
                  <input type="text" name="title" value="<!--{$arrForm.title|escape}-->" size="30" class="box30" maxlength="<!--{$smarty.const.STEXT_LEN}-->"/><span class="attention"> (上限<!--{$smarty.const.STEXT_LEN}-->文字)</span>
              </td>
          </tr>
          <tr>
              <td>メタタグ:Description
                  <span class="attention"><!--{$arrErr.description}--></span>
                  <input type="text" name="description" value="<!--{$arrForm.description|escape}-->" size="30" class="box30" maxlength="<!--{$smarty.const.STEXT_LEN}-->"/><span class="attention"> (上限<!--{$smarty.const.STEXT_LEN}-->文字)</span>
              </td>
          </tr>
          <tr>
              <td>メタタグ:Keywords
                  <span class="attention"><!--{$arrErr.keyword}--></span>
                  <input type="text" name="keyword" value="<!--{$arrForm.keyword|escape}-->" size="30" class="box30" maxlength="<!--{$smarty.const.STEXT_LEN}-->"/><span class="attention"> (上限<!--{$smarty.const.STEXT_LEN}-->文字)</span>
              </td>
          </tr>
          <tr>
              <td>h1テキスト
                  <span class="attention"><!--{$arrErr.h1}--></span>
                  <input type="text" name="h1" value="<!--{$arrForm.h1|escape}-->" size="30" class="box30" maxlength="<!--{$smarty.const.SMTEXT_LEN}-->"/><span class="attention"> (上限<!--{$smarty.const.SMTEXT_LEN}-->文字)</span>
              </td>
          </tr>
      </table>
    <!--{* ▲登録テーブルここまで *}-->

      <div class="btn-area">
          <ul>
              <li><a class="btn-action" href="javascript:;" onclick="fnModeSubmit('register', '', ''); return false"><span class="btn-next">登録</span></a></li>
          </ul>
      </div>
    </form>

    <h2>事例カテゴリ一覧</h2>
    <!--{* ▼一覧表示エリアここから *}-->
    <!--{if count($arrList) > 0}-->
    <table class="list">
        <tr>
            <td width="30">ID</td>
            <td width="160">事例カテゴリ名</td>
            <td width="60">編集</td>
            <td width="60">削除</td>
            <td width="60">移動</td>
        </tr>
        <!--{section name=cnt loop=$arrList}-->
        <tr bgcolor="<!--{if $arrForm.portfolio_category_id != $arrList[cnt].portfolio_category_id}-->#ffffff<!--{else}--><!--{$smarty.const.SELECT_RGB}--><!--{/if}-->" align="left">
            <td><!--{$arrList[cnt].portfolio_category_id}--></td>
            <td><!--{$arrList[cnt].portfolio_category_name|escape}--></td>
            <td align="center">
                <!--{if $arrForm.portfolio_category_id != $arrList[cnt].portfolio_category_id}-->
                <a href="<!--{$smarty.server.PHP_SELF|escape}-->" onclick="fnModeSubmit('pre_edit', 'portfolio_category_id', <!--{$arrList[cnt].portfolio_category_id}-->); return false;" />編集</a>
                <!--{else}-->
                編集中
                <!--{/if}-->
            </td>
            <td align="center">
                <a href="<!--{$smarty.server.PHP_SELF|escape}-->" onclick="fnModeSubmit('delete', 'portfolio_category_id', <!--{$arrList[cnt].portfolio_category_id}-->); return false;" />削除</a>
            </td>
            <td align="center">
              <!--{* 移動 *}-->
              <!--{if $smarty.section.cnt.iteration != 1}-->
              <a href="<!--{$smarty.server.PHP_SELF|escape}-->" onclick="fnModeSubmit('up','portfolio_category_id', <!--{$arrList[cnt].portfolio_category_id}-->); return false;">上へ</a>
              <!--{/if}-->
              <!--{if $smarty.section.cnt.iteration != $smarty.section.cnt.last}-->
              <a href="<!--{$smarty.server.PHP_SELF|escape}-->" onclick="fnModeSubmit('down','portfolio_category_id', <!--{$arrList[cnt].portfolio_category_id}-->); return false;">下へ</a>
              <!--{/if}-->
            </td>
        </tr>
        <!--{/section}-->
    </table>

    <!--{else}-->
    <table>
        <tr class="center">
            <td>事例カテゴリが登録されていません。</td>
        </tr>
    </table>
    <!--{/if}-->
    <!--{* ▲一覧表示エリアここまで *}-->

</div>
