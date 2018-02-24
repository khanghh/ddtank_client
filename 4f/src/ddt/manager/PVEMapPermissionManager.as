package ddt.manager
{
   import flash.utils.Dictionary;
   
   public class PVEMapPermissionManager
   {
      
      private static var _instance:PVEMapPermissionManager;
       
      
      private var allPermission:Dictionary;
      
      public function PVEMapPermissionManager(){super();}
      
      public static function get Instance() : PVEMapPermissionManager{return null;}
      
      public function getPermisitonKey(param1:int, param2:int) : int{return 0;}
      
      public function getPermission(param1:int, param2:int, param3:String) : Boolean{return false;}
      
      public function getPveMapEpicPermission(param1:int, param2:String) : Boolean{return false;}
   }
}
