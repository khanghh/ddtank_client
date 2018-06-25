package baglocked{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class BagLockPSWNeededSelecterListCell extends Sprite implements Disposeable   {                   private var _checkBox:SelectedCheckButton;            private var _titleText:FilterFrameText;            private var _index:int;            public function BagLockPSWNeededSelecterListCell($index:int, $selected:int, $text:String, textIsID:Boolean = false) { super(); }
            private function init() : void { }
            protected function onCheckClick(me:MouseEvent) : void { }
            public function dispose() : void { }
            public function setText(value:String) : void { }
            public function get index() : int { return 0; }
            public function set index(value:int) : void { }
            public function set selected(value:int) : void { }
            public function get selected() : int { return 0; }
   }}