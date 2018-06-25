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
       
      
      public function ZodiacManager(instanceClass:InstanceClass)
      {
         super();
      }
      
      public static function get instance() : ZodiacManager
      {
         var instanceclass:* = null;
         if(_instance == null)
         {
            instanceclass = new InstanceClass();
            _instance = new ZodiacManager(instanceclass);
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
      
      private function __zodiacHandler(e:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var j:int = 0;
         var temp:int = 0;
         var pkg:PackageIn = e.pkg;
         var cmd:int = pkg.readInt();
         switch(int(cmd) - 1)
         {
            case 0:
               ZodiacModel.instance.isOpen = pkg.readBoolean();
               if(ZodiacModel.instance.questArr == null)
               {
                  ZodiacModel.instance.questArr = [];
               }
               i = 0;
               while(i < 12)
               {
                  ZodiacModel.instance.questArr[i] = pkg.readInt();
                  i++;
               }
               ZodiacModel.instance.awardRecord = pkg.readInt();
               ZodiacModel.instance.maxCounts = pkg.readInt();
               ZodiacModel.instance.finshedCounts = pkg.readInt();
               setIndexTypeDic(pkg);
               break;
            case 1:
               ZodiacModel.instance.isOpen = pkg.readBoolean();
               if(ZodiacModel.instance.questArr == null)
               {
                  ZodiacModel.instance.questArr = [];
               }
               j = 0;
               while(j < 12)
               {
                  temp = pkg.readInt();
                  if(ZodiacModel.instance.questArr[j] != temp && temp != 0)
                  {
                     ZodiacModel.instance.newIndex = j + 1;
                     ZodiacModel.instance.questArr[j] = temp;
                     dispatchEvent(new Event("zodiacUpdataIndex"));
                  }
                  ZodiacModel.instance.questArr[j] = temp;
                  j++;
               }
               ZodiacModel.instance.awardRecord = pkg.readInt();
               ZodiacModel.instance.maxCounts = pkg.readInt();
               ZodiacModel.instance.finshedCounts = pkg.readInt();
               setIndexTypeDic(pkg);
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
      
      private function setIndexTypeDic(pkg:PackageIn) : void
      {
         var m:int = 0;
         var qID:int = 0;
         var type:int = 0;
         var len:int = pkg.readInt();
         for(m = 0; m < len; )
         {
            qID = pkg.readInt();
            type = pkg.readInt();
            ZodiacModel.instance.indexTypeArr[qID] = type;
            m++;
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
