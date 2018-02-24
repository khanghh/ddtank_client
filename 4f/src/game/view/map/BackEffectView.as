package game.view.map
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import game.objects.GameLiving;
   import game.objects.GamePlayer;
   import game.objects.SimpleBomb;
   import gameCommon.GameControl;
   import phy.object.PhysicalObj;
   
   public class BackEffectView extends Sprite implements Disposeable
   {
       
      
      private var _maskCircleShapeArr:Array;
      
      private var _map:MapView;
      
      private var _mapWidth:int;
      
      private var _mapHeight:int;
      
      private var _objects:Dictionary;
      
      private var _gamePlayerRadius:Number = 200;
      
      private var _gameLivingOffset:Point;
      
      private var _physicalRadius:Number = 100;
      
      private var _glowFilters:Array;
      
      public function BackEffectView(param1:MapView){super();}
      
      private function initView() : void{}
      
      private function switchEffect() : void{}
      
      public function gamePlayerRadius(param1:Number) : void{}
      
      public function resetEffect(param1:Boolean = true) : void{}
      
      public function resetPlayerVisible() : void{}
      
      private function createGlowFilter(param1:uint = 0) : GlowFilter{return null;}
      
      private function createCircleShape(param1:Number, param2:Number = 0, param3:Number = 0) : Shape{return null;}
      
      public function addObject(param1:PhysicalObj, param2:Boolean = true) : void{}
      
      public function removeObj(param1:PhysicalObj, param2:Boolean = true) : void{}
      
      public function updatePos(param1:PhysicalObj, param2:Point, param3:Boolean = true) : void{}
      
      private function checkGamePlayerSmallMap(param1:Point = null, param2:int = -1) : void{}
      
      public function removeBackEffectView() : void{}
      
      public function dispose() : void{}
   }
}
