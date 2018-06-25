package ddt.view{   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.TimerEvent;   import flash.text.TextField;   import flash.text.TextFormat;      public class FaceContainer extends Sprite   {                   private var _face:MovieClip;            private var _oldScale:int;            private var _isActingExpression:Boolean;            private var _nickName:TextField;            private var _expressionID:int;            public function FaceContainer(topLayer:Boolean = false) { super(); }
            public function get nickName() : TextField { return null; }
            public function get expressionID() : int { return 0; }
            public function set isShowNickName(value:Boolean) : void { }
            public function get isActingExpression() : Boolean { return false; }
            public function setNickName(str:String) : void { }
            private function init() : void { }
            private function __timerComplete(evt:TimerEvent) : void { }
            public function clearFace() : void { }
            public function setFace(id:int) : void { }
            public function doClearFace() : void { }
            private function __enterFrame(event:Event) : void { }
            public function dispose() : void { }
   }}