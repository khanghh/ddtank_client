package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.ShopManager;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import road7th.data.DictionaryData;
   
   public class ShopItemDisCountAnalyzer extends DataAnalyzer
   {
       
      
      private var _xml:XML;
      
      private var _shoplist:XMLList;
      
      public var shopDisCountGoods:Dictionary;
      
      private var index:int = -1;
      
      private var _timer:Timer;
      
      public function ShopItemDisCountAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
         shopDisCountGoods = new Dictionary();
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
         var info:* = null;
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
               info = new ShopItemInfo(int(_shoplist[index].@ID),int(_shoplist[index].@TemplateID));
               ObjectUtils.copyPorpertiesByXML(info,_shoplist[index]);
               info.Label = int(_shoplist[index].@LableType);
               info.AUnit = int(_shoplist[index].@AUnit);
               info.APrice1 = int(_shoplist[index].@APrice);
               info.AValue1 = int(_shoplist[index].@AValue);
               info.BUnit = int(_shoplist[index].@BUnit);
               info.BPrice1 = int(_shoplist[index].@BPrice);
               info.BValue1 = int(_shoplist[index].@BValue);
               info.CUnit = int(_shoplist[index].@CUnit);
               info.CPrice1 = int(_shoplist[index].@CPrice);
               info.CValue1 = int(_shoplist[index].@CValue);
               info.isDiscount = 2;
               var _loc4_:* = info.APrice1;
               info.APrice3 = _loc4_;
               info.APrice2 = _loc4_;
               _loc4_ = info.BPrice1;
               info.BPrice3 = _loc4_;
               info.BPrice2 = _loc4_;
               _loc4_ = info.CPrice1;
               info.CPrice3 = _loc4_;
               info.CPrice2 = _loc4_;
               addList(Math.abs(info.APrice1),info);
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
      
      private function converMoneyType(info:ShopItemInfo) : void
      {
         var _loc2_:* = Math.abs(info.APrice1);
         if(3 !== _loc2_)
         {
            if(4 === _loc2_)
            {
               info.APrice1 = -2;
            }
         }
         else
         {
            info.APrice1 = -1;
         }
         _loc2_ = Math.abs(info.BPrice1);
         if(3 !== _loc2_)
         {
            if(4 !== _loc2_)
            {
               info.BPrice1 = info.APrice1;
            }
            else
            {
               info.BPrice1 = -2;
            }
         }
         else
         {
            info.BPrice1 = -1;
         }
         _loc2_ = Math.abs(info.CPrice1);
         if(3 !== _loc2_)
         {
            if(4 !== _loc2_)
            {
               info.CPrice1 = info.APrice1;
            }
            else
            {
               info.CPrice1 = -2;
            }
         }
         else
         {
            info.CPrice1 = -1;
         }
         _loc2_ = info.APrice1;
         info.APrice3 = _loc2_;
         info.APrice2 = _loc2_;
         _loc2_ = info.BPrice1;
         info.BPrice3 = _loc2_;
         info.BPrice2 = _loc2_;
         _loc2_ = info.CPrice1;
         info.CPrice3 = _loc2_;
         info.CPrice2 = _loc2_;
      }
      
      private function addList(type:int, itemInfo:ShopItemInfo) : void
      {
         var list:DictionaryData = shopDisCountGoods[type];
         if(!list)
         {
            list = new DictionaryData();
            shopDisCountGoods[type] = list;
         }
         list.add(itemInfo.GoodsID,itemInfo);
      }
   }
}
