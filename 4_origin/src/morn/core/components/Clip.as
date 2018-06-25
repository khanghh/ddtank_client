package morn.core.components
{
   import com.pickgliss.loader.BitmapLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import flash.display.BitmapData;
   import flash.events.Event;
   import morn.core.handlers.Handler;
   import morn.core.utils.StringUtils;
   import morn.editor.core.IClip;
   
   [Event(name="imageLoaded",type="morn.core.events.UIEvent")]
   [Event(name="frameChanged",type="morn.core.events.UIEvent")]
   public class Clip extends Component implements IClip
   {
       
      
      protected var _autoStopAtRemoved:Boolean = true;
      
      protected var _bitmap:AutoBitmap;
      
      protected var _clipX:int = 1;
      
      protected var _clipY:int = 1;
      
      protected var _clipWidth:Number;
      
      protected var _clipHeight:Number;
      
      protected var _url:String;
      
      protected var _autoPlay:Boolean;
      
      protected var _interval:int;
      
      protected var _from:int = -1;
      
      protected var _to:int = -1;
      
      protected var _complete:Handler;
      
      protected var _isPlaying:Boolean;
      
      protected var _clipsUrl:String;
      
      protected var _bitmapLoader:BitmapLoader;
      
      public function Clip(url:String = null, clipX:int = 1, clipY:int = 1)
      {
         _interval = Config.MOVIE_INTERVAL;
         super();
         _clipX = clipX;
         _clipY = clipY;
         this.url = url;
      }
      
      override protected function createChildren() : void
      {
         _bitmap = new AutoBitmap();
         addChild(new AutoBitmap());
      }
      
      override protected function initialize() : void
      {
         addEventListener("addedToStage",onAddedToStage);
         addEventListener("removedFromStage",onRemovedFromStage);
      }
      
      protected function onAddedToStage(e:Event) : void
      {
         if(_autoPlay)
         {
            play();
         }
      }
      
      protected function onRemovedFromStage(e:Event) : void
      {
         if(_autoStopAtRemoved)
         {
            stop();
         }
      }
      
      public function get url() : String
      {
         return _url;
      }
      
      public function set url(value:String) : void
      {
         if(_url != value && value)
         {
            _url = value;
            callLater(changeClip);
         }
      }
      
      public function get skin() : String
      {
         return _url;
      }
      
      public function set skin(value:String) : void
      {
         url = value;
      }
      
      public function get clipX() : int
      {
         return _clipX;
      }
      
      public function set clipX(value:int) : void
      {
         if(_clipX != value)
         {
            _clipX = value;
            callLater(changeClip);
         }
      }
      
      public function get clipY() : int
      {
         return _clipY;
      }
      
      public function set clipY(value:int) : void
      {
         if(_clipY != value)
         {
            _clipY = value;
            callLater(changeClip);
         }
      }
      
      public function get clipWidth() : Number
      {
         return _clipWidth;
      }
      
      public function set clipWidth(value:Number) : void
      {
         _clipWidth = value;
         callLater(changeClip);
      }
      
      public function get clipHeight() : Number
      {
         return _clipHeight;
      }
      
      public function set clipHeight(value:Number) : void
      {
         _clipHeight = value;
         callLater(changeClip);
      }
      
      protected function changeClip() : void
      {
         if(App.asset.hasClass(_url))
         {
            loadComplete(_url,false,App.asset.getBitmapData(_url,false));
         }
         else
         {
            _bitmapLoader = LoadResourceManager.Instance.createLoader(_url,0);
            _bitmapLoader.addEventListener("complete",__onLoaderComplete);
            _bitmapLoader.addEventListener("loadError",__onLoaderError);
            LoadResourceManager.Instance.startLoad(_bitmapLoader);
         }
      }
      
      private function __onLoaderComplete(e:LoaderEvent) : void
      {
         loadComplete(_url,true,_bitmapLoader.bitmapData);
         clearBitmapLoader();
      }
      
      private function __onLoaderError(e:LoaderEvent) : void
      {
         clearBitmapLoader();
      }
      
      private function clearBitmapLoader() : void
      {
         if(_bitmapLoader)
         {
            _bitmapLoader.removeEventListener("complete",__onLoaderComplete);
            _bitmapLoader.removeEventListener("loadError",__onLoaderError);
         }
         _bitmapLoader = null;
      }
      
      protected function loadComplete(url:String, isLoad:Boolean, bmd:BitmapData) : void
      {
         if(url == _url && bmd)
         {
            if(!isNaN(_clipWidth))
            {
               _clipX = Math.ceil(bmd.width / _clipWidth);
            }
            if(!isNaN(_clipHeight))
            {
               _clipY = Math.ceil(bmd.height / _clipHeight);
            }
            clips = App.asset.getClips(url,_clipX,_clipY,true,bmd);
         }
      }
      
      public function get clips() : Vector.<BitmapData>
      {
         return _bitmap.clips;
      }
      
      public function set clips(value:Vector.<BitmapData>) : void
      {
         if(value)
         {
            _bitmap.clips = value;
            _contentWidth = _bitmap.width;
            _contentHeight = _bitmap.height;
         }
         sendEvent("imageLoaded");
      }
      
      public function get clipsUrl() : String
      {
         return _clipsUrl;
      }
      
      public function set clipsUrl(value:String) : void
      {
         var arr:* = null;
         var vec:* = undefined;
         if(value && value != "null")
         {
            _clipsUrl = value;
            arr = value.split(",");
            vec = new Vector.<BitmapData>();
            var _loc6_:int = 0;
            var _loc5_:* = arr;
            for each(var u in arr)
            {
               if(u)
               {
                  vec.push(App.asset.getBitmapData(u));
               }
               else
               {
                  vec.push(new BitmapData(1,1));
               }
            }
            _clipX = arr.length;
            _clipY = 1;
            clips = vec;
            width = vec[0].width;
            height = vec[0].height;
            _contentWidth = vec[0].width;
            _contentHeight = vec[0].height;
         }
      }
      
      public function set clipsUrlSimple(value:String) : void
      {
         var args:* = null;
         var arr:* = null;
         var len:int = 0;
         var vec:* = undefined;
         var i:int = 0;
         if(value)
         {
            args = value.split(",");
            arr = [];
            len = args[1];
            _clipsUrl = value;
            vec = new Vector.<BitmapData>();
            vec.push(App.asset.getBitmapData(args[0]));
            for(i = 1; i <= len; )
            {
               vec.push(App.asset.getBitmapData(args[0] + "$" + i));
               i++;
            }
            _clipX = vec.length;
            _clipY = 1;
            clips = vec;
            width = vec[0].width;
            height = vec[0].height;
            _contentWidth = vec[0].width;
            _contentHeight = vec[0].height;
         }
      }
      
      override public function set width(value:Number) : void
      {
         .super.width = value;
         _bitmap.width = value;
      }
      
      override public function set height(value:Number) : void
      {
         .super.height = value;
         _bitmap.height = value;
      }
      
      override public function commitMeasure() : void
      {
         exeCallLater(changeClip);
      }
      
      public function get sizeGrid() : String
      {
         if(_bitmap.sizeGrid)
         {
            return _bitmap.sizeGrid.join(",");
         }
         return null;
      }
      
      public function set sizeGrid(value:String) : void
      {
         _bitmap.sizeGrid = StringUtils.fillArray(Styles.defaultSizeGrid,value);
      }
      
      public function get frame() : int
      {
         return _bitmap.index;
      }
      
      public function set frame(value:int) : void
      {
         var handler:* = null;
         _bitmap.index = value;
         sendEvent("frameChanged");
         if(_bitmap.index == _to)
         {
            stop();
            _to = -1;
            if(_complete != null)
            {
               handler = _complete;
               _complete = null;
               handler.execute();
            }
         }
      }
      
      public function get index() : int
      {
         return _bitmap.index;
      }
      
      public function set index(value:int) : void
      {
         frame = value;
      }
      
      public function get totalFrame() : int
      {
         exeCallLater(changeClip);
         return !!_bitmap.clips?_bitmap.clips.length:0;
      }
      
      public function get autoStopAtRemoved() : Boolean
      {
         return _autoStopAtRemoved;
      }
      
      public function set autoStopAtRemoved(value:Boolean) : void
      {
         _autoStopAtRemoved = value;
      }
      
      public function get autoPlay() : Boolean
      {
         return _autoPlay;
      }
      
      public function set autoPlay(value:Boolean) : void
      {
         if(_autoPlay != value)
         {
            _autoPlay = value;
            !!_autoPlay?play():stop();
         }
      }
      
      public function get interval() : int
      {
         return _interval;
      }
      
      public function set interval(value:int) : void
      {
         if(_interval != value)
         {
            _interval = value;
            if(_isPlaying)
            {
               play();
            }
         }
      }
      
      public function get isPlaying() : Boolean
      {
         return _isPlaying;
      }
      
      public function set isPlaying(value:Boolean) : void
      {
         _isPlaying = value;
      }
      
      public function play() : void
      {
         _isPlaying = true;
         frame = _bitmap.index;
         App.timer.doLoop(_interval,loop);
      }
      
      protected function loop() : void
      {
         frame = Number(frame) + 1;
      }
      
      public function stop() : void
      {
         App.timer.clearTimer(loop);
         _isPlaying = false;
      }
      
      public function gotoAndPlay(frame:int) : void
      {
         this.frame = frame;
         play();
      }
      
      public function gotoAndStop(frame:int) : void
      {
         stop();
         this.frame = frame;
      }
      
      public function playFromTo(from:int = -1, to:int = -1, complete:Handler = null) : void
      {
         _from = from == -1?0:from;
         _to = to == -1?_clipX * _clipY - 1:to;
         _complete = complete;
         gotoAndPlay(_from);
      }
      
      override public function set dataSource(value:Object) : void
      {
         _dataSource = value;
         if(value is int || value is String)
         {
            frame = int(value);
         }
         else
         {
            .super.dataSource = value;
         }
      }
      
      public function get smoothing() : Boolean
      {
         return _bitmap.smoothing;
      }
      
      public function set smoothing(value:Boolean) : void
      {
         _bitmap.smoothing = value;
      }
      
      public function get anchorX() : Number
      {
         return _bitmap.anchorX;
      }
      
      public function set anchorX(value:Number) : void
      {
         _bitmap.anchorX = value;
      }
      
      public function get anchorY() : Number
      {
         return _bitmap.anchorY;
      }
      
      public function set anchorY(value:Number) : void
      {
         _bitmap.anchorY = value;
      }
      
      public function get bitmap() : AutoBitmap
      {
         return _bitmap;
      }
      
      override public function dispose() : void
      {
         destroy(false);
         clearBitmapLoader();
      }
      
      public function destroy(clearFromLoader:Boolean = false) : void
      {
         _bitmap.bitmapData = null;
         App.asset.destroyClips(_url);
      }
   }
}
