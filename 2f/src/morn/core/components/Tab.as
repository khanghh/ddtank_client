package morn.core.components
{
   import flash.display.DisplayObject;
   
   public class Tab extends Group
   {
      
      public static const HORIZENTAL:String = "horizontal";
      
      public static const VERTICAL:String = "vertical";
       
      
      public function Tab(param1:String = null, param2:String = null){super(null,null);}
      
      override protected function createItem(param1:String, param2:String) : DisplayObject{return null;}
      
      override protected function changeLabels() : void{}
   }
}
