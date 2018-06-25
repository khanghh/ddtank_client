package gameStarling.view{   import bagAndInfo.info.PlayerInfoViewControl;   import bombKing.BombKingManager;   import bombKing.event.BombKingEvent;   import bones.BoneMovieFactory;   import bones.display.BoneMovieStarling;   import campbattle.CampBattleManager;   import catchInsect.CatchInsectManager;   import christmas.ChristmasCoreManager;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.manager.CacheSysManager;   import com.pickgliss.manager.NoviceDataManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import com.pickgliss.utils.StarlingObjectUtils;   import consortion.ConsortionModelManager;   import ddt.data.BallInfo;   import ddt.data.EquipType;   import ddt.data.FightAchievModel;   import ddt.data.PropInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.events.BagEvent;   import ddt.events.CrazyTankSocketEvent;   import ddt.events.GameEvent;   import ddt.events.LivingEvent;   import ddt.events.PhyobjEvent;   import ddt.loader.StartupResourceLoader;   import ddt.manager.BallManager;   import ddt.manager.ChatManager;   import ddt.manager.GameInSocketOut;   import ddt.manager.ItemManager;   import ddt.manager.KeyboardShortcutsManager;   import ddt.manager.LanguageMgr;   import ddt.manager.LogManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PageInterfaceManager;   import ddt.manager.PathManager;   import ddt.manager.PetSkillManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import ddt.manager.StatisticManager;   import ddt.states.BaseStateView;   import ddt.utils.MenoryUtil;   import ddt.utils.PositionUtils;   import ddt.view.BackgoundView;   import ddt.view.PropItemView;   import demonChiYou.DemonChiYouManager;   import dragonBones.events.AnimationEvent;   import drgnBoat.DrgnBoatManager;   import escort.EscortManager;   import flash.events.TimerEvent;   import flash.geom.Point;   import flash.net.URLLoader;   import flash.net.URLRequest;   import flash.net.URLVariables;   import flash.system.ApplicationDomain;   import flash.ui.Mouse;   import flash.utils.Dictionary;   import flash.utils.Timer;   import flash.utils.getDefinitionByName;   import flash.utils.getTimer;   import flash.utils.setTimeout;   import game.GameManager;   import gameCommon.BuffManager;   import gameCommon.GameControl;   import gameCommon.GameMessageTipManager;   import gameCommon.IGameView;   import gameCommon.SkillManager;   import gameCommon.TryAgain;   import gameCommon.model.Bomb;   import gameCommon.model.FightBuffInfo;   import gameCommon.model.GameNeedMovieInfo;   import gameCommon.model.Living;   import gameCommon.model.LocalPlayer;   import gameCommon.model.MissionAgainInfo;   import gameCommon.model.Player;   import gameCommon.model.SceneEffectObj;   import gameCommon.model.SimpleBoss;   import gameCommon.model.SmallEnemy;   import gameCommon.model.TurnedLiving;   import gameCommon.objects.ActivityDungeonNextView;   import gameCommon.objects.AnimationObject;   import gameCommon.view.AchieveAnimation;   import gameCommon.view.EnergyView;   import gameCommon.view.control.LiveState;   import gameCommon.view.experience.ExpView;   import gameStarling.actions.ChangeBallAction;   import gameStarling.actions.ChangeNpcAction;   import gameStarling.actions.ChangePlayerAction;   import gameStarling.actions.GameOverAction;   import gameStarling.actions.MissionOverAction;   import gameStarling.actions.PickBoxAction;   import gameStarling.actions.PrepareShootAction;   import gameStarling.actions.SceneEffectShootBombAction;   import gameStarling.actions.ViewEachObjectAction;   import gameStarling.objects.BombAction3D;   import gameStarling.objects.GameLiving3D;   import gameStarling.objects.GameLocalPlayer3D;   import gameStarling.objects.GamePlayer3D;   import gameStarling.objects.GameSimpleBoss3D;   import gameStarling.objects.GameSmallEnemy3D;   import gameStarling.objects.SimpleBomb3D;   import gameStarling.objects.SimpleBox3D;   import gameStarling.objects.SimpleObject3D;   import hall.GameLoadingManager;   import org.aswing.KeyboardManager;   import pet.data.PetInfo;   import pet.data.PetSkillTemplateInfo;   import road7th.StarlingMain;   import road7th.comm.PackageIn;   import road7th.data.DictionaryData;   import road7th.data.DictionaryEvent;   import road7th.utils.AutoDisappear;   import road7th.utils.MovieClipWrapper;   import room.RoomManager;   import room.model.RoomPlayer;   import sevenDouble.SevenDoubleManager;   import starling.display.DisplayObjectContainer;   import starling.display.Image;   import starling.display.Sprite;   import starling.display.cell.CellContent3D;   import starlingPhy.object.PhysicalObj3D;      public class GameView3D extends GameViewBase3D implements IGameView   {                   private const ZXC_OFFSET:int = 24;            protected var _msg:String = "";            protected var _tipItems:Dictionary;            protected var _tipLayers:DisplayObjectContainer;            protected var _result:ExpView;            private var _gameLivingArr:Array;            private var _gameLivingIdArr:Array;            private var _objectDic:DictionaryData;            private var _evtArray:Array;            private var _evtFuncArray:Array;            private var _animationArray:Array;            private var _terraces:Dictionary;            private var _firstEnter:Boolean = false;            private var _soundPlayFlag:Boolean;            private var _ignoreSmallEnemy:Boolean;            private var _boxArr:Array;            private var finished:int = 0;            private var total:int = 0;            private var props:Array;            private var _logTimer:Timer;            private var _missionAgain:MissionAgainInfo;            protected var _expView:ExpView;            protected var _expGameBg:Image;            private var _isPVPover:Boolean;            public function GameView3D() { super(); }
            private function loadResource() : void { }
            private function __loaderComplete(event:LoaderEvent) : void { }
            override public function enter(prev:BaseStateView, data:Object = null) : void { }
            private function addTerraceHander(e:GameEvent) : void { }
            private function addTerrce($x:int, $y:int, $livingID:int) : void { }
            private function delTerraceHander(e:GameEvent) : void { }
            private function dioposeTerraces() : void { }
            private function retrunPlayer(id:int) : GamePlayer3D { return null; }
            private function petResLoad(currentPet:PetInfo) : void { }
            protected function __pickBox(event:CrazyTankSocketEvent) : void { }
            private function guideTip() : Boolean { return false; }
            private function isNewHand() : Boolean { return false; }
            private function __gameSysMessage(event:CrazyTankSocketEvent) : void { }
            private function __fightAchievement(event:CrazyTankSocketEvent) : void { }
            private function __windChanged(e:GameEvent) : void { }
            override public function getType() : String { return null; }
            override public function leaving(next:BaseStateView) : void { }
            override public function dispose() : void { }
            private function __showTargetPlayer(event:CrazyTankSocketEvent) : void { }
            private function __skillLock(e:CrazyTankSocketEvent) : void { }
            override public function addedToStage() : void { }
            override public function getBackType() : String { return null; }
            override protected function __playerChange(event:CrazyTankSocketEvent) : void { }
            private function changePlayerTurn(id:int, event:CrazyTankSocketEvent) : void { }
            private function setTargetIconShow(flag:Boolean) : void { }
            private function __playMovie(event:CrazyTankSocketEvent) : void { }
            private function __livingTurnRotation(event:CrazyTankSocketEvent) : void { }
            public function addliving(event:CrazyTankSocketEvent) : void { }
            public function addGameLivingToMap(params:Array) : void { }
            protected function __addAnimation(event:CrazyTankSocketEvent) : void { }
            public function deleteAnimation(type:int) : void { }
            public function hideView(flag:Boolean) : void { }
            private function __addTipLayer(evt:CrazyTankSocketEvent) : void { }
            private function addTipSprite(obj:Sprite) : void { }
            private function hideAllOther() : void { }
            public function addMapThing(evt:CrazyTankSocketEvent) : void { }
            private function addBox(obj:SimpleObject3D) : void { }
            private function addEffect(obj:SimpleObject3D, containerID:int = 0, layer:int = 0) : void { }
            public function updatePhysicObject(evt:CrazyTankSocketEvent) : void { }
            private function __applySkill(evt:CrazyTankSocketEvent) : void { }
            private function __removeSkill(evt:CrazyTankSocketEvent) : void { }
            private function __removePhysicObject(event:CrazyTankSocketEvent) : void { }
            private function __focusOnObject(event:CrazyTankSocketEvent) : void { }
            private function __barrierInfoHandler(evt:CrazyTankSocketEvent) : void { }
            private function __livingMoveto(event:CrazyTankSocketEvent) : void { }
            public function livingFalling(event:CrazyTankSocketEvent) : void { }
            private function __livingJump(event:CrazyTankSocketEvent) : void { }
            private function __livingBeat(event:CrazyTankSocketEvent) : void { }
            private function __livingSay(event:CrazyTankSocketEvent) : void { }
            private function __livingRangeAttacking(e:CrazyTankSocketEvent) : void { }
            private function __livingDirChanged(event:CrazyTankSocketEvent) : void { }
            private function __removePlayer(event:DictionaryEvent) : void { }
            private function __beginShoot(event:CrazyTankSocketEvent) : void { }
            protected function __shoot(event:CrazyTankSocketEvent) : void { }
            private function setBombKingInfo(VX:int, VY:int) : void { }
            private function __suicide(event:CrazyTankSocketEvent) : void { }
            private function __changeBall(event:CrazyTankSocketEvent) : void { }
            private function __playerUsingItem(event:CrazyTankSocketEvent) : void { }
            private function __updateBuff(evt:CrazyTankSocketEvent) : void { }
            public function boxPhysicalPos(evt:CrazyTankSocketEvent) : void { }
            private function __updatePetBuff(evt:CrazyTankSocketEvent) : void { }
            private function __startMove(event:CrazyTankSocketEvent) : void { }
            private function playerMove(pkg:PackageIn, info:Player) : void { }
            private function __onLivingBoltmove(event:CrazyTankSocketEvent) : void { }
            public function playerBlood(event:CrazyTankSocketEvent) : void { }
            private function __changWind(event:CrazyTankSocketEvent) : void { }
            private function __playerNoNole(evt:CrazyTankSocketEvent) : void { }
            private function __onChangePlayerTarget(evt:CrazyTankSocketEvent) : void { }
            public function objectSetProperty(evt:CrazyTankSocketEvent) : void { }
            private function __usePetSkill(event:CrazyTankSocketEvent) : void { }
            private function __petBeat(event:CrazyTankSocketEvent) : void { }
            private function __playerHide(event:CrazyTankSocketEvent) : void { }
            private function __gameOver(event:CrazyTankSocketEvent) : void { }
            public function logTimeHandler(event:TimerEvent = null) : void { }
            private function __missionOver(event:CrazyTankSocketEvent) : void { }
            override protected function gameOver() : void { }
            private function showTryAgain() : void { }
            private function __tryAgainTimeOut(event:GameEvent) : void { }
            private function showExpView() : void { }
            private function __expShowed(event:GameEvent) : void { }
            private function __giveup(event:GameEvent) : void { }
            private function __tryAgain(event:GameEvent) : void { }
            private function __dander(event:CrazyTankSocketEvent) : void { }
            private function __reduceDander(event:CrazyTankSocketEvent) : void { }
            private function __changeState(evt:CrazyTankSocketEvent) : void { }
            private function __selfObtainItem(event:BagEvent) : void { }
            private function __getTempItem(evt:BagEvent) : void { }
            private function __forstPlayer(event:CrazyTankSocketEvent) : void { }
            private function __changeShootCount(event:CrazyTankSocketEvent) : void { }
            private function __playSound(event:CrazyTankSocketEvent) : void { }
            private function __controlBGM(evt:CrazyTankSocketEvent) : void { }
            private function __forbidDragFocus(evt:CrazyTankSocketEvent) : void { }
            override protected function defaultForbidDragFocus() : void { }
            private function __topLayer(evt:CrazyTankSocketEvent) : void { }
            private function __loadResource(event:CrazyTankSocketEvent) : void { }
            public function livingShowBlood(event:CrazyTankSocketEvent) : void { }
            public function livingActionMapping(event:CrazyTankSocketEvent) : void { }
            private function __livingSmallColorChange(event:CrazyTankSocketEvent) : void { }
            private function __revivePlayer(event:CrazyTankSocketEvent) : void { }
            public function revivePlayerChangePlayer(id:int) : void { }
            private function __gameTrusteeship(event:CrazyTankSocketEvent) : void { }
            private function __fightStatusChange(event:CrazyTankSocketEvent) : void { }
            private function __skipNextHandler(event:CrazyTankSocketEvent) : void { }
            private function __clearDebuff(event:CrazyTankSocketEvent) : void { }
            private function delayFocusSimpleBoss() : void { }
            private function getGameLivingByID(id:int) : PhysicalObj3D { return null; }
            private function addStageCurtain(obj:SimpleObject3D) : void { }
            private function addSceneEffects(event:CrazyTankSocketEvent) : void { }
   }}