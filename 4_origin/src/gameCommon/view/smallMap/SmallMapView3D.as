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
      
      public function SmallMapView3D(map:MapView3D, info:MissionInfo)
      {
         _drawMatrix = new Matrix();
         _child = new Dictionary();
         _collideRect = new Rectangle(-45,-30,100,80);
         super();
         _map = map;
         _missionInfo = info;
         _processer = new ThingProcesser();
         initView();
         initEvent();
      }
      
      public function set locked(value:Boolean) : void
      {
         _locked = value;
      }
      
      public function get locked() : Boolean
      {
         return _locked;
      }
      
      public function set allowDrag(value:Boolean) : void
      {
         _allowDrag = value;
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
      
      public function setHardLevel(value:int, type:int = 0) : void
      {
         if(type == 0)
         {
            _titleBar.title = HARD_LEVEL[value];
         }
         else
         {
            _titleBar.title = HARD_LEVEL1[value];
         }
      }
      
      public function setBarrier(val:int, max:int) : void
      {
         _titleBar.setBarrier(val,max);
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
         var g:Graphics = graphics;
         if(!(GameControl.Instance.smallMapBorderEnable() || GameControl.Instance.smallMapShape()))
         {
            g.clear();
            g.beginBitmapFill(_lineRef);
            g.drawRect(0,0,_w,_h);
            g.endFill();
         }
         _thingLayer.scrollRect = new Rectangle(0,0,_w,_h);
         g = _thingLayer.graphics;
         g.clear();
         g.beginFill(0,0);
         g.drawRect(0,0,_w,_h);
         g.endFill();
      }
      
      private function drawForeground() : void
      {
         var pen:* = null;
         if(!GameControl.Instance.smallMapBorderEnable())
         {
            if(GameControl.Instance.smallMapGrid())
            {
               drawRandomForeground();
            }
            else
            {
               pen = _foreground.graphics;
               pen.clear();
               pen.lineStyle(1,6710886);
               pen.beginFill(0,0);
               pen.drawRect(0,0,_w,_h);
               pen.endFill();
            }
         }
      }
      
      private function drawRandomForeground() : void
      {
         var i:int = 0;
         var skew:int = 0;
         var skewWH:int = _skew;
         var skewW:int = skewWH * 2 + _w;
         var skewH:int = _h + skewWH;
         _foreground.x = -skewWH;
         var pen:Graphics = _foreground.graphics;
         pen.clear();
         pen.lineStyle(1,6710886);
         var c:int = 15;
         for(i = 0; i <= c; )
         {
            skew = Math.random() * 2;
            pen.moveTo(i * (skewW / c) + skew,-skewWH);
            pen.lineTo(i * (skewW / c) + skew,skewH);
            pen.moveTo(0,i * (skewH / c) + skew);
            pen.lineTo(skewW,i * (skewH / c) + skew);
            i++;
         }
         pen.endFill();
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
         var i:int = 0;
         var round:* = null;
         if(_split == null)
         {
            return;
         }
         while(_split.numChildren > 0)
         {
            _split.removeChildAt(0);
         }
         _texts = [];
         var perW:Number = _screen.width / 10;
         _split.graphics.clear();
         _split.graphics.lineStyle(1,16777215,1);
         for(i = 1; i < 10; )
         {
            _split.graphics.moveTo(perW * i,0);
            _split.graphics.lineTo(perW * i,_screen.height);
            round = ClassUtils.CreatInstance(NUMBERS_ARR[i - 1]);
            round.x = perW * i;
            round.y = (_screen.height - round.height) / 2;
            round.stop();
            _split.addChild(round);
            _texts.push(round);
            i++;
         }
         _split.graphics.endFill();
      }
      
      public function ShineText(value:int) : void
      {
         var i:int = 0;
         large();
         drawMask();
         for(i = 0; i < value; )
         {
            setTimeout(shineText,i * 1500,i);
            i++;
         }
      }
      
      private function drawMask() : void
      {
         var bounds:* = null;
         var hole:* = null;
         if(_screenMask == null)
         {
            bounds = getBounds(parent);
            _screenMask = new Sprite();
            _screenMask.graphics.beginFill(0,0.8);
            _screenMask.graphics.drawRect(0,0,StageReferance.stageWidth,StageReferance.stageHeight);
            _screenMask.graphics.endFill();
            _screenMask.blendMode = "layer";
            hole = new Sprite();
            hole.graphics.beginFill(0,1);
            hole.graphics.drawRect(0,0,bounds.width,bounds.height);
            hole.graphics.endFill();
            hole.x = this.x;
            hole.y = bounds.top;
            hole.blendMode = "erase";
            _screenMask.addChild(hole);
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
         for each(var round in _texts)
         {
            round.gotoAndStop(1);
         }
      }
      
      private function shineText(i:int) : void
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
         if(i > 4)
         {
            (_texts[4] as MovieClip).play();
         }
         else
         {
            (_texts[i] as MovieClip).play();
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
      
      private function __mouseDown(evt:MouseEvent) : void
      {
         _Screen_X = _screen.x;
         _Screen_Y = _screen.y;
         StageReferance.stage.addEventListener("mouseUp",__mouseUp);
         StageReferance.stage.addEventListener("mouseMove",__mouseMove);
         addEventListener("enterFrame",__onEnterFrame);
         var dragBounds:Rectangle = new Rectangle(0,0,_w,_h);
         dragBounds.top = 0;
         dragBounds.right = dragBounds.right - _screen.width;
         dragBounds.bottom = dragBounds.bottom - _screen.height;
         _screen.startDrag(false,dragBounds);
         _startDrag = true;
      }
      
      private function __mouseUp(evt:MouseEvent) : void
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
      
      private function __mouseMove(evt:MouseEvent) : void
      {
      }
      
      private function __onEnterFrame(evt:Event) : void
      {
         var tx:Number = NaN;
         var ty:Number = NaN;
         if(_startDrag)
         {
            tx = (_screen.x + _screen.width / 2) / _drawMatrix.a;
            ty = (_screen.y + _screen.height / 2) / _drawMatrix.d;
            _map.animateSet.addAnimation(new DragMapAnimation(tx,ty,true));
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
      
      private function drawDead(mustDraw:Boolean = false) : void
      {
         if(!_map.mapChanged && !mustDraw)
         {
            return;
         }
         if(!_map.stone)
         {
            return;
         }
         var pen:Graphics = _beadShape.graphics;
         pen.clear();
         pen.beginBitmapFill(_map.stone.bitmapData,_drawMatrix,false,true);
         pen.drawRect(0,0,_w,_h);
         pen.endFill();
      }
      
      public function draw(mustDraw:Boolean = false) : void
      {
         if(!_map.mapChanged && !mustDraw)
         {
            return;
         }
         var pen:Graphics = _groundShape.graphics;
         pen.clear();
         if(!_map.ground)
         {
            pen.beginFill(0,0);
         }
         else
         {
            pen.beginBitmapFill(_map.ground.bitmapData,_drawMatrix,false,true);
         }
         pen.drawRect(0,0,_w,_h);
         pen.endFill();
      }
      
      public function setScreenPos(posX:Number, posY:Number) : void
      {
         var newX:Number = NaN;
         var newY:Number = NaN;
         var bounds:* = null;
         if(!_locked && !_startDrag)
         {
            newX = Math.abs(posX * _drawMatrix.a);
            newY = Math.abs(posY * _drawMatrix.d);
            bounds = _screen.getBounds(this);
            if(newX + _screen.width >= _w)
            {
               _screen.x = _w - _screen.width;
            }
            else if(newX < 0)
            {
               _screen.x = 0;
            }
            else
            {
               _screen.x = newX;
            }
            if(newY + _screen.height >= _h)
            {
               _screen.y = _h - _screen.height;
            }
            else if(newY < 0)
            {
               _screen.y = 0;
            }
            else
            {
               _screen.y = newY;
            }
            if(_split != null)
            {
               _split.x = _screen.x;
               _split.y = _screen.y;
            }
         }
      }
      
      public function addObj(object:SmallObject) : void
      {
         if(!object.onProcess)
         {
            addAnimation(object);
         }
         _thingLayer.addChild(object);
      }
      
      public function removeObj(object:SmallObject) : void
      {
         if(object.parent == _thingLayer)
         {
            _thingLayer.removeChild(object);
            if(object.onProcess)
            {
               removeAnimation(object);
            }
         }
      }
      
      public function updatePos(object:SmallObject, pos:Point) : void
      {
         if(object == null)
         {
            return;
         }
         object.x = pos.x * _drawMatrix.a;
         object.y = pos.y * _drawMatrix.d;
         _thingLayer.addChild(object);
      }
      
      public function addAnimation(object:SmallObject) : void
      {
         _processer.addThing(object);
      }
      
      public function removeAnimation(object:SmallObject) : void
      {
         _processer.removeThing(object);
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
      
      private function __largeMap(event:MouseEvent) : void
      {
         _changeScale = 0.2;
         var oldRateX:Number = _rateX;
         var oldRateY:Number = _rateY;
         update();
         updateChildPos(oldRateX,oldRateY);
         SoundManager.instance.play("008");
      }
      
      private function __smallMap(event:MouseEvent) : void
      {
         _changeScale = -0.2;
         var oldRateX:Number = _rateX;
         var oldRateY:Number = _rateY;
         update();
         updateChildPos(oldRateX,oldRateY);
         SoundManager.instance.play("008");
      }
      
      private function updateChildPos(oldRateX:Number, oldRateY:Number) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = _child;
         for each(var c in _child)
         {
            c.x = c.x / oldRateX * _rateX;
            c.y = c.y / oldRateY * _rateY;
         }
      }
      
      private function __click(event:MouseEvent) : void
      {
         if(!_locked && _allowDrag)
         {
            _map.animateSet.addAnimation(new DragMapAnimation(event.localX / _drawMatrix.a,event.localY / _drawMatrix.d));
         }
      }
      
      private function __enterFrame(event:Event) : void
      {
         var tx:Number = (_screen.x + _screen.width / 2) / _rateX;
         var ty:Number = (_screen.y + _screen.height / 2) / _rateY;
         if(_split != null)
         {
            _split.x = _screen.x;
            _split.y = _screen.y;
         }
         _map.animateSet.addAnimation(new DragMapAnimation(tx,ty,true));
      }
      
      public function moveToPlayer() : void
      {
         var player:LocalPlayer = GameControl.Instance.Current.selfGamePlayer;
         var tx:Number = player.pos.x;
         var ty:Number = (_screen.y + _screen.height / 2) / _drawMatrix.d;
         _map.animateSet.addAnimation(new DragMapAnimation(tx,ty,true));
      }
      
      public function get titleBar() : SmallMapTitleBar
      {
         return _titleBar;
      }
      
      public function set enableExit(b:Boolean) : void
      {
         _titleBar.enableExit = b;
      }
      
      public function drawRouteLine(id:int) : void
      {
         var i:int = 0;
         _drawRoute.graphics.clear();
         var _loc8_:int = 0;
         var _loc7_:* = _allLivings;
         for each(var liv in _allLivings)
         {
            liv.currentSelectId = id;
         }
         if(id < 0)
         {
            return;
         }
         var living:Living = _allLivings[id];
         if(!living)
         {
            return;
         }
         var data:Vector.<Point> = living.route;
         if(!data || data.length == 0)
         {
            return;
         }
         _collideRect.x = living.pos.x * _drawMatrix.a - 50 * _drawMatrix.a;
         _collideRect.y = living.pos.y * _drawMatrix.d - 50 * _drawMatrix.d;
         _drawRoute.graphics.lineStyle(1,16711680,1);
         var length:int = data.length;
         for(i = 0; i < length - 1; )
         {
            drawDashed(_drawRoute.graphics,data[i],data[i + 1],8,5);
            i++;
         }
      }
      
      private function drawDashed(graphics:Graphics, beginPoint:Point, endPoint:Point, width:Number, grap:Number) : void
      {
         var y:Number = NaN;
         var x:Number = NaN;
         if(!graphics || !beginPoint || !endPoint || width <= 0 || grap <= 0)
         {
            return;
         }
         var Ox:Number = beginPoint.x * _drawMatrix.a;
         var Oy:Number = beginPoint.y * _drawMatrix.d;
         var radian:Number = Math.atan2(endPoint.y * _drawMatrix.d - Oy,endPoint.x * _drawMatrix.a - Ox);
         var totalLen:* = 0.5;
         trace("small map :" + totalLen);
         var currLen:* = 0;
         while(currLen <= totalLen)
         {
            if(_collideRect.contains(x,y))
            {
               return;
            }
            x = Ox + Math.cos(radian) * currLen;
            y = Oy + Math.sin(radian) * currLen;
            graphics.moveTo(x,y);
            currLen = Number(currLen + width);
            if(currLen > totalLen)
            {
               currLen = totalLen;
            }
            x = Ox + Math.cos(radian) * currLen;
            y = Oy + Math.sin(radian) * currLen;
            graphics.lineTo(x,y);
            currLen = Number(currLen + grap);
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
   
   public function addThing(object:SmallObject) : void
   {
      if(!object.onProcess)
      {
         _objectList.push(object);
         object.onProcess = true;
         startup();
      }
   }
   
   public function removeThing(object:SmallObject) : void
   {
      var i:int = 0;
      if(!object.onProcess)
      {
         return;
      }
      var len:int = _objectList.length;
      for(i = 0; i < len; )
      {
         if(_objectList[i] == object)
         {
            _objectList.splice(i,1);
            object.onProcess = false;
            if(_objectList.length <= 0)
            {
               shutdown();
            }
            return;
         }
         i++;
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
   
   private function __onFrame(evt:Event) : void
   {
      var now:int = getTimer();
      var frameRate:int = now - _lastTime;
      var testStart:int = getTimer();
      var _loc7_:int = 0;
      var _loc6_:* = _objectList;
      for each(var object in _objectList)
      {
         object.onFrame(frameRate);
      }
      _lastTime = now;
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
      var object:SmallObject = _objectList.shift();
      while(object != null)
      {
         object.onProcess = false;
         object = _objectList.shift();
      }
      _objectList = null;
   }
}
