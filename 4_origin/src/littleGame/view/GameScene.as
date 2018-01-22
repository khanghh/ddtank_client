package littleGame.view
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.setTimeout;
   import littleGame.LittleGameManager;
   import littleGame.actions.LittleLivingBornAction;
   import littleGame.data.Grid;
   import littleGame.data.Node;
   import littleGame.events.LittleGameEvent;
   import littleGame.events.LittleLivingEvent;
   import littleGame.model.LittleLiving;
   import littleGame.model.LittlePlayer;
   import littleGame.model.LittleSelf;
   import littleGame.model.Scenario;
   import road7th.utils.MovieClipWrapper;
   
   public class GameScene extends Sprite implements Disposeable
   {
       
      
      private var _game:Scenario;
      
      private var _background:DisplayObject;
      
      private var _foreground:DisplayObject;
      
      private var _backLivingLayer:Sprite;
      
      private var _foreLivingLayer:Sprite;
      
      private var _debug:Boolean = false;
      
      private var _cameraRect:Rectangle;
      
      private var _x:Number = 0;
      
      private var _y:Number = 0;
      
      private var _gameLivings:Dictionary;
      
      private var _left:int;
      
      private var _right:int;
      
      private var _top:int;
      
      private var _bottom:int;
      
      private var shouldRender:Boolean = true;
      
      private var selfGameLiving:GameLittleSelf;
      
      private var selfPos:Point;
      
      private var otherPos:Point;
      
      private var CONST_DISTANCE:Number;
      
      private var dt:Number = 0;
      
      public function GameScene(param1:Scenario)
      {
         selfPos = new Point();
         otherPos = new Point();
         super();
         _game = param1;
         _cameraRect = new Rectangle(300,250,300,150);
         _left = StageReferance.stageWidth - _game.grid.width;
         _right = 0;
         _top = StageReferance.stageHeight - _game.grid.height;
         _bottom = 0;
         _gameLivings = new Dictionary();
         CONST_DISTANCE = Point.distance(new Point(),new Point(StageReferance.stageHeight,StageReferance.stageHeight));
         configUI();
         addEvent();
         _backLivingLayer.mouseEnabled = false;
         _foreLivingLayer.mouseEnabled = false;
      }
      
      private function configUI() : void
      {
         drawScene();
         _backLivingLayer = new Sprite();
         addChildAt(_backLivingLayer,getChildIndex(_foreground));
         _foreLivingLayer = new Sprite();
         addChild(_foreLivingLayer);
         drawLivings();
         if(_debug)
         {
            drawGrid();
         }
      }
      
      private function drawLivings() : void
      {
         var _loc1_:Dictionary = _game.livings;
         var _loc3_:int = 1;
         var _loc5_:int = 0;
         var _loc4_:* = _loc1_;
         for each(var _loc2_ in _loc1_)
         {
            if(_loc2_.isSelf || !_loc2_.isPlayer)
            {
               drawLiving(_loc2_);
            }
            else
            {
               _loc3_++;
               setTimeout(drawLiving,150 * _loc3_,_loc2_);
            }
         }
      }
      
      private function drawLiving(param1:LittleLiving) : GameLittleLiving
      {
         var _loc2_:* = null;
         if(_game == null || _game.livings == null || _game.livings[param1.id] != param1)
         {
            return null;
         }
         if(param1.isSelf)
         {
            _loc2_ = new GameLittleSelf(param1 as LittleSelf);
            selfGameLiving = _loc2_ as GameLittleSelf;
            param1.addEventListener("posChanged",__selfPosChanged);
            focusSelf(param1);
         }
         else if(param1.isPlayer)
         {
            _loc2_ = new GameLittlePlayer(param1 as LittlePlayer);
         }
         else
         {
            _loc2_ = new GameLittleLiving(param1);
         }
         _backLivingLayer.addChild(_loc2_);
         if(_gameLivings[param1.id])
         {
            trace("::::");
         }
         _gameLivings[param1.id] = _loc2_;
         sortLiving(_loc2_);
         return _loc2_;
      }
      
      private function onLivingClicked(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         var _loc6_:LittleSelf = _game.selfPlayer;
         var _loc5_:GameLittleLiving = param1.currentTarget as GameLittleLiving;
         var _loc2_:int = _loc5_.living.pos.x * _loc5_.living.speed / _game.grid.cellSize;
         var _loc3_:int = _loc5_.living.pos.y * _loc5_.living.speed / _game.grid.cellSize;
         var _loc4_:Array = LittleGameManager.Instance.fillPath(_loc6_,_game.grid,_loc6_.pos.x,_loc6_.pos.y,_loc2_,_loc3_);
         if(!_loc4_)
         {
         }
      }
      
      private function drawGrid() : void
      {
         var _loc6_:int = 0;
         var _loc1_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:Grid = _game.grid;
         var _loc2_:BitmapData = new BitmapData(_loc4_.width,_loc4_.height,true,0);
         var _loc3_:Array = _loc4_.nodes;
         var _loc7_:int = _loc3_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            _loc1_ = _loc3_[_loc6_].length;
            _loc5_ = 0;
            while(_loc5_ < _loc1_)
            {
               if(!_loc3_[_loc6_][_loc5_].walkable)
               {
                  _loc2_.fillRect(new Rectangle(_loc5_ * _loc4_.cellSize,_loc6_ * _loc4_.cellSize,_loc4_.cellSize,_loc4_.cellSize),2583625728);
               }
               _loc5_++;
            }
            _loc6_++;
         }
         addChild(new Bitmap(_loc2_));
      }
      
      private function drawScene() : void
      {
         _background = ClassUtils.CreatInstance("asset.littleGame.back" + _game.id);
         addChild(_background);
         _foreground = ClassUtils.CreatInstance("asset.littleGame.fore" + _game.id);
         if(_foreground is DisplayObjectContainer)
         {
            var _loc1_:Boolean = false;
            DisplayObjectContainer(_foreground).mouseEnabled = _loc1_;
            DisplayObjectContainer(_foreground).mouseChildren = _loc1_;
         }
         addChild(_foreground);
      }
      
      private function addEvent() : void
      {
         _game.addEventListener("addLiving",__addLiving);
         _game.addEventListener("update",__update);
         _game.addEventListener("removeLiving",__removeLiving);
         addEventListener("click",__click);
      }
      
      private function __mouseDown(param1:MouseEvent) : void
      {
         startDrag();
         StageReferance.stage.addEventListener("mouseUp",__mouseUp);
      }
      
      private function __mouseUp(param1:MouseEvent) : void
      {
         StageReferance.stage.removeEventListener("mouseUp",__mouseUp);
         stopDrag();
      }
      
      private function __removeLiving(param1:LittleGameEvent) : void
      {
         var _loc3_:LittleLiving = param1.paras[0] as LittleLiving;
         var _loc2_:GameLittleLiving = _gameLivings[_loc3_.id];
         if(_loc2_)
         {
            _loc2_.removeEventListener("click",onLivingClicked);
            ObjectUtils.disposeObject(_loc2_);
            delete _gameLivings[_loc3_.id];
         }
      }
      
      private function __update(param1:LittleGameEvent) : void
      {
         updateLivingVisible();
         sortDepth();
      }
      
      private function sortDepth() : void
      {
         var _loc4_:int = 0;
         var _loc1_:* = null;
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < _backLivingLayer.numChildren)
         {
            _loc1_ = _backLivingLayer.getChildAt(_loc4_);
            if(_loc1_ is GameLittleLiving && !GameLittleLiving(_loc1_).lock)
            {
               _loc2_.push(_loc1_);
            }
            else
            {
               _loc2_.push(_loc1_);
            }
            _loc4_++;
         }
         _loc2_.sortOn(["y"],[16]);
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _backLivingLayer.setChildIndex(_loc2_[_loc3_],_loc3_);
            _loc3_++;
         }
      }
      
      private function updateLivingVisible() : void
      {
         if(selfGameLiving)
         {
            selfPos.x = selfGameLiving.x;
            selfPos.y = selfGameLiving.y;
            var _loc3_:int = 0;
            var _loc2_:* = _gameLivings;
            for each(var _loc1_ in _gameLivings)
            {
               otherPos.x = _loc1_.x;
               otherPos.y = _loc1_.y;
               shouldRender = Point.distance(selfPos,otherPos) < CONST_DISTANCE;
               if(shouldRender || _loc1_.lock)
               {
                  _loc1_.realRender = true;
                  if(!_loc1_.lock)
                  {
                     _backLivingLayer.addChild(_loc1_);
                  }
               }
               else
               {
                  _loc1_.realRender = false;
                  if(_backLivingLayer.contains(_loc1_))
                  {
                     _backLivingLayer.removeChild(_loc1_);
                  }
               }
            }
         }
      }
      
      private function sortLiving(param1:GameLittleLiving) : void
      {
         var _loc2_:Rectangle = param1.getBounds(this);
         var _loc4_:Vector.<Rectangle> = _game.stones;
         var _loc6_:int = 0;
         var _loc5_:* = _loc4_;
         for each(var _loc3_ in _loc4_)
         {
            if(_loc3_.intersects(_loc2_))
            {
               if(_loc2_.bottom <= _loc3_.bottom)
               {
                  _backLivingLayer.addChild(param1);
               }
               else
               {
                  _foreLivingLayer.addChild(param1);
               }
            }
         }
      }
      
      private function __selfPosChanged(param1:LittleLivingEvent) : void
      {
         var _loc4_:LittleLiving = param1.currentTarget as LittleLiving;
         var _loc3_:Point = new Point(param1.paras[0].x * _loc4_.speed,param1.paras[0].y * _loc4_.speed);
         var _loc2_:Point = new Point(_loc4_.pos.x * _loc4_.speed,_loc4_.pos.y * _loc4_.speed);
         var _loc5_:Point = localToGlobal(_loc2_);
         if(_loc2_.y > _loc3_.y && _loc5_.y > _cameraRect.bottom)
         {
            y = y + (_loc3_.y - _loc2_.y);
         }
         else if(_loc2_.y < _loc3_.y && _loc5_.y < _cameraRect.top)
         {
            y = y + (_loc3_.y - _loc2_.y);
         }
         if(_loc2_.x > _loc3_.x && _loc5_.x > _cameraRect.right)
         {
            x = x + (_loc3_.x - _loc2_.x);
         }
         else if(_loc2_.x < _loc3_.x && _loc5_.x < _cameraRect.left)
         {
            x = x + (_loc3_.x - _loc2_.x);
         }
      }
      
      public function drawServPath(param1:LittleLiving) : void
      {
         var _loc6_:int = 0;
         var _loc4_:Array = param1.servPath;
         var _loc2_:Graphics = _foreLivingLayer.graphics;
         _loc2_.clear();
         var _loc3_:Node = _loc4_[0];
         _loc2_.lineStyle(2,255);
         _loc2_.moveTo(_loc3_.x * _game.grid.cellSize,_loc3_.y * _game.grid.cellSize);
         var _loc5_:int = _loc4_.length;
         ChatManager.Instance.sysChatYellow("drawServPath:" + _loc5_);
         _loc6_ = 1;
         while(_loc6_ < _loc5_)
         {
            _loc2_.lineTo(_loc4_[_loc6_].x * _game.grid.cellSize,_loc4_[_loc6_].y * _game.grid.cellSize);
            _loc6_++;
         }
         _loc2_.endFill();
      }
      
      override public function set x(param1:Number) : void
      {
         if(param1 >= _left && param1 <= _right)
         {
            .super.x = param1;
         }
      }
      
      override public function set y(param1:Number) : void
      {
         if(param1 >= _top && param1 <= _bottom)
         {
            .super.y = param1;
         }
      }
      
      private function __click(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         var _loc6_:LittleSelf = _game.selfPlayer;
         var _loc3_:int = mouseX / _game.grid.cellSize;
         var _loc4_:int = mouseY / _game.grid.cellSize;
         var _loc5_:Array = LittleGameManager.Instance.fillPath(_loc6_,_game.grid,_loc6_.pos.x,_loc6_.pos.y,_loc3_,_loc4_);
         if(_loc5_)
         {
            LittleGameManager.Instance.selfMoveTo(_game,_loc6_,_loc6_.pos.x,_loc6_.pos.y,_loc3_,_loc4_,_game.clock.time,_loc5_);
            _loc2_ = new MovieClipWrapper(ClassUtils.CreatInstance("asset.hotSpring.MouseClickMovie"),true,true);
            var _loc7_:Boolean = false;
            _loc2_.movie.mouseEnabled = _loc7_;
            _loc2_.movie.mouseChildren = _loc7_;
            _loc2_.x = mouseX;
            _loc2_.y = mouseY;
            addChild(_loc2_.movie);
         }
      }
      
      public function findGameLiving(param1:int) : GameLittleLiving
      {
         return _gameLivings[param1];
      }
      
      public function __addLiving(param1:LittleGameEvent) : void
      {
         var _loc2_:GameLittleLiving = drawLiving(param1.paras[0]);
         if(!_loc2_.living.isPlayer)
         {
            _loc2_.living.act(new LittleLivingBornAction(_loc2_.living));
         }
      }
      
      private function focusSelf(param1:LittleLiving) : void
      {
         var _loc2_:Point = localToGlobal(new Point(param1.pos.x * param1.speed,param1.pos.y * param1.speed));
         x = (StageReferance.stageWidth >> 1) - _loc2_.x;
         y = (StageReferance.stageWidth >> 1) - _loc2_.y;
      }
      
      private function removeEvent() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _gameLivings;
         for each(var _loc1_ in _gameLivings)
         {
            _loc1_.removeEventListener("click",onLivingClicked);
         }
         _game.removeEventListener("addLiving",__addLiving);
         _game.removeEventListener("update",__update);
         _game.removeEventListener("removeLiving",__removeLiving);
         removeEventListener("click",__click);
      }
      
      public function addToLayer(param1:DisplayObject, param2:int) : void
      {
         var _loc3_:DisplayObjectContainer = getLayer(param2);
         if(_loc3_)
         {
            _loc3_.addChild(param1);
         }
      }
      
      public function getLayer(param1:int) : DisplayObjectContainer
      {
         switch(int(param1))
         {
            case 0:
               return _backLivingLayer;
            case 1:
               return _foreLivingLayer;
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         removeEvent();
         if(parent)
         {
            parent.removeChild(this);
         }
         var _loc4_:int = 0;
         var _loc3_:* = _gameLivings;
         for(var _loc2_ in _gameLivings)
         {
            _loc1_ = _gameLivings[_loc2_];
            ObjectUtils.disposeObject(_loc1_);
            delete _gameLivings[_loc2_];
         }
         _game = null;
         ObjectUtils.disposeObject(_background);
         ObjectUtils.disposeObject(_foreground);
         ObjectUtils.disposeObject(_backLivingLayer);
         ObjectUtils.disposeObject(_foreLivingLayer);
         selfGameLiving = null;
         _background = null;
         _foreground = null;
         _backLivingLayer = null;
         _foreLivingLayer = null;
      }
   }
}
