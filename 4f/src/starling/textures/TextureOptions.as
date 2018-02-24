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
      
      public function TextureOptions(param1:Number = 1.0, param2:Boolean = false, param3:String = "bgra", param4:Boolean = false){super();}
      
      public function clone() : TextureOptions{return null;}
      
      public function get scale() : Number{return 0;}
      
      public function set scale(param1:Number) : void{}
      
      public function get format() : String{return null;}
      
      public function set format(param1:String) : void{}
      
      public function get mipMapping() : Boolean{return false;}
      
      public function set mipMapping(param1:Boolean) : void{}
      
      public function get optimizeForRenderToTexture() : Boolean{return false;}
      
      public function set optimizeForRenderToTexture(param1:Boolean) : void{}
      
      public function get repeat() : Boolean{return false;}
      
      public function set repeat(param1:Boolean) : void{}
      
      public function get onReady() : Function{return null;}
      
      public function set onReady(param1:Function) : void{}
   }
}
