<!--{*
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
 *}-->

<div id="undercolumn">
    <h2 class="title"><!--{$tpl_title|h}--></h2>

    <div id="undercolumn_contact">

        <form name="form1" method="post" action="?" enctype="multipart/form-data" >
        <input type="hidden" name="<!--{$smarty.const.TRANSACTION_ID_NAME}-->" value="<!--{$transactionid}-->" />
        <input type="hidden" name="mode" value="confirm" />

        <table summary="修理フォーム">
<!--{*## 顧客法人管理 ADD BEGIN ##*}-->
<!--{if $smarty.const.USE_CUSTOMER_COMPANY === true}-->
            <tr>
                <th>法人名</th>
                <td>
                    <!--{assign var=key value="company"}-->
                    <span class="attention"><!--{$arrErr[$key]}--></span>
                    <input type="text" name="<!--{$key}-->" value="<!--{$arrForm[$key]|default:$arrData[$key]}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key]|sfGetErrorColor}-->; ime-mode: active;" class="box380" />
                </td>
            </tr>
            <tr>
                <th>法人名(フリガナ)</th>
                <td>
                    <!--{assign var=key value="company_kana"}-->
                    <span class="attention"><!--{$arrErr[$key]}--></span>
                    <input type="text" name="<!--{$key}-->" value="<!--{$arrForm[$key]|default:$arrData[$key]}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key]|sfGetErrorColor}-->; ime-mode: active;" class="box380" />
                </td>
            </tr>
<!--{/if}-->
<!--{*## 顧客法人管理 ADD END ##*}-->
            <tr>
                <th>お名前<span class="attention">※</span></th>
                <td>
                    <span class="attention"><!--{$arrErr.name01}--><!--{$arrErr.name02}--></span>
                    姓&nbsp;<input type="text" class="box120" name="name01" value="<!--{$arrForm.name01|default:$arrData.name01|h}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr.name01|sfGetErrorColor}-->; ime-mode: active;" />　
                    名&nbsp;<input type="text" class="box120" name="name02" value="<!--{$arrForm.name02|default:$arrData.name02|h}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr.name02|sfGetErrorColor}-->; ime-mode: active;" />
                </td>
            </tr>
            <tr>
                <th>お名前(フリガナ)<span class="attention">※</span></th>
                <td>
                    <span class="attention"><!--{$arrErr.kana01}--><!--{$arrErr.kana02}--></span>
                    セイ&nbsp;<input type="text" class="box120" name="kana01" value="<!--{$arrForm.kana01|default:$arrData.kana01|h}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr.kana01|sfGetErrorColor}-->; ime-mode: active;" />　
                    メイ&nbsp;<input type="text" class="box120" name="kana02" value="<!--{$arrForm.kana02|default:$arrData.kana02|h}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr.kana02|sfGetErrorColor}-->; ime-mode: active;" />
                </td>
            </tr>
            <tr>
                <th>郵便番号</th>
                <td>
                    <span class="attention"><!--{$arrErr.zip01}--><!--{$arrErr.zip02}--></span>
                    <p class="top">
                        〒&nbsp;
                        <input type="text" name="zip01" class="box60" value="<!--{$arrForm.zip01|default:$arrData.zip01|h}-->" maxlength="<!--{$smarty.const.ZIP01_LEN}-->" style="<!--{$arrErr.zip01|sfGetErrorColor}-->; ime-mode: disabled;" />&nbsp;-&nbsp;
                        <input type="text" name="zip02" class="box60" value="<!--{$arrForm.zip02|default:$arrData.zip02|h}-->" maxlength="<!--{$smarty.const.ZIP02_LEN}-->" style="<!--{$arrErr.zip02|sfGetErrorColor}-->; ime-mode: disabled;" />　
                        <a href="http://search.post.japanpost.jp/zipcode/" target="_blank"><span class="mini">郵便番号検索</span></a>
                    </p>
                    <p class="zipimg">
                        <a href="javascript:fnCallAddress('<!--{$smarty.const.INPUT_ZIP_URLPATH}-->', 'zip01', 'zip02', 'pref', 'addr01');">
                            <img src="<!--{$TPL_URLPATH}-->img/button/btn_address_input.jpg" alt="住所自動入力" /></a>
                        <span class="mini">&nbsp;郵便番号を入力後、クリックしてください。</span>
                    </p>
                </td>
            </tr>
            <tr>
                <th>住所</th>
                <td>
                    <span class="attention"><!--{$arrErr.pref}--><!--{$arrErr.addr01}--><!--{$arrErr.addr02}--></span>

                    <select name="pref" style="<!--{$arrErr.pref|sfGetErrorColor}-->">
                    <option value="">都道府県を選択</option><!--{html_options options=$arrPREF selected=$arrForm.pref|default:$arrData.pref|h}--></select>

                    <p>
                        <input type="text" class="box380" name="addr01" value="<!--{$arrForm.addr01|default:$arrData.addr01|h}-->" style="<!--{$arrErr.addr01|sfGetErrorColor}-->; ime-mode: active;" /><br />
                        <!--{$smarty.const.SAMPLE_ADDRESS1}-->
                    </p>

                    <p>
                        <input type="text" class="box380" name="addr02" value="<!--{$arrForm.addr02|default:$arrData.addr02|h}-->" style="<!--{$arrErr.addr02|sfGetErrorColor}-->; ime-mode: active;" /><br />
                        <!--{$smarty.const.SAMPLE_ADDRESS2}-->
                    </p>

                    <p class="mini"><span class="attention">住所は2つに分けてご記入ください。マンション名は必ず記入してください。</span></p>
                </td>
            </tr>
            <tr>
                <th>電話番号<span class="attention">※</span></th>
                <td>
                    <span class="attention"><!--{$arrErr.tel01}--><!--{$arrErr.tel02}--><!--{$arrErr.tel03}--></span>
                    <input type="text" class="box60" name="tel01" value="<!--{$arrForm.tel01|default:$arrData.tel01|h}-->" maxlength="<!--{$smarty.const.TEL_ITEM_LEN}-->" style="<!--{$arrErr.tel01|sfGetErrorColor}-->; ime-mode: disabled;" />&nbsp;-&nbsp;
                    <input type="text" class="box60" name="tel02" value="<!--{$arrForm.tel02|default:$arrData.tel02|h}-->" maxlength="<!--{$smarty.const.TEL_ITEM_LEN}-->" style="<!--{$arrErr.tel02|sfGetErrorColor}-->; ime-mode: disabled;" />&nbsp;-&nbsp;
                    <input type="text" class="box60" name="tel03" value="<!--{$arrForm.tel03|default:$arrData.tel03|h}-->" maxlength="<!--{$smarty.const.TEL_ITEM_LEN}-->" style="<!--{$arrErr.tel03|sfGetErrorColor}-->; ime-mode: disabled;" />
                </td>
            </tr>
            <tr>
                <th>メールアドレス<span class="attention">※</span></th>
                <td>
                    <span class="attention"><!--{$arrErr.email}--><!--{$arrErr.email02}--></span>
                    <input type="text" class="box380 top" name="email" value="<!--{$arrForm.email|default:$arrData.email|h}-->" style="<!--{$arrErr.email|sfGetErrorColor}-->; ime-mode: disabled;" /><br />
                    <!--{* ログインしていれば入力済みにする *}-->
                    <!--{if $smarty.server.REQUEST_METHOD != 'POST' && $smarty.session.customer}-->
                    <!--{assign var=email02 value=$arrData.email}-->
                    <!--{/if}-->
                    <input type="text" class="box380" name="email02" value="<!--{$arrForm.email02|default:$email02|h}-->" style="<!--{$arrErr.email02|sfGetErrorColor}-->; ime-mode: disabled;" /><br />
                    <p class="mini"><span class="attention">確認のため2度入力してください。</span></p>
                </td>
            </tr>
            <tr>
                <th nowrap>商品名</th>
                <td>
                    <!--{assign var=key value="product_name"}-->
                    <span class="attention"><!--{$arrErr[$key]}--></span>
                    <input type="text" name="<!--{$key}-->" value="<!--{$arrForm[$key]|h}-->" />
                </td>
            </tr>
            <tr>
                <th nowrap>ご購入年月日</th>
                <td>
                    <!--{assign var=key1 value="buy_year"}-->
                    <!--{assign var=key2 value="buy_month"}-->
                    <!--{assign var=key3 value="buy_date"}-->
                    <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--><!--{$arrErr[$key3]}--></span>
                    <input type="text" name="<!--{$key1}-->" value="<!--{$arrForm[$key1]|h}-->" maxlength="4" class="box60"/>年&nbsp
                    <input type="text" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]|h}-->" maxlength="2" class="box60"/>月&nbsp
                    <input type="text" name="<!--{$key3}-->" value="<!--{$arrForm[$key3]|h}-->" maxlength="2" class="box60"/>日&nbsp
                </td>
            </tr>
            <tr>
                <th nowrap>修理内容</th>
                <td>
                    <!--{assign var=key value="repair_type"}-->
                    <!--{html_checkboxes name=$key options=$arrREPAIR_TYPE checked=$arrForm[$key]|h separator="&nbsp&nbsp"}--></select>
                </td>
            </tr>
            <tr>
                <th>修理状態・ご要望等<span class="attention">※</span><br />
                <span class="mini">（全角<!--{$smarty.const.MLTEXT_LEN}-->字以下）</span></th>
                <td>
                    <span class="attention"><!--{$arrErr.contents}--></span>
                    <textarea name="contents" class="box380" cols="65" rows="15" style="<!--{$arrErr.contents|h|sfGetErrorColor}-->; ime-mode: active;"><!--{"\n"}--><!--{$arrForm.contents|h}--></textarea>
                    
                    <br /><br /><span class="mini">修理アクセサリー画像アップロード</span><br />
                    <!--{foreach key=key item=item from=$arrHidden}-->
                    <input type="hidden" name="<!--{$key}-->" value="<!--{$item|h}-->" />
                    <!--{/foreach}-->
                    <!--{assign var=key value="image"}-->
                    <span class="attention"><!--{$arrErr[$key]}--></span>
                    <!--{if $arrFile[$key].filepath != ""}-->
                    <img src="<!--{$arrFile[$key].filepath}-->"/>
                    <a href="" onclick="fnModeSubmit('delete_image', '', ''); return false;">[画像の取り消し]</a><br />
                    <!--{/if}-->
                    <input type="file" name="<!--{$key}-->" size="40" style="<!--{$arrErr[$key]|sfGetErrorColor}--> display:inline-block;" />
                    <input type="button" name="btn" value="アップロード" onclick="fnModeSubmit('upload_image', '', ''); return false;">
                    <br /><span class="attention mini">「参照」でファイルを開いた後、必ず「アップロード」ボタンをクリックしてください。</span>
                </td>
            </tr>
        </table>

        <div class="btn_area">
            <ul>
                <li>
                    <input type="image" onmouseover="chgImgImageSubmit('<!--{$TPL_URLPATH}-->img/button/btn_confirm_on.jpg', this)" onmouseout="chgImgImageSubmit('<!--{$TPL_URLPATH}-->img/button/btn_confirm.jpg', this)" src="<!--{$TPL_URLPATH}-->img/button/btn_confirm.jpg" alt="確認ページへ" name="confirm" />
                </li>
            </ul>
        </div>

        </form>
    </div>
</div>
