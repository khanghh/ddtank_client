package game.gametrainer.view{   import bagAndInfo.cell.DragEffect;   import bagAndInfo.cell.LinkedBagCell;   import flash.events.Event;   import flash.events.MouseEvent;      public class DropCell extends LinkedBagCell   {                   public function DropCell() { super(null); }
            override public function dragDrop(effect:DragEffect) : void { }
            override protected function onMouseOver(evt:MouseEvent) : void { }
            override protected function onMouseOut(evt:MouseEvent) : void { }
            override protected function onMouseClick(evt:MouseEvent) : void { }
            override protected function createContentComplete() : void { }
   }}