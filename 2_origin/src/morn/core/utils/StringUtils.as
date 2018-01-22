package morn.core.utils
{
   import flash.geom.Rectangle;
   
   public class StringUtils
   {
       
      
      public function StringUtils()
      {
         super();
      }
      
      public static function fillArray(param1:Array, param2:String, param3:Class = null) : Array
      {
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc4_:Array = ObjectUtils.clone(param1);
         if(Boolean(param2))
         {
            _loc5_ = param2.split(",");
            _loc6_ = 0;
            _loc7_ = Math.min(_loc4_.length,_loc5_.length);
            while(_loc6_ < _loc7_)
            {
               _loc8_ = _loc5_[_loc6_];
               _loc4_[_loc6_] = _loc8_ == "true"?true:_loc8_ == "false"?false:_loc8_;
               if(param3 != null)
               {
                  _loc4_[_loc6_] = param3(_loc8_);
               }
               _loc6_++;
            }
         }
         return _loc4_;
      }
      
      public static function rectToString(param1:Rectangle) : String
      {
         if(param1)
         {
            return param1.x + "," + param1.y + "," + param1.width + "," + param1.height;
         }
         return null;
      }
   }
}
