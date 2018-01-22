package ddt.manager
{
   import flash.utils.Dictionary;
   
   public class PVEMapPermissionManager
   {
      
      private static var _instance:PVEMapPermissionManager;
       
      
      private var allPermission:Dictionary;
      
      public function PVEMapPermissionManager()
      {
         allPermission = new Dictionary();
         super();
      }
      
      public static function get Instance() : PVEMapPermissionManager
      {
         if(_instance == null)
         {
            _instance = new PVEMapPermissionManager();
         }
         return _instance;
      }
      
      public function getPermisitonKey(param1:int, param2:int) : int
      {
         var _loc4_:Array = [String(param1),String(param2)];
         var _loc3_:String = _loc4_.join("|");
         return allPermission[_loc3_];
      }
      
      public function getPermission(param1:int, param2:int, param3:String) : Boolean
      {
         var _loc4_:String = param3.substr(param1 - 1,1).toUpperCase();
         if(_loc4_ == "")
         {
            return false;
         }
         if(param2 == 0)
         {
            return true;
         }
         if(param2 == 1)
         {
            return _loc4_ != "1"?true:false;
         }
         if(param2 == 2)
         {
            if(_loc4_ == "F" || _loc4_ == "7")
            {
               return true;
            }
            return false;
         }
         if(param2 == 3)
         {
            return _loc4_ == "F"?true:false;
         }
         if(param2 == 4)
         {
            return _loc4_ == "F"?true:false;
         }
         return false;
      }
      
      public function getPveMapEpicPermission(param1:int, param2:String) : Boolean
      {
         var _loc4_:* = null;
         var _loc5_:Boolean = false;
         if(param2)
         {
            _loc4_ = param2.split("-");
            var _loc7_:int = 0;
            var _loc6_:* = _loc4_;
            for each(var _loc3_ in _loc4_)
            {
               if(_loc3_ == String(param1))
               {
                  _loc5_ = true;
                  break;
               }
            }
         }
         return _loc5_;
      }
   }
}
