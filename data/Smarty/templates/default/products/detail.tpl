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
//]]></script>

<div id="undercolumn" class=" pure-u-1">
    <form name="form1" id="form1" method="post" action="?">
    <input type="hidden" name="<!--{$smarty.const.TRANSACTION_ID_NAME}-->" value="<!--{$transactionid}-->" />
    
    
    
    
    
          <!--★タイトル★-->
          <div class="pure-u-1 detail_main_img"> <img src="<!--{$TPL_URLPATH}-->img/page/detail/main_img_01.png" width="695" height="309">
            <p>どんなタイプの装いにもとても合わせやすいベーシックなお色のウエスタンブーツ。<br />
デニムはもちろん甘系のふんわりスカートにも相性良しで、何気ない、いつものスタイルがグッとオシャレになる使えるアイテムです。</p>
          </div>
          
          <!--オイルレザーに本格的なウエスタン-->
          <div class="pure-u-1 box_detail_product_point">
            <h2 class="title1">オイルレザーに本格的なウエスタン刺繍を施したAll japan made のオリジナル</h2>
            <div class="pure-g-r">
              <div class="point_1">
                <div class="pure-u-1">
                  <h3><span>Point:1</span>日本人の足に合う様設計</h3>
                </div>
                <div class="pure-u-3-5">
                  <div><img src="<!--{$TPL_URLPATH}-->img/page/detail/img_01.png" /></div>
                  <p>使用している木型はインポートの本格的ウエスタンブーツ木型の特徴を生かしつつ日本人の足に合う様設計された物になっていますので足入れがよく、甲高・幅広の足の方にも好評頂いております。</p>
                </div>
                <div class="pure-u-2-5"> <img src="<!--{$TPL_URLPATH}-->img/page/detail/img_02.png" /> </div>
              </div>
              <div class="point_2 pure-u-1-2">
                <h3><span>Point:2</span>日本人の足に合う様設計</h3>
                <div class="">
                  <div><img src="<!--{$TPL_URLPATH}-->img/page/detail/img_03.png" width="320" height="220" /></div>
                  <p>つま先はナロウ・ポインテッドスタイルで、ヒールは5 センチのアンダースラングスタイル、履き口の深いスカラップと共に伝統的なカウボーイブーツのスタイルを継承しつつ、底材にスペイン製キャスター( 合成素材) を使用して日常履きとして履きやすく、リーズナブルに仕上げています。</p>
                </div>
              </div>
              <div class="point_3 pure-u-1-2">
                <h3><span>Point:3</span>日本人の足に合う様設計</h3>
                <div class="">
                  <div><img src="<!--{$TPL_URLPATH}-->img/page/detail/img_03.png" width="320" height="220" /></div>
                  <p>ブーツの筒も程良い太さなのでパンツをブーツインするスタイルにも、スカートスタイルにも幅広く活躍していただけるスタンダードなブーツです。</p>
                </div>
              </div>
            </div>
          </div>
          
          <!--使い込むほどに味が出るチョコのオイルレザー-->
          
          <div class="pure-u-1 box_detail_product_point2">
            <h2 class="title1">使い込むほどに味が出るチョコのオイルレザー</h2>
            <div class="pure-g-r">
              <div class="pure-u-1">
                <div><img src="<!--{$TPL_URLPATH}-->img/page/detail/img_04.png" /></div>
                <p>チョコのオイルレザーを使用しております。<br />オイルレザー素材自体にムラ感があり、こするとツヤ感が出る味のある素材になっております。</p>
              </div>
              <div class="pure-u-1-3">
                <div><img src="<!--{$TPL_URLPATH}-->img/page/detail/img_05.png" /></div>
                <p>筒部分には金茶の5 本ウエスタン刺繍がされています。</p>
              </div>
              <div class="pure-u-1-3">
                <div><img src="<!--{$TPL_URLPATH}-->img/page/detail/img_06.png" /></div>
                <p>ソールの底面はオーナメント( 焼き印) が施されたツヤ感のあるベージュ。</p>
              </div>
              <div class="pure-u-1-3">
                <div><img src="<!--{$TPL_URLPATH}-->img/page/detail/img_07.png" /></div>
                <p>ヒールの側面は濃茶を使用しています。</p>
              </div>
            </div>
          </div>
          
          <!--スタッフ職人の声-->
          <div class="pure-u-1">
            <h2 class="title1">スタッフ職人の声</h2>
            <div class="panel-body pure-g-r">
              <div class="pure-u-7-24"> <img class="" src="<!--{$TPL_URLPATH}-->img/page/leather/img_01.png" width="153" height="150"> </div>
              <div class="pure-u-16-24">
                <div><img src="<!--{$TPL_URLPATH}-->img/page/detail/img_08.png" /></div>
                <p>インポート物の超本格的なウエスタンもいいですが、ソールが本革底でお手入れも大変だし値段も高い。そして、何よりも足に合わない!( 甲が薄く、幅が狭いのが多いですよね。) この木型は日本人の足に合う様設計された物になっているので本当に履きやすく、幅広・甲高な足にはそのままで、甲の薄い方には中敷きを入れて履かれるといいです。</p>
