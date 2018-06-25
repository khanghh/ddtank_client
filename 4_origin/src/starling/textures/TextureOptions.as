package starling.textures
{
   import starling.core.Starling;
   
   public class TextureOptions
   {
       
      
      private var mScale:Number;
      
      private var mFormat:String;
      
      private var mMipMapping:Boolean;
      
      private var mOptimizeForRenderToTexture:Boolean = false;
      
      private var mOnReady:Function = null;
      
      private var mRepeat:Boolean = false;
      
      public function TextureOptions(scale:Number = 1.0, mipMapping:Boolean = false, format:String = "bgra", repeat:Boolean = false)
      {
         super();
         mScale = scale;
         mFormat = format;
         mMipMapping = mipMapping;
         mRepeat = repeat;
      }
      
      public function clone() : TextureOptions
      {
         var clone:TextureOptions = new TextureOptions(mScale,mMipMapping,mFormat,mRepeat);
         clone.mOptimizeForRenderToTexture = mOptimizeForRenderToTexture;
         clone.mOnReady = mOnReady;
         return clone;
      }
      
      public function get scale() : Number
      {
         return mScale;
      }
      
      public function set scale(value:Number) : void
      {
         mScale = value > 0?value:Number(Starling.contentScaleFactor);
      }
      
      public function get format() : String
      {
         return mFormat;
      }
      
      public function set format(value:String) : void
      {
         mFormat = value;
      }
      
      public function get mipMapping() : Boolean
      {
         return mMipMapping;
      }
      
      public function set mipMapping(value:Boolean) : void
      {
         mMipMapping = value;
      }
      
      public function get optimizeForRenderToTexture() : Boolean
      {
         return mOptimizeForRenderToTexture;
      }
      
      public function set optimizeForRenderToTexture(value:Boolean) : void
      {
         mOptimizeForRenderToTexture = value;
      }
      
      public function get repeat() : Boolean
      {
         return mRepeat;
      }
      
      public function set repeat(value:Boolean) : void
      {
         mRepeat = value;
      }
      
      public function get onReady() : Function
      {
         return mOnReady;
      }
      
      public function set onReady(value:Function) : void
      {
         mOnReady = value;
      }
   }
}
