
		<!-- ▼特集 -->
        <div>
          <div class="pure-g-r">
		    <!-- ▼バナー　左列 -->
            <div class="pure-u-1-2 pure-g-r">
              <div class="pure-u-22-24">
                <!-- 特集 -->
                <h3 class="title"><img src="<!--{$TPL_URLPATH}-->img/page/top/icon_h3.png" /> 特集</h3>
                <div class="pure-g-r">
                  <div class="pure-u-1"><a href="#"><img src="<!--{$TPL_URLPATH}-->img/page/top/bnr_tokushu.png" width="455" height="115" border="0"></a></div>
                </div>
              </div>
			  <!-- ▼ニュース -->
              <div class="pure-u-22-24">
                <div class="box_news">
                  <!-- NEWS -->
                  <h3 class="title"><img src="<!--{$TPL_URLPATH}-->img/page/top/icon_h3.png" /> NEWS</h3>
                  <div class="list-group pure-u-1 pure-g-r"  style="height:275px; overflow:auto;">

                    <!--{section name=data loop=$arrNews}-->
                      <div class="pure-u-1"> <div class="list-group-item">
                      <div class="media">
                        <!--{if $arrNews[data].image}-->
                        <img src="<!--{$smarty.const.IMAGE_SAVE_URLPATH|sfTrimURL}-->/<!--{$arrNews[data].image|h}-->" alt="..." width="60" class="media-object pull-left" >
                        <!--{/if}-->
                        <div class="media-body">
                          <h4 class="media-heading"><strong><!--{$arrNews[data].news_date_disp|date_format:"%Y.%m.%d"}--> &nbsp&nbsp
                            <!--{if $arrNews[data].news_url}--><a href="<!--{$arrNews[data].news_url}-->" <!--{if $arrNews[data].link_method eq "2"}--> target="_blank"<!--{/if}-->><!--{/if}-->
						                <!--{$arrNews[data].news_title|escape|nl2br}-->
						                <!--{if $arrNews[data].news_url}--></a><!--{/if}-->
                          </strong></h4>
		                      <p><!--{$arrNews[data].news_comment|escape|nl2br}--> </p>
		                    </div>
		                  </div>
                    </div></div>
      						  <!--{/section}-->
                  </div>
                </div>
              </div>
            </div>

			<!-- ▼バナー　右列 -->
            <div class="pure-u-1-2">
              <div class="box_info_01 pure-u-22-24">
                <!-- 知って欲しいこと -->
                <h3 class="title"><img src="<!--{$TPL_URLPATH}-->img/page/top/icon_h3.png" /> 知って欲しいこと</h3>
                <div class="pure-g-r">
                  <div class="pure-u-1-3"><a href="#" class="thumbnail"><img src="<!--{$TPL_URLPATH}-->img/page/top/img_info_01.png" width="124" height="124" border="0"><span class="buttom_right_icon"><img src="../user_data/packages/default/img/page/top/icon_right_down_02.png" width="13" height="13" /></span></a></div>
                  <div class="pure-u-1-3"><a href="#" class="thumbnail"><img src="<!--{$TPL_URLPATH}-->img/page/top/img_info_02.png" width="124" height="124" border="0"><span class="buttom_right_icon"><img src="../user_data/packages/default/img/page/top/icon_right_down_02.png" width="13" height="13" /></span></a></div>
                  <div class="pure-u-1-3"><a href="#" class="thumbnail"><img src="<!--{$TPL_URLPATH}-->img/page/top/img_info_03.png" width="124" height="124" border="0"><span class="buttom_right_icon"><img src="../user_data/packages/default/img/page/top/icon_right_down_02.png" width="13" height="13" /></span></a></div>
                  <div class="pure-u-1-3"><a href="#" class="thumbnail"><img src="<!--{$TPL_URLPATH}-->img/page/top/img_info_04.png" width="124" height="124" border="0"><span class="buttom_right_icon"><img src="../user_data/packages/default/img/page/top/icon_right_down_02.png" width="13" height="13" /></span></a></div>
                  <div class="pure-u-1-3"><a href="#" class="thumbnail"><img src="<!--{$TPL_URLPATH}-->img/page/top/img_info_05.png" width="124" height="124" border="0"><span class="buttom_right_icon"><img src="../user_data/packages/default/img/page/top/icon_right_down_02.png" width="13" height="13" /></span></a></div>
                  <div class="pure-u-1-3"><a href="#" class="thumbnail"><img src="<!--{$TPL_URLPATH}-->img/page/top/img_info_06.png" width="124" height="124" border="0"><span class="buttom_right_icon"><img src="../user_data/packages/default/img/page/top/icon_right_down_02.png" width="13" height="13" /></span></a></div>
                  <div class="pure-u-1-3"><a href="#" class="thumbnail"><img src="<!--{$TPL_URLPATH}-->img/page/top/img_info_07.png" width="124" height="124" border="0"><span class="buttom_right_icon"><img src="../user_data/packages/default/img/page/top/icon_right_down_02.png" width="13" height="13" /></span></a></div>
                  <div class="pure-u-1-3"><a href="#" class="thumbnail"><img src="<!--{$TPL_URLPATH}-->img/page/top/img_info_08.png" width="124" height="124" border="0"><span class="buttom_right_icon"><img src="../user_data/packages/default/img/page/top/icon_right_down_02.png" width="13" height="13" /></span></a></div>
                  <div class="pure-u-1-3"><a href="<!--{$smarty.const.ROOT_URLPATH}-->contact/" class="thumbnail"><img src="<!--{$TPL_URLPATH}-->img/page/top/img_info_09.png" width="124" height="124" border="0"><span class="buttom_right_icon"><img src="../user_data/packages/default/img/page/top/icon_right_down_02.png" width="13" height="13" /></span></a></div>
                </div>
              </div>
            </div>
          </div>
        </div>