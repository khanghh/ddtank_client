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
      
      public function GameLittleLiving(living:LittleLiving)
      {
         _living = living;
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
      
      public function set realRender(value:Boolean) : void
      {
         if(_realRender == value)
         {
            return;
         }
         _realRender = value;
         ICharacter(_body).realRender = value;
      }
      
      public function setInhaled(val:Boolean) : void
      {
      }
      
      public function get lock() : Boolean
      {
         return _living && _living.lock;
      }
      
      public function set lock(val:Boolean) : void
      {
         if(_living)
         {
            _living.lock = val;
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
         var ch:ICharacter = CharacterFactory.Instance.creatChacrater(_living._modelID);
         ch.soundEnabled = false;
         _body = addChild(ch as DisplayObject);
         _body.x = -ch.registerPoint.x;
         _body.y = -ch.registerPoint.y;
         _hitArea = new Sprite();
         _hitArea.buttonMode = true;
         addChild(_hitArea);
         _hitArea.graphics.clear();
         _hitArea.graphics.beginFill(11141120,0);
         _hitArea.graphics.drawRect(ch.rect.x,ch.rect.y,ch.rect.width,ch.rect.height);
         _hitArea.graphics.endFill();
         __directionChanged(null);
         _living.bornLife = ch.getActionFrames("born");
         _living.dieLife = ch.getActionFrames("die");
         if(_living.currentAction)
         {
            ch.doAction(_living.currentAction);
         }
         else
         {
            ch.doAction("stand");
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
      
      private function __click(event:MouseEvent) : void
      {
         if(parent)
         {
            if(Point.distance(LittleGameManager.Instance.Current.selfPlayer.pos,_living.pos) <= 20)
            {
               LittleGameManager.Instance.livingClick(LittleGameManager.Instance.Current,_living,parent.mouseX,parent.mouseY);
               event.stopPropagation();
            }
         }
      }
      
      protected function onOver(event:MouseEvent) : void
      {
         this.filters = [new GlowFilter(16711680,1,24,24,2)];
      }
      
      protected function onOut(event:MouseEvent) : void
      {
         this.filters = [];
      }
      
      protected function __doAction(event:LittleLivingEvent) : void
      {
         if(!lock && _body)
         {
            ICharacter(_body).doAction(_living.currentAction);
         }
      }
      
      protected function __directionChanged(event:LittleLivingEvent) : void
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
         var ch:ICharacter = _body as ICharacter;
         if(_body && ch)
         {
            _body.x = _body.scaleX == 1?-ch.registerPoint.x:Number(ch.registerPoint.x);
         }
      }
      
      private function __posChanged(event:LittleLivingEvent) : void
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
