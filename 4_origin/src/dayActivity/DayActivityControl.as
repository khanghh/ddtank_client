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
      
      public function DayActivityControl(target:IEventDispatcher = null)
      {
         super(target);
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
         var eType:int = 155;
         SocketManager.Instance.addEventListener(PkgEvent.format(eType,3),addSpeedResp);
         SocketManager.Instance.addEventListener(PkgEvent.format(eType,4),changGoodsBtn);
         SocketManager.Instance.addEventListener(PkgEvent.format(eType,2),initSingleActivity);
         SocketManager.Instance.addEventListener(PkgEvent.format(eType,7),addActivityChange);
         DayActivityManager.Instance.addEventListener("activityOpenView",createActivityFrame);
      }
      
      public function changGoodsBtn(e:PkgEvent) : void
      {
         var id:int = e.pkg.readInt();
         var bool:Boolean = e.pkg.readBoolean();
         if(bool)
         {
            DayActivityManager.Instance.btnArr[id - 1][1] = 1;
            if(_activityFrame)
            {
               _activityFrame.updataBtn(id);
            }
            DayActivityManager.Instance.dispatchEvent(new Event("daily_activity_get_status_change"));
         }
      }
      
      public function addActivityChange(e:PkgEvent) : void
      {
         var id:int = e.pkg.readInt();
         var count:int = e.pkg.readInt();
         updataNum(id,count);
      }
      
      public function send(i:int, id:int) : void
      {
         SocketManager.Instance.out.addSpeed(i,id);
      }
      
      private function updataNum(id:int, count:int) : void
      {
         var arr:* = null;
         var i:int = 0;
         if(DayActivityManager.Instance.sessionArr == null)
         {
            DayActivityManager.Instance.sessionArr = [];
         }
         var len:int = DayActivityManager.Instance.sessionArr.length;
         if(len == 0)
         {
            arr = [];
            arr[0] = id;
            arr[1] = count;
            DayActivityManager.Instance.sessionArr.push(arr);
         }
         else
         {
            for(i = 0; i < len; )
            {
               if(DayActivityManager.Instance.sessionArr[i][0] == id)
               {
                  DayActivityManager.Instance.sessionArr[i][1] = count;
                  break;
               }
               if(i >= len - 1)
               {
                  arr = [];
                  arr[0] = id;
                  arr[1] = count;
                  DayActivityManager.Instance.sessionArr.push(arr);
               }
               i++;
            }
         }
      }
      
      public function addSpeedResp(e:PkgEvent) : void
      {
         var id:int = e.pkg.readInt();
         var bool:Boolean = e.pkg.readBoolean();
         DayActivityManager.Instance.activityValue = e.pkg.readInt();
         var actId:int = e.pkg.readInt();
         if(DayActivityManager.Instance.speedActArr.indexOf(actId) == -1)
         {
            DayActivityManager.Instance.speedActArr.push(actId);
         }
         addOverList(bool,id);
         if(_activityFrame && _activityFrame.parent)
         {
            _activityFrame.setLeftView(DayActivityManager.Instance.overList,DayActivityManager.Instance.noOverList);
            _activityFrame.setBar(DayActivityManager.Instance.activityValue);
         }
      }
      
      private function addOverList(bool:Boolean, type:int, count:int = 0) : void
      {
         var j:int = 0;
         var len:int = DayActivityManager.Instance.acitivityDataList.length;
         for(j = 0; j < len; )
         {
            if(DayActivityManager.Instance.acitivityDataList[j].ActivityType == type)
            {
               if(bool)
               {
                  DayActivityManager.Instance.acitivityDataList[j].OverCount = DayActivityManager.Instance.acitivityDataList[j].Count;
                  DayActivityManager.Instance.overList.push(DayActivityManager.Instance.acitivityDataList[j]);
                  DayActivityManager.Instance.deleNoOverListItem(type);
               }
               else
               {
                  DayActivityManager.Instance.acitivityDataList[j].OverCount = count;
                  if(DayActivityManager.Instance.acitivityDataList[j].Count <= count)
                  {
                     if(!checkOverList(DayActivityManager.Instance.acitivityDataList[j].ActivityType))
                     {
                        DayActivityManager.Instance.overList.push(DayActivityManager.Instance.acitivityDataList[j]);
                     }
                     DayActivityManager.Instance.deleNoOverListItem(type);
                  }
               }
               break;
            }
            j++;
         }
      }
      
      private function checkOverList(type:int) : Boolean
      {
         var i:int = 0;
         var len:int = DayActivityManager.Instance.overList.length;
         for(i = 0; i < len; )
         {
            if(DayActivityManager.Instance.overList[i].ActivityType == type)
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      public function initSingleActivity(e:PkgEvent) : void
      {
         var id1:int = e.pkg.readInt();
         var count1:int = e.pkg.readInt();
         if(id1 == 4 || id1 == 5 || id1 == 6 || id1 == 18 || id1 == 19)
         {
            DayActivityManager.Instance.bossDataDic[id1] = count1;
         }
         DayActivityManager.Instance.activityValue = e.pkg.readInt();
         addOverList(false,id1,count1);
         if(_activityFrame && _activityFrame.parent)
         {
            _activityFrame.setLeftView(DayActivityManager.Instance.overList,DayActivityManager.Instance.noOverList);
            _activityFrame.setBar(DayActivityManager.Instance.activityValue);
         }
      }
      
      protected function createActivityFrame(event:Event) : void
      {
         _activityFrame = ComponentFactory.Instance.creatComponentByStylename("dayActivity.ActivityFrame");
         LayerManager.Instance.addToLayer(_activityFrame,3,true,1);
      }
      
      public function initActivityStata(_list:Vector.<DayActivieListItem>) : void
      {
         if(WorldBossManager.Instance.isOpen)
         {
            if(WorldBossManager.Instance.currentPVE_ID == 30002)
            {
               updateActivityData(DayActivityManager.Instance.ANYEBOJUE,_list,false);
            }
            else if(WorldBossManager.Instance.currentPVE_ID == 1243)
            {
               updateActivityData(DayActivityManager.Instance.YUANGUJULONG,_list,false);
            }
            else
            {
               updateActivityData(DayActivityManager.Instance.ZUQIUBOSS,_list,false);
            }
         }
         else if(WorldBossManager.Instance.currentPVE_ID == 30002)
         {
            updateActivityData(DayActivityManager.Instance.ANYEBOJUE,_list,true);
         }
         else if(WorldBossManager.Instance.currentPVE_ID == 1243)
         {
            updateActivityData(DayActivityManager.Instance.YUANGUJULONG,_list,true);
         }
         else
         {
            updateActivityData(DayActivityManager.Instance.ZUQIUBOSS,_list,true);
         }
         if(LeagueManager.instance.isOpen)
         {
            updateActivityData(DayActivityManager.Instance.LIANSAI,_list,false);
         }
         else
         {
            updateActivityData(DayActivityManager.Instance.LIANSAI,_list,true);
         }
         if(ConsortionModelManager.Instance.isBossOpen)
         {
            updateActivityData(DayActivityManager.Instance.GONGHUIBOSS,_list,false);
         }
         else
         {
            updateActivityData(DayActivityManager.Instance.GONGHUIBOSS,_list,true);
         }
         if(BattleGroudManager.Instance.isShow)
         {
            updateActivityData(DayActivityManager.Instance.ZHANCHANG,_list,false);
         }
         else
         {
            updateActivityData(DayActivityManager.Instance.ZHANCHANG,_list,true);
         }
         if(CampBattleManager.instance.openFlag)
         {
            updateActivityData(DayActivityManager.Instance.ZHENYINGZHAN,_list,false);
         }
         else
         {
            updateActivityData(DayActivityManager.Instance.ZHENYINGZHAN,_list,true);
         }
         if(ConsortiaBattleManager.instance.isOpen)
         {
            updateActivityData(DayActivityManager.Instance.GONGHUIZHAN,_list,false);
         }
         else
         {
            updateActivityData(DayActivityManager.Instance.GONGHUIZHAN,_list,true);
         }
         if(EntertainmentModeManager.instance.isopen)
         {
            updateActivityData(DayActivityManager.Instance.Entertainment,_list,false);
         }
         else
         {
            updateActivityData(DayActivityManager.Instance.Entertainment,_list,true);
         }
         if(LanternRiddlesManager.instance.isBegin)
         {
            updateActivityData(DayActivityManager.Instance.LanternRiddles,_list,false);
         }
         else
         {
            updateActivityData(DayActivityManager.Instance.LanternRiddles,_list,true);
         }
         if(RescueManager.instance.isBegin)
         {
            updateActivityData(DayActivityManager.Instance.Rescue,_list,false);
         }
         else
         {
            updateActivityData(DayActivityManager.Instance.Rescue,_list,true);
         }
         if(HorseRaceManager.Instance.isShowIcon)
         {
            updateActivityData(DayActivityManager.Instance.HorseRace,_list,false);
         }
         else
         {
            updateActivityData(DayActivityManager.Instance.HorseRace,_list,true);
         }
         if(SevenDoubleManager.instance.isStart)
         {
            updateActivityData(DayActivityManager.Instance.SevenDouble,_list,false);
         }
         else
         {
            updateActivityData(DayActivityManager.Instance.SevenDouble,_list,true);
         }
         if(CatchBeastManager.instance.isBegin)
         {
            updateActivityData(DayActivityManager.Instance.CatchBeast,_list,false);
         }
         else
         {
            updateActivityData(DayActivityManager.Instance.CatchBeast,_list,true);
         }
      }
      
      private function updateActivityData(str:String, _list:Vector.<DayActivieListItem>, bool:Boolean) : void
      {
         var i:int = 0;
         var len:int = _list.length;
         for(i = 0; i < len; )
         {
            if(str == _list[i].data.ActiveTime)
            {
               if(str == DayActivityManager.Instance.ZHANCHANG)
               {
                  _list[i].data.TotalCount = PlayerManager.Instance.Self.BattleCount;
               }
               _list[i].initTxt(bool);
               return;
            }
            i++;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_activityFrame);
         _activityFrame = null;
      }
   }
}
