package campbattle
{
   import campbattle.data.CampBattleAwardsDataAnalyzer;
   import ddt.CoreManager;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.CheckWeaponManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddtActivityIcon.DdtActivityIconManager;
   import ddtActivityIcon.DdtIconTxt;
   import flash.display.MovieClip;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class CampBattleManager extends CoreManager
   {
      
      public static const CAMPBATTLE_INITSECEN:String = "campbattle_initscene";
      
      private static var _instance:CampBattleManager;
       
      
      public var openFlag:Boolean;
      
      public var campViewFlag:Boolean;
      
      private var _isFighting:Boolean;
      
      private var _activityTxt:DdtIconTxt;
      
      private var _entryBtn:MovieClip;
      
      private var _lastCreatTime:int;
      
      private var _endTime:Date;
      
      private var _initPkg:PackageIn;
      
      public var awardsFrameView:Boolean = true;
      
      public var mapID:int;
      
      public var goodsZone:int;
      
      public var goods:Array;
      
      public function CampBattleManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : CampBattleManager{return null;}
      
      public function get isFighting() : Boolean{return false;}
      
      public function set isFighting(param1:Boolean) : void{}
      
      public function setup() : void{}
      
      protected function __onInitSecenHander(param1:PkgEvent) : void{}
      
      override protected function start() : void{}
      
      public function addCampBtn(param1:Boolean = true, param2:String = null) : void{}
      
      public function deleCanpBtn() : void{}
      
      private function __onActionIsOpenHander(param1:PkgEvent) : void{}
      
      public function __onCampBtnHander(param1:MouseEvent) : void{}
      
      public function get toEndTime() : int{return 0;}
      
      private function getDateHourTime(param1:Date) : int{return 0;}
      
      public function templateDataSetup(param1:CampBattleAwardsDataAnalyzer) : void{}
      
      private function returnGoodsArray(param1:Array) : Array{return null;}
      
      public function getLevelGoodsItems(param1:int) : Array{return null;}
      
      public function get initPkg() : PackageIn{return null;}
   }
}
