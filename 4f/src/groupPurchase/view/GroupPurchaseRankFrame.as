package groupPurchase.view{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import flash.display.Bitmap;   import flash.events.Event;   import flash.events.TimerEvent;   import flash.utils.Timer;   import groupPurchase.GroupPurchaseManager;      public class GroupPurchaseRankFrame extends Frame   {                   private var _bg:Bitmap;            private var _cellList:Vector.<GroupPurchaseRankCell>;            private var _timer2:Timer;            private var _endTime:Date;            public function GroupPurchaseRankFrame() { super(); }
            private function initView() : void { }
            private function initRefreshData() : void { }
            private function requestRefreshData(event:TimerEvent) : void { }
            private function getRefreshDelay() : int { return 0; }
            private function refreshView(event:Event) : void { }
            private function initEvent() : void { }
            private function __responseHandler(evt:FrameEvent) : void { }
            override public function dispose() : void { }
   }}