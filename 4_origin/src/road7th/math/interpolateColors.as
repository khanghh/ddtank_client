package road7th.math
{
   public function interpolateColors(param1:uint, param2:uint, param3:Number) : uint
   {
      var _loc8_:Number = 1 - param3;
      var _loc4_:uint = Math.round((param1 >>> 16 & 255) * param3 + (param2 >>> 16 & 255) * _loc8_);
      var _loc6_:uint = Math.round((param1 >>> 8 & 255) * param3 + (param2 >>> 8 & 255) * _loc8_);
      var _loc5_:uint = Math.round((param1 & 255) * param3 + (param2 & 255) * _loc8_);
      var _loc7_:uint = Math.round((param1 >>> 24 & 255) * param3 + (param2 >>> 24 & 255) * _loc8_);
      return _loc7_ << 24 | _loc4_ << 16 | _loc6_ << 8 | _loc5_;
   }
}
