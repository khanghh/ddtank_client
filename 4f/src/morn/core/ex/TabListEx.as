package morn.core.ex{   import morn.core.components.ISelect;   import morn.core.components.List;      public class TabListEx extends List   {                   public function TabListEx() { super(); }
            override protected function changeSelectStatus() : void { }
            protected function changeSelectItemState(item:ISelect, value:Boolean) : void { }
            public function disabledOf($disabled:Boolean, head:int, last:* = 0) : void { }
   }}