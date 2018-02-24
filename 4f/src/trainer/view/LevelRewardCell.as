package trainer.view
{
   import bagAndInfo.cell.BaseCell;
   import bagAndInfo.cell.CellContentCreator;
   import com.greensock.TweenMax;
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class LevelRewardCell extends BaseCell
   {
       
      
      public function LevelRewardCell(param1:ItemTemplateInfo = null){super(null,null,null,null);}
      
      override protected function createChildren() : void{}
      
      override protected function updateSize(param1:Sprite) : void{}
      
      private function getSize() : Number{return 0;}
      
      override public function get height() : Number{return 0;}
      
      override public function get width() : Number{return 0;}
      
      override protected function onMouseOver(param1:MouseEvent) : void{}
      
      override protected function onMouseOut(param1:MouseEvent) : void{}
      
      private function showEffect() : void{}
      
      private function hideEffect() : void{}
   }
}
