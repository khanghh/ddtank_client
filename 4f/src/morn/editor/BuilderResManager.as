package morn.editor
{
   import flash.display.BitmapData;
   import morn.core.managers.AssetManager;
   import morn.core.utils.BitmapUtils;
   
   public class BuilderResManager extends AssetManager
   {
       
      
      public function BuilderResManager(){super();}
      
      override public function hasClass(param1:String) : Boolean{return false;}
      
      override public function getClass(param1:String) : Class{return null;}
      
      override public function getAsset(param1:String) : *{return null;}
      
      override public function getBitmapData(param1:String, param2:Boolean = true) : BitmapData{return null;}
      
      override public function getClips(param1:String, param2:int, param3:int, param4:Boolean = true, param5:BitmapData = null) : Vector.<BitmapData>{return null;}
   }
}
