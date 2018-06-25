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
      
      public function BlurFilter(blurX:Number = 1, blurY:Number = 1, resolution:Number = 1)
      {
         mOffsets = new <Number>[0,0,0,0];
         mWeights = new <Number>[0,0,0,0];
         mColor = new <Number>[1,1,1,1];
         sTmpWeights = new Vector.<Number>(5,true);
         super(1,resolution);
         mBlurX = blurX;
         mBlurY = blurY;
         updateMarginsAndPasses();
      }
      
      public static function createDropShadow(distance:Number = 4.0, angle:Number = 0.785, color:uint = 0, alpha:Number = 0.5, blur:Number = 1.0, resolution:Number = 0.5) : BlurFilter
      {
         var dropShadow:BlurFilter = new BlurFilter(blur,blur,resolution);
         dropShadow.offsetX = Math.cos(angle) * distance;
         dropShadow.offsetY = Math.sin(angle) * distance;
         dropShadow.mode = "below";
         dropShadow.setUniformColor(true,color,alpha);
         return dropShadow;
      }
      
      public static function createGlow(color:uint = 16776960, alpha:Number = 1.0, blur:Number = 1.0, resolution:Number = 0.5) : BlurFilter
      {
         var glow:BlurFilter = new BlurFilter(blur,blur,resolution);
         glow.mode = "below";
         glow.setUniformColor(true,color,alpha);
         return glow;
      }
      
      override protected function createPrograms() : void
      {
         mNormalProgram = createProgram(false);
         mTintedProgram = createProgram(true);
      }
      
      private function createProgram(tinted:Boolean) : Program3D
      {
         var programName:String = !!tinted?"BF_t":"BF_n";
         var target:Starling = Starling.current;
         if(target.hasProgram(programName))
         {
            return target.getProgram(programName);
         }
         var vertexShader:String = "m44 op, va0, vc0       \nmov v0, va1            \nsub v1, va1, vc4.zwxx  \nsub v2, va1, vc4.xyxx  \nadd v3, va1, vc4.xyxx  \nadd v4, va1, vc4.zwxx  \n";
         var fragmentShader:String = "tex ft0,  v0, fs0 <2d, clamp, linear, mipnone> \nmul ft5, ft0, fc0.xxxx                         \ntex ft1,  v1, fs0 <2d, clamp, linear, mipnone> \nmul ft1, ft1, fc0.zzzz                         \nadd ft5, ft5, ft1                              \ntex ft2,  v2, fs0 <2d, clamp, linear, mipnone> \nmul ft2, ft2, fc0.yyyy                         \nadd ft5, ft5, ft2                              \ntex ft3,  v3, fs0 <2d, clamp, linear, mipnone> \nmul ft3, ft3, fc0.yyyy                         \nadd ft5, ft5, ft3                              \ntex ft4,  v4, fs0 <2d, clamp, linear, mipnone> \nmul ft4, ft4, fc0.zzzz                         \n";
         if(tinted)
         {
            fragmentShader = fragmentShader + "add ft5, ft5, ft4                              \nmul ft5.xyz, fc1.xyz, ft5.www                  \nmul oc, ft5, fc1.wwww                          \n";
         }
         else
         {
            fragmentShader = fragmentShader + "add  oc, ft5, ft4                              \n";
         }
         return target.registerProgramFromSource(programName,vertexShader,fragmentShader);
      }
      
      override protected function activate(pass:int, context:Context3D, texture:Texture) : void
      {
         updateParameters(pass,texture.nativeWidth,texture.nativeHeight);
         context.setProgramConstantsFromVector("vertex",4,mOffsets);
         context.setProgramConstantsFromVector("fragment",0,mWeights);
         if(mUniformColor && pass == numPasses - 1)
         {
            context.setProgramConstantsFromVector("fragment",1,mColor);
            context.setProgram(mTintedProgram);
         }
         else
         {
            context.setProgram(mNormalProgram);
         }
      }
      
      private function updateParameters(pass:int, textureWidth:int, textureHeight:int) : void
      {
         var sigma:Number = NaN;
         var pixelSize:Number = NaN;
         var i:int = 0;
         var horizontal:* = pass < mBlurX;
         if(horizontal)
         {
            sigma = Math.min(1,mBlurX - pass) * 2;
            pixelSize = 1 / textureWidth;
         }
         else
         {
            sigma = Math.min(1,mBlurY - (pass - Math.ceil(mBlurX))) * 2;
            pixelSize = 1 / textureHeight;
         }
         var _loc13_:Number = 2 * sigma * sigma;
         var _loc7_:Number = 1 / Math.sqrt(_loc13_ * 3.14159265358979);
         for(i = 0; i < 5; )
         {
            sTmpWeights[i] = _loc7_ * Math.exp(-i * i / _loc13_);
            i++;
         }
         mWeights[0] = sTmpWeights[0];
         mWeights[1] = sTmpWeights[1] + sTmpWeights[2];
         mWeights[2] = sTmpWeights[3] + sTmpWeights[4];
         var weightSum:Number = mWeights[0] + 2 * mWeights[1] + 2 * mWeights[2];
         var invWeightSum:Number = 1 / weightSum;
         var _loc14_:* = 0;
         var _loc15_:* = mWeights[_loc14_] * invWeightSum;
         mWeights[_loc14_] = _loc15_;
         _loc15_ = 1;
         _loc14_ = mWeights[_loc15_] * invWeightSum;
         mWeights[_loc15_] = _loc14_;
         _loc14_ = 2;
         _loc15_ = mWeights[_loc14_] * invWeightSum;
         mWeights[_loc14_] = _loc15_;
         var offset1:Number = (pixelSize * sTmpWeights[1] + 2 * pixelSize * sTmpWeights[2]) / mWeights[1];
         var offset2:Number = (3 * pixelSize * sTmpWeights[3] + 4 * pixelSize * sTmpWeights[4]) / mWeights[2];
         if(horizontal)
         {
            mOffsets[0] = offset1;
            mOffsets[1] = 0;
            mOffsets[2] = offset2;
            mOffsets[3] = 0;
         }
         else
         {
            mOffsets[0] = 0;
            mOffsets[1] = offset1;
            mOffsets[2] = 0;
            mOffsets[3] = offset2;
         }
      }
      
      private function updateMarginsAndPasses() : void
      {
         if(mBlurX == 0 && mBlurY == 0)
         {
            mBlurX = 0.001;
         }
         numPasses = Math.ceil(mBlurX) + Math.ceil(mBlurY);
         marginX = (3 + Math.ceil(mBlurX)) / resolution;
         marginY = (3 + Math.ceil(mBlurY)) / resolution;
      }
      
      public function setUniformColor(enable:Boolean, color:uint = 0, alpha:Number = 1.0) : void
      {
         mColor[0] = Color.getRed(color) / 255;
         mColor[1] = Color.getGreen(color) / 255;
         mColor[2] = Color.getBlue(color) / 255;
         mColor[3] = alpha;
         mUniformColor = enable;
      }
      
      public function get blurX() : Number
      {
         return mBlurX;
      }
      
      public function set blurX(value:Number) : void
      {
         mBlurX = value;
         updateMarginsAndPasses();
      }
      
      public function get blurY() : Number
      {
         return mBlurY;
      }
      
      public function set blurY(value:Number) : void
      {
         mBlurY = value;
         updateMarginsAndPasses();
      }
   }
}
