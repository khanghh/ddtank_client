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
      
      public function FightPlayer(playerVO:FightPlayerVo)
      {
         playerVO.playerInfo.showMounts = false;
         super(playerVO);
      }
      
      public function updatePlayerState() : void
      {
         var isWalk:Boolean = true;
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
            isWalk = false;
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
            isWalk = false;
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
         if(isWalk && _isWalk != isWalk && _playerVO && _playerVO.playerInfo.ID != PlayerManager.Instance.Self.ID)
         {
            _isWalk = isWalk;
            if(fightPlayerVo.stateType == "consortiaGuard")
            {
               startRandomWalk(2,1,{"0_1":[462,470,1098,1022]});
            }
         }
      }
      
      override protected function onControlWalk(evt:TimerEvent) : void
      {
         if(fightPlayerVo && (fightPlayerVo.isFight || fightPlayerVo.isDie))
         {
            _posTimer.reset();
            _posTimer.delay = getRandomDelayTime();
            _posTimer.repeatCount = 1;
            return;
         }
         super.onControlWalk(evt);
      }
      
      public function set showPlayer(value:Boolean) : void
      {
         _isShowPlayer = value;
         _characterPlayer.visible = _isShowPlayer && !fightPlayerVo.isDie;
      }
      
      override protected function updatePetsFollow() : void
      {
      }
      
      public function reveive() : void
      {
         var movie:BoneMovieWrapper = new BoneMovieWrapper("sceneFightRevive",false,true);
         addChild(movie.asDisplay);
         movie.playAction("default",showReveive);
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
