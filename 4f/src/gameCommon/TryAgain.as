package gameCommon{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.cmd.CmdCheckBagLockedPSWNeeds;   import ddt.events.GameEvent;   import ddt.manager.GameInSocketOut;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.SoundManager;   import ddt.utils.CheckMoneyUtils;   import ddt.view.DoubleSelectedItem;   import flash.display.BitmapData;   import flash.display.DisplayObject;   import flash.display.Graphics;   import flash.display.Shape;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.events.TimerEvent;   import flash.geom.Matrix;   import flash.utils.Dictionary;   import flash.utils.Timer;   import gameCommon.model.MissionAgainInfo;   import room.RoomManager;      [Event(name="timeOut",type="ddt.events.GameEvent")]   [Event(name="tryagain",type="ddt.events.GameEvent")]   [Event(name="giveup",type="ddt.events.GameEvent")]   public class TryAgain extends Sprite implements Disposeable   {                   private var _back:DisplayObject;            private var _tryagain:BaseButton;            private var _giveup:BaseButton;            private var _titleField:FilterFrameText;            private var _valueField:FilterFrameText;            private var _valueBack:DisplayObject;            private var _timer:Timer;            private var _numDic:Dictionary;            private var _markshape:Shape;            private var _container:Sprite;            private var _buffNote:DisplayObject;            protected var _isShowNum:Boolean;            protected var _info:MissionAgainInfo;            protected var _selectedItem:DoubleSelectedItem;            public function TryAgain(info:MissionAgainInfo, isShowNum:Boolean = true) { super(); }
            public function show() : void { }
            private function configUI() : void { }
            private function drawLevelAgainBuff() : void { }
            private function drawBlack() : void { }
            private function creatNums() : void { }
            private function addEvent() : void { }
            private function __missionAgain(event:GameEvent) : void { }
            private function timeOut() : void { }
            private function __timeComplete(event:TimerEvent) : void { }
            private function drawMark(count:int) : void { }
            private function __mark(event:TimerEvent) : void { }
            protected function __tryagainClick(event:MouseEvent) : void { }
            protected function onCheckComplete() : void { }
            private function __onResponse(evt:FrameEvent) : void { }
            protected function tryagain(bool:Boolean = true) : void { }
            private function __giveup(event:MouseEvent) : void { }
            private function removeEvent() : void { }
            public function setLabyrinthTryAgain() : void { }
            public function dispose() : void { }
   }}