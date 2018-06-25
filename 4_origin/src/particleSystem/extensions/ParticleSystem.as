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
      
      public function ParticleSystem(texture:Texture, emissionRate:Number, initialCapacity:int = 128, maxCapacity:int = 8192, blendFactorSource:String = null, blendFactorDest:String = null)
      {
         super();
         if(texture == null)
         {
            throw new ArgumentError("texture must not be null");
         }
         mTexture = texture;
         mPremultipliedAlpha = texture.premultipliedAlpha;
         mParticles = new Vector.<Particle>(0,false);
         mVertexData = new VertexData(0);
         mIndices = new Vector.<uint>(0);
         mEmissionRate = emissionRate;
         mEmissionTime = 0;
         mFrameTime = 0;
         mEmitterY = 0;
         mEmitterX = 0;
         mMaxCapacity = Math.min(8192,maxCapacity);
         mBlendFactorDestination = blendFactorDest || "oneMinusSourceAlpha";
         mBlendFactorSource = blendFactorSource || (!!mPremultipliedAlpha?"one":"sourceAlpha");
         createProgram();
         raiseCapacity(initialCapacity);
         Starling.current.stage3D.addEventListener("context3DCreate",onContextCreated,false,0,true);
      }
      
      override public function dispose() : void
      {
         Starling.current.stage3D.removeEventListener("context3DCreate",onContextCreated);
         if(mVertexBuffer)
         {
            mVertexBuffer.dispose();
         }
         if(mIndexBuffer)
         {
            mIndexBuffer.dispose();
         }
         super.dispose();
      }
      
      private function onContextCreated(event:Object) : void
      {
         createProgram();
         raiseCapacity(0);
      }
      
      protected function createParticle() : Particle
      {
         return new Particle();
      }
      
      protected function initParticle(particle:Particle) : void
      {
         particle.x = mEmitterX;
         particle.y = mEmitterY;
         particle.currentTime = 0;
         particle.totalTime = 1;
         particle.color = Math.random() * 16777215;
      }
      
      protected function advanceParticle(particle:Particle, passedTime:Number) : void
      {
         particle.y = particle.y + passedTime * 250;
         particle.alpha = 1 - particle.currentTime / particle.totalTime;
         particle.scale = 1 - particle.alpha;
         particle.currentTime = particle.currentTime + passedTime;
      }
      
      private function raiseCapacity(byAmount:int) : void
      {
         var i:* = 0;
         var numVertices:int = 0;
         var numIndices:int = 0;
         var oldCapacity:int = capacity;
         var newCapacity:int = Math.min(mMaxCapacity,capacity + byAmount);
         var context:Context3D = Starling.context;
         if(context == null)
         {
            throw new MissingContextError();
         }
         var baseVertexData:VertexData = new VertexData(4);
         baseVertexData.setTexCoords(0,0,0);
         baseVertexData.setTexCoords(1,1,0);
         baseVertexData.setTexCoords(2,0,1);
         baseVertexData.setTexCoords(3,1,1);
         mTexture.adjustVertexData(baseVertexData,0,4);
         mParticles.fixed = false;
         mIndices.fixed = false;
         for(i = oldCapacity; i < newCapacity; )
         {
            numVertices = i * 4;
            numIndices = i * 6;
            mParticles[i] = createParticle();
            mVertexData.append(baseVertexData);
            mIndices[numIndices] = numVertices;
            mIndices[int(numIndices + 1)] = numVertices + 1;
            mIndices[int(numIndices + 2)] = numVertices + 2;
            mIndices[int(numIndices + 3)] = numVertices + 1;
            mIndices[int(numIndices + 4)] = numVertices + 3;
            mIndices[int(numIndices + 5)] = numVertices + 2;
            i++;
         }
         mParticles.fixed = true;
         mIndices.fixed = true;
         if(mVertexBuffer)
         {
            mVertexBuffer.dispose();
         }
         if(mIndexBuffer)
         {
            mIndexBuffer.dispose();
         }
         mVertexBuffer = context.createVertexBuffer(newCapacity * 4,8);
         mVertexBuffer.uploadFromVector(mVertexData.rawData,0,newCapacity * 4);
         mIndexBuffer = context.createIndexBuffer(newCapacity * 6);
         mIndexBuffer.uploadFromVector(mIndices,0,newCapacity * 6);
      }
      
      public function start(duration:Number = 1.7976931348623157E308) : void
      {
         if(mEmissionRate != 0)
         {
            mEmissionTime = duration;
         }
      }
      
      public function stop(clearParticles:Boolean = false) : void
      {
         mEmissionTime = 0;
         if(clearParticles)
         {
            mNumParticles = 0;
         }
      }
      
      override public function getBounds(targetSpace:DisplayObject, resultRect:Rectangle = null) : Rectangle
      {
         if(resultRect == null)
         {
            resultRect = new Rectangle();
         }
         getTransformationMatrix(targetSpace,sHelperMatrix);
         MatrixUtil.transformCoords(sHelperMatrix,0,0,sHelperPoint);
         resultRect.x = sHelperPoint.x;
         resultRect.y = sHelperPoint.y;
         var _loc3_:int = 0;
         resultRect.height = _loc3_;
         resultRect.width = _loc3_;
         return resultRect;
      }
      
      public function advanceTime(passedTime:Number) : void
      {
         var particle:* = null;
         var nextParticle:* = null;
         var timeBetweenParticles:Number = NaN;
         var color:* = 0;
         var alpha:Number = NaN;
         var rotation:Number = NaN;
         var y:Number = NaN;
         var x:Number = NaN;
         var yOffset:Number = NaN;
         var xOffset:Number = NaN;
         var i:int = 0;
         var centerOffsetX:Number = NaN;
         var centerOffsetY:Number = NaN;
         var j:int = 0;
         var cos:Number = NaN;
         var sin:Number = NaN;
         var cosX:Number = NaN;
         var cosY:Number = NaN;
         var sinX:Number = NaN;
         var sinY:Number = NaN;
         var x2:Number = NaN;
         var y2:Number = NaN;
         var particleIndex:int = 0;
         while(particleIndex < mNumParticles)
         {
            particle = mParticles[particleIndex] as Particle;
            if(particle.currentTime < particle.totalTime)
            {
               advanceParticle(particle,passedTime);
               particleIndex++;
            }
            else
            {
               if(particleIndex != mNumParticles - 1)
               {
                  nextParticle = mParticles[int(mNumParticles - 1)] as Particle;
                  mParticles[int(mNumParticles - 1)] = particle;
                  mParticles[particleIndex] = nextParticle;
               }
               mNumParticles = mNumParticles - 1;
               if(mNumParticles == 0 && mEmissionTime == 0)
               {
                  dispatchEvent(new Event("complete"));
               }
            }
         }
         if(mEmissionTime > 0)
         {
            timeBetweenParticles = 1 / mEmissionRate;
            mFrameTime = mFrameTime + passedTime;
            while(mFrameTime > 0)
            {
               if(mNumParticles < mMaxCapacity)
               {
                  if(mNumParticles == capacity)
                  {
                     raiseCapacity(capacity);
                  }
                  mNumParticles = Number(mNumParticles) + 1;
                  particle = mParticles[int(Number(mNumParticles))] as Particle;
                  initParticle(particle);
                  advanceParticle(particle,mFrameTime);
               }
               mFrameTime = mFrameTime - timeBetweenParticles;
            }
            if(mEmissionTime != 1.79769313486232e308)
            {
               mEmissionTime = Math.max(0,mEmissionTime - passedTime);
            }
         }
         var vertexID:* = 0;
         var textureWidth:Number = mTexture.width;
         var textureHeight:Number = mTexture.height;
         for(i = 0; i < mNumParticles; )
         {
            vertexID = i << 2;
            particle = mParticles[i] as Particle;
            color = uint(particle.color);
            alpha = particle.alpha;
            rotation = particle.rotation;
            x = particle.x;
            y = particle.y;
            xOffset = textureWidth * particle.scale >> 1;
            yOffset = textureHeight * particle.scale >> 1;
            centerOffsetX = mCenterOffset.x;
            centerOffsetY = mCenterOffset.y;
            for(j = 0; j < 4; )
            {
               mVertexData.setColor(vertexID + j,color);
               mVertexData.setAlpha(vertexID + j,alpha);
               j++;
            }
            if(rotation)
            {
               cos = Math.cos(rotation);
               sin = Math.sin(rotation);
               cosX = cos * xOffset;
               cosY = cos * yOffset;
               sinX = sin * xOffset;
               sinY = sin * yOffset;
               x2 = cos * centerOffsetX - sin * centerOffsetY;
               y2 = cos * centerOffsetY + sin * centerOffsetX;
               mVertexData.setPosition(vertexID,x - cosX + sinY + x2,y - sinX - cosY + y2);
               mVertexData.setPosition(vertexID + 1,x + cosX + sinY + x2,y + sinX - cosY + y2);
               mVertexData.setPosition(vertexID + 2,x - cosX - sinY + x2,y - sinX + cosY + y2);
               mVertexData.setPosition(vertexID + 3,x + cosX - sinY + x2,y + sinX + cosY + y2);
            }
            else
            {
               mVertexData.setPosition(vertexID,x - xOffset + centerOffsetX,y - yOffset + centerOffsetY);
               mVertexData.setPosition(vertexID + 1,x + xOffset + centerOffsetX,y - yOffset + centerOffsetY);
               mVertexData.setPosition(vertexID + 2,x - xOffset + centerOffsetX,y + yOffset + centerOffsetY);
               mVertexData.setPosition(vertexID + 3,x + xOffset + centerOffsetX,y + yOffset + centerOffsetY);
            }
            i++;
         }
      }
      
      override public function render(support:RenderSupport, alpha:Number) : void
      {
         if(mNumParticles == 0)
         {
            return;
         }
         support.finishQuadBatch();
         if(support.hasOwnProperty("raiseDrawCount"))
         {
            support.raiseDrawCount();
         }
         alpha = alpha * this.alpha;
         var context:Context3D = Starling.context;
         var pma:Boolean = texture.premultipliedAlpha;
         var _loc5_:* = !!pma?alpha:1;
         sRenderAlpha[2] = _loc5_;
         _loc5_ = _loc5_;
         sRenderAlpha[1] = _loc5_;
         sRenderAlpha[0] = _loc5_;
         sRenderAlpha[3] = alpha;
         if(context == null)
         {
            throw new MissingContextError();
         }
         mVertexBuffer.uploadFromVector(mVertexData.rawData,0,mNumParticles * 4);
         mIndexBuffer.uploadFromVector(mIndices,0,mNumParticles * 6);
         context.setBlendFactors(mBlendFactorSource,mBlendFactorDestination);
         context.setTextureAt(0,mTexture.base);
         context.setProgram(mProgram);
         context.setProgramConstantsFromMatrix("vertex",0,support.mvpMatrix3D,true);
         context.setProgramConstantsFromVector("vertex",4,sRenderAlpha,1);
         context.setVertexBufferAt(0,mVertexBuffer,0,"float2");
         context.setVertexBufferAt(1,mVertexBuffer,2,"float4");
         context.setVertexBufferAt(2,mVertexBuffer,6,"float2");
         context.drawTriangles(mIndexBuffer,0,mNumParticles * 2);
         context.setTextureAt(0,null);
         context.setVertexBufferAt(0,null);
         context.setVertexBufferAt(1,null);
         context.setVertexBufferAt(2,null);
      }
      
      public function populate(count:int) : void
      {
         var p:* = null;
         var i:int = 0;
         count = Math.min(count,mMaxCapacity - mNumParticles);
         if(mNumParticles + count > capacity)
         {
            raiseCapacity(count - capacity);
         }
         i = 0;
         while(i < count)
         {
            p = mParticles[mNumParticles + i];
            initParticle(p);
            advanceParticle(p,Math.random() * p.totalTime);
            i++;
         }
         mNumParticles = mNumParticles + count;
      }
      
      private function createProgram() : void
      {
         var textureOptions:* = null;
         var vertexProgramCode:* = null;
         var fragmentProgramCode:* = null;
         var vertexProgramAssembler:* = null;
         var fragmentProgramAssembler:* = null;
         var mipmap:Boolean = mTexture.mipMapping;
         var textureFormat:String = mTexture.format;
         var programName:String = "ext.ParticleSystem." + textureFormat + (!!mipmap?"+mm":"");
         mProgram = Starling.current.getProgram(programName);
         if(mProgram == null)
         {
            textureOptions = "2d, clamp, linear, " + (!!mipmap?"mipnearest":"mipnone");
            if(textureFormat == "compressed")
            {
               textureOptions = textureOptions + ", dxt1";
            }
            else if(textureFormat == "compressedAlpha")
            {
               textureOptions = textureOptions + ", dxt5";
            }
            vertexProgramCode = "m44 op, va0, vc0 \nmul v0, va1, vc4 \nmov v1, va2      \n";
            fragmentProgramCode = "tex ft1, v1, fs0 <" + textureOptions + "> \n" + "mul oc, ft1, v0";
            vertexProgramAssembler = new AGALMiniAssembler();
            vertexProgramAssembler.assemble("vertex",vertexProgramCode);
            fragmentProgramAssembler = new AGALMiniAssembler();
            fragmentProgramAssembler.assemble("fragment",fragmentProgramCode);
            Starling.current.registerProgram(programName,vertexProgramAssembler.agalcode,fragmentProgramAssembler.agalcode);
            mProgram = Starling.current.getProgram(programName);
         }
      }
      
      public function get isEmitting() : Boolean
      {
         return mEmissionTime > 0 && mEmissionRate > 0;
      }
      
      public function get capacity() : int
      {
         return mVertexData.numVertices / 4;
      }
      
      public function get numParticles() : int
      {
         return mNumParticles;
      }
      
      public function get maxCapacity() : int
      {
         return mMaxCapacity;
      }
      
      public function set maxCapacity(value:int) : void
      {
         mMaxCapacity = Math.min(8192,value);
      }
      
      public function get emissionRate() : Number
      {
         return mEmissionRate;
      }
      
      public function set emissionRate(value:Number) : void
      {
         mEmissionRate = value;
      }
      
      public function get emitterX() : Number
      {
         return mEmitterX;
      }
      
      public function set emitterX(value:Number) : void
      {
         mEmitterX = value;
      }
      
      public function get emitterY() : Number
      {
         return mEmitterY;
      }
      
      public function set emitterY(value:Number) : void
      {
         mEmitterY = value;
      }
      
      public function get blendFactorSource() : String
      {
         return mBlendFactorSource;
      }
      
      public function set blendFactorSource(value:String) : void
      {
         mBlendFactorSource = value;
      }
      
      public function get blendFactorDestination() : String
      {
         return mBlendFactorDestination;
      }
      
      public function set blendFactorDestination(value:String) : void
      {
         mBlendFactorDestination = value;
      }
      
      public function get texture() : Texture
      {
         return mTexture;
      }
      
      public function set texture(value:Texture) : void
      {
         mTexture = value;
         createProgram();
      }
      
      public function get centerOffset() : Point
      {
         return mCenterOffset;
      }
      
      public function set centerOffset(value:Point) : void
      {
         mCenterOffset = value;
      }
   }
}
