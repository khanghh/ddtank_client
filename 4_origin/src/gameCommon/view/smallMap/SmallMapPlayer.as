package gameCommon.view.smallMap
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ClassUtils;
   import ddt.events.LivingEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import gameCommon.GameControl;
   import gameCommon.model.Living;
   import gameCommon.model.SimpleBoss;
   import gameCommon.model.SmallEnemy;
   import gameCommon.model.TurnedLiving;
   
   public class SmallMapPlayer extends Sprite
   {
       
      
      private var _info:Living;
      
      private var _player:MovieClip;
      
      public function SmallMapPlayer(param1:Living)
      {
         super();
         _info = param1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         if(_info is SimpleBoss || _info is SmallEnemy)
         {
            if(_info.team == 1)
            {
               createPlayer(ComponentFactory.Instance.creatCustomObject("asset.game.SmallMapPlayer1Asset"));
               return;
            }
         }
         if(_info.team == 1)
         {
            createPlayer(ClassUtils.CreatInstance("asset.game.SmallMapPlayer9Asset"));
         }
         else if(_info.team == 2)
         {
            createPlayer(ClassUtils.CreatInstance("asset.game.SmallMapPlayer10Asset"));
         }
         else if(_info.team == 3)
         {
            createPlayer(ClassUtils.CreatInstance("asset.game.SmallMapPlayer11Asset"));
         }
         else if(_info.team == 4)
         {
            createPlayer(ClassUtils.CreatInstance("asset.game.SmallMapPlayer12Asset"));
         }
         else if(_info.team == 5)
         {
            createPlayer(ClassUtils.CreatInstance("asset.game.SmallMapPlayer13Asset"));
         }
         else if(_info.team == 6)
         {
            createPlayer(ClassUtils.CreatInstance("asset.game.SmallMapPlayer14Asset"));
         }
         else if(_info.team == 7)
         {
            createPlayer(ClassUtils.CreatInstance("asset.game.SmallMapPlayer15Asset"));
         }
         else if(_info.team == 8)
         {
            createPlayer(ClassUtils.CreatInstance("asset.game.SmallMapPlayer16Asset"));
         }
      }
      
      private function initEvent() : void
      {
         _info.addEventListener("attackingChanged",__change);
         _info.addEventListener("hiddenChanged",__hide);
         _info.addEventListener("die",__die);
      }
      
      public function dispose() : void
      {
         _info.removeEventListener("attackingChanged",__change);
         _info.removeEventListener("hiddenChanged",__hide);
         _info.removeEventListener("die",__die);
         _info = null;
         _player.stop();
         _player = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function createPlayer(param1:MovieClip) : void
      {
         _player = param1;
         var _loc2_:* = 1.2;
         _player.scaleY = _loc2_;
         _player.scaleX = _loc2_;
         param1["attrack_mc"].visible = false;
         addChild(_player);
         if(_info.isSelf)
         {
            param1["player_mc"].gotoAndPlay(1);
         }
         else
         {
            param1["player_mc"].gotoAndStop(8);
         }
      }
      
      private function __change(param1:LivingEvent) : void
      {
         if((_info as TurnedLiving).isAttacking)
         {
            _player["attrack_mc"].visible = true;
         }
         else
         {
            _player["attrack_mc"].visible = false;
         }
      }
      
      private function __hide(param1:LivingEvent) : void
      {
         if(_info.isHidden)
         {
            if(_info.team != GameControl.Instance.Current.selfGamePlayer.team)
            {
               alpha = 0;
               visible = false;
            }
            else
            {
               alpha = 0.5;
            }
         }
         else
         {
            alpha = 1;
            visible = true;
         }
      }
      
      private function __die(param1:LivingEvent) : void
      {
         _player["attrack_mc"].visible = false;
      }
   }
}
