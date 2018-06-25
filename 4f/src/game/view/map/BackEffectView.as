package game.view.map{   import com.greensock.TweenLite;   import com.pickgliss.ui.core.Disposeable;   import flash.display.DisplayObject;   import flash.display.Shape;   import flash.display.Sprite;   import flash.filters.GlowFilter;   import flash.geom.Point;   import flash.utils.Dictionary;   import game.objects.GameLiving;   import game.objects.GamePlayer;   import game.objects.SimpleBomb;   import gameCommon.GameControl;   import phy.object.PhysicalObj;      public class BackEffectView extends Sprite implements Disposeable   {                   private var _maskCircleShapeArr:Array;            private var _map:MapView;            private var _mapWidth:int;            private var _mapHeight:int;            private var _objects:Dictionary;            private var _gamePlayerRadius:Number = 200;            private var _gameLivingOffset:Point;            private var _physicalRadius:Number = 100;            private var _glowFilters:Array;            public function BackEffectView(map:MapView) { super(); }
            private function initView() : void { }
            private function switchEffect() : void { }
            public function gamePlayerRadius(value:Number) : void { }
            public function resetEffect(isCach:Boolean = true) : void { }
            public function resetPlayerVisible() : void { }
            private function createGlowFilter(color:uint = 0) : GlowFilter { return null; }
            private function createCircleShape(radius:Number, x:Number = 0, y:Number = 0) : Shape { return null; }
            public function addObject(phy:PhysicalObj, isCach:Boolean = true) : void { }
            public function removeObj(phy:PhysicalObj, isCach:Boolean = true) : void { }
            public function updatePos(phy:PhysicalObj, pos:Point, isCach:Boolean = true) : void { }
            private function checkGamePlayerSmallMap(pos:Point = null, dis:int = -1) : void { }
            public function removeBackEffectView() : void { }
            public function dispose() : void { }
   }}