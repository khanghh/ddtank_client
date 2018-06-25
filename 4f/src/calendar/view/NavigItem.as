package calendar.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.DisplayUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import flash.display.DisplayObject;   import flash.display.Sprite;      public class NavigItem extends Sprite implements Disposeable   {                   private var _back:DisplayObject;            private var _textField:FilterFrameText;            private var _count:int;            private var _selected:Boolean = false;            private var _received:Boolean = false;            public function NavigItem(count:int) { super(); }
            private function configUI() : void { }
            public function get selected() : Boolean { return false; }
            public function set selected(value:Boolean) : void { }
            public function get received() : Boolean { return false; }
            public function set received(value:Boolean) : void { }
            public function get count() : int { return 0; }
            public function dispose() : void { }
   }}