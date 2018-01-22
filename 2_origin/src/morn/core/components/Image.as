package morn.core.components
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.BitmapLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import flash.display.BitmapData;
   import morn.core.events.UIEvent;
   import morn.core.utils.StringUtils;
   
   [Event(name="imageLoaded",type="morn.core.events.UIEvent")]
   public class Image extends Component
   {
       
      
      protected var _bitmap:AutoBitmap;
      
      protected var _url:String;
      
      protected var _bitmapLoader:BitmapLoader;
      
      public function Image(param1:String = null)
      {
         super();
         this.url = param1;
      }
      
      override protected function createChildren() : void
      {
         addChild(this._bitmap = new AutoBitmap());
      }
      
      public function get url() : String
      {
         return this._url;
      }
      
      public function set url(param1:String) : void
      {
         if(this._url != param1)
         {
            this._url = param1;
            if(Boolean(param1))
            {
               if(App.asset.hasClass(this._url))
               {
                  this.bitmapData = App.asset.getBitmapData(this._url);
               }
               else
               {
                  this._bitmapLoader = LoadResourceManager.Instance.createLoader(this._url,BaseLoader.BITMAP_LOADER);
                  this._bitmapLoader.addEventListener(LoaderEvent.COMPLETE,this.__onLoaderComplete);
                  this._bitmapLoader.addEventListener(LoaderEvent.LOAD_ERROR,this.__onLoaderError);
                  LoadResourceManager.Instance.startLoad(this._bitmapLoader);
               }
            }
            else
            {
               this.bitmapData = null;
            }
         }
      }
      
      private function __onLoaderComplete(param1:LoaderEvent) : void
      {
         this.setBitmapData(this._url,this._bitmapLoader.bitmapData);
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
      
      public function get skin() : String
      {
         return this._url;
      }
      
      public function set skin(param1:String) : void
      {
         this.url = param1;
      }
      
      public function get bitmapData() : BitmapData
      {
         return this._bitmap.bitmapData;
      }
      
      public function set bitmapData(param1:BitmapData) : void
      {
         if(param1)
         {
            _contentWidth = param1.width;
            _contentHeight = param1.height;
         }
         this._bitmap.bitmapData = param1;
         sendEvent(UIEvent.IMAGE_LOADED);
      }
      
      protected function setBitmapData(param1:String, param2:BitmapData) : void
      {
         if(param1 == this._url)
         {
            this.bitmapData = param2;
         }
      }
      
      protected function setBitmapDataError(param1:String) : void
      {
         if(param1 == this._url)
         {
            this.bitmapData = null;
         }
      }
      
      override public function set width(param1:Number) : void
      {
         super.width = param1;
         this._bitmap.width = width;
      }
      
      override public function set height(param1:Number) : void
      {
         super.height = param1;
         this._bitmap.height = height;
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
      
      public function get bitmap() : AutoBitmap
      {
         return this._bitmap;
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
      
      override public function set dataSource(param1:Object) : void
      {
         _dataSource = param1;
         if(param1 is String)
         {
            this.url = String(param1);
         }
         else
         {
            super.dataSource = param1;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.clearBitmapLoader();
         this._bitmap && this._bitmap.dispose();
         this._bitmap = null;
      }
      
      public function destroy(param1:Boolean = false) : void
      {
         this._bitmap.bitmapData = null;
         App.asset.disposeBitmapData(this._url);
      }
   }
}
