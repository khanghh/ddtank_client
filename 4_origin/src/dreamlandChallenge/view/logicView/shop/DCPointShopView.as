package dreamlandChallenge.view.logicView.shop
{
   import com.pickgliss.ui.LayerManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import dreamlandChallenge.data.DreamLandModel;
   import dreamlandChallenge.view.mornui.shop.DCPointShopViewUI;
   import flash.events.Event;
   import morn.core.components.Component;
   import morn.core.handlers.Handler;
   
   public class DCPointShopView extends DCPointShopViewUI
   {
       
      
      private var _goodsInfoList:Array;
      
      private var _model:DreamLandModel;
      
      public function DCPointShopView(mode:DreamLandModel)
      {
         _model = mode;
         super();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,false,1);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         text1.text = LanguageMgr.GetTranslation("ddt.dreamLand.view.text15");
         text2.text = LanguageMgr.GetTranslation("ddt.dreamLand.view.text16");
         text3.text = LanguageMgr.GetTranslation("ddt.dreamLand.view.text17");
         btn_return.label = LanguageMgr.GetTranslation("ddt.dreamLand.view.text19");
         btn_close.clickHandler = new Handler(__closeView);
         btn_return.clickHandler = new Handler(__closeView);
         list_shops.renderHandler = new Handler(__listRender);
         if(_model)
         {
            _model.addEventListener("selfPointUpdate",__updatePointHandler);
         }
         initShops();
         nav_changePage.selectHandler = new Handler(__pageChangeHandler);
      }
      
      private function __pageChangeHandler(index:int) : void
      {
         SoundManager.instance.playButtonSound();
         list_shops.page = index - 1;
      }
      
      private function initShops() : void
      {
         _goodsInfoList = ShopManager.Instance.getValidGoodsArrayByType(130);
         list_shops.array = _goodsInfoList;
         list_shops.page = 1;
         nav_changePage.maxPage = list_shops.totalPage;
         lbl_point.text = _model.selfPoint.toString();
      }
      
      private function __updatePointHandler(evt:Event) : void
      {
         lbl_point.text = _model.selfPoint.toString();
      }
      
      private function __listRender(item:Component, index:int) : void
      {
         var render:DCPointShopItem = item as DCPointShopItem;
         if(index < list_shops.length)
         {
            render.info = list_shops.array[index];
         }
         else
         {
            render.info = null;
         }
      }
      
      private function __closeView() : void
      {
         SoundManager.instance.playButtonSound();
         dispose();
      }
      
      override public function dispose() : void
      {
         if(_model)
         {
            _model.removeEventListener("selfPointUpdate",__updatePointHandler);
         }
         _model = null;
         super.dispose();
      }
   }
}
