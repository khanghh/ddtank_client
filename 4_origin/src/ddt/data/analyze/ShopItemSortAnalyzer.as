package ddt.data.analyze
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ShopManager;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class ShopItemSortAnalyzer extends DataAnalyzer
   {
       
      
      private var _xml:XML;
      
      private var _shoplist:XMLList;
      
      public var shopSortedGoods:Dictionary;
      
      private var index:int = -1;
      
      private var _timer:Timer;
      
      public function ShopItemSortAnalyzer(param1:Function)
      {
         super(param1);
         shopSortedGoods = new Dictionary();
      }
      
      override public function analyze(param1:*) : void
      {
         _xml = new XML(param1);
         if(_xml.@value == "true")
         {
            _shoplist = _xml..Item;
            parseShop();
         }
         else
         {
            message = _xml.@message;
            onAnalyzeError();
         }
      }
      
      private function parseShop() : void
      {
         _timer = new Timer(30);
         _timer.addEventListener("timer",__partexceute);
         _timer.start();
      }
      
      private function __partexceute(param1:TimerEvent) : void
      {
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:* = null;
         var _loc2_:* = null;
         if(!ShopManager.Instance.initialized)
         {
            return;
         }
         _loc6_ = 0;
         while(_loc6_ < 40)
         {
            index = Number(index) + 1;
            if(index < _shoplist.length())
            {
               _loc4_ = _shoplist[index].@Type;
               _loc3_ = _shoplist[index].@ShopId;
               _loc5_ = ShopManager.Instance.getShopItemByGoodsID(_loc3_);
               if(_loc5_ != null)
               {
                  addToList(_loc4_,_loc5_);
               }
               else
               {
                  _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("shop.DataError.NoGood") + _loc3_);
                  _loc2_.addEventListener("response",__onResponse);
               }
               _loc6_++;
               continue;
            }
            _timer.removeEventListener("timer",__partexceute);
            _timer.stop();
            _timer = null;
            onAnalyzeComplete();
            return;
         }
      }
      
      private function __onResponse(param1:FrameEvent) : void
      {
         var _loc2_:BaseAlerFrame = BaseAlerFrame(param1.target);
         _loc2_.removeEventListener("response",__onResponse);
         _loc2_.dispose();
      }
      
      private function addToList(param1:int, param2:ShopItemInfo) : void
      {
         var _loc3_:Vector.<ShopItemInfo> = shopSortedGoods[param1];
         if(_loc3_ == null)
         {
            _loc3_ = new Vector.<ShopItemInfo>();
            shopSortedGoods[param1] = _loc3_;
         }
         _loc3_.push(param2);
      }
   }
}
