package devilTurn.view
{
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.TimeManager;
   import devilTurn.DevilTurnManager;
   import devilTurn.event.DevilTurnEvent;
   import devilTurn.model.DevilTurnModel;
   import devilTurn.model.DevilTurnPointShopItem;
   import devilTurn.view.mornui.DevilTurnMallViewUI;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import morn.core.components.Box;
   import morn.core.handlers.Handler;
   import road7th.utils.DateUtils;
   
   public class DevilTurnMallView extends DevilTurnMallViewUI
   {
       
      
      private var _model:DevilTurnModel;
      
      private var _timer:Timer;
      
      private var _endTime:Number;
      
      public function DevilTurnMallView()
      {
         super();
      }
      
      override protected function preinitialize() : void
      {
         _model = DevilTurnManager.instance.model;
         _endTime = DateUtils.getDateByStr(ServerConfigManager.instance.devilTurnEndDate).time;
         super.preinitialize();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         text6.text = LanguageMgr.GetTranslation("devilTurn.mornUI.label6");
         _timer = new Timer(60000);
         _timer.addEventListener("timer",__onTimer);
         _timer.start();
         __onTimer(null);
         countText.text = _model.lotteryCount.toString();
         awardList.renderHandler = new Handler(onRenderAwardList);
         awardList.array = _model.pointsShopList;
         DevilTurnManager.instance.addEventListener("updateinfo",__onUpdateInfo);
      }
      
      private function __onTimer(e:TimerEvent) : void
      {
         var dateStr:* = null;
         var date:* = null;
         var time:int = (_endTime - TimeManager.Instance.NowTime()) / 1000;
         if(time >= 0)
         {
            date = DateUtils.dateTimeRemainArr(time);
            dateStr = LanguageMgr.GetTranslation("tank.devilTurn.expireDate",date[0],date[1],date[2]);
         }
         else
         {
            dateStr = LanguageMgr.GetTranslation("tank.devilTurn.activityFinish");
            _timer.stop();
         }
         expireDateText.text = dateStr;
      }
      
      private function onRenderAwardList(item:Box, index:int) : void
      {
         var view:DevilTurnMallItem = item as DevilTurnMallItem;
         if(index < awardList.array.length)
         {
            view.info = awardList.array[index] as DevilTurnPointShopItem;
         }
         else
         {
            view.info = null;
         }
      }
      
      private function __onUpdateInfo(e:DevilTurnEvent) : void
      {
         countText.text = _model.lotteryCount.toString();
      }
      
      override public function dispose() : void
      {
         _timer.stop();
         _timer.removeEventListener("timer",__onTimer);
         _timer = null;
         DevilTurnManager.instance.removeEventListener("updateinfo",__onUpdateInfo);
         _model = null;
         super.dispose();
      }
   }
}
