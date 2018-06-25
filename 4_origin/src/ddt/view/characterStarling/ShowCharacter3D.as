package ddt.view.characterStarling
{
   import bones.display.BoneMovieStarling;
   import com.pickgliss.utils.StarlingObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.ItemManager;
   import ddt.view.character.ICharacterLoader;
   import ddt.view.character.ShowCharacterLoader;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.display.DisplayObjectContainer;
   import starling.display.Sprite;
   
   public class ShowCharacter3D extends BaseCharacter3D
   {
      
      public static const STAND:String = "stand";
      
      public static const WIN:String = "win";
      
      public static const LOST:String = "lost";
      
      public static const BIG_WIDTH:int = 250;
      
      public static const BIG_HEIGHT:int = 342;
       
      
      private var _showLight:Boolean;
      
      private var _lightPos:Point;
      
      private var _light1:BoneMovieStarling;
      
      private var _light2:BoneMovieStarling;
      
      private var _light01:BaseLightLayer3D;
      
      private var _light02:SinpleLightLayer3D;
      
      private var _loading:BoneMovieStarling;
      
      private var _wing:BoneMovieStarling;
      
      private var _staticBmp:Sprite;
      
      private var _showGun:Boolean;
      
      private var _characterWithWeapon:BitmapData;
      
      private var _characterWithoutWeapon:BitmapData;
      
      private var _currentAction:String;
      
      private var _recordNimbus:int;
      
      private var _needMultiFrame:Boolean;
      
      private var _showWing:Boolean = true;
      
      private var _playAnimation:Boolean = true;
      
      private var _wpCrtBmd:BitmapData;
      
      private var _winCrtBmd:BitmapData;
      
      public function ShowCharacter3D(info:PlayerInfo, $showGun:Boolean = true, $showLight:Boolean = true, needMultiFrame:Boolean = false)
      {
         super(info,false);
         _showGun = $showGun;
         _showLight = $showLight;
         _lightPos = new Point(0,0);
         _needMultiFrame = needMultiFrame;
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
         if(_loadCompleted)
         {
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
      
      private function stopWing() : void
      {
         _wing.stop();
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
         _light1.stop();
         _light2.stop();
         stopWing();
      }
      
      private function playAllMoiveClip() : void
      {
         _light1.play();
         _light2.play();
         _wing.play();
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
         var bitmap:Bitmap = new Bitmap(bitmapdata,"auto",true);
         tmpContainer.removeChild(_container);
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
                  _light02 = new SinpleLightLayer3D(_info.Nimbus);
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
                  _light01 = new BaseLightLayer3D(_info.Nimbus);
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
      
      private function callBack01($load:BaseLightLayer3D) : void
      {
         if(_light1 && _light1.parent)
         {
            _light1.parent.removeChild(_light1);
         }
         _light1 = $load.getContent3D();
         if(_light1 != null)
         {
            _container.addChildAt(_light1,0);
            _light1.x = _lightPos.x + 47;
            _light1.y = _lightPos.y + 65;
         }
         drawBitmapWithWingAndLight();
         restoreAnimationState();
      }
      
      private function callBack02($load:SinpleLightLayer3D) : void
      {
         if(_light2 && _light2.parent)
         {
            _light2.parent.removeChild(_light2);
         }
         _light2 = $load.getContent3D();
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
         var bodyIndex:int = _container.getChildIndex(_bodyImage);
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
         if(_bodyImage != null)
         {
            _container.addChild(_bodyImage);
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
            _bodyImage.y = -13;
         }
         else
         {
            _bodyImage.y = 0;
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
            _bodyImage.width = 120;
            _bodyImage.height = 165;
         }
         else
         {
            _bodyImage.width = 250;
            _bodyImage.height = 342;
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
         _bodyImage.width = width;
         _bodyImage.height = height;
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
         StarlingObjectUtils.disposeAllChildren(_staticBmp);
         StarlingObjectUtils.disposeObject(_staticBmp);
         _staticBmp = null;
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
