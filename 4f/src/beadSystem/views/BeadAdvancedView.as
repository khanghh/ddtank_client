package beadSystem.views{   import beadSystem.model.AdvanceBeadInfo;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.CEvent;   import ddt.utils.PositionUtils;   import flash.display.Sprite;   import road7th.data.DictionaryData;      public class BeadAdvancedView extends Sprite implements Disposeable   {                   private var _bg:MutipleImage;            private var _leftView:BeadAdvancedListView;            private var _rightView:BeadAdvancedRightView;            private var _curPageIndex:int = -1;            public function BeadAdvancedView() { super(); }
            protected function initView() : void { }
            protected function initEvent() : void { }
            protected function removeEvent() : void { }
            public function update(info:DictionaryData) : void { }
            public function refresh() : void { }
            public function set curPageIndex(value:int) : void { }
            public function get curPageIndex() : int { return 0; }
            public function selectChangeHandler(evt:CEvent) : void { }
            public function dispose() : void { }
   }}