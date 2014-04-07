
    <div class=" pure-g-r">
      <div class="box_searchproduct pure-u-1">
        <div class="panel panel-default ">
          <div class="panel-heading"><img src="<!--{$TPL_URLPATH}-->img/page/sidebar/searchproduct/title.png" /></div>
          <div class="panel-body ">
			<!--検索フォーム-->
            <form name="search_form" id="search_form" method="get" action="<!--{$smarty.const.ROOT_URLPATH}-->products/list.php" role="form">
              <div class="form-group">
                <div class="">
                  <div class=" form-group">
                    <label class="" for="products">フリーワード検索</label>
                    <div class="input-group input-group-sm"> <span class="input-group-addon glyphicon glyphicon-search" style=" top: 0px; "></span>
                      <input id="products" type="text" class="form-control" name="name" maxlength="50" value="<!--{$smarty.get.name|escape}-->">
                      <span class="input-group-btn">
                      <button class="btn btn-default" type="submit">検索</button>
                      </span> </div>
                    <!-- /input-group -->
                  </div>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>