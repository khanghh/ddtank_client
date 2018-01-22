package gameStarling.objects
{
   import bones.BoneMovieFactory;
   import bones.game.ActionMovieBone;
   import com.pickgliss.utils.StarlingObjectUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.LivingEvent;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import gameCommon.model.SimpleBoss;
   import gameStarling.actions.ChangeDirectionAction;
   import gameStarling.actions.MonsterShootBombAction;
   import starlingPhy.maps.Map3D;
   
   public class GameSimpleBoss3D extends GameTurnedLiving3D
   {
       
      
      private var bombList:Array;
      
      private var shootEvt:CrazyTankSocketEvent;
      
      private var shoots:Array;
      
      public function GameSimpleBoss3D(param1:SimpleBoss)
      {
         bombList = [];
         shoots = [];
         super(param1);
         param1.defaultAction = "stand";
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
         super.initChatball();
         _originalHeight = this.height;
         _originalWidth = this.width;
      }
      
      override protected function initFreezonRect() : void
      {
         _effRect = new Rectangle(-10,35,bodyWidth * 1.3,bodyHeight * 1.4);
      }
      
      override protected function __forzenChanged(param1:LivingEvent) : void
      {
         if(_info.isFrozen)
         {
            StarlingObjectUtils.disposeObject(effectForzen);
            effectForzen = null;
            effectForzen = BoneMovieFactory.instance.creatBoneMovie("bonesGameTrailFrostEffectAsset");
            effectForzen.width = _effRect.width;
            effectForzen.height = _effRect.height;
            effectForzen.x = _effRect.x;
            effectForzen.y = _effRect.y;
            addChild(effectForzen);
         }
         else
         {
            StarlingObjectUtils.disposeObject(effectForzen);
            effectForzen = null;
         }
      }
      
      override protected function __dirChanged(param1:LivingEvent) : void
      {
         _info.act(new ChangeDirectionAction(this,_info.direction));
      }
      
      override public function setMap(param1:Map3D) : void
      {
         super.setMap(param1);
         if(param1)
         {
            __posChanged(null);
         }
      }
      
      override protected function __shoot(param1:LivingEvent) : void
      {
         map.act(new MonsterShootBombAction(this,param1.paras[0],param1.paras[1],24));
      }
      
      override protected function __attackingChanged(param1:LivingEvent) : void
      {
      }
      
      override protected function __posChanged(param1:LivingEvent) : void
      {
         super.__posChanged(param1);
      }
      
      public function get simpleBoss() : SimpleBoss
      {
         return info as SimpleBoss;
      }
      
      override protected function __bloodChanged(param1:LivingEvent) : void
      {
         if(param1.paras[0] == 0)
         {
            if(_actionMovie != null)
            {
               (_actionMovie as ActionMovieBone).doAction("renew",playRenewActionCompleteCall,[param1]);
            }
         }
         else if(param1.paras[0] == 10)
         {
            super.__bloodChanged(param1);
         }
         else
         {
            if(param1.paras[0] == 5)
            {
               updateBloodStrip();
               return;
            }
            super.__bloodChanged(param1);
            if(_info.State != 1)
            {
               doAction("cry");
            }
         }
      }
      
      private function playRenewActionCompleteCall(param1:Array) : void
      {
         super.__bloodChanged(param1[0]);
      }
      
      override protected function __die(param1:LivingEvent) : void
      {
         if(isMoving())
         {
            stopMoving();
         }
         super.__die(param1);
         if(_info.typeLiving == 6)
         {
            actionMovie.doAction("specialDie");
            return;
         }
         if(param1.paras[0])
         {
            if(_info.typeLiving == 5)
            {
               actionMovie.doAction("die",clearEnemy);
            }
            else
            {
               actionMovie.doAction("die",dispose);
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
      
      override protected function __changeState(param1:LivingEvent) : void
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
      
      private function __disposeLater(param1:Event) : void
      {
         _chatballview.removeEventListener("complete",__disposeLater);
         dispose();
      }
   }
}
