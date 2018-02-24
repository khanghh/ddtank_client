package starling.display.shaders
{
   import com.adobe.utils.AGALMiniAssembler;
   import flash.display3D.Context3D;
   import flash.utils.ByteArray;
   
   public class AbstractShader implements IShader
   {
      
      private static var assembler:AGALMiniAssembler;
       
      
      protected var _opCode:ByteArray;
      
      public function AbstractShader(){super();}
      
      protected function compileAGAL(param1:String, param2:String) : void{}
      
      public function get opCode() : ByteArray{return null;}
      
      public function setConstants(param1:Context3D, param2:int) : void{}
   }
}
