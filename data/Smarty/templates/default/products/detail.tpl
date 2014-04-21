<!--{*
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
 *}-->

<script type="text/javascript" src="<!--{$smarty.const.ROOT_URLPATH}-->js/products.js"></script>
<script type="text/javascript" src="<!--{$smarty.const.ROOT_URLPATH}-->js/jquery.facebox/facebox.js"></script>
<link rel="stylesheet" type="text/css" href="<!--{$smarty.const.ROOT_URLPATH}-->js/jquery.facebox/facebox.css" media="screen" />
<script type="text/javascript">//<![CDATA[
    // 規格2に選択肢を割り当てる。
    function fnSetClassCategories(form, classcat_id2_selected) {
        var $form = $(form);
        var product_id = $form.find('input[name=product_id]').val();
        var $sele1 = $form.find('select[name=classcategory_id1]');
        var $sele2 = $form.find('select[name=classcategory_id2]');
        setClassCategories($form, product_id, $sele1, $sele2, classcat_id2_selected);
    }
    $(document).ready(function() {
        $('a.expansion').facebox({
            loadingImage : '<!--{$smarty.const.ROOT_URLPATH}-->js/jquery.facebox/loading.gif',
            closeImage   : '<!--{$smarty.const.ROOT_URLPATH}-->js/jquery.facebox/closelabel.png'
        });
    });

    function changeMainImg(img){
      $("#main_image").attr("src", img);
    }
    function resetMainImg(){
      $("#main_image").attr("src", "<!--{$arrFile.main_image.filepath|h}-->");
    }

//]]></script>

