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
      
      public function CampBattleManager(target:IEventDispatcher = null)
      {
         super(target);
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
      
      public function set isFighting(value:Boolean) : void
      {
         _isFighting = value;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(146,6),__onInitSecenHander);
         SocketManager.Instance.addEventListener(PkgEvent.format(146,10),__onActionIsOpenHander);
      }
      
      protected function __onInitSecenHander(event:PkgEvent) : void
      {
         _initPkg = event.pkg;
         show();
         campViewFlag = true;
      }
      
      override protected function start() : void
      {
         dispatchEvent(new CEvent("campbattle_initscene",_initPkg));
      }
      
      public function addCampBtn($isOpen:Boolean = true, timeStr:String = null) : void
      {
         HallIconManager.instance.updateSwitchHandler("camp",$isOpen,timeStr);
      }
      
      public function deleCanpBtn() : void
      {
         HallIconManager.instance.updateSwitchHandler("camp",false);
      }
      
      private function __onActionIsOpenHander(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         openFlag = pkg.readBoolean();
         var startTime:Date = pkg.readDate();
         _endTime = pkg.readDate();
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
      
      public function __onCampBtnHander(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.Grade < 30)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",30));
            return;
         }
         CheckWeaponManager.instance.setFunction(this,__onCampBtnHander,[event]);
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
      
      private function getDateHourTime(date:Date) : int
      {
         return int(date.hours * 3600 + date.minutes * 60 + date.seconds);
      }
      
      public function templateDataSetup(data:CampBattleAwardsDataAnalyzer) : void
      {
         goods = returnGoodsArray(data._dataList);
      }
      
      private function returnGoodsArray(data:Array) : Array
      {
         var i:int = 0;
         var arrData:Array = [];
         var arr1:Array = [];
         var arr2:Array = [];
         var arr3:Array = [];
         var arr4:Array = [];
         var arr5:Array = [];
         var arr6:Array = [];
         var arr7:Array = [];
         var arr8:Array = [];
         var arr9:Array = [];
         var arr10:Array = [];
         for(i = 0; i < data.length; )
         {
            if(data[i][0].MinRank == 1 && data[i][0].MaxRank == 1)
            {
               arr1.push(data[i][0]);
            }
            else if(data[i][0].MinRank == 2 && data[i][0].MaxRank == 2)
            {
               arr2.push(data[i][0]);
            }
            else if(data[i][0].MinRank == 3 && data[i][0].MaxRank == 3)
            {
               arr3.push(data[i][0]);
            }
            else if(data[i][0].MinRank == 4 && data[i][0].MaxRank == 4)
            {
               arr4.push(data[i][0]);
            }
            else if(data[i][0].MinRank == 1 && data[i][0].MaxRank == 10)
            {
               arr5.push(data[i][0]);
            }
            else if(data[i][0].MinRank == 11 && data[i][0].MaxRank == 20)
            {
               arr6.push(data[i][0]);
            }
            else if(data[i][0].MinRank == 21 && data[i][0].MaxRank == 30)
            {
               arr7.push(data[i][0]);
            }
            else if(data[i][0].MinRank == 31 && data[i][0].MaxRank == 40)
            {
               arr8.push(data[i][0]);
            }
            else if(data[i][0].MinRank == 41 && data[i][0].MaxRank == 50)
            {
               arr9.push(data[i][0]);
            }
            else if(data[i][0].MinRank == 51 && data[i][0].MaxRank == 60)
            {
               arr10.push(data[i][0]);
            }
            i++;
         }
         arrData.push(arr1,arr2,arr3,arr4,arr5,arr6,arr7,arr8,arr9,arr10);
         return arrData;
      }
      
      public function getLevelGoodsItems(level:int) : Array
      {
         return goods[level];
      }
      
      public function get initPkg() : PackageIn
      {
         return _initPkg;
      }
   }
}
