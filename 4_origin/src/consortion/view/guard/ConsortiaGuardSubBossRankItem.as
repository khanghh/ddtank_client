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
      
      public function ConsortiaGuardSubBossRankItem(param1:int)
      {
         super();
         _num = param1;
         initView();
      }
      
      private function initView() : void
      {
         _rankingText = ComponentFactory.Instance.creatComponentByStylename("consortiaGuard.rank.rankText");
         _rankingText.text = String(_num + 1);
         PositionUtils.setPos(_rankingText,"consortiaGuard.bossRankItem.rankTextPos");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("consortiaGuard.rank.nameText");
         PositionUtils.setPos(_nameText,"consortiaGuard.bossRankItem.nameTextPos");
         _hurtText = ComponentFactory.Instance.creatComponentByStylename("consortiaGuard.rank.nameText");
         PositionUtils.setPos(_hurtText,"consortiaGuard.bossRankItem.hurtTextPos");
         _attacksNumText = ComponentFactory.Instance.creatComponentByStylename("consortiaGuard.rank.nameText");
         PositionUtils.setPos(_attacksNumText,"consortiaGuard.bossRankItem.attacksNumTextPos");
         addChild(_nameText);
         addChild(_rankingText);
         addChild(_hurtText);
         addChild(_attacksNumText);
      }
      
      public function updata(param1:ConsortiaBossDataVo) : void
      {
         _rankingText.text = String(param1.rank);
         _nameText.text = param1.name;
         _hurtText.text = String(param1.damage);
         _attacksNumText.text = String(param1.attacksCount);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_rankingText);
         _rankingText = null;
         ObjectUtils.disposeObject(_hurtText);
         _hurtText = null;
         ObjectUtils.disposeObject(_attacksNumText);
         _attacksNumText = null;
      }
   }
}
