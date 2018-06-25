package par.lifeeasing{   import road7th.math.ColorLine;   import road7th.math.XLine;      public class AbstractLifeEasing   {                   public var vLine:XLine;            public var rvLine:XLine;            public var spLine:XLine;            public var sizeLine:XLine;            public var weightLine:XLine;            public var alphaLine:XLine;            public var colorLine:ColorLine;            public function AbstractLifeEasing() { super(); }
            public function easingVelocity(orient:Number, energy:Number) : Number { return 0; }
            public function easingRandomVelocity(orient:Number, energy:Number) : Number { return 0; }
            public function easingSize(orient:Number, energy:Number) : Number { return 0; }
            public function easingSpinVelocity(orient:Number, energy:Number) : Number { return 0; }
            public function easingWeight(orient:Number, energy:Number) : Number { return 0; }
            public function easingColor(orient:uint, energy:Number) : uint { return null; }
            public function easingApha(orient:Number, energy:Number) : Number { return 0; }
   }}