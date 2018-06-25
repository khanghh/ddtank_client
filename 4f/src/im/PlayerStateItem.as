package im{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.cell.IDropListCell;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.player.PlayerState;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class PlayerStateItem extends Sprite implements IDropListCell, Disposeable   {                   private var _date:PlayerState;            private var _stateID:int;            private var _icon:Bitmap;            private var _overBg:Bitmap;            private var _stateName:FilterFrameText;            private var _selected:Boolean;            public function PlayerStateItem() { super(); }
            private function initView() : void { }
            public function getCellValue() : * { return null; }
            public function setCellValue(value:*) : void { }
            private function update() : void { }
            private function __out(event:MouseEvent) : void { }
            private function __over(event:MouseEvent) : void { }
            public function get selected() : Boolean { return false; }
            public function set selected(value:Boolean) : void { }
            private function creatIcon() : Bitmap { return null; }
            override public function get height() : Number { return 0; }
            override public function get width() : Number { return 0; }
            public function asDisplayObject() : DisplayObject { return null; }
            public function dispose() : void { }
   }}