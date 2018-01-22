package hall.player.vo
{
   import flash.utils.Dictionary;
   
   public class PlayerPetsInfo
   {
       
      
      private var _disDic:Dictionary;
      
      public function PlayerPetsInfo()
      {
         super();
         _disDic = new Dictionary();
      }
      
      public function set distanceDic(param1:String) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:Array = param1.split(",");
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc2_ = _loc3_[_loc4_].split(":");
            _disDic[_loc2_[0]] = _loc2_[1];
            _loc4_++;
         }
      }
      
      public function get disDic() : Dictionary
      {
         return _disDic;
      }
   }
}
