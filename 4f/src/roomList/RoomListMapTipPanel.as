package roomList{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.UICreatShortcut;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;      public class RoomListMapTipPanel extends Sprite implements Disposeable   {            public static const FB_CHANGE:String = "fbChange";                   private var _bg:ScaleBitmapImage;            private var _listContent:VBox;            private var _itemArray:Array;            private var _cellWidth:int;            private var _cellheight:int;            private var _list:ScrollPanel;            private var _value:int;            public function RoomListMapTipPanel(cellWidth:int, cellheight:int) { super(); }
            public function get value() : int { return 0; }
            public function resetValue() : void { }
            private function init() : void { }
            public function addItem(id:int) : void { }
            private function __itemClick(event:MouseEvent) : void { }
            private function cleanItem() : void { }
            public function dispose() : void { }
   }}