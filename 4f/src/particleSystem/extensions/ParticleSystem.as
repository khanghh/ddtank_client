package particleSystem.extensions
{
   import com.adobe.utils.AGALMiniAssembler;
   import flash.display3D.Context3D;
   import flash.display3D.IndexBuffer3D;
   import flash.display3D.Program3D;
   import flash.display3D.VertexBuffer3D;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.animation.IAnimatable;
   import starling.core.RenderSupport;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.errors.MissingContextError;
   import starling.events.Event;
   import starling.textures.Texture;
   import starling.utils.MatrixUtil;
   import starling.utils.VertexData;
   
   [Event(name="complete",type="starling.events.Event")]
   public class ParticleSystem extends DisplayObject implements IAnimatable
   {
      
      private static var sHelperMatrix:Matrix = new Matrix();
      
      private static var sHelperPoint:Point = new Point();
      
      private static var sRenderAlpha:Vector.<Number> = new <Number>[1,1,1,1];
       
      
      private var mTexture:Texture;
      
      private var mParticles:Vector.<Particle>;
      
      private var mFrameTime:Number;
      
      private var mProgram:Program3D;
      
      private var mVertexData:VertexData;
      
      private var mVertexBuffer:VertexBuffer3D;
      
      private var mIndices:Vector.<uint>;
      
      private var mIndexBuffer:IndexBuffer3D;
      
      private var mNumParticles:int;
      
      private var mMaxCapacity:int;
      
      private var mEmissionRate:Number;
      
      private var mEmissionTime:Number;
      
      protected var mEmitterX:Number;
      
      protected var mEmitterY:Number;
      
      protected var mPremultipliedAlpha:Boolean;
      
      protected var mBlendFactorSource:String;
      
      protected var mBlendFactorDestination:String;
      
      protected var mCenterOffset:Point;
      
      public function ParticleSystem(param1:Texture, param2:Number, param3:int = 128, param4:int = 8192, param5:String = null, param6:String = null){super();}
      
      override public function dispose() : void{}
      
      private function onContextCreated(param1:Object) : void{}
      
      protected function createParticle() : Particle{return null;}
      
      protected function initParticle(param1:Particle) : void{}
      
      protected function advanceParticle(param1:Particle, param2:Number) : void{}
      
      private function raiseCapacity(param1:int) : void{}
      
      public function start(param1:Number = 1.7976931348623157E308) : void{}
      
      public function stop(param1:Boolean = false) : void{}
      
      override public function getBounds(param1:DisplayObject, param2:Rectangle = null) : Rectangle{return null;}
      
      public function advanceTime(param1:Number) : void{}
      
      override public function render(param1:RenderSupport, param2:Number) : void{}
      
      public function populate(param1:int) : void{}
      
      private function createProgram() : void{}
      
      public function get isEmitting() : Boolean{return false;}
      
      public function get capacity() : int{return 0;}
      
      public function get numParticles() : int{return 0;}
      
      public function get maxCapacity() : int{return 0;}
      
      public function set maxCapacity(param1:int) : void{}
      
      public function get emissionRate() : Number{return 0;}
      
      public function set emissionRate(param1:Number) : void{}
      
      public function get emitterX() : Number{return 0;}
      
      public function set emitterX(param1:Number) : void{}
      
      public function get emitterY() : Number{return 0;}
      
      public function set emitterY(param1:Number) : void{}
      
      public function get blendFactorSource() : String{return null;}
      
      public function set blendFactorSource(param1:String) : void{}
      
      public function get blendFactorDestination() : String{return null;}
      
      public function set blendFactorDestination(param1:String) : void{}
      
      public function get texture() : Texture{return null;}
      
      public function set texture(param1:Texture) : void{}
      
      public function get centerOffset() : Point{return null;}
      
      public function set centerOffset(param1:Point) : void{}
   }
}
