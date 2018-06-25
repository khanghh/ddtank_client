package bagAndInfo.bag{   import bagAndInfo.cell.BagCell;   import bagAndInfo.cell.DragEffect;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.TextButton;   import ddt.interfaces.ICell;   import ddt.interfaces.IDragable;   import ddt.manager.DragManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.filters.ColorMatrixFilter;      public class BreakGoodsBtn extends TextButton implements IDragable   {                   private var _dragTarget:BagCell;            private var _enabel:Boolean;            private var win:BreakGoodsView;            private var myColorMatrix_filter:ColorMatrixFilter;            private var lightingFilter:ColorMatrixFilter;            public function BreakGoodsBtn() { super(); }
            override protected function init() : void { }
            private function __mouseClick(event:MouseEvent) : void { }
            public function dragStart(stageX:Number, stageY:Number) : void { }
            public function dragStop(effect:DragEffect) : void { }
            private function breakBack() : void { }
            public function getSource() : IDragable { return null; }
            public function getDragData() : Object { return null; }
            private function removeEvents() : void { }
            private function initEvent() : void { }
            override public function dispose() : void { }
            private function __addToStage(evt:Event) : void { }
            private function __removeFromStage(evt:Event) : void { }
            private function cancelBack() : void { }
   }}