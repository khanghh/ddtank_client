package ddt.view.tips{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Bitmap;   import flash.display.Sprite;      public class WinRate extends Sprite implements Disposeable   {                   private var _win:int;            private var _total:int;            private var _bg:Bitmap;            private var rate_txt:FilterFrameText;            public function WinRate($win:int, $total:int) { super(); }
            private function init() : void { }
            public function setRate($win:int, $total:int) : void { }
            public function dispose() : void { }
   }}