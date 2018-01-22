package magicHouse.magicCollection
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   
   public class MagicHouseTitleTip extends BaseTip
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _tipTitle:FilterFrameText;
      
      private var _attack:FilterFrameText;
      
      private var _attackValue:FilterFrameText;
      
      private var _defense:FilterFrameText;
      
      private var _defenseValue:FilterFrameText;
      
      private var _damage:FilterFrameText;
      
      private var _damageValue:FilterFrameText;
      
      public function MagicHouseTitleTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         mouseChildren = false;
         mouseEnabled = false;
         super.init();
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipBg");
         _tipTitle = ComponentFactory.Instance.creatComponentByStylename("magichouse.titleTip.Text");
         _attack = ComponentFactory.Instance.creatComponentByStylename("magichouse.titleTip.Text");
         _attackValue = ComponentFactory.Instance.creatComponentByStylename("magichouse.titleTip.Text");
         _defense = ComponentFactory.Instance.creatComponentByStylename("magichouse.titleTip.Text");
         _defenseValue = ComponentFactory.Instance.creatComponentByStylename("magichouse.titleTip.Text");
         _damage = ComponentFactory.Instance.creatComponentByStylename("magichouse.titleTip.Text");
         _damageValue = ComponentFactory.Instance.creatComponentByStylename("magichouse.titleTip.Text");
         _attack.text = LanguageMgr.GetTranslation("magichouse.collectionView.titleTip.attack");
         _defense.text = LanguageMgr.GetTranslation("magichouse.collectionView.titleTip.defense");
         _damage.text = LanguageMgr.GetTranslation("magichouse.collectionView.titleTip.damage");
         PositionUtils.setPos(_tipTitle,"magicHouse.titleTipTitleTxtPos");
         PositionUtils.setPos(_attack,"magicHouse.titleTipAttackTxtPos");
         PositionUtils.setPos(_defense,"magicHouse.titleTipDefenseTxtPos");
         PositionUtils.setPos(_damage,"magicHouse.titleTipDamageTxtPos");
         PositionUtils.setPos(_attackValue,"magicHouse.titleTipAttackValueTxtPos");
         PositionUtils.setPos(_defenseValue,"magicHouse.titleTipDefenseValueTxtPos");
         PositionUtils.setPos(_damageValue,"magicHouse.titleTipDamageValueTxtPos");
         addChild(_tipTitle);
         addChild(_attack);
         addChild(_attackValue);
         addChild(_defense);
         addChild(_defenseValue);
         addChild(_damage);
         addChild(_damageValue);
         setBGWidth(150);
         setBGHeight(130);
         this.tipbackgound = _bg;
      }
      
      override public function set tipData(param1:Object) : void
      {
         .super.tipData = param1;
         this.setTitleText(param1.title);
         this.atcAddValueText(param1.magicAttack);
         this.defAddValueText(param1.magicDefense);
         this.lukAddValueText(param1.critDamage);
      }
      
      private function setTitleText(param1:String) : void
      {
         _tipTitle.text = param1;
      }
      
      private function atcAddValueText(param1:int) : void
      {
         _attackValue.text = "+" + String(param1);
      }
      
      private function defAddValueText(param1:int) : void
      {
         _defenseValue.text = "+" + String(param1);
      }
      
      private function lukAddValueText(param1:int) : void
      {
         _damageValue.text = "+" + String(param1);
      }
      
      public function setBGWidth(param1:int = 0) : void
      {
         _bg.width = param1;
      }
      
      public function setBGHeight(param1:int = 0) : void
      {
         _bg.height = param1;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_tipTitle)
         {
            addChild(_tipTitle);
         }
         if(_attack)
         {
            addChild(_attack);
         }
         if(_defense)
         {
            addChild(_defense);
         }
         if(_damage)
         {
            addChild(_damage);
         }
         if(_attackValue)
         {
            addChild(_attackValue);
         }
         if(_defenseValue)
         {
            addChild(_defenseValue);
         }
         if(_damageValue)
         {
            addChild(_damageValue);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_attack)
         {
            ObjectUtils.disposeObject(_attack);
            _attack = null;
         }
         if(_defense)
         {
            ObjectUtils.disposeObject(_defense);
            _defense = null;
         }
         if(_damage)
         {
            ObjectUtils.disposeObject(_damage);
            _damage = null;
         }
         if(_attackValue)
         {
            ObjectUtils.disposeObject(_attackValue);
            _attackValue = null;
         }
         if(_defenseValue)
         {
            ObjectUtils.disposeObject(_defenseValue);
            _defenseValue = null;
         }
         if(_damageValue)
         {
            ObjectUtils.disposeObject(_damageValue);
            _damageValue = null;
         }
      }
   }
}
