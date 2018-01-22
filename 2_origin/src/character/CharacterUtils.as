package character
{
   import flash.geom.Point;
   
   public class CharacterUtils
   {
       
      
      public function CharacterUtils()
      {
         super();
      }
      
      public static function creatFrames(param1:String) : Vector.<int>
      {
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc2_:Vector.<int> = new Vector.<int>();
         var _loc3_:Array = param1.split(",");
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ = _loc3_[_loc4_];
            if(_loc5_.indexOf("-") > -1)
            {
               _loc6_ = _loc5_.split("-")[0];
               _loc7_ = _loc5_.split("-")[1];
               _loc8_ = _loc6_;
               while(_loc8_ <= _loc7_)
               {
                  _loc2_.push(_loc8_);
                  _loc8_++;
               }
            }
            else
            {
               _loc2_.push(int(_loc5_));
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public static function creatPoints(param1:String) : Vector.<Point>
      {
         var _loc5_:String = null;
         var _loc6_:Point = null;
         var _loc2_:Vector.<Point> = new Vector.<Point>();
         var _loc3_:Array = param1.split("|");
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ = _loc3_[_loc4_];
            _loc6_ = new Point(Number(_loc5_.split(",")[0]),Number(_loc5_.split(",")[1]));
            _loc2_.push(_loc6_);
            _loc4_++;
         }
         return _loc2_;
      }
   }
}
