package com.pickgliss.manager
{
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class WaitTimeAlertManager
   {
      
      private static var _instance:WaitTimeAlertManager;
       
      
      private var _waitTimer:Timer;
      
      private var _waitFrame:BaseAlerFrame;
      
      private var _waitPalyerCount:int;
      
      private var _waitTime:int;
      
      private var _callBack:Function;
      
      private var _msg:String;
      
      private var _progressArr:Array;
      
      private var _currentProgress:uint = 0;
      
      public function WaitTimeAlertManager()
      {
         _progressArr = ["...","....",".....","......"];
         super();
      }
      
      public static function get Instance() : WaitTimeAlertManager
      {
         if(_instance == null)
         {
            _instance = new WaitTimeAlertManager();
         }
         return _instance;
      }
      
      public function createWaitFrame(param1:String, param2:String, param3:int, param4:int, param5:Function = null) : BaseAlerFrame
      {
         _msg = param2;
         _waitPalyerCount = param3;
         _waitTime = param4;
         _callBack = param5;
         clearWaitFrame();
         _waitFrame = AlertManager.Instance.simpleAlert(param1,"","","",false,false,false,2,null,"waitTimeFrameAlert");
         showWaitFrameMsg();
         createWaitTimer();
         return _waitFrame;
      }
      
      private function showWaitFrameMsg() : void
      {
         var _loc1_:String = _msg.replace(/r/g,_waitPalyerCount);
         var _loc2_:String = _msg.replace(/r/g,_waitTime);
         if(_waitFrame)
         {
            _waitFrame.info.data = _loc2_ + getProgressStr();
         }
      }
      
      private function getProgressStr() : String
      {
         var _loc1_:String = _progressArr[_currentProgress];
         _currentProgress = Number(_currentProgress) + 1;
         if(_currentProgress > _progressArr.length - 1)
         {
            _currentProgress = 0;
         }
         return "\n" + _loc1_;
      }
      
      public function updateWaitFrameMsg(param1:String) : void
      {
         if(_waitFrame)
         {
            _waitFrame.info.data = param1;
         }
      }
      
      private function createWaitTimer() : void
      {
         if(_waitTimer)
         {
            _waitTimer.removeEventListener("timer",__waitTimerHandler);
            _waitTimer.stop();
            _waitTimer = null;
         }
         _waitTimer = new Timer(1000);
         _waitTimer.addEventListener("timer",__waitTimerHandler);
         _waitTimer.start();
      }
      
      private function __waitTimerHandler(param1:TimerEvent) : void
      {
         if(_waitTime > 0)
         {
            _waitTime = Number(_waitTime) - 1;
            showWaitFrameMsg();
         }
         else
         {
            clearWaitTimer();
            if(_callBack != null)
            {
               _callBack();
            }
         }
      }
      
      private function clearWaitFrame() : void
      {
         if(_waitFrame)
         {
            _waitFrame.dispose();
            _waitFrame = null;
         }
      }
      
      private function clearWaitTimer() : void
      {
         if(_waitTimer)
         {
            _waitTimer.removeEventListener("timer",__waitTimerHandler);
            _waitTimer.stop();
            _waitTimer = null;
         }
      }
      
      public function dispose() : void
      {
         clearWaitTimer();
         clearWaitFrame();
         _waitTime = 0;
      }
   }
}
