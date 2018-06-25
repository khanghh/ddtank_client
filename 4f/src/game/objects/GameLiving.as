package game.objects{   import com.pickgliss.loader.ModuleLoader;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.LivingEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import ddt.view.PropItemView;   import ddt.view.chat.chatBall.ChatBallBase;   import ddt.view.chat.chatBall.ChatBallPlayer;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.display.DisplayObject;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.geom.Point;   import flash.geom.Rectangle;   import flash.utils.Dictionary;   import game.actions.LivingDeadEffectAction;   import game.actions.LivingFallingAction;   import game.actions.LivingJumpAction;   import game.actions.LivingMoveAction;   import game.actions.LivingTurnAction;   import game.actions.PlayerFallingAction;   import game.actions.PlayerWalkAction;   import game.animations.ShockMapAnimation;   import game.view.AutoPropEffect;   import game.view.EffectIconContainer;   import game.view.IDisplayPack;   import game.view.buff.FightBuffBar;   import game.view.buff.SkillBuffBar;   import game.view.effects.ShootPercentView;   import game.view.effects.ShowEffect;   import game.view.map.MapView;   import gameCommon.GameControl;   import gameCommon.actions.BaseAction;   import gameCommon.event.LivingCommandEvent;   import gameCommon.model.Living;   import gameCommon.model.Player;   import gameCommon.model.SimpleBoss;   import gameCommon.model.SmallEnemy;   import gameCommon.view.effects.BaseMirariEffectIcon;   import gameCommon.view.smallMap.SmallLiving;   import gameCommon.view.smallMap.SmallPlayer;   import phy.object.PhysicalObj;   import phy.object.SmallObject;   import road.game.resource.ActionMovie;   import road.game.resource.ActionMovieEvent;   import road7th.data.DictionaryData;   import road7th.data.DictionaryEvent;   import road7th.data.StringObject;   import road7th.utils.AutoDisappear;   import road7th.utils.MovieClipWrapper;   import room.RoomManager;   import tank.events.ActionEvent;      public class GameLiving extends PhysicalObj   {            protected static var SHOCK_EVENT:String = "shockEvent";            protected static var SHOCK_EVENT2:String = "shockEvent2";            protected static var SHIELD:String = "shield";            protected static var BOMB_EVENT:String = "bombEvent";            public static var SHOOT_PREPARED:String = "shootPrepared";            protected static var RENEW:String = "renew";            protected static var NEED_FOCUS:String = "focus";            protected static var PLAY_EFFECT:String = "playeffect";            protected static var PLAYER_EFFECT:String = "effect";            protected static var ATTACK_COMPLETE_FOCUS:String = "attackCompleteFocus";            public static const stepY:int = 7;            public static const npcStepX:int = 1;            public static const npcStepY:int = 3;                   protected var _info:Living;            protected var _actionMovie:ActionMovie;            protected var _chatballview:ChatBallBase;            protected var _smallView:SmallLiving;            protected var speedMult:int = 1;            protected var _nickName:FilterFrameText;            protected var _targetBlood:int;            protected var targetAttackEffect:int;            protected var _originalHeight:Number;            protected var _originalWidth:Number;            public var bodyWidth:Number;            public var bodyHeight:Number;            public var isExist:Boolean = true;            protected var _turns:int;            private var _offsetX:Number = 0;            private var _offsetY:Number = 0;            private var _speedX:Number = 3;            private var _speedY:Number = 7;            protected var _bloodStripBg:Bitmap;            protected var _HPStrip:ScaleFrameImage;            protected var _bloodWidth:int;            protected var _buffBar:FightBuffBar;            private var _fightPower:FilterFrameText;            private var _buffEffect:DictionaryData;            protected var _attestBtn:ScaleFrameImage;            private var _targetIcon:MovieClip;            protected var _skillBuffBar:SkillBuffBar;            private var _effectIconContainer:EffectIconContainer;            protected var counter:int = 1;            protected var ap:Number = 0;            protected var effectForzen:Sprite;            protected var lock:MovieClip;            private var solidIceEffect:Sprite;            private var _noRemoveEffect:Array;            protected var _isDie:Boolean = false;            protected var _effRect:Rectangle;            private var _attackEffectPlayer:PhysicalObj;            private var _attackEffectPlaying:Boolean = false;            protected var _attackEffectPos:Point;            protected var _moviePool:Object;            private var _hiddenByServer:Boolean;            protected var _propArray:Array;            private var _onSmallMap:Boolean = true;            public function GameLiving(info:Living) { super(null); }
            public static function getAttackEffectAssetByID(id:int) : MovieClip { return null; }
            public function get stepX() : int { return 0; }
            public function get stepY() : int { return 0; }
            override public function get x() : Number { return 0; }
            override public function get y() : Number { return 0; }
            public function get EffectIcon() : EffectIconContainer { return null; }
            override public function get layer() : int { return 0; }
            public function get info() : Living { return null; }
            public function get map() : MapView { return null; }
            private function __fightPowerChanged(event:LivingEvent) : void { }
            public function addTartgetIcon() : void { }
            public function deleteTargetIcon() : void { }
            public function setFightPower(fightPower:int) : void { }
            public function set fightPowerVisible(value:Boolean) : void { }
            protected function initView() : void { }
            private function creatAttestBtn() : void { }
            protected function initInfoChange() : void { }
            protected function initSmallMapObject() : void { }
            protected function initEffectIcon() : void { }
            protected function initFreezonRect() : void { }
            public function addChildrenByPack(pack:IDisplayPack) : void { }
            protected function initListener() : void { }
            protected function __markMeHideDest(event:LivingEvent) : void { }
            public function replaceMovie() : void { }
            protected function __addToState(event:Event) : void { }
            protected function __removeContinuousEffect(event:LivingEvent) : void { }
            protected function __playContinuousEffect(event:LivingEvent) : void { }
            protected function __buffChanged(event:LivingEvent) : void { }
            protected function __removeSkillMovie(event:LivingEvent) : void { }
            protected function __applySkill(event:LivingEvent) : void { }
            protected function __playSkillMovie(event:LivingEvent) : void { }
            protected function __skillMovieComplete(event:Event) : void { }
            protected function __bombed(event:LivingEvent) : void { }
            protected function removeListener() : void { }
            protected function __shockMap(evt:ActionEvent) : void { }
            protected function __shockMap2(evt:Event) : void { }
            protected function __renew(evt:Event) : void { }
            protected function __startBlank(evt:Event) : void { }
            protected function drawBlank(evt:Event) : void { }
            protected function __showDefence(evt:Event) : void { }
            protected function __addEffectHandler(e:DictionaryEvent) : void { }
            protected function __removeEffectHandler(e:DictionaryEvent) : void { }
            protected function __clearEffectHandler(e:DictionaryEvent) : void { }
            protected function __sizeChangeHandler(e:Event) : void { }
            protected function __changeState(evt:LivingEvent) : void { }
            protected function initMovie() : void { }
            protected function initChatball() : void { }
            protected function __startMoving(event:LivingEvent) : void { }
            protected function __say(event:LivingEvent) : void { }
            protected function fitChatBallPos() : void { }
            protected function get popPos() : Point { return null; }
            protected function get popDir() : Point { return null; }
            override public function collidedByObject(obj:PhysicalObj) : void { }
            protected function __beat(event:LivingEvent) : void { }
            protected function updateTargetsBlood(arg:Array) : void { }
            protected function __beginNewTurn(event:LivingEvent) : void { }
            protected function __playMovie(event:LivingEvent) : void { }
            protected function __turnRotation(event:LivingEvent) : void { }
            protected function __bloodChanged(event:LivingEvent) : void { }
            protected function __maxHpChanged(event:LivingEvent) : void { }
            protected function updateBloodStrip() : void { }
            private function offset(off:int = 30) : int { return 0; }
            protected function __die(event:LivingEvent) : void { }
            override public function die() : void { }
            public function revive() : void { }
            protected function __dirChanged(event:LivingEvent) : void { }
            protected function __forzenChanged(event:LivingEvent) : void { }
            protected function __lockStateChanged(evt:LivingEvent) : void { }
            protected function _solidIceStateChanged(event:LivingEvent) : void { }
            protected function _targetStealthStateChanged(event:LivingEvent) : void { }
            protected function _enableSpellSkill(evt:LivingEvent) : void { }
            protected function _addSkillBuffBar_Handler(evt:LivingEvent) : void { }
            protected function __hiddenChanged(event:LivingEvent) : void { }
            protected function __posChanged(event:LivingEvent) : void { }
            protected function __jump(event:LivingEvent) : void { }
            protected function __moveTo(event:LivingEvent) : void { }
            public function canMoveDirection(dir:Number) : Boolean { return false; }
            public function canStand(x:int, y:int) : Boolean { return false; }
            public function getNextWalkPoint(dir:int) : Point { return null; }
            private function __needFocus(evt:ActionMovieEvent) : void { }
            protected function __playEffect(evt:ActionMovieEvent) : void { }
            protected function __playerEffect(evt:ActionMovieEvent) : void { }
            public function needFocus(offsetX:int = 0, offsetY:int = 0, data:Object = null, player:GameLiving = null) : void { }
            private function __attackCompleteFocus(event:ActionMovieEvent) : void { }
            protected function __shoot(event:LivingEvent) : void { }
            protected function __transmit(event:LivingEvent) : void { }
            protected function __fall(event:LivingEvent) : void { }
            public function get actionMovie() : ActionMovie { return null; }
            public function get movie() : Sprite { return null; }
            public function doAction(actionType:*) : void { }
            public function showEffect(classLink:String) : void { }
            public function showBuffEffect(classLink:String, buffId:int) : void { }
            public function removeBuffEffect(buffId:int) : void { }
            public function act(action:BaseAction) : void { }
            public function traceCurrentAction() : void { }
            override public function update(dt:Number) : void { }
            protected function getBodyBmpData(action:String = "") : BitmapData { return null; }
            private function getBodyBitmapData(action:String = "") : BitmapData { return null; }
            protected function deleteSmallView() : void { }
            private function removeAllPetBuffEffects() : void { }
            override public function dispose() : void { }
            public function get EffectRect() : Rectangle { return null; }
            override public function get smallView() : SmallObject { return null; }
            protected function __showAttackEffect(event:LivingEvent) : void { }
            protected function __playDeadEffect(event:LivingEvent) : void { }
            private function __playComplete(event:Event) : void { }
            protected function hasMovie(name:String) : Boolean { return false; }
            protected function creatAttackEffectAssetByID(id:int) : MovieClip { return null; }
            private function cleanMovies() : void { }
            public function showBlood(value:Boolean) : void { }
            override public function setActionMapping(source:String, target:String) : void { }
            override public function set visible(value:Boolean) : void { }
            private function get hiddenByServer() : Boolean { return false; }
            private function set hiddenByServer(value:Boolean) : void { }
            protected function __onLivingCommand(evt:LivingCommandEvent) : void { }
            protected function onChatBallComplete(evt:Event) : void { }
            protected function doUseItemAnimation(skip:Boolean = false) : void { }
            protected function headPropEffect() : void { }
            override public function startMoving() : void { }
            override public function stopMoving() : void { }
            public function setProperty(property:String, value:String) : void { }
            public function modifyPlayerColor() : void { }
            public function playerMoveTo(params:Array) : void { }
            public function getAction(type:String) : * { return null; }
            public function changeSmallViewColor(index:int) : void { }
   }}