package gameCommon
{
   import ddt.events.LivingEvent;
   import ddt.view.character.GameCharacter;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   import flash.events.KeyboardEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import game.view.map.MapView;
   import gameCommon.model.GameInfo;
   import gameCommon.model.Living;
   import gameCommon.model.LocalPlayer;
   import gameCommon.model.SmallEnemy;
   import org.aswing.KeyStroke;
   import org.aswing.KeyboardManager;
   import phy.math.EulerVector;
   import road7th.data.DictionaryData;
   import room.RoomManager;
   
   public class HeroAutoControl extends EventDispatcher
   {
       
      
      private var _keyBoards:Array;
      
      private var _isAuto:Boolean = false;
      
      private var _stateFlag:int;
      
      private var _arf:int;
      
      private var _gf:int;
      
      private var _ga:int;
      
      private var _wa:int;
      
      private var _mass:Number = 10;
      
      private var _gravityFactor:Number = 70;
      
      private var _dt:Number = 0.04;
      
      protected var _windFactor:Number = 240;
      
      private var _currentLivID:int;
      
      private var _drawRoute:Sprite;
      
      private var _collideRect:Rectangle;
      
      private var _curWind:Number = 0;
      
      private var _keyBoardTime:uint = 0;
      
      private var _shootTime:uint = 0;
      
      public function HeroAutoControl(){super();}
      
      private function initCanves() : void{}
      
      private function shoot() : void{}
      
      private function readyShoot(param1:Function) : void{}
      
      private function initAddKey() : void{}
      
      private function exeKeyBoard(param1:Function) : void{}
      
      private function addKeyBoard(param1:int, param2:Function = null) : void{}
      
      private function getTarget(param1:Point) : Living{return null;}
      
      private function getSelfPoint() : Point{return null;}
      
      private function localToGlcbalByPoint(param1:Point) : Point{return null;}
      
      private function get map() : MapView{return null;}
      
      public function setAutoState(param1:Boolean) : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      public function updateWind(param1:Number) : void{}
      
      private function get curWind() : Number{return 0;}
      
      private function __autoShootHandler(param1:LivingEvent) : void{}
      
      private function get selfPlayer() : LocalPlayer{return null;}
      
      private function get gameInfo() : GameInfo{return null;}
      
      public function clear() : void{}
      
      protected function judgeMaxPower(param1:Point, param2:Point, param3:Number, param4:Boolean, param5:Boolean) : Boolean{return false;}
      
      protected function ifHit(param1:Number, param2:Number, param3:Point) : Boolean{return false;}
      
      protected function getPower(param1:Number, param2:Number, param3:Point, param4:Point, param5:Number, param6:Boolean, param7:Boolean) : Number{return 0;}
      
      private function getRouteData(param1:Number, param2:Number, param3:Point, param4:Point) : Vector.<Point>{return null;}
      
      private function isOutOfMap(param1:EulerVector, param2:EulerVector) : Boolean{return false;}
      
      public function get currentLivID() : int{return 0;}
      
      public function set currentLivID(param1:int) : void{}
      
      private function drawRouteLine(param1:int) : void{}
      
      public function drawDashed(param1:Graphics, param2:Point, param3:Point, param4:Number, param5:Number) : void{}
      
      private function calculateRecent() : int{return 0;}
      
      private function getDistance(param1:Point, param2:Point) : int{return 0;}
      
      private function setKeyEventDisenable(param1:Boolean) : void{}
   }
}
