package foodActivity
{
   import com.pickgliss.utils.ObjectUtils;
   import ddt.CoreManager;
   import ddt.events.PkgEvent;
   import ddt.manager.SocketManager;
   import ddt.manager.TimeManager;
   import ddt.view.FoodActivityEnterIcon;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import foodActivity.event.FoodActivityEvent;
   import hall.HallStateView;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GmActivityInfo;
   
   public class FoodActivityManager extends CoreManager
   {
      
      private static var _instance:FoodActivityManager;
       
      
      private var _info:GmActivityInfo;
      
      public var _isStart:Boolean;
      
      public var ripeNum:int;
      
      public var cookingCount:int;
      
      public var state:int;
      
      public var currentSumTime:int;
      
      public var delayTime:int;
      
      private var _timer:Timer;
      
      public var sumTime:int;
      
      private var _actId:String;
      
      private var _foodActivityEnterIcon:FoodActivityEnterIcon;
      
      private var _hallView:HallStateView;
      
      public function FoodActivityManager(){super();}
      
      public static function get Instance() : FoodActivityManager{return null;}
      
      public function setUp() : void{}
      
      protected function pkgHandler(param1:PkgEvent) : void{}
      
      private function cleanDataHandler(param1:PackageIn) : void{}
      
      private function cookingHanlder(param1:PackageIn) : void{}
      
      private function updateView() : void{}
      
      private function updateCookingCount(param1:PackageIn) : void{}
      
      private function openOrCloseHandler(param1:PackageIn) : void{}
      
      public function checkOpen() : void{}
      
      private function initData() : void{}
      
      public function initBtn() : void{}
      
      public function startTime(param1:Boolean = false) : void{}
      
      public function endTime() : void{}
      
      public function stopTime() : void{}
      
      protected function __timerHandler(param1:TimerEvent) : void{}
      
      public function deleteBtn() : void{}
      
      override protected function start() : void{}
      
      public function get info() : GmActivityInfo{return null;}
      
      public function set info(param1:GmActivityInfo) : void{}
      
      public function get isStart() : Boolean{return false;}
      
      public function get foodActivityIcon() : FoodActivityEnterIcon{return null;}
   }
}
