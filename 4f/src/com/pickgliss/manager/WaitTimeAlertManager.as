package com.pickgliss.manager{   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import flash.events.TimerEvent;   import flash.utils.Timer;      public class WaitTimeAlertManager   {            private static var _instance:WaitTimeAlertManager;                   private var _waitTimer:Timer;            private var _waitFrame:BaseAlerFrame;            private var _waitPalyerCount:int;            private var _waitTime:int;            private var _callBack:Function;            private var _msg:String;            private var _progressArr:Array;            private var _currentProgress:uint = 0;            public function WaitTimeAlertManager() { super(); }
            public static function get Instance() : WaitTimeAlertManager { return null; }
            public function createWaitFrame(title:String, msg:String, waitPalyerCount:int, waitTime:int, callBack:Function = null) : BaseAlerFrame { return null; }
            private function showWaitFrameMsg() : void { }
            private function getProgressStr() : String { return null; }
            public function updateWaitFrameMsg(str:String) : void { }
            private function createWaitTimer() : void { }
            private function __waitTimerHandler(evt:TimerEvent) : void { }
            private function clearWaitFrame() : void { }
            private function clearWaitTimer() : void { }
            public function dispose() : void { }
   }}