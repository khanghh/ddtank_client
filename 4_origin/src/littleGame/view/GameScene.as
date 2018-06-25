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
      
      public function GameScene(game:Scenario)
      {
         selfPos = new Point();
         otherPos = new Point();
         super();
         _game = game;
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
         var livings:Dictionary = _game.livings;
         var i:int = 1;
         var _loc5_:int = 0;
         var _loc4_:* = livings;
         for each(var living in livings)
         {
            if(living.isSelf || !living.isPlayer)
            {
               drawLiving(living);
            }
            else
            {
               i++;
               setTimeout(drawLiving,150 * i,living);
            }
         }
      }
      
      private function drawLiving(living:LittleLiving) : GameLittleLiving
      {
         var gameLiving:* = null;
         if(_game == null || _game.livings == null || _game.livings[living.id] != living)
         {
            return null;
         }
         if(living.isSelf)
         {
            gameLiving = new GameLittleSelf(living as LittleSelf);
            selfGameLiving = gameLiving as GameLittleSelf;
            living.addEventListener("posChanged",__selfPosChanged);
            focusSelf(living);
         }
         else if(living.isPlayer)
         {
            gameLiving = new GameLittlePlayer(living as LittlePlayer);
         }
         else
         {
            gameLiving = new GameLittleLiving(living);
         }
         _backLivingLayer.addChild(gameLiving);
         if(_gameLivings[living.id])
         {
            trace("::::");
         }
         _gameLivings[living.id] = gameLiving;
         sortLiving(gameLiving);
         return gameLiving;
      }
      
      private function onLivingClicked(event:MouseEvent) : void
      {
         event.stopPropagation();
         var self:LittleSelf = _game.selfPlayer;
         var gameliving:GameLittleLiving = event.currentTarget as GameLittleLiving;
         var dx:int = gameliving.living.pos.x * gameliving.living.speed / _game.grid.cellSize;
         var dy:int = gameliving.living.pos.y * gameliving.living.speed / _game.grid.cellSize;
         var path:Array = LittleGameManager.Instance.fillPath(self,_game.grid,self.pos.x,self.pos.y,dx,dy);
         if(!path)
         {
         }
      }
      
      private function drawGrid() : void
      {
         var i:int = 0;
         var cols:int = 0;
         var j:int = 0;
         var grid:Grid = _game.grid;
         var bitmapData:BitmapData = new BitmapData(grid.width,grid.height,true,0);
         var nodes:Array = grid.nodes;
         var rows:int = nodes.length;
         for(i = 0; i < rows; )
         {
            cols = nodes[i].length;
            for(j = 0; j < cols; )
            {
               if(!nodes[i][j].walkable)
               {
                  bitmapData.fillRect(new Rectangle(j * grid.cellSize,i * grid.cellSize,grid.cellSize,grid.cellSize),2583625728);
               }
               j++;
            }
            i++;
         }
         addChild(new Bitmap(bitmapData));
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
      
      private function __mouseDown(event:MouseEvent) : void
      {
         startDrag();
         StageReferance.stage.addEventListener("mouseUp",__mouseUp);
      }
      
      private function __mouseUp(event:MouseEvent) : void
      {
         StageReferance.stage.removeEventListener("mouseUp",__mouseUp);
         stopDrag();
      }
      
      private function __removeLiving(event:LittleGameEvent) : void
      {
         var living:LittleLiving = event.paras[0] as LittleLiving;
         var gameLiving:GameLittleLiving = _gameLivings[living.id];
         if(gameLiving)
         {
            gameLiving.removeEventListener("click",onLivingClicked);
            ObjectUtils.disposeObject(gameLiving);
            delete _gameLivings[living.id];
         }
      }
      
      private function __update(event:LittleGameEvent) : void
      {
         updateLivingVisible();
         sortDepth();
      }
      
      private function sortDepth() : void
      {
         var i:int = 0;
         var child:* = null;
         var j:int = 0;
         var arr:Array = [];
         for(i = 0; i < _backLivingLayer.numChildren; )
         {
            child = _backLivingLayer.getChildAt(i);
            if(child is GameLittleLiving && !GameLittleLiving(child).lock)
            {
               arr.push(child);
            }
            else
            {
               arr.push(child);
            }
            i++;
         }
         arr.sortOn(["y"],[16]);
         for(j = 0; j < arr.length; )
         {
            _backLivingLayer.setChildIndex(arr[j],j);
            j++;
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
            for each(var gameLiving in _gameLivings)
            {
               otherPos.x = gameLiving.x;
               otherPos.y = gameLiving.y;
               shouldRender = Point.distance(selfPos,otherPos) < CONST_DISTANCE;
               if(shouldRender || gameLiving.lock)
               {
                  gameLiving.realRender = true;
                  if(!gameLiving.lock)
                  {
                     _backLivingLayer.addChild(gameLiving);
                  }
               }
               else
               {
                  gameLiving.realRender = false;
                  if(_backLivingLayer.contains(gameLiving))
                  {
                     _backLivingLayer.removeChild(gameLiving);
                  }
               }
            }
         }
      }
      
      private function sortLiving(gameLiving:GameLittleLiving) : void
      {
         var bounds:Rectangle = gameLiving.getBounds(this);
         var stones:Vector.<Rectangle> = _game.stones;
         var _loc6_:int = 0;
         var _loc5_:* = stones;
         for each(var stone in stones)
         {
            if(stone.intersects(bounds))
            {
               if(bounds.bottom <= stone.bottom)
               {
                  _backLivingLayer.addChild(gameLiving);
               }
               else
               {
                  _foreLivingLayer.addChild(gameLiving);
               }
            }
         }
      }
      
      private function __selfPosChanged(event:LittleLivingEvent) : void
      {
         var self:LittleLiving = event.currentTarget as LittleLiving;
         var oldPos:Point = new Point(event.paras[0].x * self.speed,event.paras[0].y * self.speed);
         var newPos:Point = new Point(self.pos.x * self.speed,self.pos.y * self.speed);
         var globalPos:Point = localToGlobal(newPos);
         if(newPos.y > oldPos.y && globalPos.y > _cameraRect.bottom)
         {
            y = y + (oldPos.y - newPos.y);
         }
         else if(newPos.y < oldPos.y && globalPos.y < _cameraRect.top)
         {
            y = y + (oldPos.y - newPos.y);
         }
         if(newPos.x > oldPos.x && globalPos.x > _cameraRect.right)
         {
            x = x + (oldPos.x - newPos.x);
         }
         else if(newPos.x < oldPos.x && globalPos.x < _cameraRect.left)
         {
            x = x + (oldPos.x - newPos.x);
         }
      }
      
      public function drawServPath(living:LittleLiving) : void
      {
         var i:int = 0;
         var path:Array = living.servPath;
         var g:Graphics = _foreLivingLayer.graphics;
         g.clear();
         var node:Node = path[0];
         g.lineStyle(2,255);
         g.moveTo(node.x * _game.grid.cellSize,node.y * _game.grid.cellSize);
         var len:int = path.length;
         ChatManager.Instance.sysChatYellow("drawServPath:" + len);
         for(i = 1; i < len; )
         {
            g.lineTo(path[i].x * _game.grid.cellSize,path[i].y * _game.grid.cellSize);
            i++;
         }
         g.endFill();
      }
      
      override public function set x(value:Number) : void
      {
         if(value >= _left && value <= _right)
         {
            .super.x = value;
         }
      }
      
      override public function set y(value:Number) : void
      {
         if(value >= _top && value <= _bottom)
         {
            .super.y = value;
         }
      }
      
      private function __click(event:MouseEvent) : void
      {
         var mc:* = null;
         var self:LittleSelf = _game.selfPlayer;
         var dx:int = mouseX / _game.grid.cellSize;
         var dy:int = mouseY / _game.grid.cellSize;
         var path:Array = LittleGameManager.Instance.fillPath(self,_game.grid,self.pos.x,self.pos.y,dx,dy);
         if(path)
         {
            LittleGameManager.Instance.selfMoveTo(_game,self,self.pos.x,self.pos.y,dx,dy,_game.clock.time,path);
            mc = new MovieClipWrapper(ClassUtils.CreatInstance("asset.hotSpring.MouseClickMovie"),true,true);
            var _loc7_:Boolean = false;
            mc.movie.mouseEnabled = _loc7_;
            mc.movie.mouseChildren = _loc7_;
            mc.x = mouseX;
            mc.y = mouseY;
            addChild(mc.movie);
         }
      }
      
      public function findGameLiving(id:int) : GameLittleLiving
      {
         return _gameLivings[id];
      }
      
      public function __addLiving(event:LittleGameEvent) : void
      {
         var gameLiving:GameLittleLiving = drawLiving(event.paras[0]);
         if(!gameLiving.living.isPlayer)
         {
            gameLiving.living.act(new LittleLivingBornAction(gameLiving.living));
         }
      }
      
      private function focusSelf(self:LittleLiving) : void
      {
         var global:Point = localToGlobal(new Point(self.pos.x * self.speed,self.pos.y * self.speed));
         x = (StageReferance.stageWidth >> 1) - global.x;
         y = (StageReferance.stageWidth >> 1) - global.y;
      }
      
      private function removeEvent() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _gameLivings;
         for each(var gameliving in _gameLivings)
         {
            gameliving.removeEventListener("click",onLivingClicked);
         }
         _game.removeEventListener("addLiving",__addLiving);
         _game.removeEventListener("update",__update);
         _game.removeEventListener("removeLiving",__removeLiving);
         removeEventListener("click",__click);
      }
      
      public function addToLayer(object:DisplayObject, layer:int) : void
      {
         var container:DisplayObjectContainer = getLayer(layer);
         if(container)
         {
            container.addChild(object);
         }
      }
      
      public function getLayer(layer:int) : DisplayObjectContainer
      {
         switch(int(layer))
         {
            case 0:
               return _backLivingLayer;
            case 1:
               return _foreLivingLayer;
         }
      }
      
      public function dispose() : void
      {
         var gameLiving:* = null;
         removeEvent();
         if(parent)
         {
            parent.removeChild(this);
         }
         var _loc4_:int = 0;
         var _loc3_:* = _gameLivings;
         for(var key in _gameLivings)
         {
            gameLiving = _gameLivings[key];
            ObjectUtils.disposeObject(gameLiving);
            delete _gameLivings[key];
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
