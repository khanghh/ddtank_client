package particleSystem.extensions{   import com.adobe.utils.AGALMiniAssembler;   import flash.display3D.Context3D;   import flash.display3D.IndexBuffer3D;   import flash.display3D.Program3D;   import flash.display3D.VertexBuffer3D;   import flash.geom.Matrix;   import flash.geom.Point;   import flash.geom.Rectangle;   import starling.animation.IAnimatable;   import starling.core.RenderSupport;   import starling.core.Starling;   import starling.display.DisplayObject;   import starling.errors.MissingContextError;   import starling.events.Event;   import starling.textures.Texture;   import starling.utils.MatrixUtil;   import starling.utils.VertexData;      [Event(name="complete",type="starling.events.Event")]   public class ParticleSystem extends DisplayObject implements IAnimatable   {            private static var sHelperMatrix:Matrix = new Matrix();            private static var sHelperPoint:Point = new Point();            private static var sRenderAlpha:Vector.<Number> = new <Number>[1,1,1,1];                   private var mTexture:Texture;            private var mParticles:Vector.<Particle>;            private var mFrameTime:Number;            private var mProgram:Program3D;            private var mVertexData:VertexData;            private var mVertexBuffer:VertexBuffer3D;            private var mIndices:Vector.<uint>;            private var mIndexBuffer:IndexBuffer3D;            private var mNumParticles:int;            private var mMaxCapacity:int;            private var mEmissionRate:Number;            private var mEmissionTime:Number;            protected var mEmitterX:Number;            protected var mEmitterY:Number;            protected var mPremultipliedAlpha:Boolean;            protected var mBlendFactorSource:String;            protected var mBlendFactorDestination:String;            protected var mCenterOffset:Point;            public function ParticleSystem(texture:Texture, emissionRate:Number, initialCapacity:int = 128, maxCapacity:int = 8192, blendFactorSource:String = null, blendFactorDest:String = null) { super(); }
            override public function dispose() : void { }
            private function onContextCreated(event:Object) : void { }
            protected function createParticle() : Particle { return null; }
            protected function initParticle(particle:Particle) : void { }
            protected function advanceParticle(particle:Particle, passedTime:Number) : void { }
            private function raiseCapacity(byAmount:int) : void { }
            public function start(duration:Number = 1.7976931348623157E308) : void { }
            public function stop(clearParticles:Boolean = false) : void { }
            override public function getBounds(targetSpace:DisplayObject, resultRect:Rectangle = null) : Rectangle { return null; }
            public function advanceTime(passedTime:Number) : void { }
            override public function render(support:RenderSupport, alpha:Number) : void { }
            public function populate(count:int) : void { }
            private function createProgram() : void { }
            public function get isEmitting() : Boolean { return false; }
            public function get capacity() : int { return 0; }
            public function get numParticles() : int { return 0; }
            public function get maxCapacity() : int { return 0; }
            public function set maxCapacity(value:int) : void { }
            public function get emissionRate() : Number { return 0; }
            public function set emissionRate(value:Number) : void { }
            public function get emitterX() : Number { return 0; }
            public function set emitterX(value:Number) : void { }
            public function get emitterY() : Number { return 0; }
            public function set emitterY(value:Number) : void { }
            public function get blendFactorSource() : String { return null; }
            public function set blendFactorSource(value:String) : void { }
            public function get blendFactorDestination() : String { return null; }
            public function set blendFactorDestination(value:String) : void { }
            public function get texture() : Texture { return null; }
            public function set texture(value:Texture) : void { }
            public function get centerOffset() : Point { return null; }
            public function set centerOffset(value:Point) : void { }
   }}