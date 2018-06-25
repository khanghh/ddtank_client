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
      
      public function ShopItemSortAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
         shopSortedGoods = new Dictionary();
      }
      
      override public function analyze(data:*) : void
      {
         _xml = new XML(data);
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
      
      private function __partexceute(evt:TimerEvent) : void
      {
         var i:int = 0;
         var type:int = 0;
         var goodsID:int = 0;
         var info:* = null;
         var alert:* = null;
         if(!ShopManager.Instance.initialized)
         {
            return;
         }
         i = 0;
         while(i < 40)
         {
            index = Number(index) + 1;
            if(index < _shoplist.length())
            {
               type = _shoplist[index].@Type;
               goodsID = _shoplist[index].@ShopId;
               info = ShopManager.Instance.getShopItemByGoodsID(goodsID);
               if(info != null)
               {
                  addToList(type,info);
               }
               else
               {
                  alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("shop.DataError.NoGood") + goodsID);
                  alert.addEventListener("response",__onResponse);
               }
               i++;
               continue;
            }
            _timer.removeEventListener("timer",__partexceute);
            _timer.stop();
            _timer = null;
            onAnalyzeComplete();
            return;
         }
      }
      
      private function __onResponse(event:FrameEvent) : void
      {
         var alert:BaseAlerFrame = BaseAlerFrame(event.target);
         alert.removeEventListener("response",__onResponse);
         alert.dispose();
      }
      
      private function addToList(type:int, shopItem:ShopItemInfo) : void
      {
         var list:Vector.<ShopItemInfo> = shopSortedGoods[type];
         if(list == null)
         {
            list = new Vector.<ShopItemInfo>();
            shopSortedGoods[type] = list;
         }
         list.push(shopItem);
      }
   }
}
