package starlingui.core.components
{
   import starling.display.Image;
   import starling.textures.Texture;
   
   public class UVImage extends Image
   {
       
      
      public function UVImage(param1:Texture)
      {
         super(param1);
      }
      
      public function setVertexPosion(param1:int, param2:Number, param3:Number) : void
      {
         mVertexData.setPosition(param1,param2,param3);
         onVertexDataChanged();
      }
   }
}
