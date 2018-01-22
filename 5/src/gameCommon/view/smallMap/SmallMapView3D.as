package gameCommon.view.smallMap
{
import com.pickgliss.toplevel.StageReferance;
import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.ui.LayerManager;
import com.pickgliss.ui.core.Disposeable;
import com.pickgliss.ui.text.FilterFrameText;
import com.pickgliss.utils.ClassUtils;
import com.pickgliss.utils.ObjectUtils;
import ddt.data.map.MissionInfo;
import ddt.manager.LanguageMgr;
import ddt.manager.SoundManager;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Graphics;
import flash.display.MovieClip;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.Dictionary;
import flash.utils.setTimeout;
import gameCommon.GameControl;
import gameCommon.model.Living;
import gameCommon.model.LocalPlayer;
import gameStarling.animations.DragMapAnimation;
import gameStarling.view.map.MapView3D;
import phy.object.SmallObject;
import road7th.data.DictionaryData;
import room.RoomManager;

public class SmallMapView3D extends Sprite implements Disposeable
{

    private static const NUMBERS_ARR:Array = ["tank.game.smallmap.ShineNumber1","tank.game.smallmap.ShineNumber2","tank.game.smallmap.ShineNumber3","tank.game.smallmap.ShineNumber4","tank.game.smallmap.ShineNumber5","tank.game.smallmap.ShineNumber6","tank.game.smallmap.ShineNumber7","tank.game.smallmap.ShineNumber8","tank.game.smallmap.ShineNumber9"];

    public static var MAX_WIDTH:int = 165;

    public static var MIN_WIDTH:int = 120;

    public static const HARD_LEVEL:Array = [LanguageMgr.GetTranslation("tank.game.smallmap.simple"),LanguageMgr.GetTranslation("tank.game.smallmap.normal"),LanguageMgr.GetTranslation("tank.game.smallmap.difficulty"),LanguageMgr.GetTranslation("tank.game.smallmap.hero"),LanguageMgr.GetTranslation("tank.room.difficulty.nightmare"),LanguageMgr.GetTranslation("tank.room.difficulty.epic")];

    public static const HARD_LEVEL1:Array = [LanguageMgr.GetTranslation("tank.game.smallmap.simple1"),LanguageMgr.GetTranslation("tank.game.smallmap.normal1"),LanguageMgr.GetTranslation("tank.game.smallmap.difficulty1")];

    public static const STAR_HARD_LEVEL:Array = LanguageMgr.GetTranslation("cryptBoss.setFrame.hardLevelTxt").split(",");


    private var _screen:Sprite;

    private var _foreMap:Sprite;

    private var _thingLayer:Sprite;

    private var _mapBorder:Sprite;

    private var _hardTxt:FilterFrameText;

    private var _line:Sprite;

    private var _smallMapContainerBg:Sprite;

    private var _mask:Shape;

    private var _foreMapMask:Shape;

    private var _changeScale:Number = 0.2;

    private var _locked:Boolean;

    private var _allowDrag:Boolean = true;

    private var _split:Sprite;

    private var _texts:Array;

    private var _screenMask:Sprite;

    private var _processer:ThingProcesser;

    private var _drawMatrix:Matrix;

    private var _lineRef:BitmapData;

    private var _foreground:Shape;

    private var _dragScreen:Sprite;

    private var _titleBar:SmallMapTitleBar;

    private var _Screen_X:int;

    private var _Screen_Y:int;

    private var _mapBmp:Bitmap;

    private var _mapDeadBmp:Bitmap;

    private var _rateX:Number;

    private var _map:MapView3D;

    private var _skew:int;

    private var _rateY:Number;

    private var _missionInfo:MissionInfo;

    private var _w:int;

    private var _h:int;

    private var _groundShape:Sprite;

    private var _beadShape:Shape;

    private var _startDrag:Boolean = false;

    private var _child:Dictionary;

    private var _update:Boolean;

    private var _allLivings:DictionaryData;

    private var _collideRect:Rectangle;

    private var _drawRoute:Sprite;

    public function SmallMapView3D(param1:MapView3D, param2:MissionInfo)
    {
        _drawMatrix = new Matrix();
        _child = new Dictionary();
        _collideRect = new Rectangle(-45,-30,100,80);
        super();
        _map = param1;
        _missionInfo = param2;
        _processer = new ThingProcesser();
        initView();
        initEvent();
    }

    public function set locked(param1:Boolean) : void
    {
        _locked = param1;
    }

    public function get locked() : Boolean
    {
        return _locked;
    }

    public function set allowDrag(param1:Boolean) : void
    {
        _allowDrag = param1;
        if(!_allowDrag)
        {
            __mouseUp(null);
        }
        var _loc2_:* = _allowDrag;
        _screen.mouseEnabled = _loc2_;
        _screen.mouseChildren = _loc2_;
    }

    public function get rateX() : Number
    {
        return _rateX;
    }

    public function get rateY() : Number
    {
        return _rateY;
    }

    public function get smallMapW() : Number
    {
        return _mask.width;
    }

    public function get smallMapH() : Number
    {
        return _mask.height;
    }

    public function setHardLevel(param1:int, param2:int = 0) : void
    {
        if(param2 == 0)
        {
            _titleBar.title = HARD_LEVEL[param1];
        }
        else
        {
            _titleBar.title = HARD_LEVEL1[param1];
        }
    }

    public function setBarrier(param1:int, param2:int) : void
    {
        _titleBar.setBarrier(param1,param2);
    }

    private function initView() : void
    {
        var _loc1_:* = 96 / _map.bound.height;
        _drawMatrix.d = _loc1_;
        _drawMatrix.a = _loc1_;
        _w = _drawMatrix.a * _map.bound.width;
        _h = _drawMatrix.d * _map.bound.height;
        if(_w > 240)
        {
            _w = 240;
            _loc1_ = 240 / _map.bound.width;
            _drawMatrix.d = _loc1_;
            _drawMatrix.a = _loc1_;
            _h = _drawMatrix.d * _map.bound.height;
        }
        _groundShape = new Sprite();
        addChild(_groundShape);
        _beadShape = new Shape();
        addChild(_beadShape);
        _screen = new DragScreen(StageReferance.stageWidth * _drawMatrix.a,StageReferance.stageHeight * _drawMatrix.d);
        addChild(_screen);
        _thingLayer = new Sprite();
        _loc1_ = false;
        _thingLayer.mouseEnabled = _loc1_;
        _thingLayer.mouseChildren = _loc1_;
        addChild(_thingLayer);
        _foreground = new Shape();
        addChild(_foreground);
        _titleBar = new SmallMapTitleBar(_missionInfo);
        _titleBar.width = _w;
        _titleBar.y = -_titleBar.height + 1;
        _titleBar = new SmallMapTitleBar(_missionInfo);
        if(GameControl.Instance.smallMapGrid())
        {
            _skew = Math.random() * 10 + 5;
            _titleBar.width = _w + _skew * 2 + 2;
            _titleBar.x = -_skew;
        }
        else
        {
            _titleBar.width = _w;
        }
        _titleBar.y = -_titleBar.height + 1;
        y = _titleBar.height;
        if(RoomManager.Instance.current.canShowTitle())
        {
            if(RoomManager.Instance.current.type == 19)
            {
                _titleBar.title = LanguageMgr.GetTranslation("ddt.game.consortiaBattle.txt");
            }
            else if(RoomManager.Instance.current.type == 24)
            {
                _titleBar.title = LanguageMgr.GetTranslation("ddt.ringstation.titleInfo");
            }
            else if(RoomManager.Instance.current.type == 51)
            {
                _titleBar.title = STAR_HARD_LEVEL[RoomManager.Instance.current.hardLevel];
            }
            else if(RoomManager.Instance.current.type == 67)
            {
                _titleBar.title = LanguageMgr.GetTranslation("renshen.ringstation.titleInfo");
            }
            else if(RoomManager.Instance.current.type == 68)
            {
                _titleBar.title = LanguageMgr.GetTranslation("tank.roomlist.RoomListIICreateRvpRoomView.PolarRegion");
            }
            else if(RoomManager.Instance.current.type == 120)
            {
                _titleBar.title = "";
            }
            else
            {
                _titleBar.title = HARD_LEVEL[RoomManager.Instance.current.hardLevel];
            }
        }
        addChild(_titleBar);
        _lineRef = ComponentFactory.Instance.creatBitmapData("asset.game.lineAsset");
        _allLivings = GameControl.Instance.Current.livings;
        drawBackground();
        drawForeground();
        updateSpliter();
        _drawRoute = new Sprite();
        addChild(_drawRoute);
    }

    public function get __StartDrag() : Boolean
    {
        return _startDrag;
    }

    private function drawBackground() : void
    {
        var _loc1_:Graphics = graphics;
        if(!(GameControl.Instance.smallMapBorderEnable() || GameControl.Instance.smallMapShape()))
        {
            _loc1_.clear();
            _loc1_.beginBitmapFill(_lineRef);
            _loc1_.drawRect(0,0,_w,_h);
            _loc1_.endFill();
        }
        _thingLayer.scrollRect = new Rectangle(0,0,_w,_h);
        _loc1_ = _thingLayer.graphics;
        _loc1_.clear();
        _loc1_.beginFill(0,0);
        _loc1_.drawRect(0,0,_w,_h);
        _loc1_.endFill();
    }

    private function drawForeground() : void
    {
        var _loc1_:* = null;
        if(!GameControl.Instance.smallMapBorderEnable())
        {
            if(GameControl.Instance.smallMapGrid())
            {
                drawRandomForeground();
            }
            else
            {
                _loc1_ = _foreground.graphics;
                _loc1_.clear();
                _loc1_.lineStyle(1,6710886);
                _loc1_.beginFill(0,0);
                _loc1_.drawRect(0,0,_w,_h);
                _loc1_.endFill();
            }
        }
    }

    private function drawRandomForeground() : void
    {
        var _loc6_:int = 0;
        var _loc5_:int = 0;
        var _loc4_:int = _skew;
        var _loc7_:int = _loc4_ * 2 + _w;
        var _loc2_:int = _h + _loc4_;
        _foreground.x = -_loc4_;
        var _loc1_:Graphics = _foreground.graphics;
        _loc1_.clear();
        _loc1_.lineStyle(1,6710886);
        var _loc3_:int = 15;
        _loc6_ = 0;
        while(_loc6_ <= _loc3_)
        {
            _loc5_ = Math.random() * 2;
            _loc1_.moveTo(_loc6_ * (_loc7_ / _loc3_) + _loc5_,-_loc4_);
            _loc1_.lineTo(_loc6_ * (_loc7_ / _loc3_) + _loc5_,_loc2_);
            _loc1_.moveTo(0,_loc6_ * (_loc2_ / _loc3_) + _loc5_);
            _loc1_.lineTo(_loc7_,_loc6_ * (_loc2_ / _loc3_) + _loc5_);
            _loc6_++;
        }
        _loc1_.endFill();
    }

    public function get foreMap() : Sprite
    {
        return this;
    }

    private function initViewAsset() : void
    {
    }

    private function updateSpliter() : void
    {
        var _loc3_:int = 0;
        var _loc2_:* = null;
        if(_split == null)
        {
            return;
        }
        while(_split.numChildren > 0)
        {
            _split.removeChildAt(0);
        }
        _texts = [];
        var _loc1_:Number = _screen.width / 10;
        _split.graphics.clear();
        _split.graphics.lineStyle(1,16777215,1);
        _loc3_ = 1;
        while(_loc3_ < 10)
        {
            _split.graphics.moveTo(_loc1_ * _loc3_,0);
            _split.graphics.lineTo(_loc1_ * _loc3_,_screen.height);
            _loc2_ = ClassUtils.CreatInstance(NUMBERS_ARR[_loc3_ - 1]);
            _loc2_.x = _loc1_ * _loc3_;
            _loc2_.y = (_screen.height - _loc2_.height) / 2;
            _loc2_.stop();
            _split.addChild(_loc2_);
            _texts.push(_loc2_);
            _loc3_++;
        }
        _split.graphics.endFill();
    }

    public function ShineText(param1:int) : void
    {
        var _loc2_:int = 0;
        large();
        drawMask();
        _loc2_ = 0;
        while(_loc2_ < param1)
        {
            setTimeout(shineText,_loc2_ * 1500,_loc2_);
            _loc2_++;
        }
    }

    private function drawMask() : void
    {
        var _loc1_:* = null;
        var _loc2_:* = null;
        if(_screenMask == null)
        {
            _loc1_ = getBounds(parent);
            _screenMask = new Sprite();
            _screenMask.graphics.beginFill(0,0.8);
            _screenMask.graphics.drawRect(0,0,StageReferance.stageWidth,StageReferance.stageHeight);
            _screenMask.graphics.endFill();
            _screenMask.blendMode = "layer";
            _loc2_ = new Sprite();
            _loc2_.graphics.beginFill(0,1);
            _loc2_.graphics.drawRect(0,0,_loc1_.width,_loc1_.height);
            _loc2_.graphics.endFill();
            _loc2_.x = this.x;
            _loc2_.y = _loc1_.top;
            _loc2_.blendMode = "erase";
            _screenMask.addChild(_loc2_);
        }
        LayerManager.Instance.addToLayer(_screenMask,3);
    }

    private function clearMask() : void
    {
        if(_screenMask && _screenMask.parent)
        {
            _screenMask.parent.removeChild(_screenMask);
        }
    }

    private function large() : void
    {
        scaleY = 3;
        scaleX = 3;
        x = StageReferance.stageWidth - width >> 1;
        y = StageReferance.stageHeight - height >> 1;
    }

    public function restore() : void
    {
        scaleY = 1;
        scaleX = 1;
        x = StageReferance.stageWidth - width - 1;
        y = _titleBar.height;
        clearMask();
    }

    public function restoreText() : void
    {
        var _loc3_:int = 0;
        var _loc2_:* = _texts;
        for each(var _loc1_ in _texts)
        {
            _loc1_.gotoAndStop(1);
        }
    }

    private function shineText(param1:int) : void
    {
        restoreText();
        if(_split == null)
        {
            _split = new Sprite();
            var _loc2_:Boolean = false;
            _split.mouseEnabled = _loc2_;
            _split.mouseChildren = _loc2_;
            addChild(_split);
            updateSpliter();
        }
        if(param1 > 4)
        {
            (_texts[4] as MovieClip).play();
        }
        else
        {
            (_texts[param1] as MovieClip).play();
        }
    }

    public function showSpliter() : void
    {
        if(_split == null)
        {
            _split = new Sprite();
            var _loc1_:Boolean = false;
            _split.mouseEnabled = _loc1_;
            _split.mouseChildren = _loc1_;
            addChild(_split);
            updateSpliter();
        }
        _split.visible = true;
    }

    public function hideSpliter() : void
    {
        if(_split != null)
        {
            _split.visible = false;
        }
    }

    private function initEvent() : void
    {
        _groundShape.addEventListener("mouseDown",__click);
        _screen.addEventListener("mouseDown",__mouseDown);
    }

    private function removeEvents() : void
    {
        _groundShape.removeEventListener("mouseDown",__click);
        _screen.removeEventListener("mouseDown",__mouseDown);
        StageReferance.stage.removeEventListener("mouseUp",__mouseUp);
        StageReferance.stage.removeEventListener("mouseMove",__mouseMove);
        removeEventListener("enterFrame",__onEnterFrame);
    }

    private function __mouseDown(param1:MouseEvent) : void
    {
        _Screen_X = _screen.x;
        _Screen_Y = _screen.y;
        StageReferance.stage.addEventListener("mouseUp",__mouseUp);
        StageReferance.stage.addEventListener("mouseMove",__mouseMove);
        addEventListener("enterFrame",__onEnterFrame);
        var _loc2_:Rectangle = new Rectangle(0,0,_w,_h);
        _loc2_.top = 0;
        _loc2_.right = _loc2_.right - _screen.width;
        _loc2_.bottom = _loc2_.bottom - _screen.height;
        _screen.startDrag(false,_loc2_);
        _startDrag = true;
    }

    private function __mouseUp(param1:MouseEvent) : void
    {
        _startDrag = false;
        StageReferance.stage.removeEventListener("mouseUp",__mouseUp);
        StageReferance.stage.removeEventListener("mouseMove",__mouseMove);
        removeEventListener("enterFrame",__onEnterFrame);
        _screen.stopDrag();
    }

    public function get screen() : Sprite
    {
        return _screen;
    }

    public function get screenX() : int
    {
        return _Screen_X;
    }

    public function get screenY() : int
    {
        return _Screen_Y;
    }

    private function __mouseMove(param1:MouseEvent) : void
    {
    }

    private function __onEnterFrame(param1:Event) : void
    {
        var _loc3_:Number = NaN;
        var _loc2_:Number = NaN;
        if(_startDrag)
        {
            _loc3_ = (_screen.x + _screen.width / 2) / _drawMatrix.a;
            _loc2_ = (_screen.y + _screen.height / 2) / _drawMatrix.d;
            _map.animateSet.addAnimation(new DragMapAnimation(_loc3_,_loc2_,true));
            if(_split)
            {
                _split.x = _screen.x;
                _split.y = _screen.y;
            }
        }
    }

    public function update() : void
    {
        draw(true);
        drawDead(true);
        updateSpliter();
        if(_split != null)
        {
            _split.x = _screen.x;
            _split.y = _screen.y;
        }
    }

    private function drawDead(param1:Boolean = false) : void
    {
        if(!_map.mapChanged && !param1)
        {
            return;
        }
        if(!_map.stone)
        {
            return;
        }
        var _loc2_:Graphics = _beadShape.graphics;
        _loc2_.clear();
        _loc2_.beginBitmapFill(_map.stone.bitmapData,_drawMatrix,false,true);
        _loc2_.drawRect(0,0,_w,_h);
        _loc2_.endFill();
    }

    public function draw(param1:Boolean = false) : void
    {
        if(!_map.mapChanged && !param1)
        {
            return;
        }
        var _loc2_:Graphics = _groundShape.graphics;
        _loc2_.clear();
        if(!_map.ground)
        {
            _loc2_.beginFill(0,0);
        }
        else
        {
            _loc2_.beginBitmapFill(_map.ground.bitmapData,_drawMatrix,false,true);
        }
        _loc2_.drawRect(0,0,_w,_h);
        _loc2_.endFill();
    }

    public function setScreenPos(param1:Number, param2:Number) : void
    {
        var _loc4_:Number = NaN;
        var _loc5_:Number = NaN;
        var _loc3_:* = null;
        if(!_locked && !_startDrag)
        {
            _loc4_ = Math.abs(param1 * _drawMatrix.a);
            _loc5_ = Math.abs(param2 * _drawMatrix.d);
            _loc3_ = _screen.getBounds(this);
            if(_loc4_ + _screen.width >= _w)
            {
                _screen.x = _w - _screen.width;
            }
            else if(_loc4_ < 0)
            {
                _screen.x = 0;
            }
            else
            {
                _screen.x = _loc4_;
            }
            if(_loc5_ + _screen.height >= _h)
            {
                _screen.y = _h - _screen.height;
            }
            else if(_loc5_ < 0)
            {
                _screen.y = 0;
            }
            else
            {
                _screen.y = _loc5_;
            }
            if(_split != null)
            {
                _split.x = _screen.x;
                _split.y = _screen.y;
            }
        }
    }

    public function addObj(param1:SmallObject) : void
    {
        if(!param1.onProcess)
        {
            addAnimation(param1);
        }
        _thingLayer.addChild(param1);
    }

    public function removeObj(param1:SmallObject) : void
    {
        if(param1.parent == _thingLayer)
        {
            _thingLayer.removeChild(param1);
            if(param1.onProcess)
            {
                removeAnimation(param1);
            }
        }
    }

    public function updatePos(param1:SmallObject, param2:Point) : void
    {
        if(param1 == null)
        {
            return;
        }
        param1.x = param2.x * _drawMatrix.a;
        param1.y = param2.y * _drawMatrix.d;
        _thingLayer.addChild(param1);
    }

    public function addAnimation(param1:SmallObject) : void
    {
        _processer.addThing(param1);
    }

    public function removeAnimation(param1:SmallObject) : void
    {
        _processer.removeThing(param1);
    }

    public function dispose() : void
    {
        removeEvents();
        _missionInfo = null;
        if(_titleBar)
        {
            ObjectUtils.disposeObject(_titleBar);
            _titleBar = null;
        }
        if(_mapBmp)
        {
            if(_mapBmp.parent)
            {
                _mapBmp.parent.removeChild(_mapBmp);
            }
            if(_mapBmp.bitmapData)
            {
                _mapBmp.bitmapData.dispose();
            }
        }
        _mapBmp = null;
        if(_mapDeadBmp)
        {
            if(_mapDeadBmp.parent)
            {
                _mapDeadBmp.parent.removeChild(_mapDeadBmp);
            }
            if(_mapDeadBmp.bitmapData)
            {
                _mapDeadBmp.bitmapData.dispose();
            }
        }
        _mapDeadBmp = null;
        if(_line)
        {
            ObjectUtils.disposeAllChildren(_line);
            if(_line.parent)
            {
                _line.parent.removeChild(_line);
            }
            _line = null;
        }
        if(_screen)
        {
            ObjectUtils.disposeAllChildren(_screen);
            if(_screen.parent)
            {
                _screen.parent.removeChild(_screen);
            }
            _screen = null;
        }
        if(_smallMapContainerBg)
        {
            ObjectUtils.disposeAllChildren(_smallMapContainerBg);
            if(_smallMapContainerBg.parent)
            {
                _smallMapContainerBg.parent.removeChild(_smallMapContainerBg);
            }
            _smallMapContainerBg = null;
        }
        if(_split)
        {
            ObjectUtils.disposeAllChildren(_split);
            if(_split)
            {
                _split.parent.removeChild(_split);
            }
            _split = null;
        }
        if(_mapBorder)
        {
            ObjectUtils.disposeAllChildren(_mapBorder);
            if(_mapBorder.parent)
            {
                _mapBorder.parent.removeChild(_mapBorder);
            }
            _mapBorder = null;
        }
        if(_map.parent)
        {
            _map.parent.removeChild(_map);
        }
        _map = null;
        ObjectUtils.disposeAllChildren(this);
        if(_lineRef)
        {
            _lineRef.dispose();
            _lineRef = null;
        }
        _processer.dispose();
        _processer = null;
        if(parent)
        {
            parent.removeChild(this);
        }
    }

    private function __largeMap(param1:MouseEvent) : void
    {
        _changeScale = 0.2;
        var _loc2_:Number = _rateX;
        var _loc3_:Number = _rateY;
        update();
        updateChildPos(_loc2_,_loc3_);
        SoundManager.instance.play("008");
    }

    private function __smallMap(param1:MouseEvent) : void
    {
        _changeScale = -0.2;
        var _loc2_:Number = _rateX;
        var _loc3_:Number = _rateY;
        update();
        updateChildPos(_loc2_,_loc3_);
        SoundManager.instance.play("008");
    }

    private function updateChildPos(param1:Number, param2:Number) : void
    {
        var _loc5_:int = 0;
        var _loc4_:* = _child;
        for each(var _loc3_ in _child)
        {
            _loc3_.x = _loc3_.x / param1 * _rateX;
            _loc3_.y = _loc3_.y / param2 * _rateY;
        }
    }

    private function __click(param1:MouseEvent) : void
    {
        if(!_locked && _allowDrag)
        {
            _map.animateSet.addAnimation(new DragMapAnimation(param1.localX / _drawMatrix.a,param1.localY / _drawMatrix.d));
        }
    }

    private function __enterFrame(param1:Event) : void
    {
        var _loc3_:Number = (_screen.x + _screen.width / 2) / _rateX;
        var _loc2_:Number = (_screen.y + _screen.height / 2) / _rateY;
        if(_split != null)
        {
            _split.x = _screen.x;
            _split.y = _screen.y;
        }
        _map.animateSet.addAnimation(new DragMapAnimation(_loc3_,_loc2_,true));
    }

    public function moveToPlayer() : void
    {
        var _loc3_:LocalPlayer = GameControl.Instance.Current.selfGamePlayer;
        var _loc2_:Number = _loc3_.pos.x;
        var _loc1_:Number = (_screen.y + _screen.height / 2) / _drawMatrix.d;
        _map.animateSet.addAnimation(new DragMapAnimation(_loc2_,_loc1_,true));
    }

    public function get titleBar() : SmallMapTitleBar
    {
        return _titleBar;
    }

    public function set enableExit(param1:Boolean) : void
    {
        _titleBar.enableExit = param1;
    }

    public function drawRouteLine(param1:int) : void
    {
        var _loc6_:int = 0;
        _drawRoute.graphics.clear();
        var _loc8_:int = 0;
        var _loc7_:* = _allLivings;
        for each(var _loc5_ in _allLivings)
        {
            _loc5_.currentSelectId = param1;
        }
        if(param1 < 0)
        {
            return;
        }
        var _loc4_:Living = _allLivings[param1];
        if(!_loc4_)
        {
            return;
        }
        var _loc3_:Vector.<Point> = _loc4_.route;
        if(!_loc3_ || _loc3_.length == 0)
        {
            return;
        }
        _collideRect.x = _loc4_.pos.x * _drawMatrix.a - 50 * _drawMatrix.a;
        _collideRect.y = _loc4_.pos.y * _drawMatrix.d - 50 * _drawMatrix.d;
        _drawRoute.graphics.lineStyle(1,16711680,1);
        var _loc2_:int = _loc3_.length;
        _loc6_ = 0;
        while(_loc6_ < _loc2_ - 1)
        {
            drawDashed(_drawRoute.graphics,_loc3_[_loc6_],_loc3_[_loc6_ + 1],8,5);
            _loc6_++;
        }
    }

    private function drawDashed(param1:Graphics, param2:Point, param3:Point, param4:Number, param5:Number) : void
    {
        var _loc9_:Number = NaN;
        var _loc11_:Number = NaN;
        if(!param1 || !param2 || !param3 || param4 <= 0 || param5 <= 0)
        {
            return;
        }
        var _loc8_:Number = param2.x * _drawMatrix.a;
        var _loc10_:Number = param2.y * _drawMatrix.d;
        var _loc12_:Number = Math.atan2(param3.y * _drawMatrix.d - _loc10_,param3.x * _drawMatrix.a - _loc8_);
        var _loc7_:* = 0.5;
        trace("small map :" + _loc7_);
        var _loc6_:* = 0;
        while(_loc6_ <= _loc7_)
        {
            if(_collideRect.contains(_loc11_,_loc9_))
            {
                return;
            }
            _loc11_ = _loc8_ + Math.cos(_loc12_) * _loc6_;
            _loc9_ = _loc10_ + Math.sin(_loc12_) * _loc6_;
            param1.moveTo(_loc11_,_loc9_);
            _loc6_ = Number(_loc6_ + param4);
            if(_loc6_ > _loc7_)
            {
                _loc6_ = _loc7_;
            }
            _loc11_ = _loc8_ + Math.cos(_loc12_) * _loc6_;
            _loc9_ = _loc10_ + Math.sin(_loc12_) * _loc6_;
            param1.lineTo(_loc11_,_loc9_);
            _loc6_ = Number(_loc6_ + param5);
        }
    }
}
}

