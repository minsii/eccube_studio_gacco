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
<script type="text/javascript">//<![CDATA[
    function fnSetClassCategories(form, classcat_id2_selected) {
        var $form = $(form);
        var product_id = $form.find('input[name=product_id]').val();
        var $sele1 = $form.find('select[name=classcategory_id1]');
        var $sele2 = $form.find('select[name=classcategory_id2]');
        setClassCategories($form, product_id, $sele1, $sele2, classcat_id2_selected);
    }
    // 並び順を変更
    function fnChangeOrderby(orderby) {
        fnSetVal('orderby', orderby);
        fnSetVal('pageno', 1);
        fnSubmit();
    }
    // 表示件数を変更
    function fnChangeDispNumber(dispNumber) {
        fnSetVal('disp_number', dispNumber);
        fnSetVal('pageno', 1);
        fnSubmit();
    }
    // カゴに入れる
    function fnInCart(productForm) {
        var searchForm = $("#form1");
        var cartForm = $(productForm);
        // 検索条件を引き継ぐ
        var hiddenValues = ['mode','category_id','maker_id','name','orderby','disp_number','pageno','rnd'];
        $.each(hiddenValues, function(){
            // 商品別のフォームに検索条件の値があれば上書き
            if (cartForm.has('input[name='+this+']').length != 0) {
                cartForm.find('input[name='+this+']').val(searchForm.find('input[name='+this+']').val());
            }
            // なければ追加
            else {
                cartForm.append($('<input type="hidden" />').attr("name", this).val(searchForm.find('input[name='+this+']').val()));
            }
        });
        // 商品別のフォームを送信
        cartForm.submit();
    }
//]]></script>

