package wantstrong.view{   import com.pickgliss.ui.core.Disposeable;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import wantstrong.WantStrongControl;   import wantstrong.WantStrongManager;   import wantstrong.model.WantStrongModel;      public class WantStrongMenu extends Sprite implements Disposeable   {                   private var _menuArr:Array;            private var _titleArr:Array;            private var _selectItem:WantStrongCell;            private var _cellArr:Array;            private var _model:WantStrongModel;            public function WantStrongMenu(model:WantStrongModel) { super(); }
            private function cellChangeHandler(event:Event) : void { }
            private function createUI() : void { }
            protected function _cellClickedHandle(event:MouseEvent) : void { }
            private function setSelectItem(item:WantStrongCell) : void { }
            public function dispose() : void { }
   }}