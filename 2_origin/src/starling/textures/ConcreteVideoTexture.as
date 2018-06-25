package starling.textures
{
   import flash.display3D.textures.TextureBase;
   import flash.utils.getQualifiedClassName;
   
   class ConcreteVideoTexture extends ConcreteTexture
   {
       
      
      function ConcreteVideoTexture(base:TextureBase, scale:Number = 1)
      {
         var format:String = "bgra";
         var width:Number = "videoWidth" in base?base["videoWidth"]:0;
         var height:Number = "videoHeight" in base?base["videoHeight"]:0;
         super(base,format,width,height,false,false,false,scale,false);
         if(getQualifiedClassName(base) != "flash.display3D.textures::VideoTexture")
         {
            throw new ArgumentError("\'base\' must be VideoTexture");
         }
      }
      
      override public function get nativeWidth() : Number
      {
         return base["videoWidth"];
      }
      
      override public function get nativeHeight() : Number
      {
         return base["videoHeight"];
      }
      
      override public function get width() : Number
      {
         return nativeWidth / scale;
      }
      
      override public function get height() : Number
      {
         return nativeHeight / scale;
      }
   }
}
