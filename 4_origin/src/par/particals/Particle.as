package par.particals
{
   import flash.display.DisplayObject;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import par.ShapeManager;
   import par.lifeeasing.AbstractLifeEasing;
   import road7th.math.randRange;
   
   public class Particle
   {
       
      
      public var x:Number;
      
      public var y:Number;
      
      public var alpha:Number;
      
      public var color:Number;
      
      public var scale:Number;
      
      public var rotation:Number;
      
      public var life:Number;
      
      public var age:Number;
      
      public var size:Number;
      
      public var v:Number;
      
      public var angle:Number;
      
      public var gv:Number;
      
      public var motionV:Number;
      
      public var weight:Number;
      
      public var spin:Number;
      
      public var image:DisplayObject;
      
      public var info:ParticleInfo;
      
      public function Particle(param1:ParticleInfo)
      {
         super();
         image = ShapeManager.create(param1.displayCreator);
         this.info = param1;
         initialize();
      }
      
      public function initialize() : void
      {
         x = 0;
         y = 0;
         color = 0;
         scale = 1;
         rotation = 0;
         age = 0;
         life = 1;
         alpha = 1;
         v = 0;
         angle = 0;
         gv = 0;
         if(image)
         {
            image.blendMode = info.blendMode;
         }
      }
      
      public function update(param1:Number) : void
      {
         var _loc4_:Number = age / life;
         var _loc2_:AbstractLifeEasing = info.lifeEasing;
         v = _loc2_.easingVelocity(v,_loc4_);
         motionV = _loc2_.easingRandomVelocity(motionV,_loc4_);
         weight = _loc2_.easingWeight(weight,_loc4_);
         gv = gv + weight;
         var _loc3_:Point = Point.polar(v,angle);
         var _loc5_:Point = Point.polar(motionV,randRange(0,2 * 3.14159265358979));
         x = x + (_loc3_.x + _loc5_.x) * param1;
         y = y + (_loc3_.y + _loc5_.y + gv) * param1;
         scale = _loc2_.easingSize(size,_loc4_);
         rotation = rotation + _loc2_.easingSpinVelocity(spin,_loc4_) * param1;
         color = _loc2_.easingColor(color,_loc4_);
         alpha = _loc2_.easingApha(1,_loc4_);
      }
      
      public function get matrixTransform() : Matrix
      {
         var _loc1_:Number = scale * Math.cos(rotation);
         var _loc2_:Number = scale * Math.sin(rotation);
         return new Matrix(_loc1_,_loc2_,-_loc2_,_loc1_,x,y);
      }
      
      public function get colorTransform() : ColorTransform
      {
         if(info.keepColor)
         {
            return new ColorTransform(1,1,1,alpha,color >> 16 & 255,color >> 8 & 255,color & 255,0);
         }
         return new ColorTransform(0,0,0,alpha,color >> 16 & 255,color >> 8 & 255,color & 255,0);
      }
   }
}
