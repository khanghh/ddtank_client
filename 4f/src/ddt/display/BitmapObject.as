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
      
      public function BitmapObject(param1:int, param2:int, param3:Boolean = true, param4:uint = 4294967295){super(null,null,null,null);}
      
      override public function dispose() : void{}
      
      public function destory() : void{}
   }
}
