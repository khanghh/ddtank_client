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
      
      public function MysteriousManager(){super();}
      
      public static function get instance() : MysteriousManager{return null;}
      
      public function setup() : void{}
      
      private function __getMysteriousData(param1:PkgEvent) : void{}
      
      public function showIcon() : void{}
      
      override protected function start() : void{}
      
      public function addMask() : void{}
      
      public function removeMask() : void{}
      
      private function onMaskClick(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
