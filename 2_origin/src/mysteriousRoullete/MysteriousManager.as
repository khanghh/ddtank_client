package mysteriousRoullete
{
   import com.pickgliss.ui.LayerManager;
   import ddt.CoreManager;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import hallIcon.HallIconManager;
   import mysteriousRoullete.event.MysteriousEvent;
   import road7th.comm.PackageIn;
   import wonderfulActivity.WonderfulActivityManager;
   
   public class MysteriousManager extends CoreManager
   {
      
      public static const TYPE_ROULETTE:int = 0;
      
      public static const TYPE_SHOP:int = 1;
      
      private static var _instance:MysteriousManager;
       
      
      public var lotteryTimes:int;
      
      public var freeGetTimes:int;
      
      public var discountBuyTimes:int;
      
      public var startTime:Date;
      
      public var endTime:Date;
      
      public var mysteriousViewFlag:Boolean;
      
      private var _func:Function;
      
      private var _funcParams:Array;
      
      public var viewType:int;
      
      public var selectIndex:int = -1;
      
      public var isMysteriousClose:Boolean = false;
      
      private var _mask:Sprite;
      
      public function MysteriousManager()
      {
         super();
      }
      
      public static function get instance() : MysteriousManager
      {
         if(!_instance)
         {
            _instance = new MysteriousManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(110,16),__getMysteriousData);
      }
      
      private function __getMysteriousData(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         lotteryTimes = _loc2_.readInt();
         freeGetTimes = _loc2_.readInt();
         discountBuyTimes = _loc2_.readInt();
         startTime = _loc2_.readDate();
         endTime = _loc2_.readDate();
         if(lotteryTimes <= 0)
         {
            if(freeGetTimes != 0 || discountBuyTimes != 0)
            {
               viewType = 1;
            }
            if(mysteriousViewFlag)
            {
               dispatchEvent(new MysteriousEvent("mysteriousSetTime",-1));
               if(freeGetTimes == 0 && discountBuyTimes == 0)
               {
                  isMysteriousClose = true;
               }
               return;
            }
            if(freeGetTimes == 0 && discountBuyTimes == 0)
            {
               if(WonderfulActivityManager.Instance.frameFlag)
               {
                  isMysteriousClose = true;
               }
               else
               {
                  HallIconManager.instance.updateSwitchHandler("mysteriousRoulette",false);
               }
               return;
            }
         }
         else
         {
            viewType = 0;
         }
         showIcon();
      }
      
      public function showIcon() : void
      {
         isMysteriousClose = false;
         HallIconManager.instance.updateSwitchHandler("mysteriousRoulette",true);
      }
      
      override protected function start() : void
      {
         dispatchEvent(new MysteriousEvent("showView",null));
      }
      
      public function addMask() : void
      {
         if(_mask == null)
         {
            _mask = new Sprite();
            _mask.graphics.beginFill(0,0);
            _mask.graphics.drawRect(0,0,2000,1200);
            _mask.graphics.endFill();
            _mask.addEventListener("click",onMaskClick);
         }
         LayerManager.Instance.addToLayer(_mask,2,false,2);
      }
      
      public function removeMask() : void
      {
         if(_mask != null)
         {
            _mask.parent.removeChild(_mask);
            _mask.removeEventListener("click",onMaskClick);
            _mask = null;
         }
      }
      
      private function onMaskClick(param1:MouseEvent) : void
      {
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("mysteriousRoulette.running"));
      }
      
      public function dispose() : void
      {
      }
   }
}
