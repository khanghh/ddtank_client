package game.actions
{
   import ddt.command.PlayerAction;
   import ddt.data.BallInfo;
   import ddt.manager.BallManager;
   import ddt.manager.SharedManager;
   import ddt.view.character.GameCharacter;
   import game.objects.GameLocalPlayer;
   import game.objects.GamePlayer;
   import gameCommon.GameControl;
   import gameCommon.actions.BaseAction;
   import pet.data.PetSkillTemplateInfo;
   
   public class PrepareShootAction extends BaseAction
   {
      
      public static var hasDoSkillAnimation:Boolean;
       
      
      private var _player:GamePlayer;
      
      private var _actionType:PlayerAction;
      
      private var _hasDonePrepareAction:Boolean;
      
      private var _skill:PetSkillTemplateInfo;
      
      private var _petMovieOver:Boolean = true;
      
      public function PrepareShootAction(param1:GamePlayer)
      {
         super();
         _player = param1;
      }
      
      override public function connect(param1:BaseAction) : Boolean
      {
         return param1 is PrepareShootAction;
      }
      
      override public function prepare() : void
      {
         var _loc1_:* = null;
         if(_player.player && _player.isLiving)
         {
            if(_player.UsedPetSkill.length > 0 && _player.UsedPetSkill.list[0].BallType == 1)
            {
               _loc1_ = _player.UsedPetSkill.list[0];
               _skill = _loc1_;
               _petMovieOver = false;
               _player.usePetSkill(_loc1_,finishPetMovie);
            }
            else
            {
               doPrepareToShootAction();
            }
         }
         else
         {
            _isFinished = true;
         }
      }
      
      private function finishPetMovie() : void
      {
         doPrepareToShootAction();
         _petMovieOver = true;
         _player.hidePetMovie();
      }
      
      private function doPrepareToShootAction() : void
      {
         _hasDonePrepareAction = true;
         var _loc1_:BallInfo = BallManager.instance.findBall(_player.player.currentBomb);
         _actionType = _loc1_.ActionType == 0?GameCharacter.SHOWTHROWS:GameCharacter.SHOWGUN;
         if(!GameControl.Instance.Current.togetherShoot || _player is GameLocalPlayer)
         {
            if((_player.player.skill >= 0 || _player.player.isSpecialSkill) && SharedManager.Instance.showParticle && !hasDoSkillAnimation)
            {
               hasDoSkillAnimation = true;
               _player.map.spellKill(_player);
            }
         }
         _player.weaponMovie = BallManager.instance.createShootMovieMovie(_player.player.currentBomb);
         _player.body.doAction(_actionType);
         if(_player.weaponMovie)
         {
            _player.weaponMovie.visible = true;
            _player.setWeaponMoiveActionSyc("start");
            _player.body.WingState = 5;
         }
      }
      
      override public function execute() : void
      {
         if(!_petMovieOver)
         {
            return;
         }
         if(_hasDonePrepareAction && (_player == null || _player.body == null || _player.body.currentAction == null))
         {
            _isFinished = true;
            return;
         }
         if(_player.body.currentAction != _actionType)
         {
            if(_player.weaponMovie)
            {
               _player.weaponMovie.visible = false;
            }
            _player.body.WingState = 1;
         }
         if(_hasDonePrepareAction && (!_player.map.isPlayingMovie && (!_player.body.actionPlaying() || _player.body.currentAction != _actionType)))
         {
            _player.isShootPrepared = true;
            _isFinished = true;
         }
      }
   }
}
