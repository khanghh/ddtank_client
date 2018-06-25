package playerDress.components{   import bagAndInfo.cell.BagCell;   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.utils.DoubleClickManager;   import ddt.data.goods.ItemTemplateInfo;   import ddt.events.CellEvent;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.events.MouseEvent;   import flash.geom.Point;      public class DressCell extends BagCell   {                   public function DressCell(index:int = 0, info:ItemTemplateInfo = null, showLoading:Boolean = true) { super(null,null,null); }
            private function initEvents() : void { }
            private function removeEvents() : void { }
            override protected function onMouseOver(evt:MouseEvent) : void { }
            override protected function onMouseClick(evt:MouseEvent) : void { }
            protected function onClick(evt:InteractiveEvent) : void { }
            protected function onDoubleClick(evt:InteractiveEvent) : void { }
            override protected function createLoading() : void { }
            override public function dispose() : void { }
   }}