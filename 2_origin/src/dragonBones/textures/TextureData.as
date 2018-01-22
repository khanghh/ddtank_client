package dragonBones.textures
{
   import flash.geom.Rectangle;
   
   public final class TextureData
   {
       
      
      public var region:Rectangle;
      
      public var frame:Rectangle;
      
      public var rotated:Boolean;
      
      public function TextureData(param1:Rectangle, param2:Rectangle, param3:Boolean)
      {
         super();
         this.region = param1;
         this.frame = param2;
         this.rotated = param3;
      }
   }
}
