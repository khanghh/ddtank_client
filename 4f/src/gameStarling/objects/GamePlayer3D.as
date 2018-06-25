package gameStarling.objects{   import bones.BoneMovieFactory;   import bones.display.BoneMovieStarling;   import com.pickgliss.loader.ModuleLoader;   import com.pickgliss.utils.ObjectUtils;   import com.pickgliss.utils.StarlingObjectUtils;   import ddt.command.PlayerAction;   import ddt.data.EquipType;   import ddt.data.goods.ItemTemplateInfo;   import ddt.data.player.SelfInfo;   import ddt.events.CrazyTankSocketEvent;   import ddt.events.LivingEvent;   import ddt.manager.ChatManager;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PetSkillManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import ddt.utils.Helpers;   import ddt.view.character.ShowCharacter;   import ddt.view.characterStarling.GameCharacter3D;   import ddt.view.chat.ChatData;   import ddt.view.chat.ChatEvent;   import ddt.view.common.DailyLeagueLevel;   import flash.events.TimerEvent;   import flash.geom.Point;   import flash.geom.Rectangle;   import flash.utils.Dictionary;   import flash.utils.Timer;   import flash.utils.setTimeout;   import gameCommon.GameControl;   import gameCommon.model.FightBuffInfo;   import gameCommon.model.GameInfo;   import gameCommon.model.Living;   import gameCommon.model.LocalPlayer;   import gameCommon.model.Player;   import gameCommon.model.SceneEffectObj;   import gameStarling.actions.GhostMoveAction;   import gameStarling.actions.PlayerBeatAction;   import gameStarling.actions.PlayerFallingAction;   import gameStarling.actions.PlayerWalkAction;   import gameStarling.actions.PrepareShootAction;   import gameStarling.actions.SelfSkipAction;   import gameStarling.actions.ShootBombAction;   import gameStarling.actions.SkillActions.ResolveHurtAction;   import gameStarling.actions.SkillActions.RevertAction;   import gameStarling.animations.BaseSetCenterAnimation;   import gameStarling.chat.ChatBallPlayer3D;   import gameStarling.view.ExpMovie3D;   import gameStarling.view.FaceContainer3D;   import gameStarling.view.GameView3D;   import horse.HorseManager;   import horse.data.HorseSkillVo;   import newTitle.NewTitleManager;   import newTitle.model.NewTitleModel;   import pet.data.PetSkillTemplateInfo;   import road7th.StarlingMain;   import road7th.comm.PackageIn;   import road7th.data.DictionaryData;   import road7th.data.StringObject;   import road7th.utils.BoneMovieWrapper;   import road7th.utils.MovieClipWrapper;   import room.RoomManager;   import starling.display.Image;   import starling.display.Sprite;   import starling.display.cell.CellContent3D;   import starling.events.Event;   import starlingPhy.maps.Map3D;   import starlingui.core.text.TextLabel;      public class GamePlayer3D extends GameTurnedLiving3D   {                   protected var _player:Sprite;            protected var _attackPlayerCite:BoneMovieStarling;            private var _levelIcon:Image;            private var _leagueRank:DailyLeagueLevel;            protected var _consortiaName:TextLabel;            protected var _teamTxt:TextLabel;            private var _facecontainer:FaceContainer3D;            private var _ballpos:Point;            private var _expView:ExpMovie3D;            private var _resolveHurtMovie:MovieClipWrapper;            private var _petMovie:GamePetMovie3D;            private var _currentPetSkill:PetSkillTemplateInfo;            private var _badgeIcon:Image;            private var _newTitle:Image;            private var _ringSkill:BoneMovieWrapper;            private var _guardCoreEffect:BoneMovieWrapper;            private var _danderFire:BoneMovieStarling;            public var isShootPrepared:Boolean;            public var UsedPetSkill:DictionaryData;            private var _character:ShowCharacter;            private var _body:GameCharacter3D;            private var _weaponMovie:BoneMovieWrapper;            private var _currentWeaponMovieAction:String = "";            private var _tomb:TombView3D;            private var _isNeedActRevive:Boolean = false;            private var _reviveTimer:Timer;            private var labelMapping:Dictionary;            public function GamePlayer3D(player:Player, character:ShowCharacter, movie:GameCharacter3D = null, templeId:int = 0) { super(null); }
            public function playRingSkill() : void { }
            public function playGuardCoreEffect() : void { }
            public function replacePlayerSource(character:ShowCharacter, movie:GameCharacter3D) : void { }
            protected function __playPlayerEffect(event:Event) : void { }
            public function get facecontainer() : FaceContainer3D { return null; }
            override protected function initView() : void { }
            private function updatePlayerTitle() : void { }
            private function updateNewTitlePos() : void { }
            private function initBuff() : void { }
            override protected function initListener() : void { }
            protected function __playerDoAction(event:LivingEvent) : void { }
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
            public function get body() : GameCharacter3D { return null; }
            public function get player() : Player { return null; }
            public function get weaponMovie() : BoneMovieWrapper { return null; }
            public function set weaponMovie(value:BoneMovieWrapper) : void { }
            private function creatWeaponShotAction(boneMovie:BoneMovieWrapper, arge:Array = null) : void { }
            private function checkCurrentMovie(e:Event) : void { }
            public function setWeaponMoiveActionSyc(action:String) : void { }
            override public function die() : void { }
            protected function __updateNamePos(event:Event) : void { }
            override public function revive() : void { }
            private function reviveCompleteHandler() : void { }
            private function insureActRevive(event:TimerEvent) : void { }
            public function clearDebuff() : void { }
            override protected function __beginNewTurn(event:LivingEvent) : void { }
            private function __getChat(evt:ChatEvent) : void { }
            public function say(msg:String, paopaoType:int) : void { }
            override protected function get popPos() : Point { return null; }
            override protected function get popDir() : Point { return null; }
            private function __getFace(evt:ChatEvent) : void { }
            public function showFace(id:int) : void { }
            public function shootPoint() : Point { return null; }
            public function getPlayerMapPos() : Point { return null; }
            override public function doAction(actionType:*, callback:Function = null, args:Array = null) : void { }
            override protected function __buffChanged(event:LivingEvent) : void { }
            override public function dispose() : void { }
            override protected function __bombed(event:LivingEvent) : void { }
            override public function setMap(map:Map3D) : void { }
            override public function setProperty(property:String, value:String) : void { }
            public function set gainEXP(value:int) : void { }
            override public function setActionMapping(source:String, target:String) : void { }
            override public function getAction(type:String) : * { return null; }
   }}