<div id="undercolumn" class="pure-u-1">
    <form name="form1" id="form1" method="get" action="?">
        <input type="hidden" name="<!--{$smarty.const.TRANSACTION_ID_NAME}-->" value="<!--{$transactionid}-->" />
        <input type="hidden" name="mode" value="<!--{$mode|h}-->" />
        <!--{* ▼検索条件 *}-->
        <input type="hidden" name="category_id" value="<!--{$arrSearchData.category_id|h}-->" />
        <input type="hidden" name="maker_id" value="<!--{$arrSearchData.maker_id|h}-->" />
        <input type="hidden" name="name" value="<!--{$arrSearchData.name|h}-->" />
        <!--{* ▲検索条件 *}-->
        <!--{* ▼ページナビ関連 *}-->
        <input type="hidden" name="orderby" value="<!--{$orderby|h}-->" />
        <input type="hidden" name="disp_number" value="<!--{$disp_number|h}-->" />
        <input type="hidden" name="pageno" value="<!--{$tpl_pageno|h}-->" />
        <!--{* ▲ページナビ関連 *}-->
        <input type="hidden" name="rnd" value="<!--{$tpl_rnd|h}-->" />
    </form>

      <!--★タイトル★-->
      <div class="pure-u-1 lead">
        <!--{if $arrCategory.category_main_image}-->
        <img src="<!--{$smarty.const.IMAGE_SAVE_URLPATH|sfTrimURL}-->/<!--{$arrCategory.category_main_image|h}-->" width="695" height="309" alt="<!--{$arrCategory.category_main_image_alt|h}-->">
        <!--{/if}-->
      </div>
      <!--★説明欄★-->
      <div><!--{$arrCategory.category_info}--></div>

      <!--一覧-->
      <div class="pure-u-1 ">
    <!--★タイトル★-->
    <h2 class="title"><!--{$tpl_subtitle|h}--></h2>
    
        <!--ページネット-->
        <div class="box_pagination pure-u-1 ">
          <div class="pure-g-r"> <span class="pure-u-1-5"><!--{$tpl_linemax}-->件の商品がございます</span>
            <div class="pure-u-3-5 text-center">
              <div class="pure-menu pure-menu-open pure-menu-horizontal">
                <!--{include file="list_pager.tpl"}-->
              </div>
            </div>
            <span class="pure-u-1-5 pure-g-r">
                <span class="pure-u-1-2 btn">
                    <!--{if $orderby != 'price'}-->
                        <a href="javascript:fnChangeOrderby('price_up');">価格順</a>
                    <!--{else}-->
                        価格順
                    <!--{/if}-->
                </span>  
                <span class="pure-u-1-2 btn">
                    <!--{if $orderby != "date"}-->
                        <a href="javascript:fnChangeOrderby('date');">新着順</a>
                    <!--{else}-->
                        新着順
                    <!--{/if}--> 
                </span>
             </span>
           </div>
        </div>
    
        <!--ウエスタンブーツ-->
        <div class="box_product_list pure-u-1 row">
        <div class=" thumbnails">
        <!--{foreach from=$arrProducts item=arrProduct name=arrProducts}-->
            <!--{assign var=id value=$arrProduct.product_id}-->
            <!--{assign var=arrErr value=$arrProduct.arrErr}-->
            <!--▼商品-->
            <form name="product_form<!--{$id|h}-->" action="?" onsubmit="return false;">
            <input type="hidden" name="<!--{$smarty.const.TRANSACTION_ID_NAME}-->" value="<!--{$transactionid}-->" />
                <div class="col-xs-4">
                  <div class="thumbnail">
                    <div class="img"><a href="<!--{$smarty.const.P_DETAIL_URLPATH|sfGetFormattedUrl:$arrProduct.product_id}-->"><img src="<!--{$smarty.const.IMAGE_SAVE_URLPATH}--><!--{$arrProduct.main_list_image|sfNoImageMainList|h}-->" alt="<!--{$arrProduct.name|h}-->." width="194" height="194" border="0" data-src="holder.js/300x200"></a></div>
                    <!--▼商品ステータス-->
                    <!--{if count($productStatus[$id]) > 0}-->
                    <div class="icons pure-g-r">
                        <!--{foreach from=$productStatus[$id] item=status}-->
                            <div class="pure-u-1-2"><img src="<!--{$TPL_URLPATH}--><!--{$arrSTATUS_IMAGE[$status]}-->" alt="<!--{$arrSTATUS[$status]}-->" /></div>
                        <!--{/foreach}-->
                    </div>
                    <!--{/if}-->
                    <!--▲商品ステータス-->
                    <div class="caption">
                    <!--★商品名★-->
                      <h3><a href="<!--{$smarty.const.P_DETAIL_URLPATH|sfGetFormattedUrl:$arrProduct.product_id}-->"><!--{$arrProduct.name|h}--></a><br />
                       <!--★価格★-->
                        <!--{if $arrProduct.price02_min_inctax == $arrProduct.price02_max_inctax}-->
                            ￥<!--{$arrProduct.price02_min_inctax|number_format}-->
                        <!--{else}-->
                            ￥<!--{$arrProduct.price02_min_inctax|number_format}-->～<!--{$arrProduct.price02_max_inctax|number_format}-->
                        <!--{/if}-->(税込)</h3>
                      <ul class="list-group">
                        <li class="list-group-item"><span class="pure-u-1-3">高さ</span><!--{$arrProduct.size_height|h}--></li>
                        <li class="list-group-item"><span class="pure-u-1-3">筒幅</span><!--{$arrProduct.size_insidelen|h}--></li>
                        <li class="list-group-item"><span class="pure-u-1-3">革</span><!--{$arrProduct.material_corium|h}--></li>
                      </ul>
                      <p><!--{$arrProduct.main_list_comment|h|nl2br}--></p>
                    </div>
                        <!--{if $tpl_stock_find[$id]}-->
                    <a href="<!--{$smarty.const.P_DETAIL_URLPATH|sfGetFormattedUrl:$arrProduct.product_id}-->"><img src="<!--{$TPL_URLPATH}-->img/page/ichiran/btn_detail.png" border="0" /></a> 
                        <!--{else}-->
                    <a href="<!--{$smarty.const.P_DETAIL_URLPATH|sfGetFormattedUrl:$arrProduct.product_id}-->"><img src="<!--{$TPL_URLPATH}-->img/page/ichiran/btn_hinkire.png" width="218" height="30" border="0" /></a> 
                        <!--{/if}-->
                  </div>
                </div>
            </form>
            <!--▲商品-->
        <!--{foreachelse}-->
            <!--{include file="frontparts/search_zero.tpl"}-->
        <!--{/foreach}-->
        </div>
        
        </div>

        <!--ページネット-->
        <div class="box_pagination pure-u-1 ">
          <div class="pure-g-r"> <span class="pure-u-1-5"><!--{$tpl_linemax}-->件の商品がございます</span>
            <div class="pure-u-3-5 text-center">
              <div class="pure-menu pure-menu-open pure-menu-horizontal">
                <!--{include file="list_pager.tpl"}-->
              </div>
            </div>
            <span class="pure-u-1-5 pure-g-r">
                <span class="pure-u-1-2 btn">
                    <!--{if $orderby != 'price'}-->
                        <a href="javascript:fnChangeOrderby('price_up');">価格順</a>
                    <!--{else}-->
                        価格順
                    <!--{/if}-->
                </span>  
                <span class="pure-u-1-2 btn">
                    <!--{if $orderby != "date"}-->
                        <a href="javascript:fnChangeOrderby('date');">新着順</a>
                    <!--{else}-->
                        新着順
                    <!--{/if}--> 
                </span>
             </span>
          </div>
        </div>
    
    </div>


<script language="javascript">
	function equalHeight(group) {
		tallest = 0;
		group.each(function() {
		thisHeight = $(this).height();
		if(thisHeight > tallest) {
		tallest = thisHeight;
		}
		});
		group.each(function() { $(this).height(tallest); });
	}
	
	$(document).ready(function() {
		equalHeight($('.box_product_list .thumbnail'));
	});

</script>
</div>
