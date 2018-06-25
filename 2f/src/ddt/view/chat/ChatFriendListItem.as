package ddt.view.chat{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.cell.IListCell;   import com.pickgliss.ui.controls.list.List;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.player.BasePlayer;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.text.TextField;      public class ChatFriendListItem extends Sprite implements IListCell, Disposeable   {            public static const SELECT:String = "select";                   private var _bg:Bitmap;            private var _contentTxt:TextField;            private var _fun:Function;            private var _info:BasePlayer;            private var _spaceLine:Bitmap;            public function ChatFriendListItem() { super(); }
            public function dispose() : void { }
            public function get info() : BasePlayer { return null; }
            private function __mouseClick(evt:MouseEvent) : void { }
            private function __mouseOut(evt:MouseEvent) : void { }
            private function __mouseOver(evt:MouseEvent) : void { }
            private function init() : void { }
            private function initEvent() : void { }
            private function updateItem() : void { }
            public function setListCellStatus(list:List, isSelected:Boolean, index:int) : void { }
            public function getCellValue() : * { return null; }
            public function setCellValue(value:*) : void { }
            public function asDisplayObject() : DisplayObject { return null; }
   }}