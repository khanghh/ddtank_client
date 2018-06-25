package lanternriddles.view{   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.image.MovieImage;   import com.pickgliss.ui.text.FilterFrameText;   import ddt.events.CrazyTankSocketEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import ddt.utils.PositionUtils;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.events.TimerEvent;   import flash.utils.Timer;   import lanternriddles.LanternRiddlesManager;   import lanternriddles.data.LanternInfo;   import road7th.comm.PackageIn;      public class QuestionView extends Sprite   {            private static var SELECT_NUM:int = 4;                   private var _questionTitle:FilterFrameText;            private var _questionCount:FilterFrameText;            private var _cdTime:FilterFrameText;            private var _question:FilterFrameText;            private var _question2:FilterFrameText;            private var _selectVec:Vector.<MovieImage>;            private var _grayFilters:Array;            private var _countDownTime:Number;            private var _timer:Timer;            private var _count:int;            private var _info:LanternInfo;            private var _resultMovie:MovieImage;            public function QuestionView() { super(); }
            private function initData() : void { }
            private function initView() : void { }
            private function initEvent() : void { }
            protected function __onAnswerResult(event:CrazyTankSocketEvent) : void { }
            protected function __onEnterFrame(event:Event) : void { }
            public function set info(info:LanternInfo) : void { }
            private function setQuestionCount(index:int) : void { }
            private function setQuestionInfo(info:LanternInfo) : void { }
            private function setCDTime(date:Date) : void { }
            protected function __onTimer(event:TimerEvent) : void { }
            private function transSecond(num:Number) : String { return null; }
            protected function __onSelectClick(event:MouseEvent) : void { }
            private function setAnswerFlag(option:int) : void { }
            public function setSelectBtnEnable(flag:Boolean) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
            public function set count(value:int) : void { }
            public function get info() : LanternInfo { return null; }
            public function get countDownTime() : Number { return 0; }
   }}