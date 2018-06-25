package game.objects{   import com.pickgliss.loader.ModuleLoader;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.command.PlayerAction;   import ddt.data.EquipType;   import ddt.data.goods.ItemTemplateInfo;   import ddt.data.player.SelfInfo;   import ddt.events.CrazyTankSocketEvent;   import ddt.events.LivingEvent;   import ddt.manager.ChatManager;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PetSkillManager;   import ddt.manager.PlayerManager;   import ddt.manager.SharedManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import ddt.utils.Helpers;   import ddt.utils.PositionUtils;   import ddt.view.ExpMovie;   import ddt.view.FaceContainer;   import ddt.view.character.CharactoryFactory;   import ddt.view.character.GameCharacter;   import ddt.view.character.ICharacter;   import ddt.view.character.ShowCharacter;   import ddt.view.chat.ChatData;   import ddt.view.chat.ChatEvent;   import ddt.view.chat.chatBall.ChatBallPlayer;   import ddt.view.common.DailyLeagueLevel;   import ddt.view.common.LevelIcon;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.TimerEvent;   import flash.geom.Point;   import flash.geom.Rectangle;   import flash.utils.Dictionary;   import flash.utils.Timer;   import flash.utils.setTimeout;   import game.actions.GhostMoveAction;   import game.actions.PlayerBeatAction;   import game.actions.PlayerFallingAction;   import game.actions.PlayerWalkAction;   import game.actions.PrepareShootAction;   import game.actions.SelfSkipAction;   import game.actions.ShootBombAction;   import game.actions.SkillActions.ResolveHurtAction;   import game.actions.SkillActions.RevertAction;   import game.actions.WeaponShootAction;   import game.animations.BaseSetCenterAnimation;   import gameCommon.GameControl;   import gameCommon.model.FightBuffInfo;   import gameCommon.model.GameInfo;   import gameCommon.model.Living;   import gameCommon.model.LocalPlayer;   import gameCommon.model.Player;   import gameCommon.model.SceneEffectObj;   import guardCore.GuardCoreManager;   import guardCore.data.GuardCoreInfo;   import horse.HorseManager;   import horse.data.HorseSkillVo;   import newTitle.NewTitleManager;   import newTitle.model.NewTitleModel;   import pet.data.PetSkillTemplateInfo;   import phy.maps.Map;   import road7th.DDTAssetManager;   import road7th.comm.PackageIn;   import road7th.data.DictionaryData;   import road7th.data.StringObject;   import road7th.utils.MovieClipWrapper;   import room.RoomManager;      public class GamePlayer extends GameTurnedLiving   {                   protected var _player:Sprite;            protected var _attackPlayerCite:MovieClip;            private var _levelIcon:LevelIcon;            private var _teamTxt:FilterFrameText;            private var _leagueRank:DailyLeagueLevel;            protected var _consortiaName:FilterFrameText;            private var _facecontainer:FaceContainer;            private var _ballpos:Point;            private var _expView:ExpMovie;            private var _resolveHurtMovie:MovieClipWrapper;            private var _petMovie:GamePetMovie;            private var _currentPetSkill:PetSkillTemplateInfo;            private var _badgeIcon:Bitmap;            private var _newTitle:Bitmap;            private var _ringSkill:MovieClip;            private var _guardCoreEffect:MovieClip;            private var _danderFire:MovieClip;            public var isShootPrepared:Boolean;            public var UsedPetSkill:DictionaryData;            private var _character:ShowCharacter;            private var _body:GameCharacter;            private var _weaponMovie:MovieClip;            private var _currentWeaponMovie:MovieClip;            private var _currentWeaponMovieAction:String = "";            private var _tomb:TombView;            private var _isNeedActRevive:Boolean = false;            private var _reviveTimer:Timer;            private var labelMapping:Dictionary;            public function GamePlayer(player:Player, character:ShowCharacter, movie:GameCharacter = null, templeId:int = 0) { super(null); }
            public function playRingSkill() : void { }
            public function playGuardCoreEffect() : void { }
            public function replacePlayerSource(character:ShowCharacter, movie:GameCharacter) : void { }
            protected function __playPlayerEffect(event:Event) : void { }
            public function get facecontainer() : FaceContainer { return null; }
            public function set facecontainer(value:FaceContainer) : void { }
            override protected function initView() : void { }
            private function creatConsortiaName() : void { }
            public function playPetMovieDebug(actName:String, pt:Point = null) : void { }
            private function initBuff() : void { }
            override protected function initListener() : void { }
            protected function __playerDoAction(event:LivingEvent) : void { }
            override protected function removeListener() : void { }
            override public function get movie() : Sprite { return null; }
            protected function __boxPickHandler(e:LivingEvent) : void { }
            override protected function __applySkill(event:LivingEvent) : void { }
            private function applyRevert(pkg:PackageIn) : void { }
            private function applyResolveHurt(pkg:PackageIn) : void { }
            protected function __addState(event:LivingEvent) : void { }
            protected function __useSkillHandler(event:LivingEvent) : void { }
            protected function __usingItem(event:LivingEvent) : void { }
            protected function __usingSpecialKill(event:LivingEvent) : void { }
            override protected function doUseItemAnimation(skip:Boolean = false) : void { }
            protected function __danderChanged(event:LivingEvent) : void { }
            override protected function __posChanged(event:LivingEvent) : void { }
            protected function __checkCollide(event:LivingEvent) : void { }
            private function __isRedSkullChanged(event:LivingEvent) : void { }
            public function playerMove() : void { }
            override protected function __dirChanged(event:LivingEvent) : void { }
            override protected function __attackingChanged(event:LivingEvent) : void { }
            protected function attackingViewChanged() : void { }
            override protected function __hiddenChanged(event:LivingEvent) : void { }
            override protected function __say(event:LivingEvent) : void { }
            override protected function __playDeadEffect(event:LivingEvent) : void { }
            override protected function __bloodChanged(event:LivingEvent) : void { }
            override protected function __shoot(event:LivingEvent) : void { }
            protected function shootIntervalDegression() : void { }
            override protected function __beat(event:LivingEvent) : void { }
            protected function __usePetSkill(event:LivingEvent) : void { }
            private function __petBeat(event:LivingEvent) : void { }
            private function playPetMovie(actName:String, pt:Point, callBack:Function = null, args:Array = null) : void { }
            public function hidePetMovie() : void { }
            private function updateHp(targets:Array) : void { }
            public function usePetSkill(skill:PetSkillTemplateInfo, callback:Function = null) : void { }
            private function skipSelfTurn() : void { }
            protected function __playerMoveTo(event:LivingEvent) : void { }
            override public function playerMoveTo(params:Array) : void { }
            override protected function __fall(event:LivingEvent) : void { }
            override protected function __jump(event:LivingEvent) : void { }
            private function setSoulPos() : void { }
            public function get character() : ShowCharacter { return null; }
            public function get body() : GameCharacter { return null; }
            public function get player() : Player { return null; }
            private function addWing() : void { }
            public function checkShowWing() : void { }
            private function removeWing() : void { }
            public function get weaponMovie() : MovieClip { return null; }
            public function set weaponMovie(value:MovieClip) : void { }
            private function checkCurrentMovie(e:Event) : void { }
            public function setWeaponMoiveActionSyc(action:String) : void { }
            override public function die() : void { }
            protected function __updateNamePos(event:Event) : void { }
            override public function revive() : void { }
            private function reviveCompleteHandler(event:Event) : void { }
            private function insureActRevive(event:TimerEvent) : void { }
            public function clearDebuff() : void { }
            override protected function __beginNewTurn(event:LivingEvent) : void { }
            private function __getChat(evt:ChatEvent) : void { }
            private function say(msg:String, paopaoType:int) : void { }
            override protected function get popPos() : Point { return null; }
            override protected function get popDir() : Point { return null; }
            private function __getFace(evt:ChatEvent) : void { }
            private function showFace(id:int) : void { }
            public function shootPoint() : Point { return null; }
            override public function doAction(actionType:*) : void { }
            override protected function __buffChanged(event:LivingEvent) : void { }
            override public function dispose() : void { }
            override protected function __bombed(event:LivingEvent) : void { }
            override public function setMap(map:Map) : void { }
            override public function setProperty(property:String, value:String) : void { }
            public function set gainEXP(value:int) : void { }
            override public function setActionMapping(source:String, target:String) : void { }
            override public function getAction(type:String) : * { return null; }
            public function playFlagBattleReviveAction() : void { }
            public function clone(lvingId:int = 0) : GamePlayer { return null; }
   }}