package morn.core.ex
{
   import flash.display.DisplayObject;
   
   public class TabEx extends GroupEx
   {
      
      public static const HORIZENTAL:String = "horizontal";
      
      public static const VERTICAL:String = "vertical";
       
      
      protected var _offset:String;
      
      public function TabEx(param1:String = null, param2:String = null){super(null,null);}
      
      override protected function createItem(param1:String, param2:String) : DisplayObject{return null;}
      
      public function set offset(param1:String) : void{}
      
      public function get offset() : String{return null;}
      
      override protected function changeImageLabels() : void{}
   }
}
