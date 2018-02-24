package starling.filters
{
   import flash.display3D.Context3D;
   import flash.display3D.Program3D;
   import starling.core.Starling;
   import starling.textures.Texture;
   import starling.utils.Color;
   
   public class BlurFilter extends FragmentFilter
   {
      
      private static const NORMAL_PROGRAM_NAME:String = "BF_n";
      
      private static const TINTED_PROGRAM_NAME:String = "BF_t";
      
      private static const MAX_SIGMA:Number = 2.0;
       
      
      private var mNormalProgram:Program3D;
      
      private var mTintedProgram:Program3D;
      
      private var mOffsets:Vector.<Number>;
      
      private var mWeights:Vector.<Number>;
      
      private var mColor:Vector.<Number>;
      
      private var mBlurX:Number;
      
      private var mBlurY:Number;
      
      private var mUniformColor:Boolean;
      
      private var sTmpWeights:Vector.<Number>;
      
      public function BlurFilter(param1:Number = 1, param2:Number = 1, param3:Number = 1){super(null,null);}
      
      public static function createDropShadow(param1:Number = 4.0, param2:Number = 0.785, param3:uint = 0, param4:Number = 0.5, param5:Number = 1.0, param6:Number = 0.5) : BlurFilter{return null;}
      
      public static function createGlow(param1:uint = 16776960, param2:Number = 1.0, param3:Number = 1.0, param4:Number = 0.5) : BlurFilter{return null;}
      
      override protected function createPrograms() : void{}
      
      private function createProgram(param1:Boolean) : Program3D{return null;}
      
      override protected function activate(param1:int, param2:Context3D, param3:Texture) : void{}
      
      private function updateParameters(param1:int, param2:int, param3:int) : void{}
      
      private function updateMarginsAndPasses() : void{}
      
      public function setUniformColor(param1:Boolean, param2:uint = 0, param3:Number = 1.0) : void{}
      
      public function get blurX() : Number{return 0;}
      
      public function set blurX(param1:Number) : void{}
      
      public function get blurY() : Number{return 0;}
      
      public function set blurY(param1:Number) : void{}
   }
}
