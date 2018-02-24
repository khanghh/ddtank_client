package game.objects
{
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
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
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.Helpers;
   import ddt.utils.PositionUtils;
   import ddt.view.ExpMovie;
   import ddt.view.FaceContainer;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.GameCharacter;
   import ddt.view.character.ICharacter;
   import ddt.view.character.ShowCharacter;
   import ddt.view.chat.ChatData;
   import ddt.view.chat.ChatEvent;
   import ddt.view.chat.chatBall.ChatBallPlayer;
   import ddt.view.common.DailyLeagueLevel;
   import ddt.view.common.LevelIcon;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.setTimeout;
   import game.actions.GhostMoveAction;
   import game.actions.PlayerBeatAction;
   import game.actions.PlayerFallingAction;
   import game.actions.PlayerWalkAction;
   import game.actions.PrepareShootAction;
   import game.actions.SelfSkipAction;
   import game.actions.ShootBombAction;
   import game.actions.SkillActions.ResolveHurtAction;
   import game.actions.SkillActions.RevertAction;
   import game.actions.WeaponShootAction;
   import game.animations.BaseSetCenterAnimation;
   import gameCommon.GameControl;
   import gameCommon.model.FightBuffInfo;
   import gameCommon.model.GameInfo;
   import gameCommon.model.Living;
   import gameCommon.model.LocalPlayer;
   import gameCommon.model.Player;
   import gameCommon.model.SceneEffectObj;
   import guardCore.GuardCoreManager;
   import guardCore.data.GuardCoreInfo;
   import horse.HorseManager;
   import horse.data.HorseSkillVo;
   import newTitle.NewTitleManager;
   import newTitle.model.NewTitleModel;
   import pet.data.PetSkillTemplateInfo;
   import phy.maps.Map;
   import road7th.DDTAssetManager;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import road7th.data.StringObject;
   import road7th.utils.MovieClipWrapper;
   import room.RoomManager;
   
   public class GamePlayer extends GameTurnedLiving
   {
       
      
      protected var _player:Sprite;
      
      protected var _attackPlayerCite:MovieClip;
      
      private var _levelIcon:LevelIcon;
      
      private var _teamTxt:FilterFrameText;
      
      private var _leagueRank:DailyLeagueLevel;
      
      protected var _consortiaName:FilterFrameText;
      
      private var _facecontainer:FaceContainer;
      
      private var _ballpos:Point;
      
      private var _expView:ExpMovie;
      
      private var _resolveHurtMovie:MovieClipWrapper;
      
      private var _petMovie:GamePetMovie;
      
      private var _currentPetSkill:PetSkillTemplateInfo;
      
      private var _badgeIcon:Bitmap;
      
      private var _newTitle:Bitmap;
      
      private var _ringSkill:MovieClip;
      
      private var _guardCoreEffect:MovieClip;
      
      private var _danderFire:MovieClip;
      
      public var isShootPrepared:Boolean;
      
      public var UsedPetSkill:DictionaryData;
      
      private var _character:ShowCharacter;
      
      private var _body:GameCharacter;
      
      private var _weaponMovie:MovieClip;
      
      private var _currentWeaponMovie:MovieClip;
      
      private var _currentWeaponMovieAction:String = "";
      
      private var _tomb:TombView;
      
      private var _isNeedActRevive:Boolean = false;
      
      private var _reviveTimer:Timer;
      
      private var labelMapping:Dictionary;
      
      public function GamePlayer(param1:Player, param2:ShowCharacter, param3:GameCharacter = null, param4:int = 0){super(null);}
      
      public function playRingSkill() : void{}
      
      public function playGuardCoreEffect() : void{}
      
      public function replacePlayerSource(param1:ShowCharacter, param2:GameCharacter) : void{}
      
      protected function __playPlayerEffect(param1:Event) : void{}
      
      public function get facecontainer() : FaceContainer{return null;}
      
      public function set facecontainer(param1:FaceContainer) : void{}
      
      override protected function initView() : void{}
      
      private function creatConsortiaName() : void{}
      
      public function playPetMovieDebug(param1:String, param2:Point = null) : void{}
      
      private function initBuff() : void{}
      
      override protected function initListener() : void{}
      
      protected function __playerDoAction(param1:LivingEvent) : void{}
      
      override protected function removeListener() : void{}
      
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
      
      public function get body() : GameCharacter{return null;}
      
      public function get player() : Player{return null;}
      
      private function addWing() : void{}
      
      public function checkShowWing() : void{}
      
      private function removeWing() : void{}
      
      public function get weaponMovie() : MovieClip{return null;}
      
      public function set weaponMovie(param1:MovieClip) : void{}
      
      private function checkCurrentMovie(param1:Event) : void{}
      
      public function setWeaponMoiveActionSyc(param1:String) : void{}
      
      override public function die() : void{}
      
      protected function __updateNamePos(param1:Event) : void{}
      
      override public function revive() : void{}
      
      private function reviveCompleteHandler(param1:Event) : void{}
      
      private function insureActRevive(param1:TimerEvent) : void{}
      
      public function clearDebuff() : void{}
      
      override protected function __beginNewTurn(param1:LivingEvent) : void{}
      
      private function __getChat(param1:ChatEvent) : void{}
      
      private function say(param1:String, param2:int) : void{}
      
      override protected function get popPos() : Point{return null;}
      
      override protected function get popDir() : Point{return null;}
      
      private function __getFace(param1:ChatEvent) : void{}
      
      private function showFace(param1:int) : void{}
      
      public function shootPoint() : Point{return null;}
      
      override public function doAction(param1:*) : void{}
      
      override protected function __buffChanged(param1:LivingEvent) : void{}
      
      override public function dispose() : void{}
      
      override protected function __bombed(param1:LivingEvent) : void{}
      
      override public function setMap(param1:Map) : void{}
      
      override public function setProperty(param1:String, param2:String) : void{}
      
      public function set gainEXP(param1:int) : void{}
      
      override public function setActionMapping(param1:String, param2:String) : void{}
      
      override public function getAction(param1:String) : *{return null;}
      
      public function playFlagBattleReviveAction() : void{}
      
      public function clone(param1:int = 0) : GamePlayer{return null;}
   }
}
