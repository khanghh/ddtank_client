package consortion.view.club{   import com.pickgliss.ui.controls.container.VBox;   import consortion.ConsortionModelManager;   import consortion.data.ConsortiaApplyInfo;   import consortion.event.ConsortionEvent;   import ddt.data.ConsortiaInfo;   import ddt.manager.SoundManager;   import flash.events.MouseEvent;      public class ConsortionList extends VBox   {                   private var _currentItem:ConsortionListItem;            private var items:Vector.<ConsortionListItem>;            private var _selfApplyList:Vector.<ConsortiaApplyInfo>;            public function ConsortionList() { super(); }
            private function __applyListChange(event:ConsortionEvent) : void { }
            override protected function init() : void { }
            private function __clickHandler(event:MouseEvent) : void { }
            public function get currentItem() : ConsortionListItem { return null; }
            private function __overHandler(event:MouseEvent) : void { }
            private function __outHandler(event:MouseEvent) : void { }
            public function setListData(data:Vector.<ConsortiaInfo>) : void { }
            private function setStatus() : void { }
            override public function dispose() : void { }
   }}