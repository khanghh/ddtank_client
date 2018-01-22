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
      
      public function ShopItemDisCountAnalyzer(param1:Function)
      {
         super(param1);
         shopDisCountGoods = new Dictionary();
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
         var _loc3_:int = 0;
         var _loc2_:* = null;
         if(!ShopManager.Instance.initialized)
         {
            return;
         }
         _loc3_ = 0;
         while(_loc3_ < 40)
         {
            index = Number(index) + 1;
            if(index < _shoplist.length())
            {
               _loc2_ = new ShopItemInfo(int(_shoplist[index].@ID),int(_shoplist[index].@TemplateID));
               ObjectUtils.copyPorpertiesByXML(_loc2_,_shoplist[index]);
               _loc2_.Label = int(_shoplist[index].@LableType);
               _loc2_.AUnit = int(_shoplist[index].@AUnit);
               _loc2_.APrice1 = int(_shoplist[index].@APrice);
               _loc2_.AValue1 = int(_shoplist[index].@AValue);
               _loc2_.BUnit = int(_shoplist[index].@BUnit);
               _loc2_.BPrice1 = int(_shoplist[index].@BPrice);
               _loc2_.BValue1 = int(_shoplist[index].@BValue);
               _loc2_.CUnit = int(_shoplist[index].@CUnit);
               _loc2_.CPrice1 = int(_shoplist[index].@CPrice);
               _loc2_.CValue1 = int(_shoplist[index].@CValue);
               _loc2_.isDiscount = 2;
               var _loc4_:* = _loc2_.APrice1;
               _loc2_.APrice3 = _loc4_;
               _loc2_.APrice2 = _loc4_;
               _loc4_ = _loc2_.BPrice1;
               _loc2_.BPrice3 = _loc4_;
               _loc2_.BPrice2 = _loc4_;
               _loc4_ = _loc2_.CPrice1;
               _loc2_.CPrice3 = _loc4_;
               _loc2_.CPrice2 = _loc4_;
               addList(Math.abs(_loc2_.APrice1),_loc2_);
               _loc3_++;
               continue;
            }
            _timer.removeEventListener("timer",__partexceute);
            _timer.stop();
            _timer = null;
            onAnalyzeComplete();
            return;
         }
      }
      
      private function converMoneyType(param1:ShopItemInfo) : void
      {
         var _loc2_:* = Math.abs(param1.APrice1);
         if(3 !== _loc2_)
         {
            if(4 === _loc2_)
            {
               param1.APrice1 = -2;
            }
         }
         else
         {
            param1.APrice1 = -1;
         }
         _loc2_ = Math.abs(param1.BPrice1);
         if(3 !== _loc2_)
         {
            if(4 !== _loc2_)
            {
               param1.BPrice1 = param1.APrice1;
            }
            else
            {
               param1.BPrice1 = -2;
            }
         }
         else
         {
            param1.BPrice1 = -1;
         }
         _loc2_ = Math.abs(param1.CPrice1);
         if(3 !== _loc2_)
         {
            if(4 !== _loc2_)
            {
               param1.CPrice1 = param1.APrice1;
            }
            else
            {
               param1.CPrice1 = -2;
            }
         }
         else
         {
            param1.CPrice1 = -1;
         }
         _loc2_ = param1.APrice1;
         param1.APrice3 = _loc2_;
         param1.APrice2 = _loc2_;
         _loc2_ = param1.BPrice1;
         param1.BPrice3 = _loc2_;
         param1.BPrice2 = _loc2_;
         _loc2_ = param1.CPrice1;
         param1.CPrice3 = _loc2_;
         param1.CPrice2 = _loc2_;
      }
      
      private function addList(param1:int, param2:ShopItemInfo) : void
      {
         var _loc3_:DictionaryData = shopDisCountGoods[param1];
         if(!_loc3_)
         {
            _loc3_ = new DictionaryData();
            shopDisCountGoods[param1] = _loc3_;
         }
         _loc3_.add(param2.GoodsID,param2);
      }
   }
}
