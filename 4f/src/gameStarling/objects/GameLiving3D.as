package gameStarling.objects
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieStarling;
   import bones.game.ActionMovieBone;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StarlingObjectUtils;
   import ddt.events.LivingEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.chat.chatBall.ChatBallBase;
   import dragonBones.events.AnimationEvent;
   import flash.display.Bitmap;
import flash.events.Event;
import flash.geom.Point;
   import flash.geom.Rectangle;
   import gameCommon.BloodNumberCreater;
   import gameCommon.GameControl;
   import gameCommon.actions.BaseAction;
   import gameCommon.event.LivingCommandEvent;
   import gameCommon.model.GameInfo;
   import gameCommon.model.Living;
   import gameCommon.model.Player;
   import gameCommon.view.smallMap.SmallLiving;
   import gameCommon.view.smallMap.SmallPlayer;
   import gameStarling.actions.LivingDeadEffectAction;
   import gameStarling.actions.LivingFallingAction;
   import gameStarling.actions.LivingJumpAction;
   import gameStarling.actions.LivingMoveAction;
   import gameStarling.actions.LivingTurnAction;
   import gameStarling.actions.PlayerFallingAction;
   import gameStarling.actions.PlayerWalkAction;
   import gameStarling.animations.ShockMapAnimation;
   import gameStarling.chat.ChatBallPlayer3D;
   import gameStarling.view.AutoPropEffect3D;
   import gameStarling.view.EffectIconContainer3D;
   import gameStarling.view.buff.FightBuffBar3D;
   import gameStarling.view.buff.SkillBuffBar3D;
   import gameStarling.view.effects.ShootPercentView3D;
   import gameStarling.view.effects.ShowEffect3D;
   import gameStarling.view.map.MapView3D;
   import phy.object.SmallObject;
   import road.game.resource.ActionMovieEvent;
   import road7th.StarlingMain;
   import road7th.data.DictionaryData;
   import road7th.data.StringObject;
   import road7th.utils.AutoDisappearStarling;
   import road7th.utils.BoneMovieWrapper;
   import room.RoomManager;
   import starling.display.DisplayObject;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.display.cell.CellContent3D;
   import starling.events.Event;
   import starlingPhy.object.PhysicalObj3D;
   import starlingui.core.text.TextLabel;
   
   public class GameLiving3D extends PhysicalObj3D
   {
      
      protected static var SHOCK_EVENT:String = "shockEvent";
      
      protected static var SHOCK_EVENT2:String = "shockEvent2";
      
      protected static var SHIELD:String = "shield";
      
      protected static var BOMB_EVENT:String = "bombEvent";
      
      public static var SHOOT_PREPARED:String = "shootPrepared";
      
      protected static var RENEW:String = "renew";
      
      protected static var NEED_FOCUS:String = "focus";
      
      protected static var PLAY_EFFECT:String = "playeffect";
      
      protected static var PLAYER_EFFECT:String = "effect";
      
      protected static var ATTACK_COMPLETE_FOCUS:String = "attackCompleteFocus";
      
      public static const stepY:int = 7;
      
      public static const npcStepX:int = 1;
      
      public static const npcStepY:int = 3;
       
      
      protected var _info:Living;
      
      protected var _actionMovie:Sprite;
      
      protected var _chatballview:ChatBallBase;
      
      protected var _smallView:SmallLiving;
      
      protected var speedMult:int = 1;
      
      protected var _nickName:TextLabel;
      
      protected var _targetBlood:int;
      
      protected var targetAttackEffect:int;
      
      protected var _originalHeight:Number;
      
      protected var _originalWidth:Number;
      
      public var bodyWidth:Number;
      
      public var bodyHeight:Number;
      
      public var isExist:Boolean = true;
      
      protected var _turns:int;
      
      private var _offsetX:Number = 0;
      
      private var _offsetY:Number = 0;
      
      private var _speedX:Number = 3;
      
      private var _speedY:Number = 7;
      
      protected var _bloodStripBg:Image;
      
      protected var _HPStrip:Image;
      
      protected var _bloodWidth:int;
      
      protected var _buffBar:FightBuffBar3D;
      
      protected var _skillBuffBar:SkillBuffBar3D;
      
      private var _fightPower:TextLabel;
      
      private var _buffEffect:DictionaryData;
      
      protected var _girlAttest:Image;
      
      private var _targetIcon:BoneMovieStarling;
      
      private var _bodyLoader:DisplayLoader;
      
      protected var counter:int = 1;
      
      protected var ap:Number = 0;
      
      private var _effectIconContainer:EffectIconContainer3D;
      
      protected var effectForzen:BoneMovieStarling;
      
      private var solidIceEffect:BoneMovieStarling;
      
      private var _noRemoveEffect:Array;
      
      protected var _isDie:Boolean = false;
      
      protected var _effRect:Rectangle;
      
      private var _attackEffectPlayer:PhysicalObj3D;
      
      private var _attackEffectPlaying:Boolean = false;
      
      protected var _attackEffectPos:Point;
      
      protected var _moviePool:Object;
      
      private var _hiddenByServer:Boolean;
      
      protected var _propArray:Array;
      
      private var _onSmallMap:Boolean = true;
      
      private var _actionList:Array;
      
      public function GameLiving3D(param1:Living){super(null);}
      
      public function get stepX() : int{return 0;}
      
      public function get stepY() : int{return 0;}
      
      override public function get x() : Number{return 0;}
      
      override public function get y() : Number{return 0;}
      
      override public function get layer() : int{return 0;}
      
      public function get info() : Living{return null;}
      
      public function get map() : MapView3D{return null;}
      
      public function addTartgetIcon() : void{}
      
      public function deleteTargetIcon() : void{}
      
      public function setFightPower(param1:int) : void{}
      
      public function set fightPowerVisible(param1:Boolean) : void{}
      
      protected function initView() : void{}
      
      private function creatAttestBtn() : void{}
      
      protected function initInfoChange() : void{}
      
      protected function initSmallMapObject() : void{}
      
      protected function initEffectIcon() : void{}
      
      protected function initFreezonRect() : void{}
      
      protected function initListener() : void{}
      
      protected function removeListener() : void{}
      
      protected function movieActionEvent(param1:BoneMovieWrapper, param2:Array = null) : void{}
      
      protected function movieEffectEvent(param1:BoneMovieWrapper, param2:Array = null) : void{}
      
      protected function movieSkillEvent(param1:BoneMovieWrapper, param2:Array = null) : void{}
      
      protected function renew() : void{}
      
      protected function shockMap(param1:int) : void{}
      
      protected function shockMap2() : void{}
      
      protected function showDefence() : void{}
      
      private function attackCompleteFocus(param1:Object) : void{}
      
      protected function startBlank() : void{}
      
      protected function __addToState(param1:starling.events.Event) : void{}
      
      protected function __removeContinuousEffect(param1:LivingEvent) : void{}
      
      protected function __playContinuousEffect(param1:LivingEvent) : void{}
      
      protected function __buffChanged(param1:LivingEvent) : void{}
      
      protected function __applySkill(param1:LivingEvent) : void{}
      
      protected function __playSkillMovie(param1:LivingEvent) : void{}
      
      protected function __bombed(param1:LivingEvent) : void{}
      
      protected function drawBlank(param1:starling.events.Event) : void{}
      
      public function get EffectIcon() : EffectIconContainer3D{return null;}
      
      protected function __sizeChangeHandler(param1:starling.events.Event) : void{}
      
      protected function __changeState(param1:LivingEvent) : void{}
      
      protected function initMovie() : void{}
      
      private function loadBodyBitmap() : void{}
      
      private function __onBodyLoaderComplete(param1:LoaderEvent) : void{}
      
      public function replaceMovie() : void{}
      
      protected function initChatball() : void{}
      
      protected function __startMoving(param1:LivingEvent) : void{}
      
      protected function __say(param1:LivingEvent) : void{}
      
      protected function fitChatBallPos() : void{}
      
      protected function get popPos() : Point{return null;}
      
      protected function get popDir() : Point{return null;}
      
      protected function __beat(param1:LivingEvent) : void{}
      
      protected function updateTargetsBlood(param1:Array) : void{}
      
      protected function __beginNewTurn(param1:LivingEvent) : void{}
      
      protected function __playMovie(param1:LivingEvent) : void{}
      
      protected function __turnRotation(param1:LivingEvent) : void{}
      
      protected function __bloodChanged(param1:LivingEvent) : void{}
      
      protected function __maxHpChanged(param1:LivingEvent) : void{}
      
      protected function updateBloodStrip() : void{}
      
      private function offset(param1:int = 30) : int{return 0;}
      
      protected function __die(param1:LivingEvent) : void{}
      
      override public function die() : void{}
      
      public function revive() : void{}
      
      protected function __dirChanged(param1:LivingEvent) : void{}
      
      protected function __forzenChanged(param1:LivingEvent) : void{}
      
      protected function __lockStateChanged(param1:LivingEvent) : void{}
      
      protected function _solidIceStateChanged(param1:LivingEvent) : void{}
      
      protected function _targetStealthStateChanged(param1:LivingEvent) : void{}
      
      protected function _enableSpellSkill(param1:LivingEvent) : void{}
      
      protected function _addSkillBuffBar_Handler(param1:LivingEvent) : void{}
      
      public function showIcon(param1:int, param2:Boolean = true) : void{}
      
      protected function __hiddenChanged(param1:LivingEvent) : void{}
      
      protected function __posChanged(param1:LivingEvent) : void{}
      
      protected function __jump(param1:LivingEvent) : void{}
      
      protected function __moveTo(param1:LivingEvent) : void{}
      
      public function canMoveDirection(param1:Number) : Boolean{return false;}
      
      public function canStand(param1:int, param2:int) : Boolean{return false;}
      
      public function getNextWalkPoint(param1:int) : Point{return null;}
      
      protected function __playerEffect(param1:ActionMovieEvent) : void{}
      
      public function needFocus(param1:int = 0, param2:int = 0, param3:Object = null) : void{}
      
      protected function __shoot(param1:LivingEvent) : void{}
      
      protected function __transmit(param1:LivingEvent) : void{}
      
      protected function __fall(param1:LivingEvent) : void{}
      
      public function get actionMovie() : ActionMovieBone{return null;}
      
      public function get movie() : Sprite{return null;}
      
      public function doAction(param1:*, param2:Function = null, param3:Array = null) : void{}
      
      private function doActionCallBack(param1:Function = null, param2:Array = null) : void{}
      
      public function showEffect(param1:String) : void{}
      
      public function showBuffEffect(param1:String, param2:int) : void{}
      
      public function removeBuffEffect(param1:int) : void{}
      
      public function act(param1:BaseAction) : void{}
      
      public function traceCurrentAction() : void{}
      
      override public function update(param1:Number) : void{}
      
      protected function deleteSmallView() : void{}
      
      private function removeAllPetBuffEffects() : void{}
      
      override public function dispose() : void{}
      
      public function get EffectRect() : Rectangle{return null;}
      
      override public function get smallView() : SmallObject{return null;}
      
      protected function __showAttackEffect(param1:LivingEvent) : void{}
      
      protected function __playDeadEffect(param1:LivingEvent) : void{}
      
      private function __playComplete(param1:AnimationEvent) : void{}
      
      protected function creatAttackEffectAssetByID(param1:int) : BoneMovieStarling{return null;}
      
      private function cleanMovies() : void{}
      
      public function showBlood(param1:Boolean) : void{}
      
      override public function setActionMapping(param1:String, param2:String) : void{}
      
      override public function set visible(param1:Boolean) : void{}
      
      private function get hiddenByServer() : Boolean{return false;}
      
      private function set hiddenByServer(param1:Boolean) : void{}
      
      protected function __onLivingCommand(param1:LivingCommandEvent) : void{}
      
      protected function onChatBallComplete(param1:flash.events.Event) : void{}
      
      protected function doUseItemAnimation(param1:Boolean = false) : void{}
      
      protected function headPropEffect(param1:BoneMovieWrapper = null, param2:Array = null) : void{}
      
      override public function startMoving() : void{}
      
      override public function stopMoving() : void{}
      
      public function setProperty(param1:String, param2:String) : void{}
      
      public function modifyPlayerColor() : void{}
      
      public function playerMoveTo(param1:Array) : void{}
      
      public function getAction(param1:String) : *{return null;}
      
      public function startAction(param1:Array) : void{}
      
      private function executeAction() : void{}
      
      public function changeSmallViewColor(param1:int) : void{}
   }
}
