package morn.core.ex
{
   import morn.core.components.ISelect;
   import morn.core.components.List;
   
   public class TabListEx extends List
   {
       
      
      public function TabListEx(){super();}
      
      override protected function changeSelectStatus() : void{}
      
      protected function changeSelectItemState(param1:ISelect, param2:Boolean) : void{}
      
      public function disabledOf(param1:Boolean, param2:int, param3:* = 0) : void{}
   }
}
