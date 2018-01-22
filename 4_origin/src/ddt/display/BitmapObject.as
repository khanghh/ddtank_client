package ddt.display
{
   import com.pickgliss.ui.core.Disposeable;
   import ddt.manager.BitmapManager;
   import flash.display.BitmapData;
   
   public class BitmapObject extends BitmapData implements Disposeable
   {
       
      
      public var linkName:String = "BitmapObject";
      
      public var linkCount:int = 0;
      
      public var manager:BitmapManager;
      
      public function BitmapObject(param1:int, param2:int, param3:Boolean = true, param4:uint = 4294967295)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function dispose() : void
      {
         linkCount = Number(linkCount) - 1;
      }
      
      public function destory() : void
      {
         manager = null;
         super.dispose();
      }
   }
}
