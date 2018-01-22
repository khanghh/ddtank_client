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
      
      public function AbstractLifeEasing()
      {
         vLine = new XLine();
         rvLine = new XLine();
         spLine = new XLine();
         sizeLine = new XLine();
         weightLine = new XLine();
         alphaLine = new XLine();
         super();
      }
      
      public function easingVelocity(param1:Number, param2:Number) : Number
      {
         return param1 * vLine.interpolate(param2);
      }
      
      public function easingRandomVelocity(param1:Number, param2:Number) : Number
      {
         return param1 * rvLine.interpolate(param2);
      }
      
      public function easingSize(param1:Number, param2:Number) : Number
      {
         return param1 * sizeLine.interpolate(param2);
      }
      
      public function easingSpinVelocity(param1:Number, param2:Number) : Number
      {
         return param1 * spLine.interpolate(param2);
      }
      
      public function easingWeight(param1:Number, param2:Number) : Number
      {
         return param1 * weightLine.interpolate(param2);
      }
      
      public function easingColor(param1:uint, param2:Number) : uint
      {
         if(colorLine)
         {
            return colorLine.interpolate(param2);
         }
         return param1;
      }
      
      public function easingApha(param1:Number, param2:Number) : Number
      {
         return param1 * alphaLine.interpolate(param2);
      }
   }
}
