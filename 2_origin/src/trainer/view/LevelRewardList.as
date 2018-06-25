package trainer.view
{
   import bagAndInfo.cell.BaseCell;
   import flash.display.Sprite;
   
   public class LevelRewardList extends Sprite
   {
       
      
      private var _cells:Vector.<BaseCell>;
      
      public function LevelRewardList()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _cells = new Vector.<BaseCell>();
      }
      
      public function addCell(cell:BaseCell) : void
      {
         _cells.push(cell);
         addChild(cell);
         arrangeCell();
      }
      
      private function arrangeCell() : void
      {
         var i:int = 0;
         for(i = 0; i < _cells.length; )
         {
            var _loc2_:int = 1;
            _cells[i].scaleY = _loc2_;
            _cells[i].scaleX = _loc2_;
            if(i == 0)
            {
               addChild(_cells[0]);
               _loc2_ = 0;
               _cells[0].y = _loc2_;
               _cells[0].x = _loc2_;
            }
            else
            {
               addChild(_cells[i]);
               _cells[i].x = _cells[i - 1].x + _cells[i - 1].width + 20;
            }
            i++;
         }
      }
      
      public function disopse() : void
      {
         var i:int = 0;
         for(i = 0; i < _cells.length; )
         {
            _cells[i].dispose();
            i++;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
