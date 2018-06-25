package ddt.manager{   import flash.utils.Dictionary;      public class PVEMapPermissionManager   {            private static var _instance:PVEMapPermissionManager;                   private var allPermission:Dictionary;            public function PVEMapPermissionManager() { super(); }
            public static function get Instance() : PVEMapPermissionManager { return null; }
            public function getPermisitonKey(mapid:int, level:int) : int { return 0; }
            public function getPermission(mapid:int, level:int, mapPermission:String) : Boolean { return false; }
            public function getPveMapEpicPermission(mapId:int, pveEpicPermission:String) : Boolean { return false; }
   }}