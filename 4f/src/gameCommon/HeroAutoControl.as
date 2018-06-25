package gameCommon{   import ddt.events.LivingEvent;   import ddt.view.character.GameCharacter;   import flash.display.Graphics;   import flash.display.Sprite;   import flash.events.EventDispatcher;   import flash.events.KeyboardEvent;   import flash.geom.Point;   import flash.geom.Rectangle;   import flash.utils.clearTimeout;   import flash.utils.setTimeout;   import game.view.map.MapView;   import gameCommon.model.GameInfo;   import gameCommon.model.Living;   import gameCommon.model.LocalPlayer;   import gameCommon.model.SmallEnemy;   import org.aswing.KeyStroke;   import org.aswing.KeyboardManager;   import phy.math.EulerVector;   import road7th.data.DictionaryData;   import room.RoomManager;      public class HeroAutoControl extends EventDispatcher   {                   private var _keyBoards:Array;            private var _isAuto:Boolean = false;            private var _stateFlag:int;            private var _arf:int;            private var _gf:int;            private var _ga:int;            private var _wa:int;            private var _mass:Number = 10;            private var _gravityFactor:Number = 70;            private var _dt:Number = 0.04;            protected var _windFactor:Number = 240;            private var _currentLivID:int;            private var _drawRoute:Sprite;            private var _collideRect:Rectangle;            private var _curWind:Number = 0;            private var _keyBoardTime:uint = 0;            private var _shootTime:uint = 0;            public function HeroAutoControl() { super(); }
            private function initCanves() : void { }
            private function shoot() : void { }
            private function readyShoot(calFun:Function) : void { }
            private function initAddKey() : void { }
            private function exeKeyBoard(calFun:Function) : void { }
            private function addKeyBoard(code:int, backFun:Function = null) : void { }
            private function getTarget(attackerPos:Point) : Living { return null; }
            private function getSelfPoint() : Point { return null; }
            private function localToGlcbalByPoint($p:Point) : Point { return null; }
            private function get map() : MapView { return null; }
            public function setAutoState($state:Boolean) : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            public function updateWind(value:Number) : void { }
            private function get curWind() : Number { return 0; }
            private function __autoShootHandler(evt:LivingEvent) : void { }
            private function get selfPlayer() : LocalPlayer { return null; }
            private function get gameInfo() : GameInfo { return null; }
            public function clear() : void { }
            protected function judgeMaxPower(shootPos:Point, enemyPos:Point, shootAngle:Number, xS_Lef_E:Boolean, yS_Up_E:Boolean) : Boolean { return false; }
            protected function ifHit(bulletX:Number, bulletY:Number, enemyPos:Point) : Boolean { return false; }
            protected function getPower(min:Number, max:Number, shootPos:Point, enemyPos:Point, shootAngle:Number, xS_Lef_E:Boolean, yS_Up_E:Boolean) : Number { return 0; }
            private function getRouteData(power:Number, shootAngle:Number, shootPos:Point, enemyPos:Point) : Vector.<Point> { return null; }
            private function isOutOfMap(ex:EulerVector, ey:EulerVector) : Boolean { return false; }
            public function get currentLivID() : int { return 0; }
            public function set currentLivID(value:int) : void { }
            private function drawRouteLine(id:int) : void { }
            public function drawDashed(graphics:Graphics, beginPoint:Point, endPoint:Point, width:Number, grap:Number) : void { }
            private function calculateRecent() : int { return 0; }
            private function getDistance(start:Point, end:Point) : int { return 0; }
            private function setKeyEventDisenable(value:Boolean) : void { }
   }}