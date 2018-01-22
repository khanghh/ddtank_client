package starling.display.player
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieFastStarling;
   import com.pickgliss.utils.StarlingObjectUtils;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import flash.events.TimerEvent;
   import road7th.StarlingMain;
   import road7th.utils.BoneMovieWrapper;
   import starling.display.Image;
   import starling.scene.hall.player.HallPlayer;
   
   public class FightPlayer extends HallPlayer
   {
       
      
      private var _fightMoive:BoneMovieFastStarling;
      
      private var _tombstone:Image;
      
      private var _isWalk:Boolean;
      
      private var _showPlayer:Boolean;
      
      private var _isShowPlayer:Boolean = true;
      
      public function FightPlayer(param1:FightPlayerVo)
      {
         param1.playerInfo.showMounts = false;
         super(param1);
      }
      
      public function updatePlayerState() : void
      {
         var _loc1_:Boolean = true;
         stopWalk();
         if(fightPlayerVo.isFight)
         {
            if(_fightMoive == null)
            {
               _fightMoive = BoneMovieFactory.instance.creatBoneMovieFast("sceneFightMovie");
               PositionUtils.setPos(_fightMoive,"sceneFight.fightMoviePos");
            }
            if(!_fightMoive.parent)
            {
               addChild(_fightMoive);
            }
            _loc1_ = false;
         }
         else
         {
            StarlingObjectUtils.removeObject(_fightMoive);
         }
         if(fightPlayerVo.isDie)
         {
            if(_tombstone == null)
            {
               _tombstone = StarlingMain.instance.createImage("image_fight_tomb","sceneFight.tombPos");
               var _loc2_:* = 1.2;
               _tombstone.scaleY = _loc2_;
               _tombstone.scaleX = _loc2_;
               addChild(_tombstone);
            }
            if(!_tombstone.parent)
            {
               addChild(_tombstone);
            }
            _characterPlayer.visible = false;
            _loc1_ = false;
         }
         else if(_tombstone)
         {
            StarlingObjectUtils.disposeObject(_tombstone);
            _tombstone = null;
            reveive();
         }
         else
         {
            _characterPlayer.visible = _isShowPlayer && true;
         }
         if(_loc1_ && _isWalk != _loc1_ && _playerVO && _playerVO.playerInfo.ID != PlayerManager.Instance.Self.ID)
         {
            _isWalk = _loc1_;
            if(fightPlayerVo.stateType == "consortiaGuard")
            {
               startRandomWalk(2,1,{"0_1":[462,470,1098,1022]});
            }
         }
      }
      
      override protected function onControlWalk(param1:TimerEvent) : void
      {
         if(fightPlayerVo && (fightPlayerVo.isFight || fightPlayerVo.isDie))
         {
            _posTimer.reset();
            _posTimer.delay = getRandomDelayTime();
            _posTimer.repeatCount = 1;
            return;
         }
         super.onControlWalk(param1);
      }
      
      public function set showPlayer(param1:Boolean) : void
      {
         _isShowPlayer = param1;
         _characterPlayer.visible = _isShowPlayer && !fightPlayerVo.isDie;
      }
      
      override protected function updatePetsFollow() : void
      {
      }
      
      public function reveive() : void
      {
         var _loc1_:BoneMovieWrapper = new BoneMovieWrapper("sceneFightRevive",false,true);
         addChild(_loc1_.asDisplay);
         _loc1_.playAction("default",showReveive);
      }
      
      private function showReveive() : void
      {
         updatePlayerState();
      }
      
      override public function update() : void
      {
         if(fightPlayerVo.isDie == false && _isShowPlayer)
         {
            super.update();
         }
      }
      
      public function get fightPlayerVo() : FightPlayerVo
      {
         return _playerVO as FightPlayerVo;
      }
      
      override public function dispose() : void
      {
         StarlingObjectUtils.disposeObject(_fightMoive);
         _fightMoive = null;
         StarlingObjectUtils.disposeObject(_tombstone);
         _tombstone = null;
         if(playerVO)
         {
            playerVO.playerInfo.showMounts = true;
         }
         super.dispose();
      }
   }
}
