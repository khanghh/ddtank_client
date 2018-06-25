package morn.editor
{
   import flash.display.BitmapData;
   import morn.core.managers.AssetManager;
   import morn.core.utils.BitmapUtils;
   
   public class BuilderResManager extends AssetManager
   {
       
      
      public function BuilderResManager()
      {
         super();
      }
      
      override public function hasClass(name:String) : Boolean
      {
         return Sys.hasRes(name);
      }
      
      override public function getClass(name:String) : Class
      {
         return Sys.getResClass(name);
      }
      
      override public function getAsset(name:String) : *
      {
         return Sys.getRes(name);
      }
      
      override public function getBitmapData(name:String, cache:Boolean = true) : BitmapData
      {
         return Sys.getResBitmapData(name);
      }
      
      override public function getClips(name:String, xNum:int, yNum:int, cache:Boolean = true, source:BitmapData = null) : Vector.<BitmapData>
      {
         var bmd:BitmapData = getBitmapData(name,false);
         var clips:Vector.<BitmapData> = BitmapUtils.createClips(bmd,xNum,yNum);
         return clips;
      }
   }
}
