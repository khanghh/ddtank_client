package par.lifeeasing
{
   import road7th.math.ColorLine;
   import road7th.math.XLine;
   
   public class AbstractLifeEasing
   {
       
      
      public var vLine:XLine;
      
      public var rvLine:XLine;
      
      public var spLine:XLine;
      
      public var sizeLine:XLine;
      
      public var weightLine:XLine;
      
      public var alphaLine:XLine;
      
      public var colorLine:ColorLine;
      
      public function AbstractLifeEasing(){super();}
      
      public function easingVelocity(param1:Number, param2:Number) : Number{return 0;}
      
      public function easingRandomVelocity(param1:Number, param2:Number) : Number{return 0;}
      
      public function easingSize(param1:Number, param2:Number) : Number{return 0;}
      
      public function easingSpinVelocity(param1:Number, param2:Number) : Number{return 0;}
      
      public function easingWeight(param1:Number, param2:Number) : Number{return 0;}
      
      public function easingColor(param1:uint, param2:Number) : uint{return null;}
      
      public function easingApha(param1:Number, param2:Number) : Number{return 0;}
   }
}
