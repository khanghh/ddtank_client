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
         for each(var cell in _buffCells)
         {
            cell.clearSelf();
         }
      }
      
      private function drawBuff() : void
      {
      }
      
      public function update(buffs:Vector.<FightBuffInfo>) : void
      {
         var i:int = 0;
         var cell:* = null;
         clearBuff();
         var len:int = buffs.length;
         for(i = 0; i < len; )
         {
            if(i + 1 > _buffCells.length)
            {
               cell = new BuffCell();
               _buffCells.push(cell);
            }
            else
            {
               cell = _buffCells[i];
            }
            cell.setInfo(buffs[i]);
            cell.x = (i & 3) * 24;
            cell.y = -(i >> 2) * 24;
            addChild(cell);
            i++;
         }
      }
      
      public function dispose() : void
      {
         var cell:BuffCell = _buffCells.shift();
         while(cell)
         {
            ObjectUtils.disposeObject(cell);
            cell = _buffCells.shift();
         }
         _buffCells = null;
      }
   }
}
