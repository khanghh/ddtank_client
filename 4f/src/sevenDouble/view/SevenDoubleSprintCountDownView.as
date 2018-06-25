package sevenDouble.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.TimeManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.TimerEvent;   import flash.utils.Timer;      public class SevenDoubleSprintCountDownView extends Sprite implements Disposeable   {                   private var _bg:Bitmap;            private var _txt:FilterFrameText;            private var _recordTxt:String;            private var _timer:Timer;            private var _endTime:Date;            public function SevenDoubleSprintCountDownView() { super(); }
            private function initView() : void { }
            public function setCountDown(endTime:Date) : void { }
            private function refreshView(endTime:Date) : void { }
            private function timerHandler(event:TimerEvent) : void { }
            public function dispose() : void { }
   }}