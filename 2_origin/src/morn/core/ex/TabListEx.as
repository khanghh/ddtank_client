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
         var i:int = 0;
         var n:int = 0;
         for(i = 0,n = _cells.length; i < n; )
         {
            changeSelectItemState(_cells[i] as ISelect,_selectedIndex == _startIndex + i);
            i++;
         }
      }
      
      protected function changeSelectItemState(item:ISelect, value:Boolean) : void
      {
         item.selected = value;
      }
      
      public function disabledOf($disabled:Boolean, head:int, last:* = 0) : void
      {
         var i:* = 0;
         if(last < 0 || last > 0 && last < head)
         {
            return;
         }
         if(last == 0 || last == head)
         {
            (getChildByName("item" + head) as TabButtonEx).disabled = $disabled;
         }
         else
         {
            for(i = head; i <= last; )
            {
               (getChildByName("item" + i) as TabButtonEx).disabled = $disabled;
               i++;
            }
         }
      }
   }
}
