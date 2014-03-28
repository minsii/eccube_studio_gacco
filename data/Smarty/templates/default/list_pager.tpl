<script>
function fnNaviPage1(pageno) {
    var fm = document.getElementById('form1');
    fm.pageno.value = pageno;
    fm.submit();
}
</script>

<ul class="">
    <!--{if $arrPagenavi.before != $arrPagenavi.now_page}-->
    <li><a href="#" onclick="fnNaviPage1('<!--{$arrPagenavi.before}-->');return false;">
    << 前へ</a></li>
    <!--{/if}-->
    <!--{assign var=fst value="1"}-->
    <!--{foreach item=pageno from=$arrPagenavi.arrPageno}-->
    <!--{assign var=fst value=""}-->
    <li>
      <!--{if $pageno == $arrPagenavi.now_page}-->
      <span class="page active"><!--{$pageno}--></span>
      <!--{else}-->
      <a href="#" class="page" onclick="fnNaviPage1('<!--{$pageno}-->');return false;"><!--{$pageno}--></a>
      <!--{/if}-->
    </li>
    <!--{/foreach}-->
    <!--{if $arrPagenavi.next != $arrPagenavi.now_page}-->
    <li><a href="#" onclick="fnNaviPage1('<!--{$arrPagenavi.next}-->');return false;">
    次へ >></a></li>
    <!--{/if}-->
</ul>

