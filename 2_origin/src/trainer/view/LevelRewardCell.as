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
       
      
      public function LevelRewardCell(param1:ItemTemplateInfo = null)
      {
         super(null,param1,false,true);
      }
      
      override protected function createChildren() : void
      {
         _pic = new CellContentCreator();
         _pic.mouseEnabled = false;
      }
      
      override protected function updateSize(param1:Sprite) : void
      {
         if(param1)
         {
            _pic.width = getSize();
            _pic.height = getSize();
            _pic.x = -getSize() * 0.5;
            _pic.y = -getSize() * 0.5;
         }
      }
      
      private function getSize() : Number
      {
         return info.CategoryID == 10?42:48;
      }
      
      override public function get height() : Number
      {
         return 48;
      }
      
      override public function get width() : Number
      {
         return 48;
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         scaleY = 1.3;
         scaleX = 1.3;
         showEffect();
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         scaleY = 1;
         scaleX = 1;
         hideEffect();
      }
      
      private function showEffect() : void
      {
         TweenMax.to(this,0.5,{
            "repeat":-1,
            "yoyo":true,
            "glowFilter":{
               "color":16777011,
               "alpha":1,
               "blurX":8,
               "blurY":8,
               "strength":3
            }
         });
      }
      
      private function hideEffect() : void
      {
         TweenMax.killChildTweensOf(this.parent,false);
         this.filters = null;
         var _loc1_:* = getSize();
         _pic.height = _loc1_;
         _pic.width = _loc1_;
         _loc1_ = -getSize() * 0.5;
         _pic.y = _loc1_;
         _pic.x = _loc1_;
      }
   }
}