import com.pickgliss.toplevel.StageReferance;
import flash.events.Event;
import flash.utils.getTimer;
import phy.object.SmallObject;

class ThingProcesser
{


    private var _objectList:Vector.<SmallObject>;

    private var _startuped:Boolean = false;

    private var _lastTime:int = 0;

    function ThingProcesser()
    {
        _objectList = new Vector.<SmallObject>();
        super();
    }

    public function addThing(param1:SmallObject) : void
    {
        if(!param1.onProcess)
        {
            _objectList.push(param1);
            param1.onProcess = true;
            startup();
        }
    }

    public function removeThing(param1:SmallObject) : void
    {
        var _loc3_:int = 0;
        if(!param1.onProcess)
        {
            return;
        }
        var _loc2_:int = _objectList.length;
        _loc3_ = 0;
        while(_loc3_ < _loc2_)
        {
            if(_objectList[_loc3_] == param1)
            {
                _objectList.splice(_loc3_,1);
                param1.onProcess = false;
                if(_objectList.length <= 0)
                {
                    shutdown();
                }
                return;
            }
            _loc3_++;
        }
    }

    public function startup() : void
    {
        if(!_startuped)
        {
            _lastTime = getTimer();
            StageReferance.stage.addEventListener("enterFrame",__onFrame);
            _startuped = true;
        }
    }

    private function __onFrame(param1:Event) : void
    {
        var _loc3_:int = getTimer();
        var _loc4_:int = _loc3_ - _lastTime;
        var _loc2_:int = getTimer();
        var _loc7_:int = 0;
        var _loc6_:* = _objectList;
        for each(var _loc5_ in _objectList)
        {
            _loc5_.onFrame(_loc4_);
        }
        _lastTime = _loc3_;
    }

    public function shutdown() : void
    {
        if(_startuped)
        {
            _lastTime = 0;
            StageReferance.stage.removeEventListener("enterFrame",__onFrame);
            _startuped = false;
        }
    }

    public function dispose() : void
    {
        shutdown();
        var _loc1_:SmallObject = _objectList.shift();
        while(_loc1_ != null)
        {
            _loc1_.onProcess = false;
            _loc1_ = _objectList.shift();
        }
        _objectList = null;
    }
}
