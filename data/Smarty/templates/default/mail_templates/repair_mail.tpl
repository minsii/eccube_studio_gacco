
<!--{$tpl_header}-->
　※本メールは自動配信メールです。
　等幅フォント(MSゴシック12ポイント、Osaka-等幅など)で
　最適にご覧になれます。

┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
　※本メールは、
　<!--{$tpl_shopname}-->より、修理依頼を登録された方に
　お送りしています。
　もしお心当たりが無い場合は、このままこのメールを破棄して
　ください。
　またその旨、<!--{$tpl_infoemail}-->まで
　ご連絡いただければ幸いです。
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

<!--{$arrForm.name01}-->様

以下の修理依頼を受付致しました。
確認次第ご連絡いたしますので、少々お待ちください。

<!--{*## 顧客法人管理 ADD BEGIN ##*}--><!--{if $smarty.const.USE_CUSTOMER_COMPANY === true}-->
■法人名　：<!--{$arrForm.company}--> (<!--{$arrForm.company_kana}-->)
<!--{/if}--><!--{*## 顧客法人管理 ADD END ##*}-->
■お名前　：<!--{$arrForm.name01}--> <!--{$arrForm.name02}--> (<!--{$arrForm.kana01}--> <!--{$arrForm.kana02}-->) 様
■郵便番号：<!--{if $arrForm.zip01 && $arrForm.zip02}-->〒<!--{$arrForm.zip01}-->-<!--{$arrForm.zip02}--><!--{/if}-->

■住所　　：<!--{$arrPref[$arrForm.pref]}--><!--{$arrForm.addr01}--><!--{$arrForm.addr02}-->
■電話番号：<!--{$arrForm.tel01}-->-<!--{$arrForm.tel02}-->-<!--{$arrForm.tel03}-->
■メールアドレス：<!--{$arrForm.email}-->

<!--{if $arrForm.product_name}-->
■商品名　：<!--{$arrForm.product_name|h}-->
<!--{/if}-->
<!--{if $arrForm.buy_year && $arrForm.buy_month && $arrForm.buy_date}-->
■ご購入年月日　：<!--{$arrForm.buy_year|h}-->年<!--{$arrForm.buy_month|h}-->月<!--{$arrForm.buy_date|h}-->日
<!--{/if}-->
<!--{if is_array($arrForm.repair_type) && count($arrForm.repair_type)}-->
■修理内容　：<!--{foreach from=$arrForm.repair_type item=rid}-->
<!--{if $rid != ""}--><!--{$arrREPAIR_TYPE[$rid]|h}-->　<!--{/if}-->
<!--{/foreach}-->
<!--{/if}-->

■修理状態・ご要望等 <!--{if $arrForm.image}-->（修理アクセサリー画像あり）<!--{/if}-->

<!--{$arrForm.contents}-->
<!--{$tpl_footer}-->
