package ddt.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.SelectedButton;   import com.pickgliss.ui.controls.SelectedButtonGroup;   import com.pickgliss.ui.controls.container.SimpleTileList;   import com.pickgliss.ui.core.Disposeable;   import ddt.data.ColorEnum;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;      [Event(name="change",type="flash.events.Event")]   public class ColorEditor extends Sprite implements Disposeable   {            public static const REDUCTIVE_COLOR:String = "reductiveColor";            public static const CHANGE_COLOR:String = "change_color";                   private var _colors:Array;            private var _skins:Array;            private var _colorsArr:Array;            private var _skinsArr:Array;            private var _colorlist:SimpleTileList;            private var _skincolorlist:SimpleTileList;            private var _colorBtn:SelectedButton;            private var _textureBtn:SelectedButton;            private var _restoreColorBtn:BaseButton;            private var _colorPanelMask:Bitmap;            private var _colorPanelBg:Bitmap;            private var _btnGroup:SelectedButtonGroup;            private var _ciGroup:SelectedButtonGroup;            private var _siGroup:SelectedButtonGroup;            private var _colorRestorable:Boolean;            private var _skinRestorable:Boolean;            private var _selectedColor:int;            private var _selectedSkin:int;            public function ColorEditor() { super(); }
            private function initColors() : void { }
            public function reset() : void { }
            public function get colorRestorable() : Boolean { return false; }
            public function set colorRestorable(value:Boolean) : void { }
            public function get skinRestorable() : Boolean { return false; }
            public function set skinRestorable(value:Boolean) : void { }
            public function set restorable(value:Boolean) : void { }
            public function get colorEditable() : Boolean { return false; }
            public function set colorEditable(value:Boolean) : void { }
            public function get skinEditable() : Boolean { return false; }
            public function set skinEditable(value:Boolean) : void { }
            private function updateReductiveColorBtn() : void { }
            public function editColor(color:int = -1) : void { }
            public function editSkin(skin:int = -1) : void { }
            public function get selectedType() : int { return 0; }
            public function set selectedType(value:int) : void { }
            public function get selectedColor() : int { return 0; }
            public function set selectedColor(value:int) : void { }
            public function get selectedSkin() : int { return 0; }
            public function set selectedSkin(value:int) : void { }
            public function resetColor() : void { }
            public function resetSkin() : void { }
            private function __colorItemClick(event:Event) : void { }
            private function __skinItemClick(event:Event) : void { }
            private function __colorEditClick(event:Event) : void { }
            private function __skinEditClick(event:Event) : void { }
            protected function __restoreColorBtnClick(event:MouseEvent) : void { }
            public function dispose() : void { }
   }}