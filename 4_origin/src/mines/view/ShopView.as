package mines.view
{
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   import mines.MinesManager;
   import mines.analyzer.ShopDropInfo;
   import mines.analyzer.ShopExchangeInfo;
   import mines.mornui.view.ShopViewUI;
   
   public class ShopView extends ShopViewUI
   {
       
      
      private var box:Sprite;
      
      private var box1:Sprite;
      
      private var list:Vector.<MinesBuyCell>;
      
      private var list1:Vector.<MinesExchangeCell>;
      
      public function ShopView()
      {
         box = new Sprite();
         box1 = new Sprite();
         super();
      }
      
      override protected function initialize() : void
      {
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc1_:* = null;
         var _loc3_:int = 0;
         var _loc5_:* = null;
         var _loc2_:* = null;
         list = new Vector.<MinesBuyCell>();
         list1 = new Vector.<MinesExchangeCell>();
         infoLabel.text = LanguageMgr.GetTranslation("ddt.mines.shopView.info");
         _loc6_ = 0;
         while(_loc6_ < MinesManager.instance.model.shopDropList.length)
         {
            _loc4_ = MinesManager.instance.model.shopDropList[_loc6_];
            _loc1_ = new MinesBuyCell();
            _loc1_.info = _loc4_;
            _loc1_.x = 136 + 75 * _loc6_;
            _loc1_.y = 273;
            box.addChild(_loc1_);
            list.push(_loc1_);
            _loc6_++;
         }
         _loc3_ = 0;
         while(_loc3_ < MinesManager.instance.model.shopExchangeList.length)
         {
            _loc5_ = MinesManager.instance.model.shopExchangeList[_loc3_];
            _loc2_ = new MinesExchangeCell();
            _loc2_.infoExchange = _loc5_;
            _loc2_.x = 136 + 75 * _loc3_;
            _loc2_.y = 402;
            box1.addChild(_loc2_);
            list1.push(_loc2_);
            _loc3_++;
         }
         addChild(box);
         addChild(box1);
      }
      
      public function updataList() : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc1_:int = 0;
         var _loc3_:* = null;
         _loc4_ = 0;
         while(_loc4_ < list.length)
         {
            _loc2_ = MinesManager.instance.model.shopDropList[_loc4_];
            list[_loc4_].info = _loc2_;
            _loc4_++;
         }
         _loc1_ = 0;
         while(_loc1_ < list1.length)
         {
            _loc3_ = MinesManager.instance.model.shopExchangeList[_loc1_];
            list1[_loc1_].infoExchange = _loc3_;
            _loc1_++;
         }
      }
   }
}
