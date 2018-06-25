package mark.views{   import com.pickgliss.utils.ObjectUtils;   import mark.MarkMgr;   import mark.data.MarkBagData;   import mark.event.MarkEvent;   import mark.items.MarkSuitItem;   import mark.mornUI.views.MarkRightViewUI;   import morn.core.handlers.Handler;      public class MarkRightView extends MarkRightViewUI   {                   private var _bag:MarkBagView = null;            private var _bagId:int = -1;            public function MarkRightView() { super(); }
            override protected function initialize() : void { }
            private function render(item:MarkSuitItem, index:int) : void { }
            private function select(index:int) : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function updateStatus() : void { }
            private function updateChips(evt:MarkEvent = null) : void { }
            private function disposeView(evt:MarkEvent) : void { }
            override public function dispose() : void { }
   }}