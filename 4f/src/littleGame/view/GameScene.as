package littleGame.view{   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.ChatManager;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.display.DisplayObject;   import flash.display.DisplayObjectContainer;   import flash.display.Graphics;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.geom.Point;   import flash.geom.Rectangle;   import flash.utils.Dictionary;   import flash.utils.setTimeout;   import littleGame.LittleGameManager;   import littleGame.actions.LittleLivingBornAction;   import littleGame.data.Grid;   import littleGame.data.Node;   import littleGame.events.LittleGameEvent;   import littleGame.events.LittleLivingEvent;   import littleGame.model.LittleLiving;   import littleGame.model.LittlePlayer;   import littleGame.model.LittleSelf;   import littleGame.model.Scenario;   import road7th.utils.MovieClipWrapper;      public class GameScene extends Sprite implements Disposeable   {                   private var _game:Scenario;            private var _background:DisplayObject;            private var _foreground:DisplayObject;            private var _backLivingLayer:Sprite;            private var _foreLivingLayer:Sprite;            private var _debug:Boolean = false;            private var _cameraRect:Rectangle;            private var _x:Number = 0;            private var _y:Number = 0;            private var _gameLivings:Dictionary;            private var _left:int;            private var _right:int;            private var _top:int;            private var _bottom:int;            private var shouldRender:Boolean = true;            private var selfGameLiving:GameLittleSelf;            private var selfPos:Point;            private var otherPos:Point;            private var CONST_DISTANCE:Number;            private var dt:Number = 0;            public function GameScene(game:Scenario) { super(); }
            private function configUI() : void { }
            private function drawLivings() : void { }
            private function drawLiving(living:LittleLiving) : GameLittleLiving { return null; }
            private function onLivingClicked(event:MouseEvent) : void { }
            private function drawGrid() : void { }
            private function drawScene() : void { }
            private function addEvent() : void { }
            private function __mouseDown(event:MouseEvent) : void { }
            private function __mouseUp(event:MouseEvent) : void { }
            private function __removeLiving(event:LittleGameEvent) : void { }
            private function __update(event:LittleGameEvent) : void { }
            private function sortDepth() : void { }
            private function updateLivingVisible() : void { }
            private function sortLiving(gameLiving:GameLittleLiving) : void { }
            private function __selfPosChanged(event:LittleLivingEvent) : void { }
            public function drawServPath(living:LittleLiving) : void { }
            override public function set x(value:Number) : void { }
            override public function set y(value:Number) : void { }
            private function __click(event:MouseEvent) : void { }
            public function findGameLiving(id:int) : GameLittleLiving { return null; }
            public function __addLiving(event:LittleGameEvent) : void { }
            private function focusSelf(self:LittleLiving) : void { }
            private function removeEvent() : void { }
            public function addToLayer(object:DisplayObject, layer:int) : void { }
            public function getLayer(layer:int) : DisplayObjectContainer { return null; }
            public function dispose() : void { }
   }}