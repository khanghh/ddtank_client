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
      
      public function getPermisitonKey(mapid:int, level:int) : int
      {
         var key:Array = [String(mapid),String(level)];
         var keyString:String = key.join("|");
         return allPermission[keyString];
      }
      
      public function getPermission(mapid:int, level:int, mapPermission:String) : Boolean
      {
         var right:String = mapPermission.substr(mapid - 1,1).toUpperCase();
         if(right == "")
         {
            return false;
         }
         if(level == 0)
         {
            return true;
         }
         if(level == 1)
         {
            return right != "1"?true:false;
         }
         if(level == 2)
         {
            if(right == "F" || right == "7")
            {
               return true;
            }
            return false;
         }
         if(level == 3)
         {
            return right == "F"?true:false;
         }
         if(level == 4)
         {
            return right == "F"?true:false;
         }
         return false;
      }
      
      public function getPveMapEpicPermission(mapId:int, pveEpicPermission:String) : Boolean
      {
         var arr:* = null;
         var bool:Boolean = false;
         if(pveEpicPermission)
         {
            arr = pveEpicPermission.split("-");
            var _loc7_:int = 0;
            var _loc6_:* = arr;
            for each(var str in arr)
            {
               if(str == String(mapId))
               {
                  bool = true;
                  break;
               }
            }
         }
         return bool;
      }
   }
}
