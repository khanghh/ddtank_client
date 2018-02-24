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
      
      public function BackEffectView(param1:MapView)
      {
         _gameLivingOffset = new Point(0,-30);
         super();
         _map = param1;
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
      
      public function gamePlayerRadius(param1:Number) : void
      {
         _gamePlayerRadius = param1;
      }
      
      public function resetEffect(param1:Boolean = true) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = _maskCircleShapeArr;
         for each(var _loc2_ in _maskCircleShapeArr)
         {
            if(_loc2_ && _loc2_.parent)
            {
               _loc2_.parent.removeChild(_loc2_);
            }
         }
         _objects = new Dictionary();
         var _loc7_:int = 0;
         var _loc6_:* = _map.gamePlayerList;
         for each(var _loc3_ in _map.gamePlayerList)
         {
            addObject(_loc3_,false);
         }
      }
      
      public function resetPlayerVisible() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _map.gamePlayerList;
         for each(var _loc1_ in _map.gamePlayerList)
         {
            _loc1_.smallView.visible = true;
         }
      }
      
      private function createGlowFilter(param1:uint = 0) : GlowFilter
      {
         return new GlowFilter(param1,1,30,30,2,1,false,false);
      }
      
      private function createCircleShape(param1:Number, param2:Number = 0, param3:Number = 0) : Shape
      {
         var _loc5_:* = null;
         var _loc4_:Number = param1 * 2;
         var _loc9_:int = 0;
         var _loc8_:* = _maskCircleShapeArr;
         for each(var _loc6_ in _maskCircleShapeArr)
         {
            if(_loc6_.parent == null && _loc6_.width == _loc4_)
            {
               _loc5_ = _loc6_;
               var _loc7_:* = _loc4_;
               _loc5_.height = _loc7_;
               _loc5_.width = _loc7_;
               _loc5_.x = param2;
               _loc5_.y = param3;
               break;
            }
         }
         if(_loc5_ == null)
         {
            _loc5_ = new Shape();
            _loc5_.graphics.beginFill(0);
            _loc5_.graphics.drawCircle(0,0,1);
            _loc5_.graphics.endFill();
            _loc5_.x = param2;
            _loc5_.y = param3;
            _loc7_ = _loc4_;
            _loc5_.height = _loc7_;
            _loc5_.width = _loc7_;
            _loc5_.blendMode = "erase";
            _maskCircleShapeArr.push(_loc5_);
         }
         addChild(_loc5_);
         return _loc5_;
      }
      
      public function addObject(param1:PhysicalObj, param2:Boolean = true) : void
      {
         var _loc4_:Number = NaN;
         var _loc3_:int = 0;
         var _loc5_:* = null;
         if(_objects[param1.Id] == null)
         {
            _loc4_ = _gamePlayerRadius;
            if(param1 is GamePlayer)
            {
               _loc3_ = GameControl.Instance.Current.selfGamePlayer.team;
               _loc5_ = param1 as GamePlayer;
               if(_loc5_.info == null || _loc3_ != _loc5_.info.team)
               {
                  return;
               }
               _objects[param1.Id] = {
                  "phy":param1,
                  "shape":createCircleShape(_loc4_,param1.pos.x + _gameLivingOffset.x,param1.pos.y + _gameLivingOffset.y)
               };
            }
            else
            {
               if(param1 is SimpleBomb)
               {
                  _objects[param1.Id] = {
                     "phy":param1,
                     "shape":createCircleShape(_loc4_,param1.pos.x,param1.pos.y)
                  };
               }
               _loc4_ = _physicalRadius;
            }
            checkGamePlayerSmallMap(param1.pos);
         }
      }
      
      public function removeObj(param1:PhysicalObj, param2:Boolean = true) : void
      {
         var _loc3_:* = null;
         if(_objects[param1.Id])
         {
            _loc3_ = _objects[param1.Id];
            if(_loc3_.shape && _loc3_.shape.parent)
            {
               _loc3_.shape.parent.removeChild(_loc3_.shape);
            }
            delete _objects[param1.Id];
            checkGamePlayerSmallMap();
         }
      }
      
      public function updatePos(param1:PhysicalObj, param2:Point, param3:Boolean = true) : void
      {
         var _loc4_:int = 0;
         if(param1 == null)
         {
            return;
         }
         addObject(param1,false);
         var _loc5_:Object = _objects[param1.Id];
         if(_loc5_)
         {
            if(param1 is GameLiving)
            {
               _loc5_.shape.x = param2.x + _gameLivingOffset.x;
               _loc5_.shape.y = param2.y + _gameLivingOffset.y;
            }
            else
            {
               _loc5_.shape.x = param2.x;
               _loc5_.shape.y = param2.y;
            }
            _loc4_ = _physicalRadius;
            if(param1 is GamePlayer)
            {
               _loc4_ = _gamePlayerRadius;
            }
            checkGamePlayerSmallMap(param2,_loc4_);
         }
      }
      
      private function checkGamePlayerSmallMap(param1:Point = null, param2:int = -1) : void
      {
         if(param2 == -1)
         {
            param2 = _physicalRadius;
         }
         var _loc3_:int = GameControl.Instance.Current.selfGamePlayer.team;
         var _loc6_:int = 0;
         var _loc5_:* = _map.gamePlayerList;
         for each(var _loc4_ in _map.gamePlayerList)
         {
            if(_loc4_.info != null)
            {
               if(_loc3_ == _loc4_.info.team)
               {
                  _loc4_.smallView.visible = true;
               }
               else if(param1 && Point.distance(_loc4_.pos,param1) <= param2)
               {
                  _loc4_.smallView.visible = true;
               }
               else
               {
                  _loc4_.smallView.visible = false;
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
         for each(var _loc1_ in _maskCircleShapeArr)
         {
            if(_loc1_)
            {
               _loc1_.graphics.clear();
               if(_loc1_.parent)
               {
                  _loc1_.parent.removeChild(_loc1_);
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
