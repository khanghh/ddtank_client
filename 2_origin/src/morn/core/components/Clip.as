package morn.core.components
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.BitmapLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import flash.display.BitmapData;
   import flash.events.Event;
   import morn.core.events.UIEvent;
   import morn.core.handlers.Handler;
   import morn.core.utils.StringUtils;
   import morn.editor.core.IClip;
   
   [Event(name="frameChanged",type="morn.core.events.UIEvent")]
   [Event(name="imageLoaded",type="morn.core.events.UIEvent")]
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
      
      public function Clip(param1:String = null, param2:int = 1, param3:int = 1)
      {
         this._interval = Config.MOVIE_INTERVAL;
         super();
         this._clipX = param2;
         this._clipY = param3;
         this.url = param1;
      }
      
      override protected function createChildren() : void
      {
         addChild(this._bitmap = new AutoBitmap());
      }
      
      override protected function initialize() : void
      {
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      protected function onAddedToStage(param1:Event) : void
      {
         if(this._autoPlay)
         {
            this.play();
         }
      }
      
      protected function onRemovedFromStage(param1:Event) : void
      {
         if(this._autoStopAtRemoved)
         {
            this.stop();
         }
      }
      
      public function get url() : String
      {
         return this._url;
      }
      
      public function set url(param1:String) : void
      {
         if(this._url != param1 && Boolean(param1))
         {
            this._url = param1;
            callLater(this.changeClip);
         }
      }
      
      public function get skin() : String
      {
         return this._url;
      }
      
      public function set skin(param1:String) : void
      {
         this.url = param1;
      }
      
      public function get clipX() : int
      {
         return this._clipX;
      }
      
      public function set clipX(param1:int) : void
      {
         if(this._clipX != param1)
         {
            this._clipX = param1;
            callLater(this.changeClip);
         }
      }
      
      public function get clipY() : int
      {
         return this._clipY;
      }
      
      public function set clipY(param1:int) : void
      {
         if(this._clipY != param1)
         {
            this._clipY = param1;
            callLater(this.changeClip);
         }
      }
      
      public function get clipWidth() : Number
      {
         return this._clipWidth;
      }
      
      public function set clipWidth(param1:Number) : void
      {
         this._clipWidth = param1;
         callLater(this.changeClip);
      }
      
      public function get clipHeight() : Number
      {
         return this._clipHeight;
      }
      
      public function set clipHeight(param1:Number) : void
      {
         this._clipHeight = param1;
         callLater(this.changeClip);
      }
      
      protected function changeClip() : void
      {
         if(App.asset.hasClass(this._url))
         {
            this.loadComplete(this._url,false,App.asset.getBitmapData(this._url,false));
         }
         else
         {
            this._bitmapLoader = LoadResourceManager.Instance.createLoader(this._url,BaseLoader.BITMAP_LOADER);
            this._bitmapLoader.addEventListener(LoaderEvent.COMPLETE,this.__onLoaderComplete);
            this._bitmapLoader.addEventListener(LoaderEvent.LOAD_ERROR,this.__onLoaderError);
            LoadResourceManager.Instance.startLoad(this._bitmapLoader);
         }
      }
      
      private function __onLoaderComplete(param1:LoaderEvent) : void
      {
         this.loadComplete(this._url,true,this._bitmapLoader.bitmapData);
         this.clearBitmapLoader();
      }
      
      private function __onLoaderError(param1:LoaderEvent) : void
      {
         this.clearBitmapLoader();
      }
      
      private function clearBitmapLoader() : void
      {
         if(this._bitmapLoader)
         {
            this._bitmapLoader.removeEventListener(LoaderEvent.COMPLETE,this.__onLoaderComplete);
            this._bitmapLoader.removeEventListener(LoaderEvent.LOAD_ERROR,this.__onLoaderError);
         }
         this._bitmapLoader = null;
      }
      
      protected function loadComplete(param1:String, param2:Boolean, param3:BitmapData) : void
      {
         if(param1 == this._url && param3)
         {
            if(!isNaN(this._clipWidth))
            {
               this._clipX = Math.ceil(param3.width / this._clipWidth);
            }
            if(!isNaN(this._clipHeight))
            {
               this._clipY = Math.ceil(param3.height / this._clipHeight);
            }
            this.clips = App.asset.getClips(param1,this._clipX,this._clipY,true,param3);
         }
      }
      
      public function get clips() : Vector.<BitmapData>
      {
         return this._bitmap.clips;
      }
      
      public function set clips(param1:Vector.<BitmapData>) : void
      {
         if(param1)
         {
            this._bitmap.clips = param1;
            _contentWidth = this._bitmap.width;
            _contentHeight = this._bitmap.height;
         }
         sendEvent(UIEvent.IMAGE_LOADED);
      }
      
      public function get clipsUrl() : String
      {
         return this._clipsUrl;
      }
      
      public function set clipsUrl(param1:String) : void
      {
         var _loc2_:Array = null;
         var _loc3_:Vector.<BitmapData> = null;
         var _loc4_:String = null;
         if(Boolean(param1) && param1 != "null")
         {
            this._clipsUrl = param1;
            _loc2_ = param1.split(",");
            _loc3_ = new Vector.<BitmapData>();
            for each(_loc4_ in _loc2_)
            {
               if(_loc4_)
               {
                  _loc3_.push(App.asset.getBitmapData(_loc4_));
               }
               else
               {
                  _loc3_.push(new BitmapData(1,1));
               }
            }
            this._clipX = _loc2_.length;
            this._clipY = 1;
            this.clips = _loc3_;
            this.width = _loc3_[0].width;
            this.height = _loc3_[0].height;
            _contentWidth = _loc3_[0].width;
            _contentHeight = _loc3_[0].height;
         }
      }
      
      public function set clipsUrlSimple(param1:String) : void
      {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:Vector.<BitmapData> = null;
         var _loc6_:int = 0;
         if(param1)
         {
            _loc2_ = param1.split(",");
            _loc3_ = [];
            _loc4_ = int(_loc2_[1]);
            this._clipsUrl = param1;
            _loc5_ = new Vector.<BitmapData>();
            _loc5_.push(App.asset.getBitmapData(_loc2_[0]));
            _loc6_ = 1;
            while(_loc6_ <= _loc4_)
            {
               _loc5_.push(App.asset.getBitmapData(_loc2_[0] + "$" + _loc6_));
               _loc6_++;
            }
            this._clipX = _loc5_.length;
            this._clipY = 1;
            this.clips = _loc5_;
            this.width = _loc5_[0].width;
            this.height = _loc5_[0].height;
            _contentWidth = _loc5_[0].width;
            _contentHeight = _loc5_[0].height;
         }
      }
      
      override public function set width(param1:Number) : void
      {
         super.width = param1;
         this._bitmap.width = param1;
      }
      
      override public function set height(param1:Number) : void
      {
         super.height = param1;
         this._bitmap.height = param1;
      }
      
      override public function commitMeasure() : void
      {
         exeCallLater(this.changeClip);
      }
      
      public function get sizeGrid() : String
      {
         if(this._bitmap.sizeGrid)
         {
            return this._bitmap.sizeGrid.join(",");
         }
         return null;
      }
      
      public function set sizeGrid(param1:String) : void
      {
         this._bitmap.sizeGrid = StringUtils.fillArray(Styles.defaultSizeGrid,param1);
      }
      
      public function get frame() : int
      {
         return this._bitmap.index;
      }
      
      public function set frame(param1:int) : void
      {
         var _loc2_:Handler = null;
         this._bitmap.index = param1;
         sendEvent(UIEvent.FRAME_CHANGED);
         if(this._bitmap.index == this._to)
         {
            this.stop();
            this._to = -1;
            if(this._complete != null)
            {
               _loc2_ = this._complete;
               this._complete = null;
               _loc2_.execute();
            }
         }
      }
      
      public function get index() : int
      {
         return this._bitmap.index;
      }
      
      public function set index(param1:int) : void
      {
         this.frame = param1;
      }
      
      public function get totalFrame() : int
      {
         exeCallLater(this.changeClip);
         return !!this._bitmap.clips?int(this._bitmap.clips.length):0;
      }
      
      public function get autoStopAtRemoved() : Boolean
      {
         return this._autoStopAtRemoved;
      }
      
      public function set autoStopAtRemoved(param1:Boolean) : void
      {
         this._autoStopAtRemoved = param1;
      }
      
      public function get autoPlay() : Boolean
      {
         return this._autoPlay;
      }
      
      public function set autoPlay(param1:Boolean) : void
      {
         if(this._autoPlay != param1)
         {
            this._autoPlay = param1;
            if(this._autoPlay)
            {
               this.play();
            }
            else
            {
               this.stop();
            }
         }
      }
      
      public function get interval() : int
      {
         return this._interval;
      }
      
      public function set interval(param1:int) : void
      {
         if(this._interval != param1)
         {
            this._interval = param1;
            if(this._isPlaying)
            {
               this.play();
            }
         }
      }
      
      public function get isPlaying() : Boolean
      {
         return this._isPlaying;
      }
      
      public function set isPlaying(param1:Boolean) : void
      {
         this._isPlaying = param1;
      }
      
      public function play() : void
      {
         this._isPlaying = true;
         this.frame = this._bitmap.index;
         App.timer.doLoop(this._interval,this.loop);
      }
      
      protected function loop() : void
      {
         this.frame++;
      }
      
      public function stop() : void
      {
         App.timer.clearTimer(this.loop);
         this._isPlaying = false;
      }
      
      public function gotoAndPlay(param1:int) : void
      {
         this.frame = param1;
         this.play();
      }
      
      public function gotoAndStop(param1:int) : void
      {
         this.stop();
         this.frame = param1;
      }
      
      public function playFromTo(param1:int = -1, param2:int = -1, param3:Handler = null) : void
      {
         this._from = param1 == -1?0:int(param1);
         this._to = param2 == -1?int(this._clipX * this._clipY - 1):int(param2);
         this._complete = param3;
         this.gotoAndPlay(this._from);
      }
      
      override public function set dataSource(param1:Object) : void
      {
         _dataSource = param1;
         if(param1 is int || param1 is String)
         {
            this.frame = int(param1);
         }
         else
         {
            super.dataSource = param1;
         }
      }
      
      public function get smoothing() : Boolean
      {
         return this._bitmap.smoothing;
      }
      
      public function set smoothing(param1:Boolean) : void
      {
         this._bitmap.smoothing = param1;
      }
      
      public function get anchorX() : Number
      {
         return this._bitmap.anchorX;
      }
      
      public function set anchorX(param1:Number) : void
      {
         this._bitmap.anchorX = param1;
      }
      
      public function get anchorY() : Number
      {
         return this._bitmap.anchorY;
      }
      
      public function set anchorY(param1:Number) : void
      {
         this._bitmap.anchorY = param1;
      }
      
      public function get bitmap() : AutoBitmap
      {
         return this._bitmap;
      }
      
      override public function dispose() : void
      {
         this.destroy(false);
         this.clearBitmapLoader();
      }
      
      public function destroy(param1:Boolean = false) : void
      {
         this._bitmap.bitmapData = null;
         App.asset.destroyClips(this._url);
      }
   }
}
