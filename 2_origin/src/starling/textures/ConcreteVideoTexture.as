package starling.textures
{
   import flash.display3D.textures.TextureBase;
   import flash.utils.getQualifiedClassName;
   
   class ConcreteVideoTexture extends ConcreteTexture
   {
       
      
      function ConcreteVideoTexture(param1:TextureBase, param2:Number = 1)
      {
         var _loc5_:String = "bgra";
         var _loc4_:Number = "videoWidth" in param1?param1["videoWidth"]:0;
         var _loc3_:Number = "videoHeight" in param1?param1["videoHeight"]:0;
         super(param1,_loc5_,_loc4_,_loc3_,false,false,false,param2,false);
         if(getQualifiedClassName(param1) != "flash.display3D.textures::VideoTexture")
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
