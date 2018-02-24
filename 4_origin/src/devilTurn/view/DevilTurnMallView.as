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
      
      private function __onTimer(param1:TimerEvent) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc2_:int = (_endTime - TimeManager.Instance.NowTime()) / 1000;
         if(_loc2_ >= 0)
         {
            _loc3_ = DateUtils.dateTimeRemainArr(_loc2_);
            _loc4_ = LanguageMgr.GetTranslation("tank.devilTurn.expireDate",_loc3_[0],_loc3_[1],_loc3_[2]);
         }
         else
         {
            _loc4_ = LanguageMgr.GetTranslation("tank.devilTurn.activityFinish");
            _timer.stop();
         }
         expireDateText.text = _loc4_;
      }
      
      private function onRenderAwardList(param1:Box, param2:int) : void
      {
         var _loc3_:DevilTurnMallItem = param1 as DevilTurnMallItem;
         if(param2 < awardList.array.length)
         {
            _loc3_.info = awardList.array[param2] as DevilTurnPointShopItem;
         }
         else
         {
            _loc3_.info = null;
         }
      }
      
      private function __onUpdateInfo(param1:DevilTurnEvent) : void
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
