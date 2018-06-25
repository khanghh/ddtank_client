package gameCommon.objects{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import ddt.manager.SocketManager;   import ddt.manager.TimeManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.events.TimerEvent;   import flash.utils.Timer;   import room.RoomManager;      public class ActivityDungeonNextView extends Sprite   {                   private var ACTIVITYDUNGEONPOINTSNUM:String = "asset.game.nextView.count_";            private var _bg:Bitmap;            private var _nextBtn:BaseButton;            private var _pointsNum:Sprite;            private var _numBitmapArray:Array;            private var _cdData:Number = 0;            private var _timer:Timer;            private var _id:int;            private var _offX:int = 8;            public function ActivityDungeonNextView(id:int, time:Number) { super(); }
            private function initView() : void { }
            protected function __onTimer(event:TimerEvent) : void { }
            private function setCountDownNumber(points:int) : void { }
            private function deleteBitmapArray() : void { }
            private function initEvent() : void { }
            public function setBtnEnable() : void { }
            protected function __onMouseClick(event:MouseEvent) : void { }
            public function dispose() : void { }
            public function get Id() : int { return 0; }
   }}