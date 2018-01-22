package dragonBones.textures
{
   import dragonBones.objects.DataParser;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   
   public class NativeTextureAtlas implements ITextureAtlas
   {
       
      
      protected var _subTextureDataDic:Object;
      
      protected var _isDifferentConfig:Boolean;
      
      protected var _name:String;
      
      protected var _movieClip:MovieClip;
      
      protected var _bitmapData:BitmapData;
      
      protected var _scale:Number;
      
      public function NativeTextureAtlas(param1:Object, param2:Object, param3:Number = 1, param4:Boolean = false){super();}
      
      public function get name() : String{return null;}
      
      public function get movieClip() : MovieClip{return null;}
      
      public function get bitmapData() : BitmapData{return null;}
      
      public function get scale() : Number{return 0;}
      
      public function dispose() : void{}
      
      public function getRegion(param1:String) : Rectangle{return null;}
      
      public function getFrame(param1:String) : Rectangle{return null;}
      
      protected function parseData(param1:Object) : void{}
      
      function movieClipToBitmapData() : void{}
      
      private function getNearest2N(param1:uint) : uint{return null;}
   }
}
