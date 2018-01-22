package morn.core.ex
{
   import morn.core.components.ISelect;
   import morn.core.components.List;
   
   public class TabListEx extends List
   {
       
      
      public function TabListEx()
      {
         super();
      }
      
      override protected function changeSelectStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = _cells.length;
         while(_loc1_ < _loc2_)
         {
            this.changeSelectItemState(_cells[_loc1_] as ISelect,Boolean(_selectedIndex == _startIndex + _loc1_));
            _loc1_++;
         }
      }
      
      protected function changeSelectItemState(param1:ISelect, param2:Boolean) : void
      {
         param1.selected = param2;
      }
      
      public function disabledOf(param1:Boolean, param2:int, param3:* = 0) : void
      {
         var _loc4_:int = 0;
         if(param3 < 0 || param3 > 0 && param3 < param2)
         {
            return;
         }
         if(param3 == 0 || param3 == param2)
         {
            (getChildByName("item" + param2) as TabButtonEx).disabled = param1;
         }
         else
         {
            _loc4_ = param2;
            while(_loc4_ <= param3)
            {
               (getChildByName("item" + _loc4_) as TabButtonEx).disabled = param1;
               _loc4_++;
            }
         }
      }
   }
}
