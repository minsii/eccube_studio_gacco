
		<!-- ▼バナー -->
          <div class="pure-g">
			<!-- ▼バナー　左列 -->
            <div class="pure-u-1-2">
              <div class="box_topbnr_01 pure-g-r">
                <div class="list-group">
                  <div class=" pure-u-1-2">
                  <a href="#" class="list-group-item">
                  <div class="media"> <span class="icon_top"><img src="<!--{$TPL_URLPATH}-->img/page/top/icon_left_top_01.png" width="60" height="60" /></span> <img src="<!--{$TPL_URLPATH}-->img/page/top/img_01.png" alt="..." width="197" height="161" class="media-object">
                    <div class="media-body">
                      <h4 class="media-heading lead text-center">日本の靴メーカーです</h4>
                    </div>
                    <span class="pull-right"><img src="<!--{$TPL_URLPATH}-->img/page/top/icon_right_down.png" /></span> </div>
                  </a>
                  </div>
                  <div class=" pure-u-1-2">
                  <a href="#" class="list-group-item">
                  <div class="media"> <span class="icon_top"><img src="<!--{$TPL_URLPATH}-->img/page/top/icon_left_top_02.png" width="60" height="60" /></span> <img src="<!--{$TPL_URLPATH}-->img/page/top/img_02.png" alt="..." width="197" height="161" class="media-object">
                    <div class="media-body">
                      <h4 class="media-heading lead text-center">一生履けるあなたの靴</h4>
                    </div>
                    <span class="pull-right"><img src="<!--{$TPL_URLPATH}-->img/page/top/icon_right_down.png" /></span> </div>
                  </a>
                  </div>
                  <div class=" pure-u-1-2">
                  <a href="#" class="list-group-item">
                  <div class="media"> <span class="icon_top"><img src="<!--{$TPL_URLPATH}-->img/page/top/icon_left_top_03.png" width="60" height="60" /></span> <img src="<!--{$TPL_URLPATH}-->img/page/top/img_03.png" alt="..." width="197" height="161" class="media-object">
                    <div class="media-body">
                      <h4 class="media-heading lead">和風ウェスタン</h4>
                    </div>
                    <span class="pull-right"><img src="<!--{$TPL_URLPATH}-->img/page/top/icon_right_down.png" /></span> </div>
                  </a>
                  </div>
                  <div class=" pure-u-1-2">
                  <a href="#" class="list-group-item">
                  <div class="media"> <span class="icon_top"><img src="<!--{$TPL_URLPATH}-->img/page/top/icon_left_top_04.png" width="60" height="60" /></span> <img src="<!--{$TPL_URLPATH}-->img/page/top/img_04.png" alt="..." width="197" height="161" class="media-object">
                    <div class="media-body">
                      <h4 class="media-heading lead">隠れウェスタンスタイル</h4>
                    </div>
                    <span class="pull-right"><img src="<!--{$TPL_URLPATH}-->img/page/top/icon_right_down.png" /></span> </div>
                  </a>
                  </div>
                  </div>
              </div>
            </div>

			<!-- ▼バナー　右列 -->
            <div class="pure-u-1-2">
              <div class="pure-g-r">
                <div class="pure-u-1-2 text-center"><a href="<!--{$smarty.const.ROOT_URLPATH}-->products/list.php?category_id=1"><img src="<!--{$TPL_URLPATH}-->img/page/top/img_05.png" width="216" height="81" border="0"></a></div>
                <div class="pure-u-1-2 text-center"><a href="<!--{$smarty.const.ROOT_URLPATH}-->products/list.php?category_id=2"><img src="<!--{$TPL_URLPATH}-->img/page/top/img_06.png" width="216" height="81" border="0"></a></div>
              </div>
              <div class="box_topbnr_03 pure-g-r">
                <div class="list-group pure-u-1 pure-g-r">

                <!--{* Men's item *}-->
                <!--{foreach from=$arrBestProducts1 item=arrProduct name="recommend_products"}-->
                  <div class="pure-u-1-2"> <div href="#" class="list-group-item">
                    <div class="media">
                      <a href="<!--{$smarty.const.P_DETAIL_URLPATH|sfGetFormattedUrl:$arrProduct.product_id}-->" class="pull-left">
                        <img src="<!--{$smarty.const.ROOT_URLPATH}-->resize_image.php?image=<!--{$arrProduct.main_list_image|sfNoImageMainList|h}-->&amp;width=68" alt="<!--{$arrProduct.name|h}-->" 
                          width="68" height="68" class="media-object"/>
                      </a>
                      <div class="media-body">
                        <h4 class="media-heading"><strong><!--{$arrProduct.name|h}--></strong></h4>
                        <p><!--{$arrProduct.comment|h|nl2br}--></p> </div>
                    </div>
                    </div> </div>
                <!--{/foreach}-->

                <!--{* Lady's item *}-->
                <!--{foreach from=$arrBestProducts2 item=arrProduct name="recommend_products"}-->
                  <div class="pure-u-1-2"> <div href="#" class="list-group-item">
                    <div class="media">
                      <a href="<!--{$smarty.const.P_DETAIL_URLPATH|sfGetFormattedUrl:$arrProduct.product_id}-->" class="pull-left">
                        <img src="<!--{$smarty.const.ROOT_URLPATH}-->resize_image.php?image=<!--{$arrProduct.main_list_image|sfNoImageMainList|h}-->&amp;width=68" alt="<!--{$arrProduct.name|h}-->" 
                          width="68" height="68" class="media-object">
                      </a>
                      <div class="media-body">
                        <h4 class="media-heading"><strong><!--{$arrProduct.name|h}--></strong></h4>
                        <p><!--{$arrProduct.comment|h|nl2br}--></p> </div>
                    </div>
                    </div> </div>
                <!--{/foreach}-->

                </div>
              </div>
            </div>
          </div>
