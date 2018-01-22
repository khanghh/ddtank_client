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
      
      override public function hasClass(param1:String) : Boolean
      {
         return Sys.hasRes(param1);
      }
      
      override public function getClass(param1:String) : Class
      {
         return Sys.getResClass(param1);
      }
      
      override public function getAsset(param1:String) : *
      {
         return Sys.getRes(param1);
      }
      
      override public function getBitmapData(param1:String, param2:Boolean = true) : BitmapData
      {
         return Sys.getResBitmapData(param1);
      }
      
      override public function getClips(param1:String, param2:int, param3:int, param4:Boolean = true, param5:BitmapData = null) : Vector.<BitmapData>
      {
         var _loc6_:BitmapData = this.getBitmapData(param1,false);
         var _loc7_:Vector.<BitmapData> = BitmapUtils.createClips(_loc6_,param2,param3);
         return _loc7_;
      }
   }
}
