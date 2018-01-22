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
      
      public function NativeTextureAtlas(param1:Object, param2:Object, param3:Number = 1, param4:Boolean = false)
      {
         super();
         _scale = param3;
         _isDifferentConfig = param4;
         if(param1 is BitmapData)
         {
            _bitmapData = param1 as BitmapData;
         }
         else if(param1 is MovieClip)
         {
            _movieClip = param1 as MovieClip;
            _movieClip.stop();
         }
         parseData(param2);
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get movieClip() : MovieClip
      {
         return _movieClip;
      }
      
      public function get bitmapData() : BitmapData
      {
         return _bitmapData;
      }
      
      public function get scale() : Number
      {
         return _scale;
      }
      
      public function dispose() : void
      {
         _movieClip = null;
         if(_bitmapData)
         {
            _bitmapData.dispose();
         }
         _bitmapData = null;
      }
      
      public function getRegion(param1:String) : Rectangle
      {
         var _loc2_:TextureData = _subTextureDataDic[param1] as TextureData;
         if(_loc2_)
         {
            return _loc2_.region;
         }
         return null;
      }
      
      public function getFrame(param1:String) : Rectangle
      {
         var _loc2_:TextureData = _subTextureDataDic[param1] as TextureData;
         if(_loc2_)
         {
            return _loc2_.frame;
         }
         return null;
      }
      
      protected function parseData(param1:Object) : void
      {
         _subTextureDataDic = DataParser.parseTextureAtlasData(param1,!!_isDifferentConfig?_scale:1);
         _name = _subTextureDataDic.__name;
      }
      
      function movieClipToBitmapData() : void
      {
         if(!_bitmapData && _movieClip)
         {
            _movieClip.gotoAndStop(1);
            _bitmapData = new BitmapData(getNearest2N(_movieClip.width),getNearest2N(_movieClip.height),true,16711935);
            _bitmapData.draw(_movieClip);
            _movieClip.gotoAndStop(_movieClip.totalFrames);
         }
      }
      
      private function getNearest2N(param1:uint) : uint
      {
         return !!(param1 & param1 - 1)?1 << param1.toString(2).length:param1;
      }
   }
}
