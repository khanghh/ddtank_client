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
      
      public function FightPlayer(param1:FightPlayerVo){super(null);}
      
      public function updatePlayerState() : void{}
      
      override protected function onControlWalk(param1:TimerEvent) : void{}
      
      public function set showPlayer(param1:Boolean) : void{}
      
      override protected function updatePetsFollow() : void{}
      
      public function reveive() : void{}
      
      private function showReveive() : void{}
      
      override public function update() : void{}
      
      public function get fightPlayerVo() : FightPlayerVo{return null;}
      
      override public function dispose() : void{}
   }
}
