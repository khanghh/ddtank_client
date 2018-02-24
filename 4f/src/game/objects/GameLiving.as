package game.objects
{
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.LivingEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.PropItemView;
   import ddt.view.chat.chatBall.ChatBallBase;
   import ddt.view.chat.chatBall.ChatBallPlayer;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import game.actions.LivingDeadEffectAction;
   import game.actions.LivingFallingAction;
   import game.actions.LivingJumpAction;
   import game.actions.LivingMoveAction;
   import game.actions.LivingTurnAction;
   import game.actions.PlayerFallingAction;
   import game.actions.PlayerWalkAction;
   import game.animations.ShockMapAnimation;
   import game.view.AutoPropEffect;
   import game.view.EffectIconContainer;
   import game.view.IDisplayPack;
   import game.view.buff.FightBuffBar;
   import game.view.buff.SkillBuffBar;
   import game.view.effects.ShootPercentView;
   import game.view.effects.ShowEffect;
   import game.view.map.MapView;
   import gameCommon.GameControl;
   import gameCommon.actions.BaseAction;
   import gameCommon.event.LivingCommandEvent;
   import gameCommon.model.Living;
   import gameCommon.model.Player;
   import gameCommon.model.SimpleBoss;
   import gameCommon.model.SmallEnemy;
   import gameCommon.view.effects.BaseMirariEffectIcon;
   import gameCommon.view.smallMap.SmallLiving;
   import gameCommon.view.smallMap.SmallPlayer;
   import phy.object.PhysicalObj;
   import phy.object.SmallObject;
   import road.game.resource.ActionMovie;
   import road.game.resource.ActionMovieEvent;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   import road7th.data.StringObject;
   import road7th.utils.AutoDisappear;
   import road7th.utils.MovieClipWrapper;
   import room.RoomManager;
   import tank.events.ActionEvent;
   
   public class GameLiving extends PhysicalObj
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
      
      protected var _actionMovie:ActionMovie;
      
      protected var _chatballview:ChatBallBase;
      
      protected var _smallView:SmallLiving;
      
      protected var speedMult:int = 1;
      
      protected var _nickName:FilterFrameText;
      
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
      
      protected var _bloodStripBg:Bitmap;
      
      protected var _HPStrip:ScaleFrameImage;
      
      protected var _bloodWidth:int;
      
      protected var _buffBar:FightBuffBar;
      
      private var _fightPower:FilterFrameText;
      
      private var _buffEffect:DictionaryData;
      
      protected var _attestBtn:ScaleFrameImage;
      
      private var _targetIcon:MovieClip;
      
      protected var _skillBuffBar:SkillBuffBar;
      
      private var _effectIconContainer:EffectIconContainer;
      
      protected var counter:int = 1;
      
      protected var ap:Number = 0;
      
      protected var effectForzen:Sprite;
      
      protected var lock:MovieClip;
      
      private var solidIceEffect:Sprite;
      
      private var _noRemoveEffect:Array;
      
      protected var _isDie:Boolean = false;
      
      protected var _effRect:Rectangle;
      
      private var _attackEffectPlayer:PhysicalObj;
      
      private var _attackEffectPlaying:Boolean = false;
      
      protected var _attackEffectPos:Point;
      
      protected var _moviePool:Object;
      
      private var _hiddenByServer:Boolean;
      
      protected var _propArray:Array;
      
      private var _onSmallMap:Boolean = true;
      
      public function GameLiving(param1:Living){super(null);}
      
      public static function getAttackEffectAssetByID(param1:int) : MovieClip{return null;}
      
      public function get stepX() : int{return 0;}
      
      public function get stepY() : int{return 0;}
      
      override public function get x() : Number{return 0;}
      
      override public function get y() : Number{return 0;}
      
      public function get EffectIcon() : EffectIconContainer{return null;}
      
      override public function get layer() : int{return 0;}
      
      public function get info() : Living{return null;}
      
      public function get map() : MapView{return null;}
      
      private function __fightPowerChanged(param1:LivingEvent) : void{}
      
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
      
      public function addChildrenByPack(param1:IDisplayPack) : void{}
      
      protected function initListener() : void{}
      
      protected function __markMeHideDest(param1:LivingEvent) : void{}
      
      public function replaceMovie() : void{}
      
      protected function __addToState(param1:Event) : void{}
      
      protected function __removeContinuousEffect(param1:LivingEvent) : void{}
      
      protected function __playContinuousEffect(param1:LivingEvent) : void{}
      
      protected function __buffChanged(param1:LivingEvent) : void{}
      
      protected function __removeSkillMovie(param1:LivingEvent) : void{}
      
      protected function __applySkill(param1:LivingEvent) : void{}
      
      protected function __playSkillMovie(param1:LivingEvent) : void{}
      
      protected function __skillMovieComplete(param1:Event) : void{}
      
      protected function __bombed(param1:LivingEvent) : void{}
      
      protected function removeListener() : void{}
      
      protected function __shockMap(param1:ActionEvent) : void{}
      
      protected function __shockMap2(param1:Event) : void{}
      
      protected function __renew(param1:Event) : void{}
      
      protected function __startBlank(param1:Event) : void{}
      
      protected function drawBlank(param1:Event) : void{}
      
      protected function __showDefence(param1:Event) : void{}
      
      protected function __addEffectHandler(param1:DictionaryEvent) : void{}
      
      protected function __removeEffectHandler(param1:DictionaryEvent) : void{}
      
      protected function __clearEffectHandler(param1:DictionaryEvent) : void{}
      
      protected function __sizeChangeHandler(param1:Event) : void{}
      
      protected function __changeState(param1:LivingEvent) : void{}
      
      protected function initMovie() : void{}
      
      protected function initChatball() : void{}
      
      protected function __startMoving(param1:LivingEvent) : void{}
      
      protected function __say(param1:LivingEvent) : void{}
      
      protected function fitChatBallPos() : void{}
      
      protected function get popPos() : Point{return null;}
      
      protected function get popDir() : Point{return null;}
      
      override public function collidedByObject(param1:PhysicalObj) : void{}
      
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
      
      protected function __hiddenChanged(param1:LivingEvent) : void{}
      
      protected function __posChanged(param1:LivingEvent) : void{}
      
      protected function __jump(param1:LivingEvent) : void{}
      
      protected function __moveTo(param1:LivingEvent) : void{}
      
      public function canMoveDirection(param1:Number) : Boolean{return false;}
      
      public function canStand(param1:int, param2:int) : Boolean{return false;}
      
      public function getNextWalkPoint(param1:int) : Point{return null;}
      
      private function __needFocus(param1:ActionMovieEvent) : void{}
      
      protected function __playEffect(param1:ActionMovieEvent) : void{}
      
      protected function __playerEffect(param1:ActionMovieEvent) : void{}
      
      public function needFocus(param1:int = 0, param2:int = 0, param3:Object = null, param4:GameLiving = null) : void{}
      
      private function __attackCompleteFocus(param1:ActionMovieEvent) : void{}
      
      protected function __shoot(param1:LivingEvent) : void{}
      
      protected function __transmit(param1:LivingEvent) : void{}
      
      protected function __fall(param1:LivingEvent) : void{}
      
      public function get actionMovie() : ActionMovie{return null;}
      
      public function get movie() : Sprite{return null;}
      
      public function doAction(param1:*) : void{}
      
      public function showEffect(param1:String) : void{}
      
      public function showBuffEffect(param1:String, param2:int) : void{}
      
      public function removeBuffEffect(param1:int) : void{}
      
      public function act(param1:BaseAction) : void{}
      
      public function traceCurrentAction() : void{}
      
      override public function update(param1:Number) : void{}
      
      protected function getBodyBmpData(param1:String = "") : BitmapData{return null;}
      
      private function getBodyBitmapData(param1:String = "") : BitmapData{return null;}
      
      protected function deleteSmallView() : void{}
      
      private function removeAllPetBuffEffects() : void{}
      
      override public function dispose() : void{}
      
      public function get EffectRect() : Rectangle{return null;}
      
      override public function get smallView() : SmallObject{return null;}
      
      protected function __showAttackEffect(param1:LivingEvent) : void{}
      
      protected function __playDeadEffect(param1:LivingEvent) : void{}
      
      private function __playComplete(param1:Event) : void{}
      
      protected function hasMovie(param1:String) : Boolean{return false;}
      
      protected function creatAttackEffectAssetByID(param1:int) : MovieClip{return null;}
      
      private function cleanMovies() : void{}
      
      public function showBlood(param1:Boolean) : void{}
      
      override public function setActionMapping(param1:String, param2:String) : void{}
      
      override public function set visible(param1:Boolean) : void{}
      
      private function get hiddenByServer() : Boolean{return false;}
      
      private function set hiddenByServer(param1:Boolean) : void{}
      
      protected function __onLivingCommand(param1:LivingCommandEvent) : void{}
      
      protected function onChatBallComplete(param1:Event) : void{}
      
      protected function doUseItemAnimation(param1:Boolean = false) : void{}
      
      protected function headPropEffect() : void{}
      
      override public function startMoving() : void{}
      
      override public function stopMoving() : void{}
      
      public function setProperty(param1:String, param2:String) : void{}
      
      public function modifyPlayerColor() : void{}
      
      public function playerMoveTo(param1:Array) : void{}
      
      public function getAction(param1:String) : *{return null;}
      
      public function changeSmallViewColor(param1:int) : void{}
   }
}
