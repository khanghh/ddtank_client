package consortion.view.selfConsortia{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SoundManager;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;      public class TakeInTurnPage extends Sprite implements Disposeable   {            public static const PAGE_CHANGE:String = "pageChange";                   private var _bg:Scale9CornerImage;            private var _next:BaseButton;            private var _pre:BaseButton;            private var _page:FilterFrameText;            private var _present:int = 1;            private var _sum:int = 1;            public function TakeInTurnPage() { super(); }
            public function get present() : int { return 0; }
            public function set present(value:int) : void { }
            public function get sum() : int { return 0; }
            public function set sum(value:int) : void { }
            private function setPage() : void { }
            private function initView() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function __nextHanlder(event:MouseEvent) : void { }
            private function setBtnState() : void { }
            private function __preHanlder(event:MouseEvent) : void { }
            public function dispose() : void { }
   }}