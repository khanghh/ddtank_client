package roomList{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleBitmapImage;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;      public class RoomListTipPanel extends Sprite implements Disposeable   {            public static const HARD_LV_CHANGE:String = "hardLvChange";                   private var _bg:ScaleBitmapImage;            private var _list:VBox;            private var _itemArray:Array;            private var _cellWidth:int;            private var _cellheight:int;            private var _value:int;            public function RoomListTipPanel(cellWidth:int, cellheight:int) { super(); }
            public function get value() : int { return 0; }
            public function resetValue() : void { }
            private function init() : void { }
            public function addItem(itemBg:Bitmap, value:int) : void { }
            private function __itemClick(event:MouseEvent) : void { }
            private function cleanItem() : void { }
            public function dispose() : void { }
   }}