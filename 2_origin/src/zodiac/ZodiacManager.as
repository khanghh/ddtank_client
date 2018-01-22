package zodiac
{
   import ddt.CoreManager;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.SocketManager;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.Event;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class ZodiacManager extends CoreManager
   {
      
      public static const SHOWMAINVIEW:String = "showMainView";
      
      public static const HIDEMAINVIEW:String = "hideMainView";
      
      public static const ZODIAC_UPDATA_INDEX:String = "zodiacUpdataIndex";
      
      public static const ZODIAC_UPDATA_MESSAGE:String = "zodiacUpdataMessage";
      
      private static var _instance:ZodiacManager;
       
      
      public function ZodiacManager(param1:InstanceClass)
      {
         super();
      }
      
      public static function get instance() : ZodiacManager
      {
         var _loc1_:* = null;
         if(_instance == null)
         {
            _loc1_ = new InstanceClass();
            _instance = new ZodiacManager(_loc1_);
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.Instance.addEventListener("zodiac",__zodiacHandler);
      }
      
      private function __zodiacHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:int = _loc4_.readInt();
         switch(int(_loc2_) - 1)
         {
            case 0:
               ZodiacModel.instance.isOpen = _loc4_.readBoolean();
               if(ZodiacModel.instance.questArr == null)
               {
                  ZodiacModel.instance.questArr = [];
               }
               _loc6_ = 0;
               while(_loc6_ < 12)
               {
                  ZodiacModel.instance.questArr[_loc6_] = _loc4_.readInt();
                  _loc6_++;
               }
               ZodiacModel.instance.awardRecord = _loc4_.readInt();
               ZodiacModel.instance.maxCounts = _loc4_.readInt();
               ZodiacModel.instance.finshedCounts = _loc4_.readInt();
               setIndexTypeDic(_loc4_);
               break;
            case 1:
               ZodiacModel.instance.isOpen = _loc4_.readBoolean();
               if(ZodiacModel.instance.questArr == null)
               {
                  ZodiacModel.instance.questArr = [];
               }
               _loc5_ = 0;
               while(_loc5_ < 12)
               {
                  _loc3_ = _loc4_.readInt();
                  if(ZodiacModel.instance.questArr[_loc5_] != _loc3_ && _loc3_ != 0)
                  {
                     ZodiacModel.instance.newIndex = _loc5_ + 1;
                     ZodiacModel.instance.questArr[_loc5_] = _loc3_;
                     dispatchEvent(new Event("zodiacUpdataIndex"));
                  }
                  ZodiacModel.instance.questArr[_loc5_] = _loc3_;
                  _loc5_++;
               }
               ZodiacModel.instance.awardRecord = _loc4_.readInt();
               ZodiacModel.instance.maxCounts = _loc4_.readInt();
               ZodiacModel.instance.finshedCounts = _loc4_.readInt();
               setIndexTypeDic(_loc4_);
               dispatchEvent(new Event("zodiacUpdataMessage"));
         }
         if(ZodiacModel.instance.isOpen)
         {
            createIcon();
         }
         else
         {
            removeIcon();
         }
      }
      
      private function setIndexTypeDic(param1:PackageIn) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = param1.readInt();
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc2_ = param1.readInt();
            _loc5_ = param1.readInt();
            ZodiacModel.instance.indexTypeArr[_loc2_] = _loc5_;
            _loc3_++;
         }
      }
      
      public function createIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("zodiac",true);
      }
      
      public function removeIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("zodiac",false);
      }
      
      public function hide() : void
      {
         dispatchEvent(new Event("hideMainView"));
      }
      
      override protected function start() : void
      {
         _zodiacLoad();
      }
      
      private function _zodiacLoad() : void
      {
         new HelperUIModuleLoad().loadUIModule(["zodiac"],onLoaded);
      }
      
      private function onLoaded() : void
      {
         dispatchEvent(new Event("showMainView"));
      }
   }
}

class InstanceClass
{
    
   
   function InstanceClass()
   {
      super();
   }
}
