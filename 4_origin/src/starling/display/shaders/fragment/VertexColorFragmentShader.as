package starling.display.shaders.fragment
{
   import starling.display.shaders.AbstractShader;
   
   public class VertexColorFragmentShader extends AbstractShader
   {
       
      
      public function VertexColorFragmentShader()
      {
         super();
         var agal:String = "mul oc, v0, fc0";
         compileAGAL("fragment",agal);
      }
   }
}
