package littleGame.view
{
   import character.ICharacter;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.ddt_internal;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import littleGame.LittleGameManager;
   import littleGame.character.LittleGameCharacter;
   import littleGame.events.LittleLivingEvent;
   import littleGame.model.LittleLiving;
   
   use namespace ddt_internal;
   
   public class GameLittleLiving extends Sprite implements Disposeable
   {
       
      
      public var isMove:Boolean = false;
      
      protected var _living:LittleLiving;
      
      protected var _body:DisplayObject;
      
      protected var _hitArea:Sprite;
      
      protected var _realRender:Boolean;
      
      public function GameLittleLiving(param1:LittleLiving)
      {
         _living = param1;
         super();
         buttonMode = true;
         configUI();
         addEvent();
         mouseEnabled = false;
      }
      
      public function get realRender() : Boolean
      {
         return _realRender;
      }
      
      public function set realRender(param1:Boolean) : void
      {
         if(_realRender == param1)
         {
            return;
         }
         _realRender = param1;
         ICharacter(_body).realRender = param1;
      }
      
      public function setInhaled(param1:Boolean) : void
      {
      }
      
      public function get lock() : Boolean
      {
         return _living && _living.lock;
      }
      
      public function set lock(param1:Boolean) : void
      {
         if(_living)
         {
            _living.lock = param1;
         }
      }
      
      public function get inGame() : Boolean
      {
         return _living && _living.inGame;
      }
      
      override public function toString() : String
      {
         return _living.toString();
      }
      
      protected function configUI() : void
      {
         x = _living.pos.x * _living.speed;
         y = _living.pos.y * _living.speed;
         createBody();
      }
      
      protected function createBody() : void
      {
         var _loc1_:ICharacter = CharacterFactory.Instance.creatChacrater(_living._modelID);
         _loc1_.soundEnabled = false;
         _body = addChild(_loc1_ as DisplayObject);
         _body.x = -_loc1_.registerPoint.x;
         _body.y = -_loc1_.registerPoint.y;
         _hitArea = new Sprite();
         _hitArea.buttonMode = true;
         addChild(_hitArea);
         _hitArea.graphics.clear();
         _hitArea.graphics.beginFill(11141120,0);
         _hitArea.graphics.drawRect(_loc1_.rect.x,_loc1_.rect.y,_loc1_.rect.width,_loc1_.rect.height);
         _hitArea.graphics.endFill();
         __directionChanged(null);
         _living.bornLife = _loc1_.getActionFrames("born");
         _living.dieLife = _loc1_.getActionFrames("die");
         if(_living.currentAction)
         {
            _loc1_.doAction(_living.currentAction);
         }
         else
         {
            _loc1_.doAction("stand");
         }
      }
      
      protected function addEvent() : void
      {
         if(_hitArea != null)
         {
            _hitArea.addEventListener("mouseOver",onOver);
            _hitArea.addEventListener("mouseOut",onOut);
            _hitArea.addEventListener("click",__click);
         }
         _living.addEventListener("posChanged",__posChanged);
         _living.addEventListener("directionChanged",__directionChanged);
         _living.addEventListener("doAction",__doAction);
      }
      
      private function __click(param1:MouseEvent) : void
      {
         if(parent)
         {
            if(Point.distance(LittleGameManager.Instance.Current.selfPlayer.pos,_living.pos) <= 20)
            {
               LittleGameManager.Instance.livingClick(LittleGameManager.Instance.Current,_living,parent.mouseX,parent.mouseY);
               param1.stopPropagation();
            }
         }
      }
      
      protected function onOver(param1:MouseEvent) : void
      {
         this.filters = [new GlowFilter(16711680,1,24,24,2)];
      }
      
      protected function onOut(param1:MouseEvent) : void
      {
         this.filters = [];
      }
      
      protected function __doAction(param1:LittleLivingEvent) : void
      {
         if(!lock && _body)
         {
            ICharacter(_body).doAction(_living.currentAction);
         }
      }
      
      protected function __directionChanged(param1:LittleLivingEvent) : void
      {
         if(!lock && _living && _body)
         {
            if(_living.isPlayer)
            {
               if(!(_body as LittleGameCharacter).isComplete)
               {
                  _body.scaleX = 1;
               }
               else if(_living.direction == "leftDown" || _living.direction == "rightUp")
               {
                  _body.scaleX = 1;
               }
               else
               {
                  _body.scaleX = -1;
               }
            }
            else if(_living.direction == "leftDown" || _living.direction == "rightUp")
            {
               _body.scaleX = 1;
            }
            else
            {
               _body.scaleX = -1;
            }
            centerBody();
         }
      }
      
      protected function centerBody() : void
      {
         var _loc1_:ICharacter = _body as ICharacter;
         if(_body && _loc1_)
         {
            _body.x = _body.scaleX == 1?-_loc1_.registerPoint.x:Number(_loc1_.registerPoint.x);
         }
      }
      
      private function __posChanged(param1:LittleLivingEvent) : void
      {
         if(!lock)
         {
            x = _living.pos.x * _living.speed;
            y = _living.pos.y * _living.speed + _living.gridIdx;
            isMove = true;
         }
      }
      
      public function get living() : LittleLiving
      {
         return _living;
      }
      
      protected function removeEvent() : void
      {
         if(_hitArea != null)
         {
            _hitArea.removeEventListener("mouseOver",onOver);
            _hitArea.removeEventListener("mouseOut",onOut);
            _hitArea.removeEventListener("click",__click);
         }
         _living.removeEventListener("posChanged",__posChanged);
         _living.removeEventListener("directionChanged",__directionChanged);
         _living.removeEventListener("doAction",__doAction);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(parent)
         {
            parent.removeChild(this);
         }
         _living = null;
         ICharacter(_body).dispose();
         _body = null;
         ObjectUtils.disposeObject(_hitArea);
         _hitArea = null;
      }
   }
}
