package ddt.view.tips{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.tip.ITip;   import com.pickgliss.utils.ObjectUtils;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.text.TextField;      public class ChatFaceTip extends Sprite implements Disposeable, ITip   {                   private var _minW:int;            private var _minH:int;            private var tip_txt:FilterFrameText;            private var _tempData:Object;            public function ChatFaceTip() { super(); }
            public function dispose() : void { }
            public function get tipData() : Object { return null; }
            public function set tipData(data:Object) : void { }
            public function asDisplayObject() : DisplayObject { return null; }
            private function init() : void { }
            private function updateW(data:String) : int { return 0; }
   }}