<p>ウエスタンブーツって意外とどんなスタイルにも合わせやすく、デニムはもちろん甘系のふんわりスカートにも相性良しで、何気ない、いつものスタイルがグッとオシャレになる使えるアイテムです。</p>
              </div>
            </div>
          </div>
          
          <!--サイズについて-->
          <div class="box_sizu_info pure-u-1">
            <h2 class="title1">サイズについて</h2>
            <div class="pure-g-r">
              <div class="pure-u-12-24"> <img class="" src="<!--{$TPL_URLPATH}-->img/page/detail/img_10.png" width="258" height="292"> </div>
              <div class="pure-u-12-24 pure-g-r">
                <div class="pure-u-1">
                  <div class="size_detail">
                    <h5>■幅の仕様変更</h5>
                    <p>筒の大きさを変更するセミオーダーをお受けしております。
筒の形状変更程度ですがセミオーダーとしてお受けさせていただきます。</p>
                    <div class="text-right"><a href="#"><img src="<!--{$TPL_URLPATH}-->img/page/detail/btn_semiorder.png" border="0" /></a></div>
                  </div>
                  <div class="size_table pure-g-r">
                    <h4 class="pure-u-1">サイズと在庫の見方</h4>
                    <div class="pure-u-1">
                      <table class="pure-u-1">
                        <colgroup>
                        <col width="25%" />
                        <col width="25%" />
                        <col width="50%" />
                        </colgroup>
                        <tr>
                          <th colspan="2"><div class="text-center">サイズ</div></th>
                          <th ><div class="text-center">在庫ズ</div></th>
                        </tr>
                        <tr>
                          <td class="size"><div class="text-center">６</div></td>
                          <td class="size"><div class="text-center">25/25</div></td>
                          <td><div class="text-center">○</div></td>
                        </tr>
                      </table>
                      <p> ○:発送目安に商品を発送します。<br />
                        △:ご注文を受けてから２週間程度で発送します。 </p>
                    </div>
                  </div>
                </div>
              </div>
              <p class="pure-u-1">※筒幅の2 倍が内径になります。<br />例）筒幅が175mm の場合の内径は350mm になります。</p>
            </div>
          </div>
          
          <!--商品詳細-->
          <div class="box_product_detail pure-u-1">
            <h2>うえスタンブーツ</h2>
            <div class="pure-g-r">
              <div class="left_detail_info pure-u-1-2 pure-g-r">
                <div class="pure-u-1"><a href="#"><img src="<!--{$TPL_URLPATH}-->img/page/detail/img_11.png" border="0" /></a></div>
                <div class="pure-u-1-3"><a href="#"><img src="<!--{$TPL_URLPATH}-->img/page/detail/img_12.png" border="0" /></a></div>
                <div class="pure-u-1-3"><a href="#"><img src="<!--{$TPL_URLPATH}-->img/page/detail/img_13.png" border="0" /></a></div>
                <div class="pure-u-1-3"><a href="#"><img src="<!--{$TPL_URLPATH}-->img/page/detail/img_14.png" border="0" /></a></div>
              </div>
              <div class="right_detail_info pure-u-1-2">
                <h4>サイズにつサイズにつサイズにつ</h4>
                <div>商品コード：WG0099</div>
                <p>販売価格：<span class="price_number">\21,840</span> (税込)<br />
                  発送までの目安：ご注文から○日<br />
                  サイズにつサイズにつサイズにつ</p>
                <table class="pure-u-1">
                  <colgroup>
                  <col width="25%" />
                  <col width="25%" />
                  <col width="50%" />
                  </colgroup>
                  <tr>
                    <th colspan="2"><div class="text-center">サイズ</div></th>
                    <th ><div class="text-center">在庫ズ</div></th>
                  </tr>
                  <tr>
                    <td class="size"><div class="text-center">６</div></td>
                    <td class="size"><div class="text-center">25/25</div></td>
                    <td><div class="text-center">○</div></td>
                  </tr>
                </table>
                <div class="pure-u-1 pure-g-r">
                  <ul class="list-group pure-u-1">
                    <li class="list-group-item"> <span>サイズ選択：</span> <span>
                      <select class="pure-u-1-2">
                        <option>選択</option>
                        <option>1</option>
                      </select>
                      </span> </li>
                    <li class="list-group-item">数量 <span>
                      <select class="pure-u-1-6">
                        <option>1</option>
                        <option>2</option>
                      </select>
                      </span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="text-right" style="display:inline-block;"><a href="#"><img src="<!--{$TPL_URLPATH}-->img/page/detail/btn_kaimono.png" border="0" /></a></span> </li>
                  </ul>
                </div>
                <div class="pure-u-1"> </div>
                <div class="pure-u-1 pure-g-r"> <span class="pure-u-1-2 panel-body"><a href="#"><img src="<!--{$TPL_URLPATH}-->img/page/detail/btn_otodoke.png" border="0" /></a></span> <span class="pure-u-1-2 panel-body"><a href="#"><img src="<!--{$TPL_URLPATH}-->img/page/detail/btn_shiharai.png" border="0" /></a></span> </div>
                <div class="pure-u-1"> </div>
                <div class="pure-u-1 text-right"> <a href="#">>> 返品についての詳細はこちら</a> </div>
                <div class="pure-u-1 text-right"> <a href="#">>> 返品についての詳細はこちら</a> </div>
                <div class="pure-u-1 text-right"> <a href="#">>> 返品についての詳細はこちら</a> </div>
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
                  <th>在庫</th>
                  <td>６</td>
                </tr>
                <tr>
                  <th>サイズ</th>
                  <td>○<br />
                    ○<br />
                    ○</td>
                </tr>
                <tr>
                  <th>サイズ</th>
                  <td>○</td>
                </tr>
                <tr>
                  <th>サイズ</th>
                  <td>○</td>
                </tr>
                <tr>
                  <th>サイズ</th>
                  <td>○</td>
                </tr>
              </table>
            </div>
          </div>
          <div class="box_toudouhin pure-u-1">
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
    
    
    
    
    
    
    
    
    <div id="detailarea" class="clearfix">
        <div id="detailphotobloc">
            <div class="photo">
                <!--{assign var=key value="main_image"}-->
                <!--★画像★-->
                <!--{if $arrProduct.main_large_image|strlen >= 1}-->
                    <a
                        href="<!--{$smarty.const.IMAGE_SAVE_URLPATH}--><!--{$arrProduct.main_large_image|h}-->"
                        class="expansion"
                        target="_blank"
                    >
                <!--{/if}-->
                    <img src="<!--{$arrFile[$key].filepath|h}-->" width="<!--{$arrFile[$key].width}-->" height="<!--{$arrFile[$key].height}-->" alt="<!--{$arrProduct.name|h}-->" class="picture" />
                <!--{if $arrProduct.main_large_image|strlen >= 1}-->
                    </a>
                <!--{/if}-->
            </div>
            <!--{if $arrProduct.main_large_image|strlen >= 1}-->
                <span class="mini">
                        <!--★拡大する★-->
                        <a
                            href="<!--{$smarty.const.IMAGE_SAVE_URLPATH}--><!--{$arrProduct.main_large_image|h}-->"
                            class="expansion"
                            target="_blank"
                        >
                            画像を拡大する</a>
                </span>
            <!--{/if}-->
        </div>

        <div id="detailrightbloc">
            <!--▼商品ステータス-->
            <!--{assign var=ps value=$productStatus[$tpl_product_id]}-->
            <!--{if count($ps) > 0}-->
                <ul class="status_icon clearfix">
                    <!--{foreach from=$ps item=status}-->
                    <li>
                        <img src="<!--{$TPL_URLPATH}--><!--{$arrSTATUS_IMAGE[$status]}-->" width="60" height="17" alt="<!--{$arrSTATUS[$status]}-->" id="icon<!--{$status}-->" />
                    </li>
                    <!--{/foreach}-->
                </ul>
            <!--{/if}-->
            <!--▲商品ステータス-->

            <!--★商品コード★-->
            <dl class="product_code">
                <dt>商品コード：</dt>
                <dd>
                    <span id="product_code_default">
                        <!--{if $arrProduct.product_code_min == $arrProduct.product_code_max}-->
                            <!--{$arrProduct.product_code_min|h}-->
                        <!--{else}-->
                            <!--{$arrProduct.product_code_min|h}-->～<!--{$arrProduct.product_code_max|h}-->
                        <!--{/if}-->
                    </span><span id="product_code_dynamic"></span>
                </dd>
            </dl>

            <!--★商品名★-->
            <h2><!--{$arrProduct.name|h}--></h2>

            <!--★通常価格★-->
            <!--{if $arrProduct.price01_min_inctax > 0}-->
                <dl class="normal_price">
                    <dt><!--{$smarty.const.NORMAL_PRICE_TITLE}-->(税込)：</dt>
                    <dd class="price">
                        <span id="price01_default"><!--{strip}-->
                            <!--{if $arrProduct.price01_min_inctax == $arrProduct.price01_max_inctax}-->
                                <!--{$arrProduct.price01_min_inctax|number_format}-->
                            <!--{else}-->
                                <!--{$arrProduct.price01_min_inctax|number_format}-->～<!--{$arrProduct.price01_max_inctax|number_format}-->
                            <!--{/if}-->
                        </span><span id="price01_dynamic"></span><!--{/strip}-->
                        円
                    </dd>
                </dl>
            <!--{/if}-->

            <!--★販売価格★-->
            <dl class="sale_price">
                <dt><!--{$smarty.const.SALE_PRICE_TITLE}-->(税込)：</dt>
                <dd class="price">
                    <span id="price02_default"><!--{strip}-->
                        <!--{if $arrProduct.price02_min_inctax == $arrProduct.price02_max_inctax}-->
                            <!--{$arrProduct.price02_min_inctax|number_format}-->
                        <!--{else}-->
                            <!--{$arrProduct.price02_min_inctax|number_format}-->～<!--{$arrProduct.price02_max_inctax|number_format}-->
                        <!--{/if}-->
                    </span><span id="price02_dynamic"></span><!--{/strip}-->
                    円
                </dd>
            </dl>

            <!--★ポイント★-->
            <!--{if $smarty.const.USE_POINT !== false}-->
                <div class="point">ポイント：
                    <span id="point_default"><!--{strip}-->
                        <!--{if $arrProduct.price02_min == $arrProduct.price02_max}-->
                            <!--{$arrProduct.price02_min|sfPrePoint:$arrProduct.point_rate|number_format}-->
                        <!--{else}-->
                            <!--{if $arrProduct.price02_min|sfPrePoint:$arrProduct.point_rate == $arrProduct.price02_max|sfPrePoint:$arrProduct.point_rate}-->
                                <!--{$arrProduct.price02_min|sfPrePoint:$arrProduct.point_rate|number_format}-->
                            <!--{else}-->
                                <!--{$arrProduct.price02_min|sfPrePoint:$arrProduct.point_rate|number_format}-->～<!--{$arrProduct.price02_max|sfPrePoint:$arrProduct.point_rate|number_format}-->
                            <!--{/if}-->
                        <!--{/if}-->
                    </span><span id="point_dynamic"></span><!--{/strip}-->
                    Pt
                </div>
            <!--{/if}-->

            <!--{* ▼メーカー *}-->
            <!--{if $arrProduct.maker_name|strlen >= 1}-->
                <dl class="maker">
                    <dt>メーカー：</dt>
                    <dd><!--{$arrProduct.maker_name|h}--></dd>
                </dl>
            <!--{/if}-->
            <!--{* ▲メーカー *}-->

            <!--▼メーカーURL-->
            <!--{if $arrProduct.comment1|strlen >= 1}-->
                <dl class="comment1">
                    <dt>メーカーURL：</dt>
                    <dd><a href="<!--{$arrProduct.comment1|h}-->"><!--{$arrProduct.comment1|h}--></a></dd>
                </dl>
            <!--{/if}-->
            <!--▼メーカーURL-->

            <!--★関連カテゴリ★-->
            <dl class="relative_cat">
                <dt>関連カテゴリ：</dt>
                <!--{section name=r loop=$arrRelativeCat}-->
                    <dd>
                        <!--{section name=s loop=$arrRelativeCat[r]}-->
                            <a href="<!--{$smarty.const.ROOT_URLPATH}-->products/list.php?category_id=<!--{$arrRelativeCat[r][s].category_id}-->"><!--{$arrRelativeCat[r][s].category_name}--></a>
                            <!--{if !$smarty.section.s.last}--><!--{$smarty.const.SEPA_CATNAVI}--><!--{/if}-->
                        <!--{/section}-->
                    </dd>
                <!--{/section}-->
            </dl>

            <!--★詳細メインコメント★-->
            <div class="main_comment"><!--{$arrProduct.main_comment|nl2br_html}--></div>

            <!--▼買い物かご-->

            <div class="cart_area clearfix">
            <input type="hidden" name="mode" value="cart" />
            <input type="hidden" name="product_id" value="<!--{$tpl_product_id}-->" />
            <input type="hidden" name="product_class_id" value="<!--{$tpl_product_class_id}-->" id="product_class_id" />
            <input type="hidden" name="favorite_product_id" value="" />

            <!--{if $tpl_stock_find}-->
                <!--{if $tpl_classcat_find1}-->
                    <div class="classlist">
                        <!--▼規格1-->
                        <ul class="clearfix">
                            <li><!--{$tpl_class_name1|h}-->：</li>
                            <li>
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
                            <li><!--{$tpl_class_name2|h}-->：</li>
                            <li>
                                <select name="classcategory_id2" style="<!--{$arrErr.classcategory_id2|sfGetErrorColor}-->">
                                </select>
                                <!--{if $arrErr.classcategory_id2 != ""}-->
                                <br /><span class="attention">※ <!--{$tpl_class_name2}-->を入力して下さい。</span>
                                <!--{/if}-->
                            </li>
                        </ul>
                        <!--▲規格2-->
                        <!--{/if}-->
                    </div>
                <!--{/if}-->

                <!--★数量★-->
                <dl class="quantity">
                    <dt>数量：</dt>
                    <dd><input type="text" class="box60" name="quantity" value="<!--{$arrForm.quantity.value|default:1|h}-->" maxlength="<!--{$smarty.const.INT_LEN}-->" style="<!--{$arrErr.quantity|sfGetErrorColor}-->" />
                        <!--{if $arrErr.quantity != ""}-->
                            <br /><span class="attention"><!--{$arrErr.quantity}--></span>
                        <!--{/if}-->
                    </dd>
                </dl>

                <div class="cartin">
                    <div class="cartin_btn">
                        <div id="cartbtn_default">
                            <!--★カゴに入れる★-->
                            <a href="javascript:void(document.form1.submit())" onmouseover="chgImg('<!--{$TPL_URLPATH}-->img/button/btn_cartin_on.jpg','cart');" onmouseout="chgImg('<!--{$TPL_URLPATH}-->img/button/btn_cartin.jpg','cart');">
                                <img src="<!--{$TPL_URLPATH}-->img/button/btn_cartin.jpg" alt="カゴに入れる" name="cart" id="cart" /></a>
                        </div>
                    </div>
                </div>
                <div class="attention" id="cartbtn_dynamic"></div>
            <!--{else}-->
                <div class="attention">申し訳ございませんが、只今品切れ中です。</div>
            <!--{/if}-->

            <!--★お気に入り登録★-->
            <!--{if $smarty.const.OPTION_FAVORITE_PRODUCT == 1 && $tpl_login === true}-->
                <div class="favorite_btn">
                    <!--{assign var=add_favorite value="add_favorite`$product_id`"}-->
                    <!--{if $arrErr[$add_favorite]}-->
                        <div class="attention"><!--{$arrErr[$add_favorite]}--></div>
                    <!--{/if}-->
                    <!--{if !$is_favorite}-->
                        <a href="javascript:fnChangeAction('?product_id=<!--{$arrProduct.product_id|h}-->'); fnModeSubmit('add_favorite','favorite_product_id','<!--{$arrProduct.product_id|h}-->');" onmouseover="chgImg('<!--{$TPL_URLPATH}-->img/button/btn_add_favorite_on.jpg','add_favorite_product');" onmouseout="chgImg('<!--{$TPL_URLPATH}-->img/button/btn_add_favorite.jpg','add_favorite_product');"><img src="<!--{$TPL_URLPATH}-->img/button/btn_add_favorite.jpg" alt="お気に入りに追加" name="add_favorite_product" id="add_favorite_product" /></a>
                    <!--{else}-->
                        <img src="<!--{$TPL_URLPATH}-->img/button/btn_add_favorite_on.jpg" alt="お気に入り登録済" name="add_favorite_product" id="add_favorite_product" />
                        <script type="text/javascript" src="<!--{$smarty.const.ROOT_URLPATH}-->js/jquery.tipsy.js"></script>
                        <script type="text/javascript">
                            var favoriteButton = $("#add_favorite_product");
                            favoriteButton.tipsy({gravity: $.fn.tipsy.autoNS, fallback: "お気に入りに登録済み", fade: true });

                            <!--{if $just_added_favorite == true}-->
                            favoriteButton.load(function(){$(this).tipsy("show")});
                            $(function(){
                                var tid = setTimeout('favoriteButton.tipsy("hide")',5000);
                            });
                            <!--{/if}-->
                        </script>
                    <!--{/if}-->
                </div>
            <!--{/if}-->
        </div>
    </div>
    <!--▲買い物かご-->
