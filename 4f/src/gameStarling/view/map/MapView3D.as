package gameStarling.view.map{   import bagAndInfo.cell.BaseCell;   import bones.BoneMovieFactory;   import bones.display.BoneMovieStarling;   import com.greensock.TweenLite;   import com.greensock.TweenMax;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.utils.StarlingObjectUtils;   import ddt.data.BallInfo;   import ddt.data.PathInfo;   import ddt.data.map.MapInfo;   import ddt.eventsStarling.Game3DEvent;   import ddt.loader.MapLoader;   import ddt.manager.BallManager;   import ddt.manager.ChatManager;   import ddt.manager.GameInSocketOut;   import ddt.manager.IMEManager;   import ddt.manager.IMManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SharedManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.view.chat.ChatEvent;   import flash.display.BitmapData;   import flash.events.ErrorEvent;   import flash.events.MouseEvent;   import flash.events.TimerEvent;   import flash.geom.Matrix;   import flash.geom.Point;   import flash.system.IME;   import flash.text.TextField;   import flash.utils.Dictionary;   import flash.utils.Timer;   import flash.utils.getTimer;   import game.GameManager;   import game.objects.BombAsset;   import gameCommon.GameControl;   import gameCommon.actions.BaseAction;   import gameCommon.model.GameInfo;   import gameCommon.model.Living;   import gameCommon.model.TurnedLiving;   import gameCommon.view.smallMap.SmallMapView3D;   import gameStarling.actions.ActionManager;   import gameStarling.animations.AnimationSet;   import gameStarling.animations.BaseSetCenterAnimation;   import gameStarling.animations.IAnimate;   import gameStarling.animations.NewHandAnimation;   import gameStarling.animations.ShockingSetCenterAnimation;   import gameStarling.animations.SpellSkillAnimation;   import gameStarling.objects.GameLiving3D;   import gameStarling.objects.GamePlayer3D;   import gameStarling.objects.GameSimpleBoss3D;   import gameStarling.objects.SimpleBox3D;   import gameStarling.view.FaceContainer3D;   import gameStarling.view.GameView3D;   import gameStarling.view.GameViewBase3D;   import road7th.StarlingMain;   import road7th.data.DictionaryData;   import starling.display.Image;   import starling.display.Sprite;   import starling.textures.RenderTexture;   import starlingPhy.maps.Ground3D;   import starlingPhy.maps.Map3D;   import starlingPhy.maps.Tile3D;   import starlingPhy.object.PhysicalObj3D;   import starlingPhy.object.Physics3D;      public class MapView3D extends Map3D   {            public static const ADD_BOX:String = "addBox";            public static const FRAMERATE_OVER_COUNT:int = 25;            public static const OVER_FRAME_GAPE:int = 46;                   private var _game:GameInfo;            private var _info:MapInfo;            private var _animateSet:AnimationSet;            private var _minX:Number;            private var _minY:Number;            private var _minScaleX:Number;            private var _minScaleY:Number;            private var _minSkyScaleX:Number;            private var _minScale:Number;            private var _smallMap:SmallMapView3D;            private var _actionManager:ActionManager;            public var gameView:GameViewBase3D;            public var currentFocusedLiving:GameLiving3D;            private var _currentTurn:int;            private var _y:Number;            private var _x:Number;            public var physicalChilds:Dictionary;            private var _currentFocusedLiving:GameLiving3D;            private var _currentFocusLevel:int;            private var _currentPlayer:TurnedLiving;            private var _scale:Number = 1;            private var _frameRateCounter:int;            private var _currentFrameRateOverCount:int = 0;            private var _frameRateAlert:BaseAlerFrame;            private var _objects:DictionaryData;            private var _gamePlayerList:Vector.<GamePlayer3D>;            private var expName:Vector.<String>;            private var expDic:Dictionary;            private var _currentTopLiving:GameLiving3D;            private var _container:Sprite;            private var _bigBox:BoneMovieStarling;            private var _isPickBigBox:Boolean;            private var _picIdList:Array;            private var _picMoveDelay:int;            private var _picList:Array;            private var _picStartPoint:Point;            private var _lastPic:BaseCell;            private var _boxTimer:Timer;            public function MapView3D(game:GameInfo, loader:MapLoader) { super(null,null,null,null); }
            public function set currentTurn(i:int) : void { }
            public function get currentTurn() : int { return 0; }
            public function requestForFocus(target:GameLiving3D, level:int = 0) : void { }
            public function cancelFocus(target:GameLiving3D = null) : void { }
            public function get currentPlayer() : TurnedLiving { return null; }
            public function set currentPlayer(value:TurnedLiving) : void { }
            public function get gameInfo() : GameInfo { return null; }
            public function get info() : MapInfo { return null; }
            public function get smallMap() : SmallMapView3D { return null; }
            public function get animateSet() : AnimationSet { return null; }
            private function initOutCrater() : void { }
            private function initBox() : void { }
            public function DigOutCrater(outBombs:DictionaryData) : void { }
            private function __setFacecontainLoctionAction(e:ChatEvent) : void { }
            private function get minX() : Number { return 0; }
            private function get minY() : Number { return 0; }
            public function spellKill(player:GamePlayer3D) : IAnimate { return null; }
            public function get isPlayingMovie() : Boolean { return false; }
            override public function set x(value:Number) : void { }
            override public function set y(value:Number) : void { }
            override public function get x() : Number { return 0; }
            override public function get y() : Number { return 0; }
            public function set scale(value:Number) : void { }
            public function get minScale() : Number { return 0; }
            public function get scale() : Number { return 0; }
            public function setCenter(px:Number, py:Number, isTween:Boolean) : void { }
            public function scenarioSetCenter(px:Number, py:Number, type:int) : void { }
            public function livingSetCenter(px:Number, py:Number, isTween:Boolean, priority:int = 2, data:Object = null) : void { }
            public function setSelfCenter(isTween:Boolean, priority:int = 2, data:Object = null) : void { }
            public function act(action:BaseAction) : void { }
            override protected function update() : void { }
            private function checkOverFrameRate() : void { }
            private function __onRespose(event:FrameEvent) : void { }
            private function overFrameOk() : void { }
            public function get drawMapView() : Image { return null; }
            private function updateSky() : void { }
            public function getPhysical(id:int) : PhysicalObj3D { return null; }
            public function get objects() : Dictionary { return null; }
            public function get getOneSimpleBoss() : GameSimpleBoss3D { return null; }
            override public function addPhysical(phy:Physics3D) : void { }
            private function controlExpNum(temp:GamePlayer3D) : void { }
            private function resetDicAndVec(temp:GamePlayer3D) : void { }
            public function setExpressionLoction() : void { }
            private function onStageFlg(tempPoint:Point) : int { return 0; }
            public function addObject(phy:Physics3D) : void { }
            public function bringToFront($info:Living) : void { }
            public function phyBringToFront(phy:PhysicalObj3D) : void { }
            override public function removePhysical(phy:Physics3D) : void { }
            override public function addMapThing(phy:Physics3D) : void { }
            override public function removeMapThing(phy:Physics3D) : void { }
            public function get actionCount() : int { return 0; }
            public function lockFocusAt(pos:Point) : void { }
            public function releaseFocus() : void { }
            public function executeAtOnce() : void { }
            public function traceCurrentAction() : void { }
            public function bringToStageTop(living:PhysicalObj3D) : void { }
            public function restoreStageTopLiving() : void { }
            public function setMatrx(m:Matrix) : void { }
            public function dropOutBox(array:Array) : void { }
            protected function __openBox(event:TimerEvent) : void { }
            protected function __onBigBoxClick(event:MouseEvent) : void { }
            public function pickBigBoxSuccessHandler() : void { }
            private function picPlayActionComplete() : void { }
            private function openBigBox(event:MouseEvent) : void { }
            private function pickBigBoxSuccessHandler2(pic:BaseCell) : void { }
            private function upMoveEndHandler(pic:BaseCell) : void { }
            private function lightCartoonPlayEndHandler(pic:BaseCell) : void { }
            private function pickBigBoxEndHandler(pic:BaseCell) : void { }
            private function getTwoHundredDisPoint(x:Number, y:Number, width:Number, height:Number, direction:int) : Point { return null; }
            public function get disableFlyCD() : Boolean { return false; }
            override public function dispose() : void { }
   }}