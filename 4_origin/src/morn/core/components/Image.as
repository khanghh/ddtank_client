package morn.core.components
{
   import com.pickgliss.loader.BitmapLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import flash.display.BitmapData;
   import morn.core.utils.StringUtils;
   
   [Event(name="imageLoaded",type="morn.core.events.UIEvent")]
   public class Image extends Component
   {
       
      
      protected var _bitmap:AutoBitmap;
      
      protected var _url:String;
      
      protected var _bitmapLoader:BitmapLoader;
      
      public function Image(url:String = null)
      {
         super();
         this.url = url;
      }
      
      override protected function createChildren() : void
      {
         _bitmap = new AutoBitmap();
         addChild(new AutoBitmap());
      }
      
      public function get url() : String
      {
         return _url;
      }
      
      public function set url(value:String) : void
      {
         if(_url != value)
         {
            _url = value;
            if(value)
            {
               if(App.asset.hasClass(_url))
               {
                  bitmapData = App.asset.getBitmapData(_url);
               }
               else
               {
                  _bitmapLoader = LoadResourceManager.Instance.createLoader(_url,0);
                  _bitmapLoader.addEventListener("complete",__onLoaderComplete);
                  _bitmapLoader.addEventListener("loadError",__onLoaderError);
                  LoadResourceManager.Instance.startLoad(_bitmapLoader);
               }
            }
            else
            {
               bitmapData = null;
            }
         }
      }
      
      private function __onLoaderComplete(e:LoaderEvent) : void
      {
         setBitmapData(_url,_bitmapLoader.bitmapData);
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
      
      public function get skin() : String
      {
         return _url;
      }
      
      public function set skin(value:String) : void
      {
         url = value;
      }
      
      public function get bitmapData() : BitmapData
      {
         return _bitmap.bitmapData;
      }
      
      public function set bitmapData(value:BitmapData) : void
      {
         if(value)
         {
            _contentWidth = value.width;
            _contentHeight = value.height;
         }
         _bitmap.bitmapData = value;
         sendEvent("imageLoaded");
      }
      
      protected function setBitmapData(url:String, bmd:BitmapData) : void
      {
         if(url == _url)
         {
            bitmapData = bmd;
         }
      }
      
      protected function setBitmapDataError(url:String) : void
      {
         if(url == _url)
         {
            bitmapData = null;
         }
      }
      
      override public function set width(value:Number) : void
      {
         .super.width = value;
         _bitmap.width = width;
      }
      
      override public function set height(value:Number) : void
      {
         .super.height = value;
         _bitmap.height = height;
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
      
      public function get bitmap() : AutoBitmap
      {
         return _bitmap;
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
      
      override public function set dataSource(value:Object) : void
      {
         _dataSource = value;
         if(value is String)
         {
            url = String(value);
         }
         else
         {
            .super.dataSource = value;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         clearBitmapLoader();
         _bitmap && _bitmap.dispose();
         _bitmap = null;
      }
      
      public function destroy(clearFromLoader:Boolean = false) : void
      {
         _bitmap.bitmapData = null;
         App.asset.disposeBitmapData(_url);
      }
   }
}
