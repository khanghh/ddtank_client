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
      
      public function easingVelocity(orient:Number, energy:Number) : Number
      {
         return orient * vLine.interpolate(energy);
      }
      
      public function easingRandomVelocity(orient:Number, energy:Number) : Number
      {
         return orient * rvLine.interpolate(energy);
      }
      
      public function easingSize(orient:Number, energy:Number) : Number
      {
         return orient * sizeLine.interpolate(energy);
      }
      
      public function easingSpinVelocity(orient:Number, energy:Number) : Number
      {
         return orient * spLine.interpolate(energy);
      }
      
      public function easingWeight(orient:Number, energy:Number) : Number
      {
         return orient * weightLine.interpolate(energy);
      }
      
      public function easingColor(orient:uint, energy:Number) : uint
      {
         if(colorLine)
         {
            return colorLine.interpolate(energy);
         }
         return orient;
      }
      
      public function easingApha(orient:Number, energy:Number) : Number
      {
         return orient * alphaLine.interpolate(energy);
      }
   }
}
