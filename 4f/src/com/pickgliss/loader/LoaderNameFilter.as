package com.pickgliss.loader
{
   import flash.utils.Dictionary;
   
   public class LoaderNameFilter
   {
      
      private static var _loadNameList:Dictionary = null;
      
      private static var _pathList:Dictionary;
       
      
      public function LoaderNameFilter(){super();}
      
      public static function setLoadNameContent(param1:XML) : void{}
      
      private static function isFilter(param1:String) : Boolean{return false;}
      
      public static function getLoadFilePath(param1:String) : String{return null;}
      
      public static function getRealFilePath(param1:String) : String{return null;}
   }
}
