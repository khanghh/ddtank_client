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
      
      public function NativeTextureAtlas(texture:Object, textureAtlasRawData:Object, textureScale:Number = 1, isDifferentConfig:Boolean = false)
      {
         super();
         _scale = textureScale;
         _isDifferentConfig = isDifferentConfig;
         if(texture is BitmapData)
         {
            _bitmapData = texture as BitmapData;
         }
         else if(texture is MovieClip)
         {
            _movieClip = texture as MovieClip;
            _movieClip.stop();
         }
         parseData(textureAtlasRawData);
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
      
      public function getRegion(name:String) : Rectangle
      {
         var textureData:TextureData = _subTextureDataDic[name] as TextureData;
         if(textureData)
         {
            return textureData.region;
         }
         return null;
      }
      
      public function getFrame(name:String) : Rectangle
      {
         var textureData:TextureData = _subTextureDataDic[name] as TextureData;
         if(textureData)
         {
            return textureData.frame;
         }
         return null;
      }
      
      protected function parseData(textureAtlasRawData:Object) : void
      {
         _subTextureDataDic = DataParser.parseTextureAtlasData(textureAtlasRawData,!!_isDifferentConfig?_scale:1);
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
      
      private function getNearest2N(_n:uint) : uint
      {
         return !!(_n & _n - 1)?1 << _n.toString(2).length:_n;
      }
   }
}