<div id="undercolumn" class=" pure-u-1">
    <form name="form1" id="form1" method="post" action="?">
    <input type="hidden" name="<!--{$smarty.const.TRANSACTION_ID_NAME}-->" value="<!--{$transactionid}-->" />





          <!--★タイトル★-->
          <div class="pure-u-1 detail_main_img">
          <!--{$arrProductOther.main_comment}--><!--{* 詳細コメント1 *}-->
          </div>

          <!--オイルレザーに本格的なウエスタン-->
          <!--{if $arrProductOther.comment2}-->
          <div class="pure-u-1 box_detail_product_point">
          <!--{$arrProductOther.comment2}--><!--{* 詳細コメント２ *}-->
          </div>
          <!--{/if}-->

          <!--使い込むほどに味が出るチョコのオイルレザー-->
          <!--{if $arrProductOther.comment4}-->
          <div class="pure-u-1 box_detail_product_point2">
          <!--{$arrProductOther.comment4}--><!--{* 詳細コメント3 *}-->
          </div>
          <!--{/if}-->

          <!--スタッフ職人の声-->
          <!--{if $arrProductOther.comment4}-->
          <div class="pure-u-1">
          <!--{$arrProductOther.comment5}--><!--{* 詳細コメント4 *}-->
          </div>
          <!--{/if}-->

          <!--サイズについて-->
          <!--{if $arrProductOther.comment6}-->
          <div class="box_sizu_info pure-u-1">
          <!--{$arrProductOther.comment6}--><!--{* 詳細コメント5 *}-->
          </div>
          <!--{/if}-->

          <!--商品詳細-->
          <div class="box_product_detail pure-u-1">
            <h2><!--{$arrProduct.name|h}--></h2>
            <div class="pure-g-r">
              <div class="left_detail_info pure-u-1-2 pure-g-r">
                <div class="pure-u-1">
                <!--{assign var=key value="main_image"}-->
                <!--★画像★-->
                <!--{if $arrProduct.main_large_image|strlen >= 1}-->
                    <a
                        href="<!--{$smarty.const.IMAGE_SAVE_URLPATH}--><!--{$arrProduct.main_large_image|h}-->"
                        data-lightbox="detail" title="<!--{$arrProduct.name|h}-->"
                    >
                <!--{/if}-->
                    <img src="<!--{$arrFile[$key].filepath|h}-->" width="<!--{$arrFile[$key].width}-->"
                      height="<!--{$arrFile[$key].height}-->" alt="<!--{$arrProduct.name|h}-->" class="picture" id="main_image"/>
                <!--{if $arrProduct.main_large_image|strlen >= 1}-->
                    </a>
                <!--{/if}--><br />
                </div>


              <!--{section name=cnt loop=$smarty.const.PRODUCTSUB_MAX}-->
              <!--★サブ画像<!--{$smarty.section.cnt.iteration}-->-->
              <!--{assign var=key_title value="sub_title`$smarty.section.cnt.index+1`"}-->
              <!--{assign var=key value="sub_image`$smarty.section.cnt.iteration`"}-->
              <!--{assign var=key1 value="sub_large_image`$smarty.section.cnt.iteration`"}-->
              <!--{if $arrProductOther[$key]|strlen >= 1}-->
                <div class="pure-u-1-3">
                  <!--{if $arrProductOther[$key1]|strlen >= 1}-->
                    <a href="<!--{$smarty.const.IMAGE_SAVE_URLPATH}--><!--{$arrProductOther[$key1]|h}-->"
                      data-lightbox="detail" title="<!--{$arrProduct.name|h}-->">
                  <!--{/if}-->
                      <img src="<!--{$arrFile[$key].filepath|h}-->" width="100" alt="<!--{$arrProductOther[$key_title]|h}-->" border="0"
                      onmouseover="changeMainImg('<!--{$smarty.const.IMAGE_SAVE_URLPATH}--><!--{$arrProductOther[$key1]|h}-->');"
                      onmouseout="resetMainImg();"/>
                  <!--{if $arrProductOther[$key1]|strlen >= 1}--></a><!--{/if}-->
                </div>
              <!--{/if}-->
              <!--{/section}-->

              </div>
              <div class="right_detail_info pure-u-1-2">
                <h4><!--{$arrProduct.name|h}--></h4>
                <div>商品コード：
                        <!--{if $arrProduct.product_code_min == $arrProduct.product_code_max}-->
                            <!--{$arrProduct.product_code_min|h}-->
                        <!--{else}-->
                            <!--{$arrProduct.product_code_min|h}-->～<!--{$arrProduct.product_code_max|h}-->
                        <!--{/if}--></div>
                <p>販売価格：<span class="price_number"><span id="price02_default"><!--{strip}-->
                        <!--{if $arrProduct.price02_min_inctax == $arrProduct.price02_max_inctax}-->
                            <!--{$arrProduct.price02_min_inctax|number_format}-->
                        <!--{else}-->
                            <!--{$arrProduct.price02_min_inctax|number_format}-->～<!--{$arrProduct.price02_max_inctax|number_format}-->
                        <!--{/if}-->
                    </span><span id="price02_dynamic"></span><!--{/strip}--></span> (税込)<br />
                  発送までの目安：ご注文から<!--{$arrDELIVERYDATE[$arrProduct.deliv_date_id]|h}--><br />

                <!--{*在庫表*}-->
                <!--{if $tpl_classcat_find1}-->
                <table class="pure-u-1">
                  <colgroup>
                  <col width="50%" />
                  <col width="50%" />
                  </colgroup>
                  <tr>
                    <th><div class="text-center"><!--{$tpl_class_name1|h}--></div></th>
                    <th ><div class="text-center">在庫</div></th>
                  </tr>
                  <tr>
                    <!--{foreach from=$arrClassCat1 key=clsid item=clscat_name}-->
                    <!--{if $clsid > 0}-->
                    <!--{assign var=pdctClsStock value=$arrProductClassStock[$clsid]}-->
                    <tr>
                      <td class="size"><div class="text-center"><!--{$pdctClsStock.name|h}--></div></td>
                      <td><div class="text-center">
                          <!--{if  $pdctClsStock.custom_made}-->▲
                          <!--{elseif $pdctClsStock.stock>0 || $pdctClsStock.stock_unlimited}-->○<!--{else}-->×<!--{/if}-->
                      </div></td>
                    </tr>
                    <!--{/if}-->
                    <!--{/foreach}-->
                  </tr>
                </table>
                <!--{/if}-->

                <div class="pure-u-1 pure-g-r">
                <input type="hidden" name="mode" value="cart" />
                <input type="hidden" name="product_id" value="<!--{$tpl_product_id}-->" />
                <input type="hidden" name="product_class_id" value="<!--{$tpl_product_class_id}-->" id="product_class_id" />
                <input type="hidden" name="favorite_product_id" value="" />
            <!--{if $tpl_stock_find}-->
                  <ul class="list-group pure-u-1">
                <!--{if $tpl_classcat_find1}-->
                    <li class="list-group-item">
                    	<span>
                        <!--▼規格1-->
                        <ul class="clearfix">
                            <li><!--{$tpl_class_name1|h}-->：
                                <select name="classcategory_id1" style="<!--{$arrErr.classcategory_id1|sfGetErrorColor}-->">
                                <!--{html_options options=$arrClassCat1 selected=$arrForm.classcategory_id1.value}-->
                                </select>
                                <!--{if $arrErr.classcategory_id1 != ""}-->
                                <br /><span class="attention">※ <!--{$tpl_class_name1}-->を入力して下さい。</span>
                                <!--{/if}-->
                            </li>
                        </ul>
                        <!--▲規格1-->

                        <!--{if $tpl_classcat_find2}-->
                        <!--▼規格2-->
                        <ul class="clearfix">
                            <li><!--{$tpl_class_name2|h}-->：
                                <select name="classcategory_id2" style="<!--{$arrErr.classcategory_id2|sfGetErrorColor}-->">
                                </select>
                                <!--{if $arrErr.classcategory_id2 != ""}-->
                                <br /><span class="attention">※ <!--{$tpl_class_name2}-->を入力して下さい。</span>
                                <!--{/if}-->
                            </li>
                        </ul>
                        <!--▲規格2-->
                        <!--{/if}-->
                      </span>
                    </li>
                <!--{/if}-->
                    <li class="list-group-item">数量 <span>
                        <select name="quantity" style="<!--{$arrErr.quantity|sfGetErrorColor}-->">
                          <!--{html_options options=$arrQUANTITY selected=$arrForm.quantity.value|default:1}-->
                        </select>
                        <!--{if $arrErr.quantity != ""}-->
                            <br /><span class="attention"><!--{$arrErr.quantity}--></span>
                        <!--{/if}-->
                      </span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!--★カゴに入れる★-->
                      <span class="text-right" style="display:inline-block;"><a href="javascript:void(document.form1.submit())"><img src="<!--{$TPL_URLPATH}-->img/page/detail/btn_kaimono.png" alt="カゴに入れる"/></a></span>
                    </li>
                  </ul>
            <!--{else}-->
                  <ul class="list-group pure-u-1">
                    <li class="list-group-item">
                      <div class="attention">申し訳ございませんが、只今品切れ中です。</div>
                      <span class="text-right" style="display:inline-block;">
                        <img src="<!--{$TPL_URLPATH}-->img/page/detail/btn_kaimono.png" alt="SOLDOUT"/>
                      </span>
                    </li>
                  </ul>
            <!--{/if}-->

                </div>

                <div class="pure-u-1"> </div>
                <div class="pure-u-1 pure-g-r"> <span class="pure-u-1-2 panel-body"><a href="#"><img src="<!--{$TPL_URLPATH}-->img/page/detail/btn_otodoke.png" border="0" /></a></span> <span class="pure-u-1-2 panel-body"><a href="#"><img src="<!--{$TPL_URLPATH}-->img/page/detail/btn_shiharai.png" border="0" /></a></span> </div>
                <div class="pure-u-1"> </div>
                <div class="pure-u-1 text-right"> <a href="#">>> 返品についての詳細はこちら</a> </div>
                <div class="pure-u-1 text-right">
                  <!--{if $arrProduct.product_code_min == $arrProduct.product_code_max}-->
                  <a href="<!--{$smarty.const.ROOT_URLPATH}-->contact/index.php?product_name=<!--{$arrProductOther.name|h}-->【<!--{$arrProduct.product_code_min|h}-->】">
                  <!--{else}-->
                  <a href="<!--{$smarty.const.ROOT_URLPATH}-->contact/index.php?product_name=<!--{$arrProductOther.name|h}-->【<!--{$arrProduct.product_code_min|h}-->～<!--{$arrProduct.product_code_max|h}-->】">
                  <!--{/if}-->
                  >> この商品を問い合わせる</a>
                </div>
                <div class="pure-u-1 text-right"> <a href="#">>> FAXでのご注文はこちら</a> </div>
              </div>
            </div>
          </div>

          <!--商品詳細１-->
          <div class="box_product_detail1 pure-u-1">
            <h2>商品詳細</h2>
            <div class="pure-g-r">
              <table class="pure-u-1">
                <colgroup>
                <col width="20%" />
                <col width="80%" />
                </colgroup>
                <tr>
                  <th>商品名</th>
                  <td><!--{$arrProductOther.name|h}--></td>
                </tr>
                <tr>
                  <th>商品コード</th>
                  <td><!--{if $arrProduct.product_code_min == $arrProduct.product_code_max}-->
                            <!--{$arrProduct.product_code_min|h}-->
                        <!--{else}-->
                            <!--{$arrProduct.product_code_min|h}-->～<!--{$arrProduct.product_code_max|h}-->
                        <!--{/if}-->
                  </td>
                </tr>
                <!--{if $arrProductOther.size}-->
                <tr>
                  <th>大きさ</th>
                  <td><!--{$arrProductOther.size|nl2br}--></td>
                </tr>
                <!--{/if}-->
                <!--{if $arrProductOther.weight}-->
                <tr>
                  <th>重さ</th>
                  <td><!--{$arrProductOther.weight|nl2br}--></td>
                </tr>
                <!--{/if}-->
                <!--{if $arrProductOther.material}-->
                <tr>
                  <th>使用素材</th>
                  <td><!--{$arrProductOther.material|nl2br}--></td>
                </tr>
                <!--{/if}-->
                <!--{if $arrProductOther.service}-->
                <tr>
                  <th>各種サービス</th>
                  <td><!--{$arrProductOther.service|nl2br}--></td>
                </tr>
                <!--{/if}-->
                <!--{if $arrProductOther.packing}-->
                <tr>
                  <th>包材仕様</th>
                  <td><!--{$arrProductOther.packing|nl2br}--></td>
                </tr>
                <!--{/if}-->
                <tr>
                  <th>通常発送お届け目安</th>
                  <td>ご注文から<!--{$arrDELIVERYDATE[$arrProduct.deliv_date_id]|h}--></td>
                </tr>
                <!--{if $arrProductOther.attention}-->
                <tr>
                  <th>商品のご注意</th>
                  <td><!--{$arrProductOther.attention|nl2br}--></td>
                </tr>
                <!--{/if}-->
              </table>
            </div>
          </div>


          <div class="box_toudouhin pure-u-1 hide" >
            <h2><img src="<!--{$TPL_URLPATH}-->img/page/detail/h3_toudouhin.png" /></h2>
            <div class="pure-g-r">
              <div class="pure-u-1-4">
                <div><a href="#"><img src="<!--{$TPL_URLPATH}-->img/page/detail/img_15.png" border="0" /></a></div>
                <p> <a href="#">テキスト</a><br />
                  <a href="#">テキスト</a><br />
                  テキスト </p>
              </div>
              <div class="pure-u-1-4">
                <div><a href="#"><img src="<!--{$TPL_URLPATH}-->img/page/detail/img_15.png" border="0" /></a></div>
                <p> <a href="#">テキスト</a><br />
                  <a href="#">テキスト</a><br />
                  テキスト </p>
              </div>
              <div class="pure-u-1-4">
                <div><a href="#"><img src="<!--{$TPL_URLPATH}-->img/page/detail/img_15.png" border="0" /></a></div>
                <p> <a href="#">テキスト</a><br />
                  <a href="#">テキスト</a><br />
                  テキスト </p>
              </div>
              <div class="pure-u-1-4">
                <div><a href="#"><img src="<!--{$TPL_URLPATH}-->img/page/detail/img_15.png" border="0" /></a></div>
                <p> <a href="#">テキスト</a><br />
                  <a href="#">テキスト</a><br />
                  テキスト </p>
              </div>
            </div>
          </div>

      <!--{* 関連商品 ここから *}-->
      <!--{if $arrRecommend}-->
      <div class="box_toudouhin pure-u-1">
        <h2><img src="<!--{$TPL_URLPATH}-->img/page/detail/h3_toudouhin.png" /></h2>
        <div class="pure-g-r">
            <!-- "previous page" action -->
            <a class="prev browse left">◀</a>
            <!-- root element for scrollable -->
            <div class="scrollable body" id="scrollable">
              <!--{foreach from=$arrRecommend item=arrItem name="arrRecommend"}-->
                <!--{assign var=price01_min value=`$arrItem.price01_min`}-->
                <!--{assign var=price01_max value=`$arrItem.price01_max`}-->
                <!--{assign var=price02_min value=`$arrItem.price02_min`}-->
                <!--{assign var=price02_max value=`$arrItem.price02_max`}-->
                <!--{assign var=product_code_min value=`$arrItem.product_code_min`}-->
                <!--{assign var=product_code_max value=`$arrItem.product_code_max`}-->
                <!--{assign var=taxfree value=`$arrItem.taxfree`}-->
                <!--{math equation="x % y == 0" x=$smarty.foreach.arrRecommend.iteration y=4 assign=right}-->
                <!--{math equation="x % y == 1" x=$smarty.foreach.arrRecommend.iteration y=4 assign=left}-->

                <!--{if $left}--><div id="<!--{$smarty.foreach.arrRecommend.iteration}--> "><!-- <!--{$smarty.foreach.arrRecommend.iteration}--> start --><!--{/if}-->
                <div class="pure-u-1-4">
                  <div>
                    <a href="<!--{$smarty.const.P_DETAIL_URLPATH|sfGetFormattedUrl:$arrItem.product_id}-->">
                      <img src="<!--{$smarty.const.IMAGE_SAVE_URLPATH}--><!--{$arrItem.main_list_image|h}-->" width="156" alt="<!--{$arrItem.name|h}-->" />
                    </a>
                  </div>
                  <p>
                      <a href="<!--{$smarty.const.P_DETAIL_URLPATH|sfGetFormattedUrl:$arrItem.product_id}-->">
                        <!--{$arrItem.name|h}-->（<!--{if $product_code_min == $product_code_max}--><!--{$product_code_min|h}-->
                            <!--{else}--><!--{$product_code_min|h}-->～<!--{$product_code_min|h}--><!--{/if}-->）
                      </a>
                  </p>
                  <p>
                  <!--{if $taxfree == 1}-->
                    <strong>￥<!--{if $price02_min == $price02_max}-->
                        <!--{$price02_min|number_format}-->
                    <!--{else}-->
                        <!--{$price02_min|number_format}-->～<!--{$price02_max|number_format}-->
                    <!--{/if}--></strong><em>(税抜)</em>
                  <!--{else}-->
                    <strong>￥<!--{if $price02_min == $price02_max}-->
                        <!--{$price02_min|sfCalcIncTax:$arrSiteInfo.tax:$arrSiteInfo.tax_rule|number_format}-->
                    <!--{else}-->
                        <!--{$price02_min|sfCalcIncTax:$arrSiteInfo.tax:$arrSiteInfo.tax_rule|number_format}-->～<!--{$price02_max|sfCalcIncTax:$arrSiteInfo.tax:$arrSiteInfo.tax_rule|number_format}-->
                    <!--{/if}--></strong><em>(税込)</em>
                  <!--{/if}-->
                  </p>
                </div>
                <!--{if $right || $smarty.foreach.arrRecommend.last}--></div><!--{/if}-->
              <!--{/foreach}-->
            </div><!-- /scrollable -->
            <!-- "next page" action -->
            <a class="next browse right">▶</a>
        </div>
      </div>
      <!--{/if}-->
      <!--{* 関連商品 ここまで *}-->

</form>

</div>
