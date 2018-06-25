package campbattle{   import campbattle.data.CampBattleAwardsDataAnalyzer;   import ddt.CoreManager;   import ddt.events.CEvent;   import ddt.events.PkgEvent;   import ddt.manager.ChatManager;   import ddt.manager.CheckWeaponManager;   import ddt.manager.GameInSocketOut;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import ddtActivityIcon.DdtActivityIconManager;   import ddtActivityIcon.DdtIconTxt;   import flash.display.MovieClip;   import flash.events.IEventDispatcher;   import flash.events.MouseEvent;   import flash.utils.getTimer;   import hallIcon.HallIconManager;   import road7th.comm.PackageIn;      public class CampBattleManager extends CoreManager   {            public static const CAMPBATTLE_INITSECEN:String = "campbattle_initscene";            private static var _instance:CampBattleManager;                   public var openFlag:Boolean;            public var campViewFlag:Boolean;            private var _isFighting:Boolean;            private var _activityTxt:DdtIconTxt;            private var _entryBtn:MovieClip;            private var _lastCreatTime:int;            private var _endTime:Date;            private var _initPkg:PackageIn;            public var awardsFrameView:Boolean = true;            public var mapID:int;            public var goodsZone:int;            public var goods:Array;            public function CampBattleManager(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : CampBattleManager { return null; }
            public function get isFighting() : Boolean { return false; }
            public function set isFighting(value:Boolean) : void { }
            public function setup() : void { }
            protected function __onInitSecenHander(event:PkgEvent) : void { }
            override protected function start() : void { }
            public function addCampBtn($isOpen:Boolean = true, timeStr:String = null) : void { }
            public function deleCanpBtn() : void { }
            private function __onActionIsOpenHander(event:PkgEvent) : void { }
            public function __onCampBtnHander(event:MouseEvent) : void { }
            public function get toEndTime() : int { return 0; }
            private function getDateHourTime(date:Date) : int { return 0; }
            public function templateDataSetup(data:CampBattleAwardsDataAnalyzer) : void { }
            private function returnGoodsArray(data:Array) : Array { return null; }
            public function getLevelGoodsItems(level:int) : Array { return null; }
            public function get initPkg() : PackageIn { return null; }
   }}