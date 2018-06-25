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
      
      public function ConsortiaGuardSubBossRankItem(num:int)
      {
         super();
         _num = num;
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
      
      public function updata(vo:ConsortiaBossDataVo) : void
      {
         _rankingText.text = String(vo.rank);
         _nameText.text = vo.name;
         _hurtText.text = String(vo.damage);
         _attacksNumText.text = String(vo.attacksCount);
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
