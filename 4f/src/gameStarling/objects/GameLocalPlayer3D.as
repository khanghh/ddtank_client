package gameStarling.objects
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieStarling;
   import com.pickgliss.utils.StarlingObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.LivingEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PetSkillManager;
   import ddt.manager.SoundManager;
   import ddt.view.character.ShowCharacter;
   import ddt.view.characterStarling.GameCharacter3D;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import gameCommon.GameControl;
   import gameCommon.model.LocalPlayer;
   import gameStarling.actions.FocusInLivingAction;
   import gameStarling.actions.PlayerBeatAction;
   import gameStarling.actions.SelfPlayerWalkAction;
   import gameStarling.actions.SelfSkipAction;
   import gameStarling.actions.newHand.NewHandFightHelpAction;
   import gameStarling.animations.BaseSetCenterAnimation;
   import gameStarling.animations.DragMapAnimation;
   import org.aswing.KeyStroke;
   import org.aswing.KeyboardManager;
   import pet.data.PetSkillTemplateInfo;
   import road7th.StarlingMain;
   import room.RoomManager;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class GameLocalPlayer3D extends GamePlayer3D
   {
      
      private static const MAX_MOVE_TIME:int = 10;
       
      
      private var _takeAim:Sprite;
      
      private var _takeBg:Image;
      
      private var _moveStripContainer:Sprite;
      
      private var _moveStrip:Image;
      
      private var _ballpos:Point;
      
      protected var _shootTimer:Timer;
      
      private var mouseAsset:BoneMovieStarling;
      
      private var _turned:Boolean;
      
      private var _transmissionEffoct:BoneMovieStarling;
      
      private var _keyDownTime:int;
      
      private var _currentReverse:int = 1;
      
      private var _isChangeReverse:Boolean = true;
      
      protected var _isShooting:Boolean = false;
      
      protected var _shootCount:int = 0;
      
      protected var _shootPoint:Point;
      
      private var _shootOverCount:int = 0;
      
      public function GameLocalPlayer3D(param1:LocalPlayer, param2:ShowCharacter, param3:GameCharacter3D = null, param4:int = 0){super(null,null,null,null);}
      
      public function get localPlayer() : LocalPlayer{return null;}
      
      public function get aim() : Sprite{return null;}
      
      override public function set pos(param1:Point) : void{}
      
      override protected function initView() : void{}
      
      override protected function initListener() : void{}
      
      private function __setCenter(param1:LivingEvent) : void{}
      
      override public function dispose() : void{}
      
      protected function __skip(param1:LivingEvent) : void{}
      
      public function showTransmissionEffoct() : void{}
      
      private function __keyUp(param1:KeyboardEvent) : void{}
      
      private function __turnLeft() : void{}
      
      private function __turnRight() : void{}
      
      protected function walk() : void{}
      
      override public function startMoving() : void{}
      
      override public function stopMoving() : void{}
      
      override protected function __attackingChanged(param1:LivingEvent) : void{}
      
      override protected function attackingViewChanged() : void{}
      
      override public function die() : void{}
      
      override public function revive() : void{}
      
      private function __mouseClick(param1:MouseEvent) : void{}
      
      public function hideTargetMouseTip() : void{}
      
      override protected function __usingItem(param1:LivingEvent) : void{}
      
      protected function __sendShoot(param1:LivingEvent) : void{}
      
      private function __shootTimer(param1:Event) : void{}
      
      override protected function __shoot(param1:LivingEvent) : void{}
      
      override protected function __beginNewTurn(param1:LivingEvent) : void{}
      
      public function get shootOverCount() : int{return 0;}
      
      public function set shootOverCount(param1:int) : void{}
      
      protected function __gunangleChanged(param1:LivingEvent) : void{}
      
      protected function __beginShoot(param1:LivingEvent) : void{}
      
      protected function __energyChanged(param1:LivingEvent) : void{}
      
      override protected function __usePetSkill(param1:LivingEvent) : void{}
   }
}
