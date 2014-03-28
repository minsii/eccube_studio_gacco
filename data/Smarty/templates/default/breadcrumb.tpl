
      <!--{if $tpl_title }-->
      <ol class="breadcrumb  pure-u-1">
        <li><a href="#"><a href="<!--{$smarty.const.ROOT_URLPATH}-->">Home</a></li>
        <!--{if $tpl_mainno == "products" }-->
          <!--{* 商品一覧・詳細画面のページパス *}-->
          <!--{section name=cnt loop=$tpl_navis }-->
            <!--{if $tpl_navis[cnt].url}-->
                <li><a href="<!--{$tpl_navis[cnt].url}-->"><!--{$tpl_navis[cnt].label}--></a></li>
            <!--{else}-->
                <li class="active"><!--{$tpl_navis[cnt].label}--></li>
            <!--{/if}-->
          <!--{/section}-->
        <!--{else}-->
          <!--{* その他画面のページパス *}-->
          <!--{if $tpl_title}-->
            <!--{if $tpl_subtitle && $tpl_subtitle != $tpl_title}-->
             <li><a href="<!--{$smarty.const.ROOT_URLPATH}--><!--{$tpl_mainno}-->"><!--{$tpl_title}--></a></li><!--{* 1階層目ページパス *}-->
             <li class="active"><!--{$tpl_subtitle}--></li> <!--{* 2階層目ページパス *}-->
            <!--{else}-->
             <li class="active"><!--{$tpl_title}--></li> <!--{* 1階層目ページパス *}-->
            <!--{/if}-->
          <!--{/if}-->
        <!--{/if}-->
      </ol>
      <!--{/if}-->