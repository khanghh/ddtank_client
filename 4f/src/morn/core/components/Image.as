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
      
      public function Image(param1:String = null){super();}
      
      override protected function createChildren() : void{}
      
      public function get url() : String{return null;}
      
      public function set url(param1:String) : void{}
      
      private function __onLoaderComplete(param1:LoaderEvent) : void{}
      
      private function __onLoaderError(param1:LoaderEvent) : void{}
      
      private function clearBitmapLoader() : void{}
      
      public function get skin() : String{return null;}
      
      public function set skin(param1:String) : void{}
      
      public function get bitmapData() : BitmapData{return null;}
      
      public function set bitmapData(param1:BitmapData) : void{}
      
      protected function setBitmapData(param1:String, param2:BitmapData) : void{}
      
      protected function setBitmapDataError(param1:String) : void{}
      
      override public function set width(param1:Number) : void{}
      
      override public function set height(param1:Number) : void{}
      
      public function get sizeGrid() : String{return null;}
      
      public function set sizeGrid(param1:String) : void{}
      
      public function get bitmap() : AutoBitmap{return null;}
      
      public function get smoothing() : Boolean{return false;}
      
      public function set smoothing(param1:Boolean) : void{}
      
      public function get anchorX() : Number{return 0;}
      
      public function set anchorX(param1:Number) : void{}
      
      public function get anchorY() : Number{return 0;}
      
      public function set anchorY(param1:Number) : void{}
      
      override public function set dataSource(param1:Object) : void{}
      
      override public function dispose() : void{}
      
      public function destroy(param1:Boolean = false) : void{}
   }
}
