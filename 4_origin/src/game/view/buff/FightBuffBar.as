package game.view.buff
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import gameCommon.model.FightBuffInfo;
   
   public class FightBuffBar extends Sprite implements Disposeable
   {
       
      
      private var _buffCells:Vector.<BuffCell>;
      
      public function FightBuffBar()
      {
         _buffCells = new Vector.<BuffCell>();
         super();
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      private function clearBuff() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _buffCells;
         for each(var _loc1_ in _buffCells)
         {
            _loc1_.clearSelf();
         }
      }
      
      private function drawBuff() : void
      {
      }
      
      public function update(param1:Vector.<FightBuffInfo>) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         clearBuff();
         var _loc3_:int = param1.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc4_ + 1 > _buffCells.length)
            {
               _loc2_ = new BuffCell();
               _buffCells.push(_loc2_);
            }
            else
            {
               _loc2_ = _buffCells[_loc4_];
            }
            _loc2_.setInfo(param1[_loc4_]);
            _loc2_.x = (_loc4_ & 3) * 24;
            _loc2_.y = -(_loc4_ >> 2) * 24;
            addChild(_loc2_);
            _loc4_++;
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:BuffCell = _buffCells.shift();
         while(_loc1_)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = _buffCells.shift();
         }
         _buffCells = null;
      }
   }
}
