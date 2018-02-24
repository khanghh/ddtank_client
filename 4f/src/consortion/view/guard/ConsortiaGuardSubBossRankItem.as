package consortion.view.guard
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.data.ConsortiaBossDataVo;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   
   public class ConsortiaGuardSubBossRankItem extends Sprite implements Disposeable
   {
       
      
      private var _nameText:FilterFrameText;
      
      private var _rankingText:FilterFrameText;
      
      private var _hurtText:FilterFrameText;
      
      private var _attacksNumText:FilterFrameText;
      
      private var _num:int;
      
      public function ConsortiaGuardSubBossRankItem(param1:int){super();}
      
      private function initView() : void{}
      
      public function updata(param1:ConsortiaBossDataVo) : void{}
      
      public function dispose() : void{}
   }
}
