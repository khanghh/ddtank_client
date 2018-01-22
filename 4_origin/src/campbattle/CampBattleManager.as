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
      
      public function CampBattleManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : CampBattleManager
      {
         if(!_instance)
         {
            _instance = new CampBattleManager();
         }
         return _instance;
      }
      
      public function get isFighting() : Boolean
      {
         return _isFighting;
      }
      
      public function set isFighting(param1:Boolean) : void
      {
         _isFighting = param1;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(146,6),__onInitSecenHander);
         SocketManager.Instance.addEventListener(PkgEvent.format(146,10),__onActionIsOpenHander);
      }
      
      protected function __onInitSecenHander(param1:PkgEvent) : void
      {
         _initPkg = param1.pkg;
         show();
         campViewFlag = true;
      }
      
      override protected function start() : void
      {
         dispatchEvent(new CEvent("campbattle_initscene",_initPkg));
      }
      
      public function addCampBtn(param1:Boolean = true, param2:String = null) : void
      {
         HallIconManager.instance.updateSwitchHandler("camp",param1,param2);
      }
      
      public function deleCanpBtn() : void
      {
         HallIconManager.instance.updateSwitchHandler("camp",false);
      }
      
      private function __onActionIsOpenHander(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         openFlag = _loc3_.readBoolean();
         var _loc2_:Date = _loc3_.readDate();
         _endTime = _loc3_.readDate();
         if(!openFlag)
         {
            deleCanpBtn();
            DdtActivityIconManager.Instance.currObj = null;
            ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("ddt.campBattle.close"));
            SocketManager.Instance.out.outCampBatttle();
         }
         else
         {
            addCampBtn();
            ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("ddt.campBattle.open"));
         }
      }
      
      public function __onCampBtnHander(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.Grade < 30)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",30));
            return;
         }
         CheckWeaponManager.instance.setFunction(this,__onCampBtnHander,[param1]);
         if(CheckWeaponManager.instance.isNoWeapon())
         {
            CheckWeaponManager.instance.showAlert();
            return;
         }
         if(getTimer() - _lastCreatTime > 1000)
         {
            _lastCreatTime = getTimer();
            GameInSocketOut.sendSingleRoomBegin(5);
         }
      }
      
      public function get toEndTime() : int
      {
         if(!_endTime)
         {
            return 0;
         }
         return getDateHourTime(_endTime) - getDateHourTime(TimeManager.Instance.Now());
      }
      
      private function getDateHourTime(param1:Date) : int
      {
         return int(param1.hours * 3600 + param1.minutes * 60 + param1.seconds);
      }
      
      public function templateDataSetup(param1:CampBattleAwardsDataAnalyzer) : void
      {
         goods = returnGoodsArray(param1._dataList);
      }
      
      private function returnGoodsArray(param1:Array) : Array
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         var _loc9_:Array = [];
         var _loc7_:Array = [];
         var _loc6_:Array = [];
         var _loc5_:Array = [];
         var _loc13_:Array = [];
         var _loc12_:Array = [];
         var _loc11_:Array = [];
         var _loc10_:Array = [];
         var _loc4_:Array = [];
         var _loc8_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_][0].MinRank == 1 && param1[_loc3_][0].MaxRank == 1)
            {
               _loc9_.push(param1[_loc3_][0]);
            }
            else if(param1[_loc3_][0].MinRank == 2 && param1[_loc3_][0].MaxRank == 2)
            {
               _loc7_.push(param1[_loc3_][0]);
            }
            else if(param1[_loc3_][0].MinRank == 3 && param1[_loc3_][0].MaxRank == 3)
            {
               _loc6_.push(param1[_loc3_][0]);
            }
            else if(param1[_loc3_][0].MinRank == 4 && param1[_loc3_][0].MaxRank == 4)
            {
               _loc5_.push(param1[_loc3_][0]);
            }
            else if(param1[_loc3_][0].MinRank == 1 && param1[_loc3_][0].MaxRank == 10)
            {
               _loc13_.push(param1[_loc3_][0]);
            }
            else if(param1[_loc3_][0].MinRank == 11 && param1[_loc3_][0].MaxRank == 20)
            {
               _loc12_.push(param1[_loc3_][0]);
            }
            else if(param1[_loc3_][0].MinRank == 21 && param1[_loc3_][0].MaxRank == 30)
            {
               _loc11_.push(param1[_loc3_][0]);
            }
            else if(param1[_loc3_][0].MinRank == 31 && param1[_loc3_][0].MaxRank == 40)
            {
               _loc10_.push(param1[_loc3_][0]);
            }
            else if(param1[_loc3_][0].MinRank == 41 && param1[_loc3_][0].MaxRank == 50)
            {
               _loc4_.push(param1[_loc3_][0]);
            }
            else if(param1[_loc3_][0].MinRank == 51 && param1[_loc3_][0].MaxRank == 60)
            {
               _loc8_.push(param1[_loc3_][0]);
            }
            _loc3_++;
         }
         _loc2_.push(_loc9_,_loc7_,_loc6_,_loc5_,_loc13_,_loc12_,_loc11_,_loc10_,_loc4_,_loc8_);
         return _loc2_;
      }
      
      public function getLevelGoodsItems(param1:int) : Array
      {
         return goods[param1];
      }
      
      public function get initPkg() : PackageIn
      {
         return _initPkg;
      }
   }
}
