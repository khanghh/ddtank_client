package gameStarling.actions
{
   import ddt.command.PlayerAction;
   import ddt.data.BallInfo;
   import ddt.manager.BallManager;
   import ddt.manager.SharedManager;
   import ddt.view.characterStarling.GameCharacter3D;
   import gameCommon.GameControl;
   import gameCommon.actions.BaseAction;
   import gameStarling.objects.GameLocalPlayer3D;
   import gameStarling.objects.GamePlayer3D;
   import pet.data.PetSkillTemplateInfo;
   import road7th.utils.BoneMovieWrapper;
   
   public class PrepareShootAction extends BaseAction
   {
      
      public static var hasDoSkillAnimation:Boolean;
       
      
      private var _player:GamePlayer3D;
      
      private var _actionType:PlayerAction;
      
      private var _hasDonePrepareAction:Boolean;
      
      private var _skill:PetSkillTemplateInfo;
      
      private var _petMovieOver:Boolean = true;
      
      public function PrepareShootAction(param1:GamePlayer3D){super();}
      
      override public function connect(param1:BaseAction) : Boolean{return false;}
      
      override public function prepare() : void{}
      
      private function finishPetMovie() : void{}
      
      private function doPrepareToShootAction() : void{}
      
      override public function execute() : void{}
   }
}
