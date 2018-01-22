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
      
      public function ShowCharacter3D(param1:PlayerInfo, param2:Boolean = true, param3:Boolean = true, param4:Boolean = false)
      {
         super(param1,false);
         _showGun = param2;
         _showLight = param3;
         _lightPos = new Point(0,0);
         _needMultiFrame = param4;
         _currentAction = "stand";
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         _info.addEventListener("propertychange",__propertyChangeII);
      }
      
      private function __propertyChangeII(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["Nimbus"])
         {
            updateLight();
         }
      }
      
      override public function set showGun(param1:Boolean) : void
      {
         if(param1 == _showGun)
         {
            return;
         }
         _showGun = param1;
         updateCharacter();
      }
      
      override public function set showWing(param1:Boolean) : void
      {
         if(_wing)
         {
            _wing.visible = param1;
         }
         if(param1 == _showWing)
         {
            return;
         }
         _showWing = param1;
      }
      
      override protected function initLoader() : void
      {
         _loader = _factory.createLoader(_info,"show");
         ShowCharacterLoader(_loader).needMultiFrames = _needMultiFrame;
      }
      
      override public function set scaleX(param1:Number) : void
      {
         if(param1 == -1)
         {
            _loading.scaleX = 1;
         }
         _dir = param1;
         .super.scaleX = param1;
         if(_loadCompleted)
         {
         }
         _container.x = param1 < 0?-_characterWidth:0;
      }
      
      override public function setShowLight(param1:Boolean, param2:Point = null) : void
      {
         if(_showLight == param1 && _lightPos == param2)
         {
            return;
         }
         _showLight = param1;
         if(param1)
         {
            if(param2 == null)
            {
               param2 = new Point(0,0);
            }
            _lightPos = param2;
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
         var _loc8_:int = _container.x;
         var _loc7_:int = _container.y;
         var _loc6_:DisplayObjectContainer = _container.parent;
         var _loc3_:int = _loc6_.getChildIndex(_container);
         var _loc4_:Rectangle = _container.getBounds(_container);
         var _loc5_:Sprite = new Sprite();
         _loc6_.removeChild(_container);
         _container.x = -_loc4_.x * _container.scaleX;
         _container.y = -_loc4_.y * _container.scaleX;
         _loc5_.addChild(_container);
         var _loc1_:BitmapData = new BitmapData(_loc5_.width,_loc5_.height,true,0);
         var _loc2_:Bitmap = new Bitmap(_loc1_,"auto",true);
         _loc5_.removeChild(_container);
         _container.x = _loc8_;
         _container.y = _loc7_;
         _loc6_.addChildAt(_container,_loc3_);
         if(_loc5_.width > 140)
         {
            _loc5_.x = _loc5_.width - 17;
         }
         else
         {
            _loc5_.x = _loc5_.width;
         }
         _staticBmp = _loc5_;
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
      
      private function callBack01(param1:BaseLightLayer3D) : void
      {
         if(_light1 && _light1.parent)
         {
            _light1.parent.removeChild(_light1);
         }
         _light1 = param1.getContent3D();
         if(_light1 != null)
         {
            _container.addChildAt(_light1,0);
            _light1.x = _lightPos.x + 47;
            _light1.y = _lightPos.y + 65;
         }
         drawBitmapWithWingAndLight();
         restoreAnimationState();
      }
      
      private function callBack02(param1:SinpleLightLayer3D) : void
      {
         if(_light2 && _light2.parent)
         {
            _light2.parent.removeChild(_light2);
         }
         _light2 = param1.getContent3D();
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
         var _loc1_:* = null;
         if(_loader != null)
         {
            _loc1_ = _loader.getContent();
            if(_characterWithWeapon && _characterWithWeapon != _loc1_[0])
            {
               _characterWithWeapon.dispose();
            }
            if(_characterWithoutWeapon && _characterWithoutWeapon != _loc1_[1])
            {
               _characterWithoutWeapon.dispose();
            }
            _characterWithWeapon = _loc1_[0];
            _characterWithoutWeapon = _loc1_[1];
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
            _wing = _loc1_[2];
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
         var _loc2_:int = _container.getChildIndex(_bodyImage);
         _loc2_ = _loc2_ < 1?0:Number(_loc2_ - 1);
         var _loc1_:Array = _info.Style.split(",");
         var _loc3_:* = ItemManager.Instance.getTemplateById(int(_loc1_[8].split("|")[0])).Property1 != "1";
         if(_info.getSuitsType() == 1 && _loc3_)
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
      
      override protected function __loadComplete(param1:ICharacterLoader) : void
      {
         if(_loading != null)
         {
            if(_loading.parent)
            {
               _loading.parent.removeChild(_loading);
            }
         }
         super.__loadComplete(param1);
         updateLight();
      }
      
      override public function doAction(param1:*) : void
      {
         _currentAction = param1;
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
      
      override public function show(param1:Boolean = true, param2:int = 1, param3:Boolean = true) : void
      {
         super.show(param1,param2,param3);
         if(param3)
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
      
      override public function showWithSize(param1:Boolean = true, param2:int = 1, param3:Number = 120, param4:Number = 165) : void
      {
         if(param3 > 140)
         {
            _container.x = param3 - 17;
         }
         else
         {
            _container.x = param3;
         }
         super.show(param1,param2);
         _bodyImage.width = param3;
         _bodyImage.height = param4;
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
