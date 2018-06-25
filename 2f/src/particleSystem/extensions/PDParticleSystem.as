package particleSystem.extensions{   import flash.geom.Point;   import starling.textures.Texture;   import starling.utils.deg2rad;      public class PDParticleSystem extends ParticleSystem   {                   private const EMITTER_TYPE_GRAVITY:int = 0;            private const EMITTER_TYPE_RADIAL:int = 1;            private var mEmitterType:int;            private var mEmitterXVariance:Number;            private var mEmitterYVariance:Number;            private var mMaxNumParticles:int;            private var mLifespan:Number;            private var mLifespanVariance:Number;            private var mStartSize:Number;            private var mStartSizeVariance:Number;            private var mEndSize:Number;            private var mEndSizeVariance:Number;            private var mEmitAngle:Number;            private var mEmitAngleVariance:Number;            private var mStartRotation:Number;            private var mStartRotationVariance:Number;            private var mEndRotation:Number;            private var mEndRotationVariance:Number;            private var mSpeed:Number;            private var mSpeedVariance:Number;            private var mGravityX:Number;            private var mGravityY:Number;            private var mRadialAcceleration:Number;            private var mRadialAccelerationVariance:Number;            private var mTangentialAcceleration:Number;            private var mTangentialAccelerationVariance:Number;            private var mMaxRadius:Number;            private var mMaxRadiusVariance:Number;            private var mMinRadius:Number;            private var mRotatePerSecond:Number;            private var mRotatePerSecondVariance:Number;            private var mStartColor:ColorArgb;            private var mStartColorVariance:ColorArgb;            private var mEndColor:ColorArgb;            private var mEndColorVariance:ColorArgb;            public function PDParticleSystem(config:XML, texture:Texture) { super(null,null,null,null,null,null); }
            override protected function createParticle() : Particle { return null; }
            override protected function initParticle(aParticle:Particle) : void { }
            override protected function advanceParticle(aParticle:Particle, passedTime:Number) : void { }
            private function updateEmissionRate() : void { }
            public function parseConfig(config:XML) : void { }
            public function get emitterType() : int { return 0; }
            public function set emitterType(value:int) : void { }
            public function get emitterXVariance() : Number { return 0; }
            public function set emitterXVariance(value:Number) : void { }
            public function get emitterYVariance() : Number { return 0; }
            public function set emitterYVariance(value:Number) : void { }
            public function get maxNumParticles() : int { return 0; }
            public function set maxNumParticles(value:int) : void { }
            public function get lifespan() : Number { return 0; }
            public function set lifespan(value:Number) : void { }
            public function get lifespanVariance() : Number { return 0; }
            public function set lifespanVariance(value:Number) : void { }
            public function get startSize() : Number { return 0; }
            public function set startSize(value:Number) : void { }
            public function get startSizeVariance() : Number { return 0; }
            public function set startSizeVariance(value:Number) : void { }
            public function get endSize() : Number { return 0; }
            public function set endSize(value:Number) : void { }
            public function get endSizeVariance() : Number { return 0; }
            public function set endSizeVariance(value:Number) : void { }
            public function get emitAngle() : Number { return 0; }
            public function set emitAngle(value:Number) : void { }
            public function get emitAngleVariance() : Number { return 0; }
            public function set emitAngleVariance(value:Number) : void { }
            public function get startRotation() : Number { return 0; }
            public function set startRotation(value:Number) : void { }
            public function get startRotationVariance() : Number { return 0; }
            public function set startRotationVariance(value:Number) : void { }
            public function get endRotation() : Number { return 0; }
            public function set endRotation(value:Number) : void { }
            public function get endRotationVariance() : Number { return 0; }
            public function set endRotationVariance(value:Number) : void { }
            public function get speed() : Number { return 0; }
            public function set speed(value:Number) : void { }
            public function get speedVariance() : Number { return 0; }
            public function set speedVariance(value:Number) : void { }
            public function get gravityX() : Number { return 0; }
            public function set gravityX(value:Number) : void { }
            public function get gravityY() : Number { return 0; }
            public function set gravityY(value:Number) : void { }
            public function get radialAcceleration() : Number { return 0; }
            public function set radialAcceleration(value:Number) : void { }
            public function get radialAccelerationVariance() : Number { return 0; }
            public function set radialAccelerationVariance(value:Number) : void { }
            public function get tangentialAcceleration() : Number { return 0; }
            public function set tangentialAcceleration(value:Number) : void { }
            public function get tangentialAccelerationVariance() : Number { return 0; }
            public function set tangentialAccelerationVariance(value:Number) : void { }
            public function get maxRadius() : Number { return 0; }
            public function set maxRadius(value:Number) : void { }
            public function get maxRadiusVariance() : Number { return 0; }
            public function set maxRadiusVariance(value:Number) : void { }
            public function get minRadius() : Number { return 0; }
            public function set minRadius(value:Number) : void { }
            public function get rotatePerSecond() : Number { return 0; }
            public function set rotatePerSecond(value:Number) : void { }
            public function get rotatePerSecondVariance() : Number { return 0; }
            public function set rotatePerSecondVariance(value:Number) : void { }
            public function get startColor() : ColorArgb { return null; }
            public function set startColor(value:ColorArgb) : void { }
            public function get startColorVariance() : ColorArgb { return null; }
            public function set startColorVariance(value:ColorArgb) : void { }
            public function get endColor() : ColorArgb { return null; }
            public function set endColor(value:ColorArgb) : void { }
            public function get endColorVariance() : ColorArgb { return null; }
            public function set endColorVariance(value:ColorArgb) : void { }
   }}