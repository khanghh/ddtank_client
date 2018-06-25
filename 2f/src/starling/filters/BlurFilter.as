package starling.filters{   import flash.display3D.Context3D;   import flash.display3D.Program3D;   import starling.core.Starling;   import starling.textures.Texture;   import starling.utils.Color;      public class BlurFilter extends FragmentFilter   {            private static const NORMAL_PROGRAM_NAME:String = "BF_n";            private static const TINTED_PROGRAM_NAME:String = "BF_t";            private static const MAX_SIGMA:Number = 2.0;                   private var mNormalProgram:Program3D;            private var mTintedProgram:Program3D;            private var mOffsets:Vector.<Number>;            private var mWeights:Vector.<Number>;            private var mColor:Vector.<Number>;            private var mBlurX:Number;            private var mBlurY:Number;            private var mUniformColor:Boolean;            private var sTmpWeights:Vector.<Number>;            public function BlurFilter(blurX:Number = 1, blurY:Number = 1, resolution:Number = 1) { super(null,null); }
            public static function createDropShadow(distance:Number = 4.0, angle:Number = 0.785, color:uint = 0, alpha:Number = 0.5, blur:Number = 1.0, resolution:Number = 0.5) : BlurFilter { return null; }
            public static function createGlow(color:uint = 16776960, alpha:Number = 1.0, blur:Number = 1.0, resolution:Number = 0.5) : BlurFilter { return null; }
            override protected function createPrograms() : void { }
            private function createProgram(tinted:Boolean) : Program3D { return null; }
            override protected function activate(pass:int, context:Context3D, texture:Texture) : void { }
            private function updateParameters(pass:int, textureWidth:int, textureHeight:int) : void { }
            private function updateMarginsAndPasses() : void { }
            public function setUniformColor(enable:Boolean, color:uint = 0, alpha:Number = 1.0) : void { }
            public function get blurX() : Number { return 0; }
            public function set blurX(value:Number) : void { }
            public function get blurY() : Number { return 0; }
            public function set blurY(value:Number) : void { }
   }}