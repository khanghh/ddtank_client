package gameStarling.objects
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieStarling;
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StarlingObjectUtils;
   import ddt.command.PlayerAction;
   import ddt.data.EquipType;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.LivingEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PetSkillManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.Helpers;
   import ddt.view.character.ShowCharacter;
   import ddt.view.characterStarling.GameCharacter3D;
   import ddt.view.chat.ChatData;
   import ddt.view.chat.ChatEvent;
   import ddt.view.common.DailyLeagueLevel;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.setTimeout;
   import gameCommon.GameControl;
   import gameCommon.model.FightBuffInfo;
   import gameCommon.model.GameInfo;
   import gameCommon.model.Living;
   import gameCommon.model.LocalPlayer;
   import gameCommon.model.Player;
   import gameCommon.model.SceneEffectObj;
   import gameStarling.actions.GhostMoveAction;
   import gameStarling.actions.PlayerBeatAction;
   import gameStarling.actions.PlayerFallingAction;
   import gameStarling.actions.PlayerWalkAction;
   import gameStarling.actions.PrepareShootAction;
   import gameStarling.actions.SelfSkipAction;
   import gameStarling.actions.ShootBombAction;
   import gameStarling.actions.SkillActions.ResolveHurtAction;
   import gameStarling.actions.SkillActions.RevertAction;
   import gameStarling.animations.BaseSetCenterAnimation;
   import gameStarling.chat.ChatBallPlayer3D;
   import gameStarling.view.ExpMovie3D;
   import gameStarling.view.FaceContainer3D;
   import gameStarling.view.GameView3D;
   import horse.HorseManager;
   import horse.data.HorseSkillVo;
   import newTitle.NewTitleManager;
   import newTitle.model.NewTitleModel;
   import pet.data.PetSkillTemplateInfo;
   import road7th.StarlingMain;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import road7th.data.StringObject;
   import road7th.utils.BoneMovieWrapper;
   import road7th.utils.MovieClipWrapper;
   import room.RoomManager;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.display.cell.CellContent3D;
   import starling.events.Event;
   import starlingPhy.maps.Map3D;
   import starlingui.core.text.TextLabel;
   
   public class GamePlayer3D extends GameTurnedLiving3D
   {
       
      
      protected var _player:Sprite;
      
      protected var _attackPlayerCite:BoneMovieStarling;
      
      private var _levelIcon:Image;
      
      private var _leagueRank:DailyLeagueLevel;
      
      protected var _consortiaName:TextLabel;
      
      protected var _teamTxt:TextLabel;
      
      private var _facecontainer:FaceContainer3D;
      
      private var _ballpos:Point;
      
      private var _expView:ExpMovie3D;
      
      private var _resolveHurtMovie:MovieClipWrapper;
      
      private var _petMovie:GamePetMovie3D;
      
      private var _currentPetSkill:PetSkillTemplateInfo;
      
      private var _badgeIcon:Image;
      
      private var _newTitle:Image;
      
      private var _ringSkill:BoneMovieWrapper;
      
      private var _guardCoreEffect:BoneMovieWrapper;
      
      private var _danderFire:BoneMovieStarling;
      
      public var isShootPrepared:Boolean;
      
      public var UsedPetSkill:DictionaryData;
      
      private var _character:ShowCharacter;
      
      private var _body:GameCharacter3D;
      
      private var _weaponMovie:BoneMovieWrapper;
      
      private var _currentWeaponMovieAction:String = "";
      
      private var _tomb:TombView3D;
      
      private var _isNeedActRevive:Boolean = false;
      
      private var _reviveTimer:Timer;
      
      private var labelMapping:Dictionary;
      
      public function GamePlayer3D(param1:Player, param2:ShowCharacter, param3:GameCharacter3D = null, param4:int = 0){super(null);}
      
      public function playRingSkill() : void{}
      
      public function playGuardCoreEffect() : void{}
      
      public function replacePlayerSource(param1:ShowCharacter, param2:GameCharacter3D) : void{}
      
      protected function __playPlayerEffect(param1:Event) : void{}
      
      public function get facecontainer() : FaceContainer3D{return null;}
      
      override protected function initView() : void{}
      
      private function updatePlayerTitle() : void{}
      
      private function updateNewTitlePos() : void{}
      
      private function initBuff() : void{}
      
      override protected function initListener() : void{}
      
      protected function __playerDoAction(param1:LivingEvent) : void{}
      
      override public function get movie() : Sprite{return null;}
      
      protected function __boxPickHandler(param1:LivingEvent) : void{}
      
      override protected function __applySkill(param1:LivingEvent) : void{}
      
      private function applyRevert(param1:PackageIn) : void{}
      
      private function applyResolveHurt(param1:PackageIn) : void{}
      
      protected function __addState(param1:LivingEvent) : void{}
      
      protected function __useSkillHandler(param1:LivingEvent) : void{}
      
      protected function __usingItem(param1:LivingEvent) : void{}
      
      protected function __usingSpecialKill(param1:LivingEvent) : void{}
      
      override protected function doUseItemAnimation(param1:Boolean = false) : void{}
      
      protected function __danderChanged(param1:LivingEvent) : void{}
      
      override protected function __posChanged(param1:LivingEvent) : void{}
      
      protected function __checkCollide(param1:LivingEvent) : void{}
      
      private function __isRedSkullChanged(param1:LivingEvent) : void{}
      
      public function playerMove() : void{}
      
      override protected function __dirChanged(param1:LivingEvent) : void{}
      
      override protected function __attackingChanged(param1:LivingEvent) : void{}
      
      protected function attackingViewChanged() : void{}
      
      override protected function __hiddenChanged(param1:LivingEvent) : void{}
      
      override protected function __say(param1:LivingEvent) : void{}
      
      override protected function __playDeadEffect(param1:LivingEvent) : void{}
      
      override protected function __bloodChanged(param1:LivingEvent) : void{}
      
      override protected function __shoot(param1:LivingEvent) : void{}
      
      protected function shootIntervalDegression() : void{}
      
      override protected function __beat(param1:LivingEvent) : void{}
      
      protected function __usePetSkill(param1:LivingEvent) : void{}
      
      private function __petBeat(param1:LivingEvent) : void{}
      
      private function playPetMovie(param1:String, param2:Point, param3:Function = null, param4:Array = null) : void{}
      
      public function hidePetMovie() : void{}
      
      private function updateHp(param1:Array) : void{}
      
      public function usePetSkill(param1:PetSkillTemplateInfo, param2:Function = null) : void{}
      
      private function skipSelfTurn() : void{}
      
      protected function __playerMoveTo(param1:LivingEvent) : void{}
      
      override public function playerMoveTo(param1:Array) : void{}
      
      override protected function __fall(param1:LivingEvent) : void{}
      
      override protected function __jump(param1:LivingEvent) : void{}
      
      private function setSoulPos() : void{}
      
      public function get character() : ShowCharacter{return null;}
      
      public function get body() : GameCharacter3D{return null;}
      
      public function get player() : Player{return null;}
      
      public function get weaponMovie() : BoneMovieWrapper{return null;}
      
      public function set weaponMovie(param1:BoneMovieWrapper) : void{}
      
      private function creatWeaponShotAction(param1:BoneMovieWrapper, param2:Array = null) : void{}
      
      private function checkCurrentMovie(param1:Event) : void{}
      
      public function setWeaponMoiveActionSyc(param1:String) : void{}
      
      override public function die() : void{}
      
      protected function __updateNamePos(param1:Event) : void{}
      
      override public function revive() : void{}
      
      private function reviveCompleteHandler() : void{}
      
      private function insureActRevive(param1:TimerEvent) : void{}
      
      public function clearDebuff() : void{}
      
      override protected function __beginNewTurn(param1:LivingEvent) : void{}
      
      private function __getChat(param1:ChatEvent) : void{}
      
      public function say(param1:String, param2:int) : void{}
      
      override protected function get popPos() : Point{return null;}
      
      override protected function get popDir() : Point{return null;}
      
      private function __getFace(param1:ChatEvent) : void{}
      
      public function showFace(param1:int) : void{}
      
      public function shootPoint() : Point{return null;}
      
      public function getPlayerMapPos() : Point{return null;}
      
      override public function doAction(param1:*, param2:Function = null, param3:Array = null) : void{}
      
      override protected function __buffChanged(param1:LivingEvent) : void{}
      
      override public function dispose() : void{}
      
      override protected function __bombed(param1:LivingEvent) : void{}
      
      override public function setMap(param1:Map3D) : void{}
      
      override public function setProperty(param1:String, param2:String) : void{}
      
      public function set gainEXP(param1:int) : void{}
      
      override public function setActionMapping(param1:String, param2:String) : void{}
      
      override public function getAction(param1:String) : *{return null;}
   }
}
