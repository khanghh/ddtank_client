package ddt.view.character
{
   import com.pickgliss.ui.core.Disposeable;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.view.characterStarling.GameCharacter3DLoader;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.IDisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BaseCharacter extends Sprite implements ICharacter, IDisplayObject, Disposeable
   {
      
      public static const BASE_WIDTH:int = 120;
      
      public static const BASE_HEIGHT:int = 165;
      
      public static const MOUSE_ON_GLOW_FILTER:Array = [new GlowFilter(16776960,1,8,8,2,2)];
       
      
      protected var _info:PlayerInfo;
      
      protected var _frames:Array;
      
      protected var _loader:ICharacterLoader;
      
      protected var _characterWidth:Number;
      
      protected var _characterHeight:Number;
      
      protected var _factory:ICharacterLoaderFactory;
      
      protected var _dir:int;
      
      protected var _container:Sprite;
      
      protected var _body:Bitmap;
      
      protected var _currentframe:int;
      
      protected var _loadCompleted:Boolean;
      
      protected var _picLines:int;
      
      protected var _picsPerLine:int;
      
      private var _autoClearLoader:Boolean;
      
      protected var _characterBitmapdata:BitmapData;
      
      protected var _bitmapChanged:Boolean;
      
      private var _lifeUpdate:Boolean;
      
      private var _disposed:Boolean;
      
      public function BaseCharacter(info:PlayerInfo, lifeUpdate:Boolean)
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
         _container.addChild(_body);
         mouseEnabled = false;
         mouseChildren = false;
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
            if(_loader == null || _loader is GameCharacterLoader || _loader is GameCharacter3DLoader)
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
      
      public function setCharacterFilter(value:Boolean) : void
      {
         _body.filters = !!value?MOUSE_ON_GLOW_FILTER:null;
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
      
      public function dispose() : void
      {
         _info.removeEventListener("propertychange",__propertyChange);
         _disposed = true;
         _info = null;
         removeEventListener("addedToStage",__addToStage);
         removeEventListener("enterFrame",__enterFrame);
         removeEventListener("removedFromStage",__removeFromStage);
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
         if(_body && _body.bitmapData)
         {
            _body.bitmapData.dispose();
         }
         _body = null;
         if(_characterBitmapdata)
         {
            _characterBitmapdata.dispose();
         }
         _characterBitmapdata = null;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
   }
}
