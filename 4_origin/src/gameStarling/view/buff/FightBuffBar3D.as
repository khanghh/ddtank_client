package gameStarling.view.buff
{
   import com.pickgliss.utils.StarlingObjectUtils;
   import gameCommon.model.FightBuffInfo;
   import starling.display.Sprite;
   
   public class FightBuffBar3D extends Sprite
   {
       
      
      private var _buffCells:Vector.<BuffCell3D>;
      
      public function FightBuffBar3D()
      {
         super();
         _buffCells = new Vector.<BuffCell3D>();
         touchable = false;
      }
      
      public function clearBuff() : void
      {
         var cell:* = null;
         while(_buffCells.length)
         {
            cell = _buffCells.shift();
            StarlingObjectUtils.disposeObject(cell);
         }
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
               cell = new BuffCell3D();
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
      
      override public function dispose() : void
      {
         clearBuff();
         _buffCells = null;
         super.dispose();
      }
   }
}
