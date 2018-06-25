package trainer.view{   import bagAndInfo.cell.BaseCell;   import bagAndInfo.cell.CellContentCreator;   import com.greensock.TweenMax;   import ddt.data.goods.ItemTemplateInfo;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class LevelRewardCell extends BaseCell   {                   public function LevelRewardCell($info:ItemTemplateInfo = null) { super(null,null,null,null); }
            override protected function createChildren() : void { }
            override protected function updateSize(sp:Sprite) : void { }
            private function getSize() : Number { return 0; }
            override public function get height() : Number { return 0; }
            override public function get width() : Number { return 0; }
            override protected function onMouseOver(evt:MouseEvent) : void { }
            override protected function onMouseOut(evt:MouseEvent) : void { }
            private function showEffect() : void { }
            private function hideEffect() : void { }
   }}