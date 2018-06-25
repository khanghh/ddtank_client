package ddt.command{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SoundManager;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.KeyboardEvent;   import flash.events.MouseEvent;      public class NumberSelecter extends Sprite implements Disposeable   {            public static const NUMBER_CLOSE:String = "number_close";            public static const NUMBER_ENTER:String = "number_enter";                   private var _minNum:int;            private var _maxNum:int;            private var _num:int;            private var _reduceBtn:BaseButton;            private var _addBtn:BaseButton;            private var numText:FilterFrameText;            private var _ennable:Boolean = true;            private var _times:int = 1;            public var bg:Image;            public var needFocus:Boolean = true;            public function NumberSelecter(min:int = 1, max:int = 99) { super(); }
            public function get times() : int { return 0; }
            public function set times(value:int) : void { }
            public function setNumberTxt(value:Boolean) : void { }
            public function get ennable() : Boolean { return false; }
            public function set ennable(value:Boolean) : void { }
            private function init() : void { }
            private function initEvents() : void { }
            private function removeEvents() : void { }
            private function addtoStageHandler(e:Event) : void { }
            private function clickHandler(evt:MouseEvent) : void { }
            private function changeHandler(evt:Event) : void { }
            private function onKeyDown(evt:KeyboardEvent) : void { }
            private function reduceBtnClickHandler(evt:MouseEvent) : void { }
            private function addBtnClickHandler(evt:MouseEvent) : void { }
            public function setFocus() : void { }
            public function set maximum(value:int) : void { }
            public function set minimum(value:int) : void { }
            public function set number(value:int) : void { }
            public function get number() : int { return 0; }
            private function updateView() : void { }
            public function dispose() : void { }
   }}