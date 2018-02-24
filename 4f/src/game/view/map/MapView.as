package game.view.map
{
   import bagAndInfo.cell.BaseCell;
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BallInfo;
   import ddt.data.PathInfo;
   import ddt.data.map.MapInfo;
   import ddt.events.GameEvent;
   import ddt.loader.MapLoader;
   import ddt.manager.BallManager;
   import ddt.manager.ChatManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.IMEManager;
   import ddt.manager.IMManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.FaceContainer;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Transform;
   import flash.system.IME;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import game.GameManager;
   import game.actions.ActionManager;
   import game.animations.AnimationSet;
   import game.animations.BaseSetCenterAnimation;
   import game.animations.IAnimate;
   import game.animations.NewHandAnimation;
   import game.animations.ShockingSetCenterAnimation;
   import game.animations.SpellSkillAnimation;
   import game.objects.BombAsset;
   import game.objects.GameLiving;
   import game.objects.GamePlayer;
   import game.objects.GameSimpleBoss;
   import game.objects.SimpleBox;
   import game.view.GameViewBase;
   import gameCommon.GameControl;
   import gameCommon.actions.BaseAction;
   import gameCommon.model.GameInfo;
   import gameCommon.model.Living;
   import gameCommon.model.TurnedLiving;
   import gameCommon.view.smallMap.SmallMapView;
   import phy.maps.Ground;
   import phy.maps.Map;
   import phy.object.PhysicalObj;
   import phy.object.Physics;
   import road7th.data.DictionaryData;
   import road7th.utils.MovieClipWrapper;
   import trainer.controller.NewHandGuideManager;
   
   public class MapView extends Map
   {
      
      public static const ADD_BOX:String = "addBox";
      
      public static const FRAMERATE_OVER_COUNT:int = 25;
      
      public static const OVER_FRAME_GAPE:int = 46;
       
      
      private var _game:GameInfo;
      
      private var _info:MapInfo;
      
      private var _animateSet:AnimationSet;
      
      private var _minX:Number;
      
      private var _minY:Number;
      
      private var _minScaleX:Number;
      
      private var _minScaleY:Number;
      
      private var _minSkyScaleX:Number;
      
      private var _minScale:Number;
      
      private var _smallMap:SmallMapView;
      
      private var _actionManager:ActionManager;
      
      public var gameView:GameViewBase;
      
      public var currentFocusedLiving:GameLiving;
      
      private var _currentTurn:int;
      
      private var _circle:Shape;
      
      private var _y:Number;
      
      private var _x:Number;
      
      private var _currentFocusedLiving:GameLiving;
      
      private var _currentFocusLevel:int;
      
      private var _currentPlayer:TurnedLiving;
      
      private var _smallObjs:Array;
      
      private var _scale:Number = 1;
      
      private var _frameRateCounter:int;
      
      private var _currentFrameRateOverCount:int = 0;
      
      private var _frameRateAlert:BaseAlerFrame;
      
      private var _objects:Dictionary;
      
      public var gamePlayerList:Vector.<GamePlayer>;
      
      private var expName:Vector.<String>;
      
      private var expDic:Dictionary;
      
      private var _backEffectView:BackEffectView;
      
      private var _currentTopLiving:GameLiving;
      
      private var _container:Sprite;
      
      private var _bigBox:MovieClipWrapper;
      
      private var _isPickBigBox:Boolean;
      
      private var _picIdList:Array;
      
      private var _picMoveDelay:int;
      
      private var _picList:Array;
      
      private var _picStartPoint:Point;
      
      private var _lastPic:BaseCell;
      
      private var _boxTimer:Timer;
      
      public function MapView(param1:GameInfo, param2:MapLoader){super(null,null,null,null);}
      
      public function set currentTurn(param1:int) : void{}
      
      public function get currentTurn() : int{return 0;}
      
      public function requestForFocus(param1:GameLiving, param2:int = 0) : void{}
      
      public function cancelFocus(param1:GameLiving = null) : void{}
      
      public function get currentPlayer() : TurnedLiving{return null;}
      
      public function set currentPlayer(param1:TurnedLiving) : void{}
      
      public function get gameInfo() : GameInfo{return null;}
      
      public function get info() : MapInfo{return null;}
      
      public function get smallMap() : SmallMapView{return null;}
      
      public function get animateSet() : AnimationSet{return null;}
      
      private function initOutCrater() : void{}
      
      private function initBox() : void{}
      
      public function DigOutCrater(param1:DictionaryData) : void{}
      
      private function __setFacecontainLoctionAction(param1:Event) : void{}
      
      private function get minX() : Number{return 0;}
      
      private function get minY() : Number{return 0;}
      
      private function __mouseClick(param1:MouseEvent) : void{}
      
      public function spellKill(param1:GamePlayer) : IAnimate{return null;}
      
      public function get isPlayingMovie() : Boolean{return false;}
      
      override public function set x(param1:Number) : void{}
      
      override public function set y(param1:Number) : void{}
      
      override public function get x() : Number{return 0;}
      
      override public function get y() : Number{return 0;}
      
      override public function set transform(param1:Transform) : void{}
      
      override public function get transform() : Transform{return null;}
      
      public function set scale(param1:Number) : void{}
      
      public function get minScale() : Number{return 0;}
      
      public function get scale() : Number{return 0;}
      
      public function setCenter(param1:Number, param2:Number, param3:Boolean) : void{}
      
      public function scenarioSetCenter(param1:Number, param2:Number, param3:int) : void{}
      
      public function livingSetCenter(param1:Number, param2:Number, param3:Boolean, param4:int = 2, param5:Object = null, param6:GameLiving = null) : void{}
      
      public function setSelfCenter(param1:Boolean, param2:int = 2, param3:Object = null) : void{}
      
      public function act(param1:BaseAction) : void{}
      
      public function showShoot(param1:Number, param2:Number) : void{}
      
      override protected function update() : void{}
      
      private function checkOverFrameRate() : void{}
      
      private function __onRespose(param1:FrameEvent) : void{}
      
      private function overFrameOk() : void{}
      
      public function get mapBitmap() : Bitmap{return null;}
      
      private function updateSky() : void{}
      
      public function getPhysical(param1:int) : PhysicalObj{return null;}
      
      public function get objects() : Dictionary{return null;}
      
      public function get getOneSimpleBoss() : GameSimpleBoss{return null;}
      
      override public function addPhysical(param1:Physics) : void{}
      
      private function controlExpNum(param1:GamePlayer) : void{}
      
      private function resetDicAndVec(param1:GamePlayer) : void{}
      
      public function setExpressionLoction() : void{}
      
      private function onStageFlg(param1:Point) : int{return 0;}
      
      public function addObject(param1:Physics) : void{}
      
      public function bringToFront(param1:Living) : void{}
      
      public function phyBringToFront(param1:PhysicalObj) : void{}
      
      override public function removePhysical(param1:Physics) : void{}
      
      override public function addMapThing(param1:Physics) : void{}
      
      override public function removeMapThing(param1:Physics) : void{}
      
      public function createBackEffectView(param1:Number = 400) : void{}
      
      public function removeBackEffectView() : void{}
      
      public function hideBackEffectView() : void{}
      
      public function showBackEffectView() : void{}
      
      private function addToBackEffectView(param1:PhysicalObj) : void{}
      
      private function updatePosBackEffectView(param1:PhysicalObj, param2:Point) : void{}
      
      private function removeToBackEffectView(param1:PhysicalObj) : void{}
      
      public function updateObjectPos(param1:PhysicalObj, param2:Point) : void{}
      
      public function get actionCount() : int{return 0;}
      
      public function lockFocusAt(param1:Point) : void{}
      
      public function releaseFocus() : void{}
      
      public function executeAtOnce() : void{}
      
      public function traceCurrentAction() : void{}
      
      public function bringToStageTop(param1:PhysicalObj) : void{}
      
      public function restoreStageTopLiving() : void{}
      
      public function setMatrx(param1:Matrix) : void{}
      
      public function dropOutBox(param1:Array) : void{}
      
      protected function __openBox(param1:TimerEvent) : void{}
      
      protected function __onBigBoxClick(param1:MouseEvent) : void{}
      
      public function pickBigBoxSuccessHandler() : void{}
      
      private function playPickBoxAwardMove(param1:Event) : void{}
      
      private function playPickBoxAwardMove2(param1:Event) : void{}
      
      private function pickBigBoxSuccessHandler2(param1:BaseCell) : void{}
      
      private function upMoveEndHandler(param1:BaseCell) : void{}
      
      private function lightCartoonPlayEndHandler(param1:BaseCell) : void{}
      
      private function pickBigBoxEndHandler(param1:BaseCell) : void{}
      
      private function playSoundEffect(param1:Event) : void{}
      
      private function openBigBox(param1:MouseEvent) : void{}
      
      private function dropEndHandler(param1:Event) : void{}
      
      private function getTwoHundredDisPoint(param1:Number, param2:Number, param3:Number, param4:Number, param5:int) : Point{return null;}
      
      public function get disableFlyCD() : Boolean{return false;}
      
      override public function dispose() : void{}
   }
}
