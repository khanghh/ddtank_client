package ddt.view.characterStarling
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StarlingObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.view.character.GameCharacterLoader;
   import ddt.view.character.ICharacter;
   import ddt.view.character.ICharacterLoader;
   import ddt.view.character.ICharacterLoaderFactory;
   import ddt.view.character.ShowCharacterLoader;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.events.Event;
   import starling.textures.Texture;
   
   public class BaseCharacter3D extends Sprite implements ICharacter, Disposeable
   {
      
      public static const BASE_WIDTH:int = 120;
      
      public static const BASE_HEIGHT:int = 165;
       
      
      protected var _info:PlayerInfo;
      
      protected var _frames:Array;
      
      protected var _loader:ICharacterLoader;
      
      protected var _characterWidth:Number;
      
      protected var _characterHeight:Number;
      
      protected var _factory:ICharacterLoaderFactory;
      
      protected var _dir:int;
      
      protected var _currentframe:int;
      
      protected var _loadCompleted:Boolean;
      
      protected var _picLines:int;
      
      protected var _picsPerLine:int;
      
      private var _autoClearLoader:Boolean;
      
      protected var _bitmapChanged:Boolean;
      
      protected var _container:Sprite;
      
      protected var _bodyImage:Image;
      
      protected var _body:Bitmap;
      
      protected var _characterBitmapdata:BitmapData;
      
      private var _lifeUpdate:Boolean;
      
      private var _disposed:Boolean;
      
      public function BaseCharacter3D(info:PlayerInfo, lifeUpdate:Boolean)
      {
         _info = info;
         _lifeUpdate = lifeUpdate;
         super();
         init();
         initEvent();
      }
      
      public function get characterWidth() : Number
      {
         return _characterWidth;
      }
      
      public function get characterHeight() : Number
      {
         return _characterHeight;
      }
      
      protected function init() : void
      {
         _currentframe = -1;
         initSizeAndPics();
         createFrames();
         _container = new Sprite();
         addChild(_container);
         _body = new Bitmap(new BitmapData(_characterWidth + 1,_characterHeight,true,0),"never",true);
         _bodyImage = Image.fromBitmap(_body,false);
         _container.addChild(_bodyImage);
         touchable = false;
         _loadCompleted = false;
      }
      
      protected function initSizeAndPics() : void
      {
         setCharacterSize(120,165);
         setPicNum(1,3);
      }
      
      protected function initEvent() : void
      {
         _info.addEventListener("propertychange",__propertyChange);
         addEventListener("addedToStage",__addToStage);
         addEventListener("removedFromStage",__removeFromStage);
      }
      
      private function __addToStage(event:Event) : void
      {
         if(_lifeUpdate)
         {
            addEventListener("enterFrame",__enterFrame);
         }
      }
      
      private function __removeFromStage(event:Event) : void
      {
         removeEventListener("enterFrame",__enterFrame);
      }
      
      private function __enterFrame(event:Event) : void
      {
         update();
      }
      
      public function update() : void
      {
      }
      
      private function __propertyChange(evt:PlayerPropertyEvent) : void
      {
         if(_disposed)
         {
            return;
         }
         if(evt.changedProperties["Style"] || evt.changedProperties["Colors"])
         {
            if(_loader == null || _loader is GameCharacterLoader)
            {
               if(_loader)
               {
                  _loader.dispose();
                  _loader = null;
               }
               initLoader();
               _loader.load(__loadComplete);
            }
            else
            {
               _loader.update();
            }
         }
      }
      
      protected function setCharacterSize(w:Number, h:Number) : void
      {
         _characterWidth = w;
         _characterHeight = h;
      }
      
      protected function setPicNum(lines:int, perline:int) : void
      {
         _picLines = lines;
         _picsPerLine = perline;
      }
      
      public function setColor(color:*) : Boolean
      {
         return false;
      }
      
      public function get info() : PlayerInfo
      {
         return _info;
      }
      
      public function get currentFrame() : int
      {
         return _currentframe;
      }
      
      public function set characterBitmapdata(value:BitmapData) : void
      {
         if(value == _characterBitmapdata)
         {
            return;
         }
         _characterBitmapdata = value;
         _bitmapChanged = true;
      }
      
      public function get characterBitmapdata() : BitmapData
      {
         return _characterBitmapdata;
      }
      
      public function get completed() : Boolean
      {
         return _loadCompleted;
      }
      
      public function getCharacterLoadLog() : String
      {
         if(_loader is ShowCharacterLoader)
         {
            return (_loader as ShowCharacterLoader).getUnCompleteLog();
         }
         return "not ShowCharacterLoader";
      }
      
      public function doAction(actionType:*) : void
      {
      }
      
      public function setDefaultAction(actionType:*) : void
      {
      }
      
      public function show(clearLoader:Boolean = true, dir:int = 1, small:Boolean = true) : void
      {
         _dir = dir > 0?1:-1;
         scaleX = _dir;
         _autoClearLoader = clearLoader;
         if(!_loadCompleted)
         {
            if(_loader == null)
            {
               initLoader();
            }
            _loader.load(__loadComplete);
         }
      }
      
      protected function __loadComplete(loader:ICharacterLoader) : void
      {
         _loadCompleted = true;
         setContent();
         if(_autoClearLoader && _loader != null)
         {
            _loader.dispose();
            _loader = null;
         }
         dispatchEvent(new Event("complete"));
      }
      
      protected function setContent() : void
      {
         if(_loader != null)
         {
            if(_characterBitmapdata && _characterBitmapdata != _loader.getContent()[0])
            {
               _characterBitmapdata.dispose();
            }
            characterBitmapdata = _loader.getContent()[0];
         }
         drawFrame(_currentframe);
      }
      
      public function setFactory(factory:ICharacterLoaderFactory) : void
      {
         _factory = factory;
      }
      
      protected function initLoader() : void
      {
         _loader = _factory.createLoader(_info,"show");
      }
      
      public function drawFrame(frame:int, type:int = 0, clearOld:Boolean = true) : void
      {
         if(_characterBitmapdata != null)
         {
            if(frame < 0 || frame >= _frames.length)
            {
               frame = 0;
            }
            if(frame != _currentframe || _bitmapChanged)
            {
               _bitmapChanged = false;
               _currentframe = frame;
               _body.bitmapData.copyPixels(_characterBitmapdata,_frames[_currentframe],new Point(0,0));
               _bodyImage.texture.dispose();
               _bodyImage.texture = Texture.fromBitmap(_body,false);
            }
         }
      }
      
      protected function createFrames() : void
      {
         var j:int = 0;
         var i:int = 0;
         var m:* = null;
         _frames = [];
         for(j = 0; j < _picLines; )
         {
            for(i = 0; i < _picsPerLine; )
            {
               m = new Rectangle(i * _characterWidth,j * _characterHeight,_characterWidth,_characterHeight);
               _frames.push(m);
               i++;
            }
            j++;
         }
      }
      
      public function set smoothing(value:Boolean) : void
      {
         _body.smoothing = value;
      }
      
      public function set showGun(value:Boolean) : void
      {
      }
      
      public function set showWing(value:Boolean) : void
      {
      }
      
      public function setShowLight(b:Boolean, p:Point = null) : void
      {
      }
      
      public function get currentAction() : *
      {
         return "";
      }
      
      public function actionPlaying() : Boolean
      {
         return false;
      }
      
      public function showWithSize(clearLoader:Boolean = true, dir:int = 1, width:Number = 120, height:Number = 165) : void
      {
      }
      
      public function resetShowBitmapBig() : void
      {
      }
      
      public function getShowBitmapBig() : *
      {
      }
      
      override public function dispose() : void
      {
         removeEventListener("enterFrame",__enterFrame);
         removeEventListener("addedToStage",__addToStage);
         removeEventListener("removedFromStage",__removeFromStage);
         if(_info)
         {
            _info.removeEventListener("propertychange",__propertyChange);
         }
         _disposed = true;
         _info = null;
         StarlingObjectUtils.disposeAllChildren(_container);
         StarlingObjectUtils.disposeObject(_container);
         StarlingObjectUtils.disposeObject(_bodyImage,true);
         ObjectUtils.disposeObject(_body);
         ObjectUtils.disposeObject(_characterBitmapdata);
         _bodyImage = null;
         _container = null;
         _body = null;
         _characterBitmapdata = null;
         if(_loader)
         {
            _loader.dispose();
            _loader = null;
         }
         _factory = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}
