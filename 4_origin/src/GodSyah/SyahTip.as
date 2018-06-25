package GodSyah
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.LanguageMgr;
   
   public class SyahTip extends Component
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _tipName:FilterFrameText;
      
      private var _line1:ScaleBitmapImage;
      
      private var _line2:ScaleBitmapImage;
      
      private var _hp:FilterFrameText;
      
      private var _hpValue:FilterFrameText;
      
      private var _armor:FilterFrameText;
      
      private var _armorValue:FilterFrameText;
      
      private var _damage:FilterFrameText;
      
      private var _damageValue:FilterFrameText;
      
      private var _attack:FilterFrameText;
      
      private var _attackValue:FilterFrameText;
      
      private var _defense:FilterFrameText;
      
      private var _defenseValue:FilterFrameText;
      
      private var _agility:FilterFrameText;
      
      private var _agilityValue:FilterFrameText;
      
      private var _lucky:FilterFrameText;
      
      private var _luckyValue:FilterFrameText;
      
      private var _valid:FilterFrameText;
      
      private var _lessValid:FilterFrameText;
      
      private var _itemPlace:int;
      
      private var _mode:SyahMode;
      
      private var _powerVec:Vector.<FilterFrameText>;
      
      private const SYAHVIEW:String = "syahview";
      
      private const BAGANDOTHERS:String = "bagandothers";
      
      public function SyahTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         _buildUI();
      }
      
      public function setTipInfo(info:ItemTemplateInfo) : void
      {
         if(SyahManager.Instance.inView)
         {
            _mode = SyahManager.Instance.getSyahModeByInfo(info);
            _buildTipInfo("syahview");
         }
         else
         {
            _mode = SyahManager.Instance.getSyahModeByInfo(info);
            _mode.isValid = SyahManager.Instance.setModeValid(info);
            _buildTipInfo("bagandothers");
         }
      }
      
      public function setBGWidth(bgWidth:int = 0) : void
      {
         _bg.width = bgWidth;
      }
      
      private function _buildUI() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipBg");
         _line1 = ComponentFactory.Instance.creatComponentByStylename("HRuleAsset");
         _line2 = ComponentFactory.Instance.creatComponentByStylename("HRuleAsset");
         _tipName = ComponentFactory.Instance.creatComponentByStylename("GodSyah.syahTip.tipName");
         _hp = ComponentFactory.Instance.creatComponentByStylename("GodSyah.syahTip.ability");
         _armor = ComponentFactory.Instance.creatComponentByStylename("GodSyah.syahTip.ability");
         _damage = ComponentFactory.Instance.creatComponentByStylename("GodSyah.syahTip.ability");
         _attack = ComponentFactory.Instance.creatComponentByStylename("GodSyah.syahTip.ability");
         _defense = ComponentFactory.Instance.creatComponentByStylename("GodSyah.syahTip.ability");
         _agility = ComponentFactory.Instance.creatComponentByStylename("GodSyah.syahTip.ability");
         _lucky = ComponentFactory.Instance.creatComponentByStylename("GodSyah.syahTip.ability");
         _hpValue = ComponentFactory.Instance.creatComponentByStylename("GodSyah.syahTip.abilityValue");
         _armorValue = ComponentFactory.Instance.creatComponentByStylename("GodSyah.syahTip.abilityValue");
         _damageValue = ComponentFactory.Instance.creatComponentByStylename("GodSyah.syahTip.abilityValue");
         _attackValue = ComponentFactory.Instance.creatComponentByStylename("GodSyah.syahTip.abilityValue");
         _defenseValue = ComponentFactory.Instance.creatComponentByStylename("GodSyah.syahTip.abilityValue");
         _agilityValue = ComponentFactory.Instance.creatComponentByStylename("GodSyah.syahTip.abilityValue");
         _luckyValue = ComponentFactory.Instance.creatComponentByStylename("GodSyah.syahTip.abilityValue");
         _valid = ComponentFactory.Instance.creatComponentByStylename("GodSyah.syahTip.valid");
         _lessValid = ComponentFactory.Instance.creatComponentByStylename("GodSyah.syahTip.valid");
         addChild(_bg);
         addChild(_line1);
         addChild(_line2);
         addChild(_tipName);
         addChild(_valid);
      }
      
      private function _buildTipInfo(type:String) : void
      {
         _tipName.text = LanguageMgr.GetTranslation("ddt.GodSyah.tip.tipName");
         _valid.text = LanguageMgr.GetTranslation("ddt.GodSyah.tip.valid",_mode.valid);
         _line1.x = _tipName.x;
         _line1.y = _tipName.y + _tipName.height + 2;
         if(type == "syahview")
         {
            _showAllDetails();
         }
         else if(type == "bagandothers")
         {
            if(_mode.isValid == false)
            {
               _lessValid.text = LanguageMgr.GetTranslation("ddt.GodSyah.tip.lessvalid");
               addChild(_lessValid);
               _lessValid.x = _tipName.x;
               _lessValid.y = _line1.y + _line1.height + 2;
               _line2.x = _tipName.x;
               _line2.y = _lessValid.y + _lessValid.height + 2;
            }
            else
            {
               _showAllDetails();
            }
         }
         _valid.x = _tipName.x;
         _valid.y = _line2.y + _line2.height + 2;
         _bg.height = _valid.y + _valid.height + 10;
      }
      
      private function _showAllDetails() : void
      {
         var i:int = 0;
         _hp.text = LanguageMgr.GetTranslation("ddt.GodSyah.tip.hp");
         _armor.text = LanguageMgr.GetTranslation("ddt.GodSyah.tip.armor");
         _damage.text = LanguageMgr.GetTranslation("ddt.GodSyah.tip.damage");
         _attack.text = LanguageMgr.GetTranslation("ddt.GodSyah.tip.attack");
         _defense.text = LanguageMgr.GetTranslation("ddt.GodSyah.tip.defense");
         _agility.text = LanguageMgr.GetTranslation("ddt.GodSyah.tip.agility");
         _lucky.text = LanguageMgr.GetTranslation("ddt.GodSyah.tip.lucky");
         _attackValue.text = "+" + _mode.attack;
         _defenseValue.text = "+" + _mode.defense;
         _agilityValue.text = "+" + _mode.agility;
         _luckyValue.text = "+" + _mode.lucky;
         _hpValue.text = "+" + _mode.hp;
         _armorValue.text = "+" + _mode.armor;
         _damageValue.text = "+" + _mode.damage;
         _powerVec = new Vector.<FilterFrameText>();
         if(parseInt(_attackValue.text) > 0)
         {
            _powerVec.push(_attack);
            _powerVec.push(_attackValue);
         }
         if(parseInt(_defenseValue.text) > 0)
         {
            _powerVec.push(_defense);
            _powerVec.push(_defenseValue);
         }
         if(parseInt(_agilityValue.text) > 0)
         {
            _powerVec.push(_agility);
            _powerVec.push(_agilityValue);
         }
         if(parseInt(_luckyValue.text) > 0)
         {
            _powerVec.push(_lucky);
            _powerVec.push(_luckyValue);
         }
         if(parseInt(_hpValue.text) > 0)
         {
            _powerVec.push(_hp);
            _powerVec.push(_hpValue);
         }
         if(parseInt(_armorValue.text) > 0)
         {
            _powerVec.push(_armor);
            _powerVec.push(_armorValue);
         }
         if(parseInt(_damageValue.text) > 0)
         {
            _powerVec.push(_damage);
            _powerVec.push(_damageValue);
         }
         i = 0;
         while(i < _powerVec.length)
         {
            if(parseInt(_powerVec[i + 1].text) > 0)
            {
               addChild(_powerVec[i]);
               addChild(_powerVec[i + 1]);
               if(i == 0)
               {
                  var _loc2_:* = _line1.y + _line1.height + 2;
                  _powerVec[i + 1].y = _loc2_;
                  _powerVec[i].y = _loc2_;
               }
               else
               {
                  _loc2_ = _powerVec[i - 1].y + _powerVec[i - 1].height + 1;
                  _powerVec[i + 1].y = _loc2_;
                  _powerVec[i].y = _loc2_;
               }
            }
            i = i + 2;
         }
         _line2.x = _tipName.x;
         _line2.y = _powerVec[_powerVec.length - 1].y + _powerVec[_powerVec.length - 1].height + 2;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_tipName)
         {
            ObjectUtils.disposeObject(_tipName);
            _tipName = null;
         }
         if(_line1)
         {
            ObjectUtils.disposeObject(_line1);
            _line1 = null;
         }
         if(_line2)
         {
            ObjectUtils.disposeObject(_line2);
            _line2 = null;
         }
         if(_hp)
         {
            ObjectUtils.disposeObject(_hp);
            _hp = null;
         }
         if(_hpValue)
         {
            ObjectUtils.disposeObject(_hpValue);
            _hpValue = null;
         }
         if(_armor)
         {
            ObjectUtils.disposeObject(_armor);
            _armor = null;
         }
         if(_armorValue)
         {
            ObjectUtils.disposeObject(_armorValue);
            _armorValue = null;
         }
         if(_damage)
         {
            ObjectUtils.disposeObject(_damage);
            _damage = null;
         }
         if(_damageValue)
         {
            ObjectUtils.disposeObject(_damageValue);
            _damageValue = null;
         }
         if(_attack)
         {
            ObjectUtils.disposeObject(_attack);
            _attack = null;
         }
         if(_attackValue)
         {
            ObjectUtils.disposeObject(_attackValue);
            _attackValue = null;
         }
         if(_defense)
         {
            ObjectUtils.disposeObject(_defense);
            _defense = null;
         }
         if(_defenseValue)
         {
            ObjectUtils.disposeObject(_defenseValue);
            _defenseValue = null;
         }
         if(_agility)
         {
            ObjectUtils.disposeObject(_agility);
            _agility = null;
         }
         if(_agilityValue)
         {
            ObjectUtils.disposeObject(_agilityValue);
            _agilityValue = null;
         }
         if(_lucky)
         {
            ObjectUtils.disposeObject(_lucky);
            _lucky = null;
         }
         if(_luckyValue)
         {
            ObjectUtils.disposeObject(_luckyValue);
            _luckyValue = null;
         }
         if(_valid)
         {
            ObjectUtils.disposeObject(_valid);
            _valid = null;
         }
      }
   }
}
