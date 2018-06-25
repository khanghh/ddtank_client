package starling.display.shaders{   import com.adobe.utils.AGALMiniAssembler;   import flash.display3D.Context3D;   import flash.utils.ByteArray;      public class AbstractShader implements IShader   {            private static var assembler:AGALMiniAssembler;                   protected var _opCode:ByteArray;            public function AbstractShader() { super(); }
            protected function compileAGAL(shaderType:String, agal:String) : void { }
            public function get opCode() : ByteArray { return null; }
            public function setConstants(context:Context3D, firstRegister:int) : void { }
   }}