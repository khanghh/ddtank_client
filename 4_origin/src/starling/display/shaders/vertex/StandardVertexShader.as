package starling.display.shaders.vertex
{
   import starling.display.shaders.AbstractShader;
   
   public class StandardVertexShader extends AbstractShader
   {
       
      
      public function StandardVertexShader()
      {
         super();
         var _loc1_:String = "m44 op, va0, vc0 \nmov v0, va1 \nmov v1, va2 \n";
         compileAGAL("vertex",_loc1_);
      }
   }
}
