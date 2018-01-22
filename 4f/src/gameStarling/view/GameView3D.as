package gameStarling.view
{
   import bagAndInfo.info.PlayerInfoViewControl;
   import bombKing.BombKingManager;
   import bombKing.event.BombKingEvent;
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieStarling;
   import campbattle.CampBattleManager;
   import catchInsect.CatchInsectManager;
   import christmas.ChristmasCoreManager;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.manager.NoviceDataManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StarlingObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.data.BallInfo;
   import ddt.data.EquipType;
   import ddt.data.FightAchievModel;
   import ddt.data.PropInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.BagEvent;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.GameEvent;
   import ddt.events.LivingEvent;
   import ddt.events.PhyobjEvent;
   import ddt.loader.StartupResourceLoader;
   import ddt.manager.BallManager;
   import ddt.manager.ChatManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.ItemManager;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LogManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PageInterfaceManager;
   import ddt.manager.PathManager;
   import ddt.manager.PetSkillManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.StatisticManager;
   import ddt.states.BaseStateView;
   import ddt.utils.MenoryUtil;
   import ddt.utils.PositionUtils;
   import ddt.view.BackgoundView;
   import ddt.view.PropItemView;
   import demonChiYou.DemonChiYouManager;
   import dragonBones.events.AnimationEvent;
   import drgnBoat.DrgnBoatManager;
   import escort.EscortManager;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.system.ApplicationDomain;
   import flash.ui.Mouse;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import game.GameManager;
   import gameCommon.BuffManager;
   import gameCommon.GameControl;
   import gameCommon.GameMessageTipManager;
   import gameCommon.IGameView;
   import gameCommon.SkillManager;
   import gameCommon.TryAgain;
   import gameCommon.model.Bomb;
   import gameCommon.model.FightBuffInfo;
   import gameCommon.model.GameNeedMovieInfo;
   import gameCommon.model.Living;
   import gameCommon.model.LocalPlayer;
   import gameCommon.model.MissionAgainInfo;
   import gameCommon.model.Player;
   import gameCommon.model.SceneEffectObj;
   import gameCommon.model.SimpleBoss;
   import gameCommon.model.SmallEnemy;
   import gameCommon.model.TurnedLiving;
   import gameCommon.objects.ActivityDungeonNextView;
   import gameCommon.objects.AnimationObject;
   import gameCommon.view.AchieveAnimation;
   import gameCommon.view.EnergyView;
   import gameCommon.view.control.LiveState;
   import gameCommon.view.experience.ExpView;
   import gameStarling.actions.ChangeBallAction;
   import gameStarling.actions.ChangeNpcAction;
   import gameStarling.actions.ChangePlayerAction;
   import gameStarling.actions.GameOverAction;
   import gameStarling.actions.MissionOverAction;
   import gameStarling.actions.PickBoxAction;
   import gameStarling.actions.PrepareShootAction;
   import gameStarling.actions.SceneEffectShootBombAction;
   import gameStarling.actions.ViewEachObjectAction;
   import gameStarling.objects.BombAction3D;
   import gameStarling.objects.GameLiving3D;
   import gameStarling.objects.GameLocalPlayer3D;
   import gameStarling.objects.GamePlayer3D;
   import gameStarling.objects.GameSimpleBoss3D;
   import gameStarling.objects.GameSmallEnemy3D;
   import gameStarling.objects.SimpleBomb3D;
   import gameStarling.objects.SimpleBox3D;
   import gameStarling.objects.SimpleObject3D;
   import hall.GameLoadingManager;
   import org.aswing.KeyboardManager;
   import pet.data.PetInfo;
   import pet.data.PetSkillTemplateInfo;
   import road7th.StarlingMain;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   import road7th.utils.AutoDisappear;
   import road7th.utils.MovieClipWrapper;
   import room.RoomManager;
   import room.model.RoomPlayer;
   import sevenDouble.SevenDoubleManager;
   import starling.display.DisplayObjectContainer;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.display.cell.CellContent3D;
   import starlingPhy.object.PhysicalObj3D;
   
   public class GameView3D extends GameViewBase3D implements IGameView
   {
       
      
      private const ZXC_OFFSET:int = 24;
      
      protected var _msg:String = "";
      
      protected var _tipItems:Dictionary;
      
      protected var _tipLayers:DisplayObjectContainer;
      
      protected var _result:ExpView;
      
      private var _gameLivingArr:Array;
      
      private var _gameLivingIdArr:Array;
      
      private var _objectDic:DictionaryData;
      
      private var _evtArray:Array;
      
      private var _evtFuncArray:Array;
      
      private var _animationArray:Array;
      
      private var _terraces:Dictionary;
      
      private var _firstEnter:Boolean = false;
      
      private var _soundPlayFlag:Boolean;
      
      private var _ignoreSmallEnemy:Boolean;
      
      private var _boxArr:Array;
      
      private var finished:int = 0;
      
      private var total:int = 0;
      
      private var props:Array;
      
      private var _logTimer:Timer;
      
      private var _missionAgain:MissionAgainInfo;
      
      protected var _expView:ExpView;
      
      protected var _expGameBg:Image;
      
      private var _isPVPover:Boolean;
      
      public function GameView3D(){super();}
      
      private function loadResource() : void{}
      
      private function __loaderComplete(param1:LoaderEvent) : void{}
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void{}
      
      private function addTerraceHander(param1:GameEvent) : void{}
      
      private function addTerrce(param1:int, param2:int, param3:int) : void{}
      
      private function delTerraceHander(param1:GameEvent) : void{}
      
      private function dioposeTerraces() : void{}
      
      private function retrunPlayer(param1:int) : GamePlayer3D{return null;}
      
      private function petResLoad(param1:PetInfo) : void{}
      
      protected function __pickBox(param1:CrazyTankSocketEvent) : void{}
      
      private function guideTip() : Boolean{return false;}
      
      private function isNewHand() : Boolean{return false;}
      
      private function __gameSysMessage(param1:CrazyTankSocketEvent) : void{}
      
      private function __fightAchievement(param1:CrazyTankSocketEvent) : void{}
      
      private function __windChanged(param1:GameEvent) : void{}
      
      override public function getType() : String{return null;}
      
      override public function leaving(param1:BaseStateView) : void{}
      
      override public function dispose() : void{}
      
      private function __showTargetPlayer(param1:CrazyTankSocketEvent) : void{}
      
      private function __skillLock(param1:CrazyTankSocketEvent) : void{}
      
      override public function addedToStage() : void{}
      
      override public function getBackType() : String{return null;}
      
      override protected function __playerChange(param1:CrazyTankSocketEvent) : void{}
      
      private function changePlayerTurn(param1:int, param2:CrazyTankSocketEvent) : void{}
      
      private function setTargetIconShow(param1:Boolean) : void{}
      
      private function __playMovie(param1:CrazyTankSocketEvent) : void{}
      
      private function __livingTurnRotation(param1:CrazyTankSocketEvent) : void{}
      
      public function addliving(param1:CrazyTankSocketEvent) : void{}
      
      public function addGameLivingToMap(param1:Array) : void{}
      
      protected function __addAnimation(param1:CrazyTankSocketEvent) : void{}
      
      public function deleteAnimation(param1:int) : void{}
      
      public function hideView(param1:Boolean) : void{}
      
      private function __addTipLayer(param1:CrazyTankSocketEvent) : void{}
      
      private function addTipSprite(param1:Sprite) : void{}
      
      private function hideAllOther() : void{}
      
      public function addMapThing(param1:CrazyTankSocketEvent) : void{}
      
      private function addBox(param1:SimpleObject3D) : void{}
      
      private function addEffect(param1:SimpleObject3D, param2:int = 0, param3:int = 0) : void{}
      
      public function updatePhysicObject(param1:CrazyTankSocketEvent) : void{}
      
      private function __applySkill(param1:CrazyTankSocketEvent) : void{}
      
      private function __removeSkill(param1:CrazyTankSocketEvent) : void{}
      
      private function __removePhysicObject(param1:CrazyTankSocketEvent) : void{}
      
      private function __focusOnObject(param1:CrazyTankSocketEvent) : void{}
      
      private function __barrierInfoHandler(param1:CrazyTankSocketEvent) : void{}
      
      private function __livingMoveto(param1:CrazyTankSocketEvent) : void{}
      
      public function livingFalling(param1:CrazyTankSocketEvent) : void{}
      
      private function __livingJump(param1:CrazyTankSocketEvent) : void{}
      
      private function __livingBeat(param1:CrazyTankSocketEvent) : void{}
      
      private function __livingSay(param1:CrazyTankSocketEvent) : void{}
      
      private function __livingRangeAttacking(param1:CrazyTankSocketEvent) : void{}
      
      private function __livingDirChanged(param1:CrazyTankSocketEvent) : void{}
      
      private function __removePlayer(param1:DictionaryEvent) : void{}
      
      private function __beginShoot(param1:CrazyTankSocketEvent) : void{}
      
      protected function __shoot(param1:CrazyTankSocketEvent) : void{}
      
      private function setBombKingInfo(param1:int, param2:int) : void{}
      
      private function __suicide(param1:CrazyTankSocketEvent) : void{}
      
      private function __changeBall(param1:CrazyTankSocketEvent) : void{}
      
      private function __playerUsingItem(param1:CrazyTankSocketEvent) : void{}
      
      private function __updateBuff(param1:CrazyTankSocketEvent) : void{}
      
      private function __updatePetBuff(param1:CrazyTankSocketEvent) : void{}
      
      private function __startMove(param1:CrazyTankSocketEvent) : void{}
      
      private function playerMove(param1:PackageIn, param2:Player) : void{}
      
      private function __onLivingBoltmove(param1:CrazyTankSocketEvent) : void{}
      
      public function playerBlood(param1:CrazyTankSocketEvent) : void{}
      
      private function __changWind(param1:CrazyTankSocketEvent) : void{}
      
      private function __playerNoNole(param1:CrazyTankSocketEvent) : void{}
      
      private function __onChangePlayerTarget(param1:CrazyTankSocketEvent) : void{}
      
      public function objectSetProperty(param1:CrazyTankSocketEvent) : void{}
      
      private function __usePetSkill(param1:CrazyTankSocketEvent) : void{}
      
      private function __petBeat(param1:CrazyTankSocketEvent) : void{}
      
      private function __playerHide(param1:CrazyTankSocketEvent) : void{}
      
      private function __gameOver(param1:CrazyTankSocketEvent) : void{}
      
      public function logTimeHandler(param1:TimerEvent = null) : void{}
      
      private function __missionOver(param1:CrazyTankSocketEvent) : void{}
      
      override protected function gameOver() : void{}
      
      private function showTryAgain() : void{}
      
      private function __tryAgainTimeOut(param1:GameEvent) : void{}
      
      private function showExpView() : void{}
      
      private function __expShowed(param1:GameEvent) : void{}
      
      private function __giveup(param1:GameEvent) : void{}
      
      private function __tryAgain(param1:GameEvent) : void{}
      
      private function __dander(param1:CrazyTankSocketEvent) : void{}
      
      private function __reduceDander(param1:CrazyTankSocketEvent) : void{}
      
      private function __changeState(param1:CrazyTankSocketEvent) : void{}
      
      private function __selfObtainItem(param1:BagEvent) : void{}
      
      private function __getTempItem(param1:BagEvent) : void{}
      
      private function __forstPlayer(param1:CrazyTankSocketEvent) : void{}
      
      private function __changeShootCount(param1:CrazyTankSocketEvent) : void{}
      
      private function __playSound(param1:CrazyTankSocketEvent) : void{}
      
      private function __controlBGM(param1:CrazyTankSocketEvent) : void{}
      
      private function __forbidDragFocus(param1:CrazyTankSocketEvent) : void{}
      
      override protected function defaultForbidDragFocus() : void{}
      
      private function __topLayer(param1:CrazyTankSocketEvent) : void{}
      
      private function __loadResource(param1:CrazyTankSocketEvent) : void{}
      
      public function livingShowBlood(param1:CrazyTankSocketEvent) : void{}
      
      public function livingActionMapping(param1:CrazyTankSocketEvent) : void{}
      
      private function __livingSmallColorChange(param1:CrazyTankSocketEvent) : void{}
      
      private function __revivePlayer(param1:CrazyTankSocketEvent) : void{}
      
      public function revivePlayerChangePlayer(param1:int) : void{}
      
      private function __gameTrusteeship(param1:CrazyTankSocketEvent) : void{}
      
      private function __fightStatusChange(param1:CrazyTankSocketEvent) : void{}
      
      private function __skipNextHandler(param1:CrazyTankSocketEvent) : void{}
      
      private function __clearDebuff(param1:CrazyTankSocketEvent) : void{}
      
      private function delayFocusSimpleBoss() : void{}
      
      private function getGameLivingByID(param1:int) : PhysicalObj3D{return null;}
      
      private function addStageCurtain(param1:SimpleObject3D) : void{}
      
      private function addSceneEffects(param1:CrazyTankSocketEvent) : void{}
   }
}
