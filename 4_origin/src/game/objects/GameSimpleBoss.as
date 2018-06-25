package game.objects
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.LivingEvent;
   import ddt.view.chat.chatBall.ChatBallBoss;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import game.actions.ChangeDirectionAction;
   import game.actions.MonsterShootBombAction;
   import gameCommon.model.SimpleBoss;
   import phy.maps.Map;
   
   public class GameSimpleBoss extends GameTurnedLiving
   {
       
      
      private var bombList:Array;
      
      private var shootEvt:CrazyTankSocketEvent;
      
      private var shoots:Array;
      
      public function GameSimpleBoss(info:SimpleBoss)
      {
         bombList = [];
         shoots = [];
         super(info);
         info.defaultAction = "stand";
      }
      
      override protected function initView() : void
      {
         initMovie();
         initFreezonRect();
         super.initView();
         _nickName.x = _nickName.x - 2;
         _nickName.y = _nickName.y + 2;
      }
      
      override protected function initChatball() : void
      {
         _chatballview = new ChatBallBoss();
         _originalHeight = this.height;
         _originalWidth = this.width;
         addChild(_chatballview);
      }
      
      override protected function initFreezonRect() : void
      {
         _effRect = new Rectangle(-10,35,bodyWidth * 1.3,bodyHeight * 1.4);
      }
      
      override protected function __forzenChanged(event:LivingEvent) : void
      {
         if(_info.isFrozen)
         {
            effectForzen = ComponentFactory.Instance.creatCustomObject("asset.gameFrostEffectAsset") as MovieClip;
            effectForzen.width = _effRect.width;
            effectForzen.height = _effRect.height;
            effectForzen.x = _effRect.x;
            effectForzen.y = _effRect.y;
            addChild(effectForzen);
         }
         else if(effectForzen)
         {
            removeChild(effectForzen);
            effectForzen = null;
         }
      }
      
      override protected function __dirChanged(event:LivingEvent) : void
      {
         _info.act(new ChangeDirectionAction(this,_info.direction));
      }
      
      override public function setMap(map:Map) : void
      {
         super.setMap(map);
         if(map)
         {
            __posChanged(null);
         }
      }
      
      override protected function __shoot(event:LivingEvent) : void
      {
         map.act(new MonsterShootBombAction(this,event.paras[0],event.paras[1],24));
      }
      
      override protected function __attackingChanged(event:LivingEvent) : void
      {
      }
      
      override protected function __posChanged(event:LivingEvent) : void
      {
         super.__posChanged(event);
      }
      
      public function get simpleBoss() : SimpleBoss
      {
         return info as SimpleBoss;
      }
      
      override protected function __bloodChanged(event:LivingEvent) : void
      {
         if(event.paras[0] == 0)
         {
            if(_actionMovie != null)
            {
               _actionMovie.doAction("renew",super.__bloodChanged,[event]);
            }
         }
         else if(event.paras[0] == 10)
         {
            super.__bloodChanged(event);
         }
         else
         {
            if(event.paras[0] == 5)
            {
               updateBloodStrip();
               return;
            }
            super.__bloodChanged(event);
            if(_info.State != 1)
            {
               doAction("cry");
            }
         }
      }
      
      override protected function __die(event:LivingEvent) : void
      {
         if(isMoving())
         {
            stopMoving();
         }
         super.__die(event);
         if(_info.typeLiving == 6)
         {
            _actionMovie.doAction("specialDie");
            return;
         }
         if(event.paras[0])
         {
            if(_info.typeLiving == 5)
            {
               _actionMovie.doAction("die",clearEnemy);
            }
            else
            {
               _actionMovie.doAction("die",dispose);
            }
         }
         else if(_info.typeLiving == 5)
         {
            clearEnemy();
         }
         else
         {
            dispose();
         }
         _isDie = true;
      }
      
      private function clearEnemy() : void
      {
         removeListener();
         deleteSmallView();
      }
      
      override protected function __changeState(evt:LivingEvent) : void
      {
         if(_info.State == 1)
         {
            doAction("angry");
         }
         else
         {
            doAction("stand");
         }
      }
      
      override public function dispose() : void
      {
         if(_chatballview.visible && _chatballview.parent)
         {
            _chatballview.addEventListener("complete",__disposeLater);
            return;
         }
         if(map && map.currentPlayer == _info)
         {
            map.currentPlayer = null;
         }
         super.dispose();
      }
      
      private function __disposeLater(evt:Event) : void
      {
         _chatballview.removeEventListener("complete",__disposeLater);
         dispose();
      }
   }
}
