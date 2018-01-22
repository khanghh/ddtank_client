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
         var _loc1_:* = null;
         while(_buffCells.length)
         {
            _loc1_ = _buffCells.shift();
            StarlingObjectUtils.disposeObject(_loc1_);
         }
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
               _loc2_ = new BuffCell3D();
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
      
      override public function dispose() : void
      {
         clearBuff();
         _buffCells = null;
         super.dispose();
      }
   }
}
