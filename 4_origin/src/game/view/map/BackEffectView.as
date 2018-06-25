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
      
      public function BackEffectView(map:MapView)
      {
         _gameLivingOffset = new Point(0,-30);
         super();
         _map = map;
         _mapWidth = _map.bound.width;
         _mapHeight = _map.bound.height;
         _maskCircleShapeArr = [];
         _objects = new Dictionary();
         _glowFilters = [createGlowFilter()];
         initView();
         switchEffect();
      }
      
      private function initView() : void
      {
         this.blendMode = "layer";
         this.graphics.beginFill(0,1);
         this.graphics.drawRect(0,0,_mapWidth,_mapHeight);
         this.graphics.endFill();
         this.filters = _glowFilters;
      }
      
      private function switchEffect() : void
      {
         this.alpha = 0;
         TweenLite.to(this,1,{"alpha":1});
      }
      
      public function gamePlayerRadius(value:Number) : void
      {
         _gamePlayerRadius = value;
      }
      
      public function resetEffect(isCach:Boolean = true) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = _maskCircleShapeArr;
         for each(var obj in _maskCircleShapeArr)
         {
            if(obj && obj.parent)
            {
               obj.parent.removeChild(obj);
            }
         }
         _objects = new Dictionary();
         var _loc7_:int = 0;
         var _loc6_:* = _map.gamePlayerList;
         for each(var gamePlayer in _map.gamePlayerList)
         {
            addObject(gamePlayer,false);
         }
      }
      
      public function resetPlayerVisible() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _map.gamePlayerList;
         for each(var gamePlayer in _map.gamePlayerList)
         {
            gamePlayer.smallView.visible = true;
         }
      }
      
      private function createGlowFilter(color:uint = 0) : GlowFilter
      {
         return new GlowFilter(color,1,30,30,2,1,false,false);
      }
      
      private function createCircleShape(radius:Number, x:Number = 0, y:Number = 0) : Shape
      {
         var shape:* = null;
         var diameter:Number = radius * 2;
         var _loc9_:int = 0;
         var _loc8_:* = _maskCircleShapeArr;
         for each(var sh in _maskCircleShapeArr)
         {
            if(sh.parent == null && sh.width == diameter)
            {
               shape = sh;
               var _loc7_:* = diameter;
               shape.height = _loc7_;
               shape.width = _loc7_;
               shape.x = x;
               shape.y = y;
               break;
            }
         }
         if(shape == null)
         {
            shape = new Shape();
            shape.graphics.beginFill(0);
            shape.graphics.drawCircle(0,0,1);
            shape.graphics.endFill();
            shape.x = x;
            shape.y = y;
            _loc7_ = diameter;
            shape.height = _loc7_;
            shape.width = _loc7_;
            shape.blendMode = "erase";
            _maskCircleShapeArr.push(shape);
         }
         addChild(shape);
         return shape;
      }
      
      public function addObject(phy:PhysicalObj, isCach:Boolean = true) : void
      {
         var radius:Number = NaN;
         var currentTeam:int = 0;
         var gamePlayer:* = null;
         if(_objects[phy.Id] == null)
         {
            radius = _gamePlayerRadius;
            if(phy is GamePlayer)
            {
               currentTeam = GameControl.Instance.Current.selfGamePlayer.team;
               gamePlayer = phy as GamePlayer;
               if(gamePlayer.info == null || currentTeam != gamePlayer.info.team)
               {
                  return;
               }
               _objects[phy.Id] = {
                  "phy":phy,
                  "shape":createCircleShape(radius,phy.pos.x + _gameLivingOffset.x,phy.pos.y + _gameLivingOffset.y)
               };
            }
            else
            {
               if(phy is SimpleBomb)
               {
                  _objects[phy.Id] = {
                     "phy":phy,
                     "shape":createCircleShape(radius,phy.pos.x,phy.pos.y)
                  };
               }
               radius = _physicalRadius;
            }
            checkGamePlayerSmallMap(phy.pos);
         }
      }
      
      public function removeObj(phy:PhysicalObj, isCach:Boolean = true) : void
      {
         var object:* = null;
         if(_objects[phy.Id])
         {
            object = _objects[phy.Id];
            if(object.shape && object.shape.parent)
            {
               object.shape.parent.removeChild(object.shape);
            }
            delete _objects[phy.Id];
            checkGamePlayerSmallMap();
         }
      }
      
      public function updatePos(phy:PhysicalObj, pos:Point, isCach:Boolean = true) : void
      {
         var dis:int = 0;
         if(phy == null)
         {
            return;
         }
         addObject(phy,false);
         var object:Object = _objects[phy.Id];
         if(object)
         {
            if(phy is GameLiving)
            {
               object.shape.x = pos.x + _gameLivingOffset.x;
               object.shape.y = pos.y + _gameLivingOffset.y;
            }
            else
            {
               object.shape.x = pos.x;
               object.shape.y = pos.y;
            }
            dis = _physicalRadius;
            if(phy is GamePlayer)
            {
               dis = _gamePlayerRadius;
            }
            checkGamePlayerSmallMap(pos,dis);
         }
      }
      
      private function checkGamePlayerSmallMap(pos:Point = null, dis:int = -1) : void
      {
         if(dis == -1)
         {
            dis = _physicalRadius;
         }
         var currentTeam:int = GameControl.Instance.Current.selfGamePlayer.team;
         var _loc6_:int = 0;
         var _loc5_:* = _map.gamePlayerList;
         for each(var gamePlayer in _map.gamePlayerList)
         {
            if(gamePlayer.info != null)
            {
               if(currentTeam == gamePlayer.info.team)
               {
                  gamePlayer.smallView.visible = true;
               }
               else if(pos && Point.distance(gamePlayer.pos,pos) <= dis)
               {
                  gamePlayer.smallView.visible = true;
               }
               else
               {
                  gamePlayer.smallView.visible = false;
               }
            }
         }
      }
      
      public function removeBackEffectView() : void
      {
         this.alpha = 1;
         TweenLite.to(this,1,{
            "alpha":0,
            "onComplete":dispose
         });
      }
      
      public function dispose() : void
      {
         TweenLite.killTweensOf(this);
         resetPlayerVisible();
         this.graphics.clear();
         var _loc3_:int = 0;
         var _loc2_:* = _maskCircleShapeArr;
         for each(var shape in _maskCircleShapeArr)
         {
            if(shape)
            {
               shape.graphics.clear();
               if(shape.parent)
               {
                  shape.parent.removeChild(shape);
               }
            }
         }
         _maskCircleShapeArr = null;
         _map = null;
         _glowFilters = null;
         _mapWidth = NaN;
         _mapHeight = NaN;
         _objects = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
