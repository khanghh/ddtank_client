package mark.items{   import mark.MarkMgr;   import mark.data.MarkProData;   import mark.mornUI.items.MarkPropItemUI;      public class MarkPropItem extends MarkPropItemUI   {                   public function MarkPropItem() { super(); }
            public function set enable(value:Boolean) : void { }
            public function get enable() : Boolean { return false; }
            public function set label(value:String) : void { }
            public function set markProData(data:MarkProData) : void { }
   }}