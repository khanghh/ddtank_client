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
      
      public function addCell(param1:BaseCell) : void
      {
         _cells.push(param1);
         addChild(param1);
         arrangeCell();
      }
      
      private function arrangeCell() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _cells.length)
         {
            var _loc2_:int = 1;
            _cells[_loc1_].scaleY = _loc2_;
            _cells[_loc1_].scaleX = _loc2_;
            if(_loc1_ == 0)
            {
               addChild(_cells[0]);
               _loc2_ = 0;
               _cells[0].y = _loc2_;
               _cells[0].x = _loc2_;
            }
            else
            {
               addChild(_cells[_loc1_]);
               _cells[_loc1_].x = _cells[_loc1_ - 1].x + _cells[_loc1_ - 1].width + 20;
            }
            _loc1_++;
         }
      }
      
      public function disopse() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _cells.length)
         {
            _cells[_loc1_].dispose();
            _loc1_++;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
