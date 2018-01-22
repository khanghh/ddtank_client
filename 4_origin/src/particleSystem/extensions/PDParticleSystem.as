package particleSystem.extensions
{
   import flash.geom.Point;
   import starling.textures.Texture;
   import starling.utils.deg2rad;
   
   public class PDParticleSystem extends ParticleSystem
   {
       
      
      private const EMITTER_TYPE_GRAVITY:int = 0;
      
      private const EMITTER_TYPE_RADIAL:int = 1;
      
      private var mEmitterType:int;
      
      private var mEmitterXVariance:Number;
      
      private var mEmitterYVariance:Number;
      
      private var mMaxNumParticles:int;
      
      private var mLifespan:Number;
      
      private var mLifespanVariance:Number;
      
      private var mStartSize:Number;
      
      private var mStartSizeVariance:Number;
      
      private var mEndSize:Number;
      
      private var mEndSizeVariance:Number;
      
      private var mEmitAngle:Number;
      
      private var mEmitAngleVariance:Number;
      
      private var mStartRotation:Number;
      
      private var mStartRotationVariance:Number;
      
      private var mEndRotation:Number;
      
      private var mEndRotationVariance:Number;
      
      private var mSpeed:Number;
      
      private var mSpeedVariance:Number;
      
      private var mGravityX:Number;
      
      private var mGravityY:Number;
      
      private var mRadialAcceleration:Number;
      
      private var mRadialAccelerationVariance:Number;
      
      private var mTangentialAcceleration:Number;
      
      private var mTangentialAccelerationVariance:Number;
      
      private var mMaxRadius:Number;
      
      private var mMaxRadiusVariance:Number;
      
      private var mMinRadius:Number;
      
      private var mRotatePerSecond:Number;
      
      private var mRotatePerSecondVariance:Number;
      
      private var mStartColor:ColorArgb;
      
      private var mStartColorVariance:ColorArgb;
      
      private var mEndColor:ColorArgb;
      
      private var mEndColorVariance:ColorArgb;
      
      public function PDParticleSystem(param1:XML, param2:Texture)
      {
         parseConfig(param1);
         var _loc3_:Number = mMaxNumParticles / mLifespan;
         super(param2,_loc3_,mMaxNumParticles,mMaxNumParticles,mBlendFactorSource,mBlendFactorDestination);
         mPremultipliedAlpha = false;
      }
      
      override protected function createParticle() : Particle
      {
         return new PDParticle();
      }
      
      override protected function initParticle(param1:Particle) : void
      {
         var _loc8_:PDParticle = param1 as PDParticle;
         var _loc15_:Number = mLifespan + mLifespanVariance * (Math.random() * 2 - 1);
         if(_loc15_ <= 0)
         {
            return;
         }
         _loc8_.currentTime = 0;
         _loc8_.totalTime = _loc15_;
         _loc8_.x = mEmitterX + mEmitterXVariance * (Math.random() * 2 - 1);
         _loc8_.y = mEmitterY + mEmitterYVariance * (Math.random() * 2 - 1);
         _loc8_.startX = mEmitterX;
         _loc8_.startY = mEmitterY;
         var _loc6_:Number = mEmitAngle + mEmitAngleVariance * (Math.random() * 2 - 1);
         var _loc3_:Number = mSpeed + mSpeedVariance * (Math.random() * 2 - 1);
         _loc8_.velocityX = _loc3_ * Math.cos(_loc6_);
         _loc8_.velocityY = _loc3_ * Math.sin(_loc6_);
         _loc8_.emitRadius = mMaxRadius + mMaxRadiusVariance * (Math.random() * 2 - 1);
         _loc8_.emitRadiusDelta = mMaxRadius / _loc15_;
         _loc8_.emitRotation = mEmitAngle + mEmitAngleVariance * (Math.random() * 2 - 1);
         _loc8_.emitRotationDelta = mRotatePerSecond + mRotatePerSecondVariance * (Math.random() * 2 - 1);
         _loc8_.radialAcceleration = mRadialAcceleration + mRadialAccelerationVariance * (Math.random() * 2 - 1);
         _loc8_.tangentialAcceleration = mTangentialAcceleration + mTangentialAccelerationVariance * (Math.random() * 2 - 1);
         var _loc9_:* = Number(mStartSize + mStartSizeVariance * (Math.random() * 2 - 1));
         var _loc4_:* = Number(mEndSize + mEndSizeVariance * (Math.random() * 2 - 1));
         if(_loc9_ < 0.1)
         {
            _loc9_ = 0.1;
         }
         if(_loc4_ < 0.1)
         {
            _loc4_ = 0.1;
         }
         _loc8_.scale = _loc9_ / texture.width;
         _loc8_.scaleDelta = (_loc4_ - _loc9_) / _loc15_ / texture.width;
         var _loc12_:ColorArgb = _loc8_.colorArgb;
         var _loc5_:ColorArgb = _loc8_.colorArgbDelta;
         _loc12_.red = mStartColor.red;
         _loc12_.green = mStartColor.green;
         _loc12_.blue = mStartColor.blue;
         _loc12_.alpha = mStartColor.alpha;
         if(mStartColorVariance.red != 0)
         {
            _loc12_.red = _loc12_.red + mStartColorVariance.red * (Math.random() * 2 - 1);
         }
         if(mStartColorVariance.green != 0)
         {
            _loc12_.green = _loc12_.green + mStartColorVariance.green * (Math.random() * 2 - 1);
         }
         if(mStartColorVariance.blue != 0)
         {
            _loc12_.blue = _loc12_.blue + mStartColorVariance.blue * (Math.random() * 2 - 1);
         }
         if(mStartColorVariance.alpha != 0)
         {
            _loc12_.alpha = _loc12_.alpha + mStartColorVariance.alpha * (Math.random() * 2 - 1);
         }
         var _loc14_:Number = mEndColor.red;
         var _loc11_:Number = mEndColor.green;
         var _loc10_:Number = mEndColor.blue;
         var _loc2_:Number = mEndColor.alpha;
         if(mEndColorVariance.red != 0)
         {
            _loc14_ = _loc14_ + mEndColorVariance.red * (Math.random() * 2 - 1);
         }
         if(mEndColorVariance.green != 0)
         {
            _loc11_ = _loc11_ + mEndColorVariance.green * (Math.random() * 2 - 1);
         }
         if(mEndColorVariance.blue != 0)
         {
            _loc10_ = _loc10_ + mEndColorVariance.blue * (Math.random() * 2 - 1);
         }
         if(mEndColorVariance.alpha != 0)
         {
            _loc2_ = _loc2_ + mEndColorVariance.alpha * (Math.random() * 2 - 1);
         }
         _loc5_.red = (_loc14_ - _loc12_.red) / _loc15_;
         _loc5_.green = (_loc11_ - _loc12_.green) / _loc15_;
         _loc5_.blue = (_loc10_ - _loc12_.blue) / _loc15_;
         _loc5_.alpha = (_loc2_ - _loc12_.alpha) / _loc15_;
         var _loc13_:Number = mStartRotation + mStartRotationVariance * (Math.random() * 2 - 1);
         var _loc7_:Number = mEndRotation + mEndRotationVariance * (Math.random() * 2 - 1);
         _loc8_.rotation = _loc13_;
         _loc8_.rotationDelta = (_loc7_ - _loc13_) / _loc15_;
      }
      
      override protected function advanceParticle(param1:Particle, param2:Number) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc7_:* = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:* = NaN;
         var _loc9_:* = NaN;
         var _loc6_:* = NaN;
         var _loc3_:PDParticle = param1 as PDParticle;
         var _loc8_:Number = _loc3_.totalTime - _loc3_.currentTime;
         param2 = _loc8_ > param2?param2:Number(_loc8_);
         _loc3_.currentTime = _loc3_.currentTime + param2;
         if(mEmitterType == 1)
         {
            _loc3_.emitRotation = _loc3_.emitRotation + _loc3_.emitRotationDelta * param2;
            _loc3_.emitRadius = _loc3_.emitRadius - _loc3_.emitRadiusDelta * param2;
            _loc3_.x = mEmitterX - Math.cos(_loc3_.emitRotation) * _loc3_.emitRadius;
            _loc3_.y = mEmitterY - Math.sin(_loc3_.emitRotation) * _loc3_.emitRadius;
            if(_loc3_.emitRadius < mMinRadius)
            {
               _loc3_.currentTime = _loc3_.totalTime;
            }
         }
         else
         {
            _loc4_ = _loc3_.x - _loc3_.startX;
            _loc5_ = _loc3_.y - _loc3_.startY;
            _loc7_ = Number(Math.sqrt(_loc4_ * _loc4_ + _loc5_ * _loc5_));
            if(_loc7_ < 0.01)
            {
               _loc7_ = 0.01;
            }
            _loc10_ = _loc4_ / _loc7_;
            _loc11_ = _loc5_ / _loc7_;
            _loc12_ = _loc10_;
            _loc9_ = _loc11_;
            _loc10_ = _loc10_ * _loc3_.radialAcceleration;
            _loc11_ = _loc11_ * _loc3_.radialAcceleration;
            _loc6_ = _loc12_;
            _loc12_ = Number(-_loc9_ * _loc3_.tangentialAcceleration);
            _loc9_ = Number(_loc6_ * _loc3_.tangentialAcceleration);
            _loc3_.velocityX = _loc3_.velocityX + param2 * (mGravityX + _loc10_ + _loc12_);
            _loc3_.velocityY = _loc3_.velocityY + param2 * (mGravityY + _loc11_ + _loc9_);
            _loc3_.x = _loc3_.x + _loc3_.velocityX * param2;
            _loc3_.y = _loc3_.y + _loc3_.velocityY * param2;
         }
         _loc3_.scale = _loc3_.scale + _loc3_.scaleDelta * param2;
         _loc3_.rotation = _loc3_.rotation + _loc3_.rotationDelta * param2;
         _loc3_.colorArgb.red = _loc3_.colorArgb.red + _loc3_.colorArgbDelta.red * param2;
         _loc3_.colorArgb.green = _loc3_.colorArgb.green + _loc3_.colorArgbDelta.green * param2;
         _loc3_.colorArgb.blue = _loc3_.colorArgb.blue + _loc3_.colorArgbDelta.blue * param2;
         _loc3_.colorArgb.alpha = _loc3_.colorArgb.alpha + _loc3_.colorArgbDelta.alpha * param2;
         _loc3_.color = _loc3_.colorArgb.toRgb();
         _loc3_.alpha = _loc3_.colorArgb.alpha;
      }
      
      private function updateEmissionRate() : void
      {
         emissionRate = mMaxNumParticles / mLifespan;
      }
      
      public function parseConfig(param1:XML) : void
      {
         config = param1;
         getIntValue = function(param1:XMLList):int
         {
            return parseInt(param1.attribute("value"));
         };
         getFloatValue = function(param1:XMLList):Number
         {
            return parseFloat(param1.attribute("value"));
         };
         getColor = function(param1:XMLList):ColorArgb
         {
            var _loc2_:ColorArgb = new ColorArgb();
            _loc2_.red = parseFloat(param1.attribute("red"));
            _loc2_.green = parseFloat(param1.attribute("green"));
            _loc2_.blue = parseFloat(param1.attribute("blue"));
            _loc2_.alpha = parseFloat(param1.attribute("alpha"));
            return _loc2_;
         };
         getBlendFunc = function(param1:XMLList):String
         {
            var _loc2_:int = getIntValue(param1);
            var _loc3_:* = _loc2_;
            if(0 !== _loc3_)
            {
               if(1 !== _loc3_)
               {
                  if(768 !== _loc3_)
                  {
                     if(769 !== _loc3_)
                     {
                        if(770 !== _loc3_)
                        {
                           if(771 !== _loc3_)
                           {
                              if(772 !== _loc3_)
                              {
                                 if(773 !== _loc3_)
                                 {
                                    if(774 !== _loc3_)
                                    {
                                       if(775 !== _loc3_)
                                       {
                                          throw new ArgumentError("unsupported blending function: " + _loc2_);
                                       }
                                       return "oneMinusDestinationColor";
                                    }
                                    return "destinationColor";
                                 }
                                 return "oneMinusDestinationAlpha";
                              }
                              return "destinationAlpha";
                           }
                           return "oneMinusSourceAlpha";
                        }
                        return "sourceAlpha";
                     }
                     return "oneMinusSourceColor";
                  }
                  return "sourceColor";
               }
               return "one";
            }
            return "zero";
         };
         mEmitterXVariance = parseFloat(config.sourcePositionVariance.attribute("x"));
         mEmitterYVariance = parseFloat(config.sourcePositionVariance.attribute("y"));
         mGravityX = parseFloat(config.gravity.attribute("x"));
         mGravityY = parseFloat(config.gravity.attribute("y"));
         mEmitterType = getIntValue(config.emitterType);
         mMaxNumParticles = getIntValue(config.maxParticles);
         mLifespan = Math.max(0.01,getFloatValue(config.particleLifeSpan));
         mLifespanVariance = getFloatValue(config.particleLifespanVariance);
         mStartSize = getFloatValue(config.startParticleSize);
         mStartSizeVariance = getFloatValue(config.startParticleSizeVariance);
         mEndSize = getFloatValue(config.finishParticleSize);
         mEndSizeVariance = getFloatValue(config.FinishParticleSizeVariance);
         mEmitAngle = deg2rad(getFloatValue(config.angle));
         mEmitAngleVariance = deg2rad(getFloatValue(config.angleVariance));
         mStartRotation = deg2rad(getFloatValue(config.rotationStart));
         mStartRotationVariance = deg2rad(getFloatValue(config.rotationStartVariance));
         mEndRotation = deg2rad(getFloatValue(config.rotationEnd));
         mEndRotationVariance = deg2rad(getFloatValue(config.rotationEndVariance));
         mSpeed = getFloatValue(config.speed);
         mSpeedVariance = getFloatValue(config.speedVariance);
         mRadialAcceleration = getFloatValue(config.radialAcceleration);
         mRadialAccelerationVariance = getFloatValue(config.radialAccelVariance);
         mTangentialAcceleration = getFloatValue(config.tangentialAcceleration);
         mTangentialAccelerationVariance = getFloatValue(config.tangentialAccelVariance);
         mMaxRadius = getFloatValue(config.maxRadius);
         mMaxRadiusVariance = getFloatValue(config.maxRadiusVariance);
         mMinRadius = getFloatValue(config.minRadius);
         mRotatePerSecond = deg2rad(getFloatValue(config.rotatePerSecond));
         mRotatePerSecondVariance = deg2rad(getFloatValue(config.rotatePerSecondVariance));
         mStartColor = getColor(config.startColor);
         mStartColorVariance = getColor(config.startColorVariance);
         mEndColor = getColor(config.finishColor);
         mEndColorVariance = getColor(config.finishColorVariance);
         mBlendFactorSource = getBlendFunc(config.blendFuncSource);
         mBlendFactorDestination = getBlendFunc(config.blendFuncDestination);
         mCenterOffset = new Point(0,0);
         mCenterOffset.x = Number(config.centerOffsetX.@value);
         mCenterOffset.y = Number(config.centerOffsetY.@value);
      }
      
      public function get emitterType() : int
      {
         return mEmitterType;
      }
      
      public function set emitterType(param1:int) : void
      {
         mEmitterType = param1;
      }
      
      public function get emitterXVariance() : Number
      {
         return mEmitterXVariance;
      }
      
      public function set emitterXVariance(param1:Number) : void
      {
         mEmitterXVariance = param1;
      }
      
      public function get emitterYVariance() : Number
      {
         return mEmitterYVariance;
      }
      
      public function set emitterYVariance(param1:Number) : void
      {
         mEmitterYVariance = param1;
      }
      
      public function get maxNumParticles() : int
      {
         return mMaxNumParticles;
      }
      
      public function set maxNumParticles(param1:int) : void
      {
         maxCapacity = param1;
         mMaxNumParticles = maxCapacity;
         updateEmissionRate();
      }
      
      public function get lifespan() : Number
      {
         return mLifespan;
      }
      
      public function set lifespan(param1:Number) : void
      {
         mLifespan = Math.max(0.01,param1);
         updateEmissionRate();
      }
      
      public function get lifespanVariance() : Number
      {
         return mLifespanVariance;
      }
      
      public function set lifespanVariance(param1:Number) : void
      {
         mLifespanVariance = param1;
      }
      
      public function get startSize() : Number
      {
         return mStartSize;
      }
      
      public function set startSize(param1:Number) : void
      {
         mStartSize = param1;
      }
      
      public function get startSizeVariance() : Number
      {
         return mStartSizeVariance;
      }
      
      public function set startSizeVariance(param1:Number) : void
      {
         mStartSizeVariance = param1;
      }
      
      public function get endSize() : Number
      {
         return mEndSize;
      }
      
      public function set endSize(param1:Number) : void
      {
         mEndSize = param1;
      }
      
      public function get endSizeVariance() : Number
      {
         return mEndSizeVariance;
      }
      
      public function set endSizeVariance(param1:Number) : void
      {
         mEndSizeVariance = param1;
      }
      
      public function get emitAngle() : Number
      {
         return mEmitAngle;
      }
      
      public function set emitAngle(param1:Number) : void
      {
         mEmitAngle = param1;
      }
      
      public function get emitAngleVariance() : Number
      {
         return mEmitAngleVariance;
      }
      
      public function set emitAngleVariance(param1:Number) : void
      {
         mEmitAngleVariance = param1;
      }
      
      public function get startRotation() : Number
      {
         return mStartRotation;
      }
      
      public function set startRotation(param1:Number) : void
      {
         mStartRotation = param1;
      }
      
      public function get startRotationVariance() : Number
      {
         return mStartRotationVariance;
      }
      
      public function set startRotationVariance(param1:Number) : void
      {
         mStartRotationVariance = param1;
      }
      
      public function get endRotation() : Number
      {
         return mEndRotation;
      }
      
      public function set endRotation(param1:Number) : void
      {
         mEndRotation = param1;
      }
      
      public function get endRotationVariance() : Number
      {
         return mEndRotationVariance;
      }
      
      public function set endRotationVariance(param1:Number) : void
      {
         mEndRotationVariance = param1;
      }
      
      public function get speed() : Number
      {
         return mSpeed;
      }
      
      public function set speed(param1:Number) : void
      {
         mSpeed = param1;
      }
      
      public function get speedVariance() : Number
      {
         return mSpeedVariance;
      }
      
      public function set speedVariance(param1:Number) : void
      {
         mSpeedVariance = param1;
      }
      
      public function get gravityX() : Number
      {
         return mGravityX;
      }
      
      public function set gravityX(param1:Number) : void
      {
         mGravityX = param1;
      }
      
      public function get gravityY() : Number
      {
         return mGravityY;
      }
      
      public function set gravityY(param1:Number) : void
      {
         mGravityY = param1;
      }
      
      public function get radialAcceleration() : Number
      {
         return mRadialAcceleration;
      }
      
      public function set radialAcceleration(param1:Number) : void
      {
         mRadialAcceleration = param1;
      }
      
      public function get radialAccelerationVariance() : Number
      {
         return mRadialAccelerationVariance;
      }
      
      public function set radialAccelerationVariance(param1:Number) : void
      {
         mRadialAccelerationVariance = param1;
      }
      
      public function get tangentialAcceleration() : Number
      {
         return mTangentialAcceleration;
      }
      
      public function set tangentialAcceleration(param1:Number) : void
      {
         mTangentialAcceleration = param1;
      }
      
      public function get tangentialAccelerationVariance() : Number
      {
         return mTangentialAccelerationVariance;
      }
      
      public function set tangentialAccelerationVariance(param1:Number) : void
      {
         mTangentialAccelerationVariance = param1;
      }
      
      public function get maxRadius() : Number
      {
         return mMaxRadius;
      }
      
      public function set maxRadius(param1:Number) : void
      {
         mMaxRadius = param1;
      }
      
      public function get maxRadiusVariance() : Number
      {
         return mMaxRadiusVariance;
      }
      
      public function set maxRadiusVariance(param1:Number) : void
      {
         mMaxRadiusVariance = param1;
      }
      
      public function get minRadius() : Number
      {
         return mMinRadius;
      }
      
      public function set minRadius(param1:Number) : void
      {
         mMinRadius = param1;
      }
      
      public function get rotatePerSecond() : Number
      {
         return mRotatePerSecond;
      }
      
      public function set rotatePerSecond(param1:Number) : void
      {
         mRotatePerSecond = param1;
      }
      
      public function get rotatePerSecondVariance() : Number
      {
         return mRotatePerSecondVariance;
      }
      
      public function set rotatePerSecondVariance(param1:Number) : void
      {
         mRotatePerSecondVariance = param1;
      }
      
      public function get startColor() : ColorArgb
      {
         return mStartColor;
      }
      
      public function set startColor(param1:ColorArgb) : void
      {
         mStartColor = param1;
      }
      
      public function get startColorVariance() : ColorArgb
      {
         return mStartColorVariance;
      }
      
      public function set startColorVariance(param1:ColorArgb) : void
      {
         mStartColorVariance = param1;
      }
      
      public function get endColor() : ColorArgb
      {
         return mEndColor;
      }
      
      public function set endColor(param1:ColorArgb) : void
      {
         mEndColor = param1;
      }
      
      public function get endColorVariance() : ColorArgb
      {
         return mEndColorVariance;
      }
      
      public function set endColorVariance(param1:ColorArgb) : void
      {
         mEndColorVariance = param1;
      }
   }
}
