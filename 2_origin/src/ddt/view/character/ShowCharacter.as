package ddt.view.character
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.ItemManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ShowCharacter extends BaseCharacter
   {
      
      public static const STAND:String = "stand";
      
      public static const WIN:String = "win";
      
      public static const LOST:String = "lost";
      
      public static const BIG_WIDTH:int = 250;
      
      public static const BIG_HEIGHT:int = 342;
       
      
      private var _showLight:Boolean;
      
      private var _lightPos:Point;
      
      private var _light1:MovieClip;
      
      private var _light2:MovieClip;
      
      private var _light01:BaseLightLayer;
      
      private var _light02:SinpleLightLayer;
      
      private var _loading:MovieClip;
      
      private var _showGun:Boolean;
      
      private var _characterWithWeapon:BitmapData;
      
      private var _characterWithoutWeapon:BitmapData;
      
      private var _wing:MovieClip;
      
      private var _staticBmp:Sprite;
      
      private var _currentAction:String;
      
      private var _recordNimbus:int;
      
      private var _needMultiFrame:Boolean;
      
      private var _showWing:Boolean = true;
      
      private var _playAnimation:Boolean = true;
      
      private var _wpCrtBmd:BitmapData;
      
      private var _winCrtBmd:BitmapData;
      
      public function ShowCharacter(info:PlayerInfo, $showGun:Boolean = true, $showLight:Boolean = true, needMultiFrame:Boolean = false)
      {
         super(info,false);
         _showGun = $showGun;
         _showLight = $showLight;
         _lightPos = new Point(0,0);
         _needMultiFrame = needMultiFrame;
         _loading = ComponentFactory.Instance.creat("asset.core.character.FigureBgAsset") as MovieClip;
         _container.addChild(_loading);
         _currentAction = "stand";
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         _info.addEventListener("propertychange",__propertyChangeII);
      }
      
      private function __propertyChangeII(evt:PlayerPropertyEvent) : void
      {
         if(evt.changedProperties["Nimbus"])
         {
            updateLight();
         }
      }
      
      override public function set showGun(value:Boolean) : void
      {
         if(value == _showGun)
         {
            return;
         }
         _showGun = value;
         updateCharacter();
      }
      
      override public function set showWing(value:Boolean) : void
      {
         if(_wing)
         {
            _wing.visible = value;
         }
         if(value == _showWing)
         {
            return;
         }
         _showWing = value;
      }
      
      override protected function initLoader() : void
      {
         _loader = _factory.createLoader(_info,"show");
         ShowCharacterLoader(_loader).needMultiFrames = _needMultiFrame;
      }
      
      override public function set scaleX(value:Number) : void
      {
         if(value == -1)
         {
            _loading.scaleX = 1;
         }
         _dir = value;
         .super.scaleX = value;
         if(!_loadCompleted)
         {
            _loading.loading1.visible = value == 1;
            _loading.loading2.visible = !_loading.loading1.visible;
         }
         _container.x = value < 0?-_characterWidth:0;
      }
      
      override public function setShowLight(b:Boolean, p:Point = null) : void
      {
         if(_showLight == b && _lightPos == p)
         {
            return;
         }
         _showLight = b;
         if(b)
         {
            if(p == null)
            {
               p = new Point(0,0);
            }
            _lightPos = p;
         }
         updateLight();
      }
      
      private function stopMovieClip(mc:MovieClip) : void
      {
         var i:int = 0;
         if(mc)
         {
            mc.gotoAndStop(1);
            if(mc.numChildren > 0)
            {
               for(i = 0; i < mc.numChildren; )
               {
                  stopMovieClip(mc.getChildAt(i) as MovieClip);
                  i++;
               }
            }
         }
      }
      
      private function playMovieClip(mc:MovieClip) : void
      {
         var i:int = 0;
         if(mc)
         {
            mc.gotoAndPlay(1);
            if(mc.numChildren > 0)
            {
               for(i = 0; i < mc.numChildren; )
               {
                  playMovieClip(mc.getChildAt(i) as MovieClip);
                  i++;
               }
            }
         }
      }
      
      private function stopWing() : void
      {
         stopMovieClip(_wing);
      }
      
      public function stopAnimation() : void
      {
         _playAnimation = false;
         stopAllMoiveClip();
      }
      
      public function playAnimation() : void
      {
         _playAnimation = true;
         playAllMoiveClip();
      }
      
      private function stopAllMoiveClip() : void
      {
         stopMovieClip(_light1);
         stopMovieClip(_light2);
         stopWing();
      }
      
      private function playAllMoiveClip() : void
      {
         playMovieClip(_light1);
         playMovieClip(_light2);
         playMovieClip(_wing);
      }
      
      private function restoreAnimationState() : void
      {
         if(_playAnimation)
         {
            playAllMoiveClip();
         }
         else
         {
            stopAllMoiveClip();
         }
      }
      
      private function drawBitmapWithWingAndLight() : void
      {
         if(_container == null || !_loadCompleted)
         {
            return;
         }
         stopAllMoiveClip();
         var _originalX:int = _container.x;
         var _originalY:int = _container.y;
         var pContainer:DisplayObjectContainer = _container.parent;
         var pIndex:int = pContainer.getChildIndex(_container);
         var clipRect:Rectangle = _container.getBounds(_container);
         var tmpContainer:Sprite = new Sprite();
         pContainer.removeChild(_container);
         _container.x = -clipRect.x * _container.scaleX;
         _container.y = -clipRect.y * _container.scaleX;
         tmpContainer.addChild(_container);
         var bitmapdata:BitmapData = new BitmapData(tmpContainer.width,tmpContainer.height,true,0);
         bitmapdata.draw(tmpContainer);
         var bitmap:Bitmap = new Bitmap(bitmapdata,"auto",true);
         tmpContainer.removeChild(_container);
         tmpContainer.addChild(bitmap);
         _container.x = _originalX;
         _container.y = _originalY;
         pContainer.addChildAt(_container,pIndex);
         if(tmpContainer.width > 140)
         {
            tmpContainer.x = tmpContainer.width - 17;
         }
         else
         {
            tmpContainer.x = tmpContainer.width;
         }
         _staticBmp = tmpContainer;
         restoreAnimationState();
      }
      
      override public function getShowBitmapBig() : *
      {
         if(_staticBmp == null)
         {
            drawBitmapWithWingAndLight();
         }
         return _staticBmp;
      }
      
      override public function resetShowBitmapBig() : void
      {
         if(_staticBmp && _staticBmp.parent)
         {
            _staticBmp.parent.removeChild(_staticBmp);
         }
         _staticBmp = null;
      }
      
      private function updateLight() : void
      {
         if(_info == null)
         {
            return;
         }
         if(_showLight && currentAction == "stand")
         {
            if(_recordNimbus != _info.Nimbus)
            {
               _recordNimbus = _info.Nimbus;
               if(_info.getHaveLight())
               {
                  if(_light02)
                  {
                     _light02.dispose();
                  }
                  _light02 = new SinpleLightLayer(_info.Nimbus);
                  _light02.load(callBack02);
               }
               else
               {
                  if(_light02)
                  {
                     _light02.dispose();
                  }
                  if(_light2 && _light2.parent)
                  {
                     _light2.parent.removeChild(_light2);
                  }
                  _light2 = null;
               }
               if(_info.getHaveCircle())
               {
                  if(_light01)
                  {
                     _light01.dispose();
                  }
                  _light01 = new BaseLightLayer(_info.Nimbus);
                  _light01.load(callBack01);
               }
               else
               {
                  if(_light01)
                  {
                     _light01.dispose();
                  }
                  if(_light1 && _light1.parent)
                  {
                     _light1.parent.removeChild(_light1);
                  }
                  _light1 = null;
               }
            }
         }
         else
         {
            _recordNimbus = 0;
            if(_light01)
            {
               _light01.dispose();
            }
            if(_light02)
            {
               _light02.dispose();
            }
            if(_light1 && _light1.parent)
            {
               _light1.parent.removeChild(_light1);
            }
            if(_light2 && _light2.parent)
            {
               _light2.parent.removeChild(_light2);
            }
            _light1 = null;
            _light2 = null;
         }
      }
      
      private function callBack01($load:BaseLightLayer) : void
      {
         if(_light1 && _light1.parent)
         {
            _light1.parent.removeChild(_light1);
         }
         _light1 = $load.getContent() as MovieClip;
         if(_light1 != null)
         {
            _container.addChildAt(_light1,0);
            _light1.x = _lightPos.x + 47;
            _light1.y = _lightPos.y + 65;
         }
         drawBitmapWithWingAndLight();
         restoreAnimationState();
      }
      
      private function callBack02($load:SinpleLightLayer) : void
      {
         if(_light2 && _light2.parent)
         {
            _light2.parent.removeChild(_light2);
         }
         _light2 = $load.getContent() as MovieClip;
         if(_light2 != null)
         {
            _container.addChild(_light2);
            _light2.x = _lightPos.x + 45;
            _light2.y = _lightPos.y + 126;
         }
         drawBitmapWithWingAndLight();
         restoreAnimationState();
      }
      
      private function updateCharacter() : void
      {
         if(_loader != null && _loader.getContent()[0] != null)
         {
            __loadComplete(_loader);
         }
         else
         {
            setContent();
         }
      }
      
      public function get characterWithWeapon() : BitmapData
      {
         return _characterWithWeapon;
      }
      
      override protected function setContent() : void
      {
         var t:* = null;
         if(_loader != null)
         {
            t = _loader.getContent();
            if(_characterWithWeapon && _characterWithWeapon != t[0])
            {
               _characterWithWeapon.dispose();
            }
            if(_characterWithoutWeapon && _characterWithoutWeapon != t[1])
            {
               _characterWithoutWeapon.dispose();
            }
            _characterWithWeapon = t[0];
            _characterWithoutWeapon = t[1];
            if(_wpCrtBmd)
            {
               _wpCrtBmd.dispose();
            }
            _wpCrtBmd = null;
            if(_winCrtBmd)
            {
               _winCrtBmd.dispose();
            }
            _winCrtBmd = null;
            if(_wing && _wing.parent)
            {
               _wing.parent.removeChild(_wing);
            }
            _wing = t[2];
         }
         if(_showGun)
         {
            characterBitmapdata = _characterWithWeapon;
         }
         else
         {
            characterBitmapdata = _characterWithoutWeapon;
         }
         doAction(_currentAction);
         drawBitmapWithWingAndLight();
      }
      
      public function get charaterWithoutWeapon() : BitmapData
      {
         if(_wpCrtBmd == null)
         {
            _wpCrtBmd = new BitmapData(_characterWidth,_characterHeight,true,0);
            _wpCrtBmd.copyPixels(_characterWithoutWeapon,_frames[0],new Point(0,0));
         }
         return _wpCrtBmd;
      }
      
      public function get winCharater() : BitmapData
      {
         if(_winCrtBmd == null)
         {
            _winCrtBmd = new BitmapData(_characterWidth,_characterHeight,true,0);
            _winCrtBmd.copyPixels(_characterBitmapdata,_frames[1],new Point(0,0));
         }
         return _winCrtBmd;
      }
      
      private function updateWing() : void
      {
         if(!_showWing || _wing == null)
         {
            if(!_showWing && _wing)
            {
               _wing.visible = false;
            }
            return;
         }
         var bodyIndex:int = _container.getChildIndex(_body);
         bodyIndex = bodyIndex < 1?0:Number(bodyIndex - 1);
         var _recordStyle:Array = _info.Style.split(",");
         var shouldAdapt:* = ItemManager.Instance.getTemplateById(int(_recordStyle[8].split("|")[0])).Property1 != "1";
         if(_info.getSuitsType() == 1 && shouldAdapt)
         {
            _wing.y = -40;
         }
         else
         {
            _wing.y = 2;
            _wing.x = -1;
         }
         if(_info.wingHide)
         {
            if(_wing.parent != null)
            {
               _wing.parent.removeChild(_wing);
            }
         }
         else
         {
            _container.addChild(_wing);
         }
         sortIndex();
      }
      
      private function sortIndex() : void
      {
         if(_light1 != null)
         {
            _container.addChild(_light1);
         }
         if(_wing != null && !_info.wingHide)
         {
            _container.addChild(_wing);
         }
         if(_body != null)
         {
            _container.addChild(_body);
         }
         if(_light2 != null)
         {
            _container.addChild(_light2);
         }
      }
      
      public function removeWing() : void
      {
         if(_wing && _wing.parent)
         {
            _wing.parent.removeChild(_wing);
         }
      }
      
      override protected function __loadComplete(loader:ICharacterLoader) : void
      {
         if(_loading != null)
         {
            if(_loading.parent)
            {
               _loading.parent.removeChild(_loading);
            }
         }
         super.__loadComplete(loader);
         updateLight();
      }
      
      override public function doAction(actionType:*) : void
      {
         _currentAction = actionType;
         if(_info.getSuitsType() == 1)
         {
            _body.y = -13;
         }
         else
         {
            _body.y = 0;
         }
         var _loc2_:* = _currentAction;
         if("stand" !== _loc2_)
         {
            if("win" !== _loc2_)
            {
               if("lost" === _loc2_)
               {
                  drawFrame(2);
                  removeWing();
               }
            }
            else
            {
               drawFrame(1);
               removeWing();
            }
         }
         else
         {
            drawFrame(0);
            updateWing();
         }
      }
      
      override protected function initSizeAndPics() : void
      {
         setCharacterSize(250,342);
         setPicNum(1,2);
      }
      
      override public function show(clearLoader:Boolean = true, dir:int = 1, small:Boolean = true) : void
      {
         super.show(clearLoader,dir,small);
         if(small)
         {
            _body.width = 120;
            _body.height = 165;
            _body.cacheAsBitmap = false;
         }
         else
         {
            _body.width = 250;
            _body.height = 342;
            _body.cacheAsBitmap = false;
         }
      }
      
      override public function showWithSize(clearLoader:Boolean = true, dir:int = 1, width:Number = 120, height:Number = 165) : void
      {
         if(width > 140)
         {
            _container.x = width - 17;
         }
         else
         {
            _container.x = width;
         }
         super.show(clearLoader,dir);
         _body.width = width;
         _body.height = height;
         _body.cacheAsBitmap = false;
      }
      
      override public function get currentAction() : *
      {
         return _currentAction;
      }
      
      override public function dispose() : void
      {
         if(_info)
         {
            _info.removeEventListener("propertychange",__propertyChangeII);
         }
         if(_light01)
         {
            _light01.dispose();
         }
         _light01 = null;
         if(_light02)
         {
            _light02.dispose();
         }
         _light02 = null;
         if(_light2 && _light2.parent)
         {
            _light2.parent.removeChild(_light2);
         }
         _light2 = null;
         if(_light1 && _light1.parent)
         {
            _light1.parent.removeChild(_light1);
         }
         _light1 = null;
         super.dispose();
         if(_characterWithoutWeapon)
         {
            _characterWithoutWeapon.dispose();
         }
         _characterWithoutWeapon = null;
         if(_staticBmp)
         {
            ObjectUtils.disposeAllChildren(_staticBmp);
            ObjectUtils.disposeObject(_staticBmp);
            _staticBmp = null;
         }
         if(_characterWithWeapon)
         {
            _characterWithWeapon.dispose();
         }
         _characterWithWeapon = null;
         if(_wing && _wing.parent)
         {
            _wing.parent.removeChild(_wing);
         }
         _wing = null;
         if(_winCrtBmd)
         {
            _winCrtBmd.dispose();
         }
         _winCrtBmd = null;
         if(_wpCrtBmd)
         {
            _wpCrtBmd.dispose();
         }
         _wpCrtBmd = null;
         if(_loading && _loading.parent)
         {
            _loading.parent.removeChild(_loading);
         }
         _loading = null;
         _lightPos = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