</div>
</form>

    <!--詳細ここまで-->

    <!--▼サブコメント-->
    <!--{section name=cnt loop=$smarty.const.PRODUCTSUB_MAX}-->
        <!--{assign var=key value="sub_title`$smarty.section.cnt.index+1`"}-->
        <!--{assign var=ikey value="sub_image`$smarty.section.cnt.index+1`"}-->
        <!--{if $arrProduct[$key] != "" or $arrProduct[$ikey]|strlen >= 1}-->
            <div class="sub_area clearfix">
                <h3><!--★サブタイトル★--><!--{$arrProduct[$key]|h}--></h3>
                <!--{assign var=ckey value="sub_comment`$smarty.section.cnt.index+1`"}-->
                <!--▼サブ画像-->
                <!--{assign var=lkey value="sub_large_image`$smarty.section.cnt.index+1`"}-->
                <!--{if $arrProduct[$ikey]|strlen >= 1}-->
                    <div class="subtext"><!--★サブテキスト★--><!--{$arrProduct[$ckey]|nl2br_html}--></div>
                    <div class="subphotoimg">
                        <!--{if $arrProduct[$lkey]|strlen >= 1}-->
                            <a href="<!--{$smarty.const.IMAGE_SAVE_URLPATH}--><!--{$arrProduct[$lkey]|h}-->" class="expansion" target="_blank" >
                        <!--{/if}-->
                        <img src="<!--{$arrFile[$ikey].filepath}-->" alt="<!--{$arrProduct.name|h}-->" width="<!--{$arrFile[$ikey].width}-->" height="<!--{$arrFile[$ikey].height}-->" />
                        <!--{if $arrProduct[$lkey]|strlen >= 1}--></a>
                            <span class="mini">
                                <a href="<!--{$smarty.const.IMAGE_SAVE_URLPATH}--><!--{$arrProduct[$lkey]|h}-->" class="expansion" target="_blank">
                                    画像を拡大する</a>
                            </span>
                        <!--{/if}-->
                    </div>
                <!--{else}-->
                    <p class="subtext"><!--★サブテキスト★--><!--{$arrProduct[$ckey]|nl2br_html}--></p>
                <!--{/if}-->
                <!--▲サブ画像-->
            </div>
        <!--{/if}-->
    <!--{/section}-->
    <!--▲サブコメント-->

    <!--この商品に対するお客様の声-->
    <div id="customervoice_area">
        <h2><img src="<!--{$TPL_URLPATH}-->img/title/tit_product_voice.jpg" alt="この商品に対するお客様の声" /></h2>

        <div class="review_bloc clearfix">
            <p>この商品に対するご感想をぜひお寄せください。</p>
            <div class="review_btn">
                <!--{if count($arrReview) < $smarty.const.REVIEW_REGIST_MAX}-->
                    <!--★新規コメントを書き込む★-->
                    <a href="./review.php"
                        onclick="win02('./review.php?product_id=<!--{$arrProduct.product_id}-->','review','600','640'); return false;"
                        onmouseover="chgImg('<!--{$TPL_URLPATH}-->img/button/btn_comment_on.jpg','review');"
                        onmouseout="chgImg('<!--{$TPL_URLPATH}-->img/button/btn_comment.jpg','review');" target="_blank">
                        <img src="<!--{$TPL_URLPATH}-->img/button/btn_comment.jpg" alt="新規コメントを書き込む" name="review" id="review" /></a>
                <!--{/if}-->
            </div>
        </div>

        <!--{if count($arrReview) > 0}-->
            <ul>
                <!--{section name=cnt loop=$arrReview}-->
                    <li>
                        <p class="voicetitle"><!--{$arrReview[cnt].title|h}--></p>
                        <p class="voicedate"><!--{$arrReview[cnt].create_date|sfDispDBDate:false}-->　投稿者：<!--{if $arrReview[cnt].reviewer_url}--><a href="<!--{$arrReview[cnt].reviewer_url}-->" target="_blank"><!--{$arrReview[cnt].reviewer_name|h}--></a><!--{else}--><!--{$arrReview[cnt].reviewer_name|h}--><!--{/if}-->　おすすめレベル：<span class="recommend_level"><!--{assign var=level value=$arrReview[cnt].recommend_level}--><!--{$arrRECOMMEND[$level]|h}--></span></p>
                        <p class="voicecomment"><!--{$arrReview[cnt].comment|h|nl2br}--></p>
                    </li>
                <!--{/section}-->
            </ul>
        <!--{/if}-->
    </div>
    <!--お客様の声ここまで-->

    <!--▼関連商品-->
    <!--{if $arrRecommend}-->
        <div id="whobought_area">
            <h2><img src="<!--{$TPL_URLPATH}-->img/title/tit_product_recommend.jpg" alt="その他のオススメ商品" /></h2>
            <!--{foreach from=$arrRecommend item=arrItem name="arrRecommend"}-->
                <div class="product_item">
                    <div class="productImage">
                        <a href="<!--{$smarty.const.P_DETAIL_URLPATH}--><!--{$arrItem.product_id|u}-->">
                            <img src="<!--{$smarty.const.ROOT_URLPATH}-->resize_image.php?image=<!--{$arrItem.main_list_image|sfNoImageMainList|h}-->&amp;width=65&amp;height=65" alt="<!--{$arrItem.name|h}-->" /></a>
                    </div>
                    <!--{assign var=price02_min value=`$arrItem.price02_min_inctax`}-->
                    <!--{assign var=price02_max value=`$arrItem.price02_max_inctax`}-->
                    <div class="productContents">
                        <h3><a href="<!--{$smarty.const.P_DETAIL_URLPATH}--><!--{$arrItem.product_id|u}-->"><!--{$arrItem.name|h}--></a></h3>
                        <p class="sale_price"><!--{$smarty.const.SALE_PRICE_TITLE}-->(税込)：<span class="price">
                            <!--{if $price02_min == $price02_max}-->
                                <!--{$price02_min|number_format}-->
                            <!--{else}-->
                                <!--{$price02_min|number_format}-->～<!--{$price02_max|number_format}-->
                            <!--{/if}-->円</span></p>
                        <p class="mini"><!--{$arrItem.comment|h|nl2br}--></p>
                    </div>
                </div><!--{* /.item *}-->
                <!--{if $smarty.foreach.arrRecommend.iteration % 2 === 0}-->
                    <div class="clear"></div>
                <!--{/if}-->
            <!--{/foreach}-->
        </div>
    <!--{/if}-->
    <!--▲関連商品-->

</div>
