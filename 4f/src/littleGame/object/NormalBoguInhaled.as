package littleGame.object{   import com.greensock.TweenLite;   import com.greensock.easing.Bounce;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.ChatManager;   import flash.display.DisplayObject;   import flash.display.Graphics;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.events.TimerEvent;   import flash.geom.Point;   import flash.utils.Dictionary;   import flash.utils.Timer;   import littleGame.LittleGameManager;   import littleGame.actions.LittleLivingDieAction;   import littleGame.interfaces.ILittleObject;   import littleGame.model.LittleLiving;   import littleGame.model.LittleSelf;   import littleGame.model.Scenario;   import littleGame.view.GameLittleLiving;   import littleGame.view.GameScene;   import littleGame.view.MarkShape;   import road7th.comm.PackageIn;      public class NormalBoguInhaled extends Sprite implements ILittleObject   {            public static var NoteCount:int;            private static const MaxNoteCount:int = 3;            private static var littleObjectCount:int = 0;                   private var _id:int;            protected var _giveup:MovieClip;            protected var _giveupAni:MovieClip;            protected var _scene:Scenario;            protected var _target:LittleLiving;            protected var _self:LittleSelf;            protected var _totalClick:int = 20;            protected var _totalScore:int = 1000;            protected var _clickScore:int;            protected var _clickCount:int = 0;            protected var _time:int;            protected var _score:int;            protected var _timer:Timer;            protected var _inhaleAsset:MovieClip;            protected var _gameLivings:Dictionary;            protected var _markBar:MarkShape;            protected var _running:Boolean = true;            protected var _removed:Boolean = false;            private var _mouseNote:DisplayObject;            public function NormalBoguInhaled() { super(); }
            public function get id() : int { return 0; }
            public function get type() : String { return null; }
            override public function toString() : String { return null; }
            public function initialize(scene:Scenario, pkg:PackageIn) : void { }
            protected function drawInhaleAsset() : void { }
            protected function lockLivings() : void { }
            protected function releaseLivings() : void { }
            protected function drawBackground() : void { }
            protected function drawMark() : void { }
            public function invoke(pkg:PackageIn) : void { }
            public function execute() : void { }
            protected function __mark(event:TimerEvent) : void { }
            protected function __markComplete(event:TimerEvent) : void { }
            protected function addEvent() : void { }
            protected function __click(event:MouseEvent) : void { }
            protected function complete() : void { }
            protected function removeEvent() : void { }
            public function dispose() : void { }
   }}