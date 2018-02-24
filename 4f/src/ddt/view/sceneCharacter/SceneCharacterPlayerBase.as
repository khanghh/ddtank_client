package ddt.view.sceneCharacter
{
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.SceneCharacterEvent;
   import ddt.view.scenePathSearcher.SceneMTween;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   
   public class SceneCharacterPlayerBase extends Sprite
   {
      
      public static const MOUSE_ON_GLOW_FILTER:Array = [new GlowFilter(16776960,1,8,8,2,2)];
       
      
      private var _callBack:Function;
      
      private var _sceneCharacterDirection:SceneCharacterDirection;
      
      private var _sceneCharacterStateSet:SceneCharacterStateSet;
      
      private var _sceneCharacterStateType:String;
      
      private var _sceneCharacterStateItem:SceneCharacterStateItem;
      
      private var _characterVisible:Boolean = true;
      
      protected var _moveSpeed:Number = 0.15;
      
      protected var _walkPath:Array;
      
      public var isWalkPathChange:Boolean = false;
      
      protected var _tween:SceneMTween;
      
      private var _walkDistance:Number;
      
      public var character:Sprite;
      
      private var _walkPath0:Point;
      
      private var po1:Point;
      
      private var _playerY:Number;
      
      private var _loadComplete:Boolean = false;
      
      public var isDefaultCharacter:Boolean;
      
      private var vFlag:int = 0;
      
      public function SceneCharacterPlayerBase(param1:Function = null){super();}
      
      public function get loadComplete() : Boolean{return false;}
      
      public function set loadComplete(param1:Boolean) : void{}
      
      private function initialize() : void{}
      
      private function setEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __change(param1:Event) : void{}
      
      private function __finish(param1:Event) : void{}
      
      public function playerWalk(param1:Array) : void{}
      
      public function set sceneCharacterActionType(param1:String) : void{}
      
      public function get playerPoint() : Point{return null;}
      
      public function set playerPoint(param1:Point) : void{}
      
      public function get moveSpeed() : Number{return 0;}
      
      public function set moveSpeed(param1:Number) : void{}
      
      public function get walkPath() : Array{return null;}
      
      public function set walkPath(param1:Array) : void{}
      
      protected function set sceneCharacterStateSet(param1:SceneCharacterStateSet) : void{}
      
      public function update() : void{}
      
      public function get sceneCharacterStateType() : String{return null;}
      
      public function set sceneCharacterStateType(param1:String) : void{}
      
      public function get sceneCharacterDirection() : SceneCharacterDirection{return null;}
      
      protected function setCharacterFilter(param1:Boolean) : void{}
      
      public function set sceneCharacterDirection(param1:SceneCharacterDirection) : void{}
      
      public function dispose() : void{}
      
      public function get playerY() : Number{return 0;}
      
      public function set playerY(param1:Number) : void{}
   }
}
