package game.view.buff
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import gameCommon.model.FightBuffInfo;
   
   public class FightBuffBar extends Sprite implements Disposeable
   {
       
      
      private var _buffCells:Vector.<BuffCell>;
      
      public function FightBuffBar(){super();}
      
      private function clearBuff() : void{}
      
      private function drawBuff() : void{}
      
      public function update(param1:Vector.<FightBuffInfo>) : void{}
      
      public function dispose() : void{}
   }
}
