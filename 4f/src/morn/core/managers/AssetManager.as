package morn.core.managers
{
   import flash.display.BitmapData;
   import flash.system.ApplicationDomain;
   import morn.core.utils.BitmapUtils;
   
   public class AssetManager
   {
       
      
      private var _bmdMap:Object;
      
      private var _clipsMap:Object;
      
      private var _domain:ApplicationDomain;
      
      public function AssetManager(){super();}
      
      public function setDomain(param1:ApplicationDomain) : void{}
      
      public function hasClass(param1:String) : Boolean{return false;}
      
      public function getClass(param1:String) : Class{return null;}
      
      public function getAsset(param1:String) : *{return null;}
      
      public function getBitmapData(param1:String, param2:Boolean = false) : BitmapData{return null;}
      
      public function getClips(param1:String, param2:int, param3:int, param4:Boolean = false, param5:BitmapData = null) : Vector.<BitmapData>{return null;}
      
      public function cacheBitmapData(param1:String, param2:BitmapData) : void{}
      
      public function disposeBitmapData(param1:String) : void{}
      
      public function cacheClips(param1:String, param2:Vector.<BitmapData>) : void{}
      
      public function destroyClips(param1:String) : void{}
   }
}
