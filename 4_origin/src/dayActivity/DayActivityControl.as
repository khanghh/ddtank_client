package dayActivity
{
   import campbattle.CampBattleManager;
   import catchbeast.CatchBeastManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import consortionBattle.ConsortiaBattleManager;
   import dayActivity.items.DayActivieListItem;
   import dayActivity.view.DayActivityView;
   import ddt.events.PkgEvent;
   import ddt.manager.BattleGroudManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import entertainmentMode.EntertainmentModeManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import horseRace.controller.HorseRaceManager;
   import lanternriddles.LanternRiddlesManager;
   import league.LeagueManager;
   import rescue.RescueManager;
   import sevenDouble.SevenDoubleManager;
   import worldboss.WorldBossManager;
   
   public class DayActivityControl extends EventDispatcher
   {
      
      private static var _instance:DayActivityControl;
       
      
      private var _activityFrame:ActivityFrame;
      
      public function DayActivityControl(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get Instance() : DayActivityControl
      {
         if(_instance == null)
         {
            _instance = new DayActivityControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         var _loc1_:int = 155;
         SocketManager.Instance.addEventListener(PkgEvent.format(_loc1_,3),addSpeedResp);
         SocketManager.Instance.addEventListener(PkgEvent.format(_loc1_,4),changGoodsBtn);
         SocketManager.Instance.addEventListener(PkgEvent.format(_loc1_,2),initSingleActivity);
         SocketManager.Instance.addEventListener(PkgEvent.format(_loc1_,7),addActivityChange);
         DayActivityManager.Instance.addEventListener("activityOpenView",createActivityFrame);
      }
      
      public function changGoodsBtn(param1:PkgEvent) : void
      {
         var _loc2_:int = param1.pkg.readInt();
         var _loc3_:Boolean = param1.pkg.readBoolean();
         if(_loc3_)
         {
            DayActivityManager.Instance.btnArr[_loc2_ - 1][1] = 1;
            if(_activityFrame)
            {
               _activityFrame.updataBtn(_loc2_);
            }
            DayActivityManager.Instance.dispatchEvent(new Event("daily_activity_get_status_change"));
         }
      }
      
      public function addActivityChange(param1:PkgEvent) : void
      {
         var _loc2_:int = param1.pkg.readInt();
         var _loc3_:int = param1.pkg.readInt();
         updataNum(_loc2_,_loc3_);
      }
      
      public function send(param1:int, param2:int) : void
      {
         SocketManager.Instance.out.addSpeed(param1,param2);
      }
      
      private function updataNum(param1:int, param2:int) : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         if(DayActivityManager.Instance.sessionArr == null)
         {
            DayActivityManager.Instance.sessionArr = [];
         }
         var _loc4_:int = DayActivityManager.Instance.sessionArr.length;
         if(_loc4_ == 0)
         {
            _loc3_ = [];
            _loc3_[0] = param1;
            _loc3_[1] = param2;
            DayActivityManager.Instance.sessionArr.push(_loc3_);
         }
         else
         {
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               if(DayActivityManager.Instance.sessionArr[_loc5_][0] == param1)
               {
                  DayActivityManager.Instance.sessionArr[_loc5_][1] = param2;
                  break;
               }
               if(_loc5_ >= _loc4_ - 1)
               {
                  _loc3_ = [];
                  _loc3_[0] = param1;
                  _loc3_[1] = param2;
                  DayActivityManager.Instance.sessionArr.push(_loc3_);
               }
               _loc5_++;
            }
         }
      }
      
      public function addSpeedResp(param1:PkgEvent) : void
      {
         var _loc2_:int = param1.pkg.readInt();
         var _loc4_:Boolean = param1.pkg.readBoolean();
         DayActivityManager.Instance.activityValue = param1.pkg.readInt();
         var _loc3_:int = param1.pkg.readInt();
         if(DayActivityManager.Instance.speedActArr.indexOf(_loc3_) == -1)
         {
            DayActivityManager.Instance.speedActArr.push(_loc3_);
         }
         addOverList(_loc4_,_loc2_);
         if(_activityFrame && _activityFrame.parent)
         {
            _activityFrame.setLeftView(DayActivityManager.Instance.overList,DayActivityManager.Instance.noOverList);
            _activityFrame.setBar(DayActivityManager.Instance.activityValue);
         }
      }
      
      private function addOverList(param1:Boolean, param2:int, param3:int = 0) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = DayActivityManager.Instance.acitivityDataList.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            if(DayActivityManager.Instance.acitivityDataList[_loc5_].ActivityType == param2)
            {
               if(param1)
               {
                  DayActivityManager.Instance.acitivityDataList[_loc5_].OverCount = DayActivityManager.Instance.acitivityDataList[_loc5_].Count;
                  DayActivityManager.Instance.overList.push(DayActivityManager.Instance.acitivityDataList[_loc5_]);
                  DayActivityManager.Instance.deleNoOverListItem(param2);
               }
               else
               {
                  DayActivityManager.Instance.acitivityDataList[_loc5_].OverCount = param3;
                  if(DayActivityManager.Instance.acitivityDataList[_loc5_].Count <= param3)
                  {
                     if(!checkOverList(DayActivityManager.Instance.acitivityDataList[_loc5_].ActivityType))
                     {
                        DayActivityManager.Instance.overList.push(DayActivityManager.Instance.acitivityDataList[_loc5_]);
                     }
                     DayActivityManager.Instance.deleNoOverListItem(param2);
                  }
               }
               break;
            }
            _loc5_++;
         }
      }
      
      private function checkOverList(param1:int) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = DayActivityManager.Instance.overList.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(DayActivityManager.Instance.overList[_loc3_].ActivityType == param1)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function initSingleActivity(param1:PkgEvent) : void
      {
         var _loc2_:int = param1.pkg.readInt();
         var _loc3_:int = param1.pkg.readInt();
         if(_loc2_ == 4 || _loc2_ == 5 || _loc2_ == 6 || _loc2_ == 18 || _loc2_ == 19)
         {
            DayActivityManager.Instance.bossDataDic[_loc2_] = _loc3_;
         }
         DayActivityManager.Instance.activityValue = param1.pkg.readInt();
         addOverList(false,_loc2_,_loc3_);
         if(_activityFrame && _activityFrame.parent)
         {
            _activityFrame.setLeftView(DayActivityManager.Instance.overList,DayActivityManager.Instance.noOverList);
            _activityFrame.setBar(DayActivityManager.Instance.activityValue);
         }
      }
      
      protected function createActivityFrame(param1:Event) : void
      {
         _activityFrame = ComponentFactory.Instance.creatComponentByStylename("dayActivity.ActivityFrame");
         LayerManager.Instance.addToLayer(_activityFrame,3,true,1);
      }
      
      public function initActivityStata(param1:Vector.<DayActivieListItem>) : void
      {
         if(WorldBossManager.Instance.isOpen)
         {
            if(WorldBossManager.Instance.currentPVE_ID == 30002)
            {
               updateActivityData(DayActivityManager.Instance.ANYEBOJUE,param1,false);
            }
            else if(WorldBossManager.Instance.currentPVE_ID == 1243)
            {
               updateActivityData(DayActivityManager.Instance.YUANGUJULONG,param1,false);
            }
            else
            {
               updateActivityData(DayActivityManager.Instance.ZUQIUBOSS,param1,false);
            }
         }
         else if(WorldBossManager.Instance.currentPVE_ID == 30002)
         {
            updateActivityData(DayActivityManager.Instance.ANYEBOJUE,param1,true);
         }
         else if(WorldBossManager.Instance.currentPVE_ID == 1243)
         {
            updateActivityData(DayActivityManager.Instance.YUANGUJULONG,param1,true);
         }
         else
         {
            updateActivityData(DayActivityManager.Instance.ZUQIUBOSS,param1,true);
         }
         if(LeagueManager.instance.isOpen)
         {
            updateActivityData(DayActivityManager.Instance.LIANSAI,param1,false);
         }
         else
         {
            updateActivityData(DayActivityManager.Instance.LIANSAI,param1,true);
         }
         if(ConsortionModelManager.Instance.isBossOpen)
         {
            updateActivityData(DayActivityManager.Instance.GONGHUIBOSS,param1,false);
         }
         else
         {
            updateActivityData(DayActivityManager.Instance.GONGHUIBOSS,param1,true);
         }
         if(BattleGroudManager.Instance.isShow)
         {
            updateActivityData(DayActivityManager.Instance.ZHANCHANG,param1,false);
         }
         else
         {
            updateActivityData(DayActivityManager.Instance.ZHANCHANG,param1,true);
         }
         if(CampBattleManager.instance.openFlag)
         {
            updateActivityData(DayActivityManager.Instance.ZHENYINGZHAN,param1,false);
         }
         else
         {
            updateActivityData(DayActivityManager.Instance.ZHENYINGZHAN,param1,true);
         }
         if(ConsortiaBattleManager.instance.isOpen)
         {
            updateActivityData(DayActivityManager.Instance.GONGHUIZHAN,param1,false);
         }
         else
         {
            updateActivityData(DayActivityManager.Instance.GONGHUIZHAN,param1,true);
         }
         if(EntertainmentModeManager.instance.isopen)
         {
            updateActivityData(DayActivityManager.Instance.Entertainment,param1,false);
         }
         else
         {
            updateActivityData(DayActivityManager.Instance.Entertainment,param1,true);
         }
         if(LanternRiddlesManager.instance.isBegin)
         {
            updateActivityData(DayActivityManager.Instance.LanternRiddles,param1,false);
         }
         else
         {
            updateActivityData(DayActivityManager.Instance.LanternRiddles,param1,true);
         }
         if(RescueManager.instance.isBegin)
         {
            updateActivityData(DayActivityManager.Instance.Rescue,param1,false);
         }
         else
         {
            updateActivityData(DayActivityManager.Instance.Rescue,param1,true);
         }
         if(HorseRaceManager.Instance.isShowIcon)
         {
            updateActivityData(DayActivityManager.Instance.HorseRace,param1,false);
         }
         else
         {
            updateActivityData(DayActivityManager.Instance.HorseRace,param1,true);
         }
         if(SevenDoubleManager.instance.isStart)
         {
            updateActivityData(DayActivityManager.Instance.SevenDouble,param1,false);
         }
         else
         {
            updateActivityData(DayActivityManager.Instance.SevenDouble,param1,true);
         }
         if(CatchBeastManager.instance.isBegin)
         {
            updateActivityData(DayActivityManager.Instance.CatchBeast,param1,false);
         }
         else
         {
            updateActivityData(DayActivityManager.Instance.CatchBeast,param1,true);
         }
      }
      
      private function updateActivityData(param1:String, param2:Vector.<DayActivieListItem>, param3:Boolean) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = param2.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            if(param1 == param2[_loc5_].data.ActiveTime)
            {
               if(param1 == DayActivityManager.Instance.ZHANCHANG)
               {
                  param2[_loc5_].data.TotalCount = PlayerManager.Instance.Self.BattleCount;
               }
               param2[_loc5_].initTxt(param3);
               return;
            }
            _loc5_++;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_activityFrame);
         _activityFrame = null;
      }
   }
}
