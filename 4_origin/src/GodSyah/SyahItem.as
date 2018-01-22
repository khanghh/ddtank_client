package GodSyah
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class SyahItem extends Sprite
   {
       
      
      private var _itemBg:Bitmap;
      
      private var _cell:SyahCell;
      
      private var _mode:SyahMode;
      
      private var _info:InventoryItemInfo;
      
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
      
      private var _vec:Vector.<FilterFrameText>;
      
      public function SyahItem()
      {
         super();
         _buildUI();
      }
      
      public function setSyahItemInfo(param1:InventoryItemInfo) : void
      {
         _info = param1;
         _mode = SyahManager.Instance.getSyahModeByInfo(param1);
         _createInfo();
      }
      
      private function _buildUI() : void
      {
         _itemBg = ComponentFactory.Instance.creatBitmap("wonderfulactivity.GodSyah.syahView.item.bg");
         _hp = ComponentFactory.Instance.creatComponentByStylename("GodSyah.syahView.ability");
         _armor = ComponentFactory.Instance.creatComponentByStylename("GodSyah.syahView.ability");
         _damage = ComponentFactory.Instance.creatComponentByStylename("GodSyah.syahView.ability");
         _attack = ComponentFactory.Instance.creatComponentByStylename("GodSyah.syahView.ability");
         _defense = ComponentFactory.Instance.creatComponentByStylename("GodSyah.syahView.ability");
         _agility = ComponentFactory.Instance.creatComponentByStylename("GodSyah.syahView.ability");
         _lucky = ComponentFactory.Instance.creatComponentByStylename("GodSyah.syahView.ability");
         _hpValue = ComponentFactory.Instance.creatComponentByStylename("GodSyah.syahView.abilityValue");
         _armorValue = ComponentFactory.Instance.creatComponentByStylename("GodSyah.syahView.abilityValue");
         _damageValue = ComponentFactory.Instance.creatComponentByStylename("GodSyah.syahView.abilityValue");
         _attackValue = ComponentFactory.Instance.creatComponentByStylename("GodSyah.syahView.abilityValue");
         _defenseValue = ComponentFactory.Instance.creatComponentByStylename("GodSyah.syahView.abilityValue");
         _agilityValue = ComponentFactory.Instance.creatComponentByStylename("GodSyah.syahView.abilityValue");
         _luckyValue = ComponentFactory.Instance.creatComponentByStylename("GodSyah.syahView.abilityValue");
         _hp.text = LanguageMgr.GetTranslation("ddt.GodSyah.tip.hp");
         _armor.text = LanguageMgr.GetTranslation("ddt.GodSyah.tip.armor");
         _damage.text = LanguageMgr.GetTranslation("ddt.GodSyah.tip.damage");
         _attack.text = LanguageMgr.GetTranslation("ddt.GodSyah.tip.attack");
         _defense.text = LanguageMgr.GetTranslation("ddt.GodSyah.tip.defense");
         _agility.text = LanguageMgr.GetTranslation("ddt.GodSyah.tip.agility");
         _lucky.text = LanguageMgr.GetTranslation("ddt.GodSyah.tip.lucky");
         addChild(_itemBg);
      }
      
      private function _createInfo() : void
      {
         _hpValue.text = "+" + _mode.hp;
         _armorValue.text = "+" + _mode.armor;
         _damageValue.text = "+" + _mode.damage;
         _attackValue.text = "+" + _mode.attack;
         _defenseValue.text = "+" + _mode.defense;
         _agilityValue.text = "+" + _mode.agility;
         _luckyValue.text = "+" + _mode.lucky;
         _cell = ComponentFactory.Instance.creatCustomObject("godSyah.syahview.syahcell");
         _cell.info = _info;
         _vec = new Vector.<FilterFrameText>();
         if(parseInt(_attackValue.text) > 0)
         {
            _vec.push(_attack);
            _vec.push(_attackValue);
         }
         if(parseInt(_defenseValue.text) > 0)
         {
            _vec.push(_defense);
            _vec.push(_defenseValue);
         }
         if(parseInt(_agilityValue.text) > 0)
         {
            _vec.push(_agility);
            _vec.push(_agilityValue);
         }
         if(parseInt(_luckyValue.text) > 0)
         {
            _vec.push(_lucky);
            _vec.push(_luckyValue);
         }
         if(parseInt(_hpValue.text) > 0)
         {
            _vec.push(_hp);
            _vec.push(_hpValue);
         }
         if(parseInt(_armorValue.text) > 0)
         {
            _vec.push(_armor);
            _vec.push(_armorValue);
         }
         if(parseInt(_damageValue.text) > 0)
         {
            _vec.push(_damage);
            _vec.push(_damageValue);
         }
         addChild(_cell);
         _arrangeText();
      }
      
      private function _arrangeText() : void
      {
         var _loc1_:int = 0;
         switch(int(_vec.length) - 2)
         {
            case 0:
               _vec[0].x = 150;
               _vec[1].x = 228;
               var _loc2_:* = 43;
               _vec[1].y = _loc2_;
               _vec[0].y = _loc2_;
               break;
            default:
               _vec[0].x = 150;
               _vec[1].x = 228;
               var _loc2_:* = 43;
               _vec[1].y = _loc2_;
               _vec[0].y = _loc2_;
               break;
            case 2:
               _vec[0].x = 150;
               _vec[1].x = 228;
               _vec[2].x = 261;
               _vec[3].x = 339;
               _loc2_ = 43;
               _vec[3].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[2].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[1].y = _loc2_;
               _vec[0].y = _loc2_;
               break;
            default:
               _vec[0].x = 150;
               _vec[1].x = 228;
               _vec[2].x = 261;
               _vec[3].x = 339;
               _loc2_ = 43;
               _vec[3].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[2].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[1].y = _loc2_;
               _vec[0].y = _loc2_;
               break;
            case 4:
               _loc2_ = 150;
               _vec[4].x = _loc2_;
               _vec[0].x = _loc2_;
               _loc2_ = 228;
               _vec[5].x = _loc2_;
               _vec[1].x = _loc2_;
               _vec[2].x = 261;
               _vec[3].x = 339;
               _loc2_ = 21;
               _vec[3].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[2].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[1].y = _loc2_;
               _vec[0].y = _loc2_;
               _loc2_ = 63;
               _vec[5].y = _loc2_;
               _vec[4].y = _loc2_;
               break;
            default:
               _loc2_ = 150;
               _vec[4].x = _loc2_;
               _vec[0].x = _loc2_;
               _loc2_ = 228;
               _vec[5].x = _loc2_;
               _vec[1].x = _loc2_;
               _vec[2].x = 261;
               _vec[3].x = 339;
               _loc2_ = 21;
               _vec[3].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[2].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[1].y = _loc2_;
               _vec[0].y = _loc2_;
               _loc2_ = 63;
               _vec[5].y = _loc2_;
               _vec[4].y = _loc2_;
               break;
            case 6:
               _loc2_ = 150;
               _vec[4].x = _loc2_;
               _vec[0].x = _loc2_;
               _loc2_ = 228;
               _vec[5].x = _loc2_;
               _vec[1].x = _loc2_;
               _loc2_ = 261;
               _vec[6].x = _loc2_;
               _vec[2].x = _loc2_;
               _loc2_ = 339;
               _vec[7].x = _loc2_;
               _vec[3].x = _loc2_;
               _loc2_ = 21;
               _vec[3].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[2].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[1].y = _loc2_;
               _vec[0].y = _loc2_;
               _loc2_ = 63;
               _vec[7].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[6].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[5].y = _loc2_;
               _vec[4].y = _loc2_;
               break;
            default:
               _loc2_ = 150;
               _vec[4].x = _loc2_;
               _vec[0].x = _loc2_;
               _loc2_ = 228;
               _vec[5].x = _loc2_;
               _vec[1].x = _loc2_;
               _loc2_ = 261;
               _vec[6].x = _loc2_;
               _vec[2].x = _loc2_;
               _loc2_ = 339;
               _vec[7].x = _loc2_;
               _vec[3].x = _loc2_;
               _loc2_ = 21;
               _vec[3].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[2].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[1].y = _loc2_;
               _vec[0].y = _loc2_;
               _loc2_ = 63;
               _vec[7].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[6].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[5].y = _loc2_;
               _vec[4].y = _loc2_;
               break;
            case 8:
               _loc2_ = 150;
               _vec[8].x = _loc2_;
               _loc2_ = _loc2_;
               _vec[4].x = _loc2_;
               _vec[0].x = _loc2_;
               _loc2_ = 228;
               _vec[9].x = _loc2_;
               _loc2_ = _loc2_;
               _vec[5].x = _loc2_;
               _vec[1].x = _loc2_;
               _loc2_ = 261;
               _vec[6].x = _loc2_;
               _vec[2].x = _loc2_;
               _loc2_ = 339;
               _vec[7].x = _loc2_;
               _vec[3].x = _loc2_;
               _loc2_ = 21;
               _vec[3].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[2].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[1].y = _loc2_;
               _vec[0].y = _loc2_;
               _loc2_ = 42;
               _vec[7].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[6].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[5].y = _loc2_;
               _vec[4].y = _loc2_;
               _loc2_ = 63;
               _vec[9].y = _loc2_;
               _vec[8].y = _loc2_;
               break;
            default:
               _loc2_ = 150;
               _vec[8].x = _loc2_;
               _loc2_ = _loc2_;
               _vec[4].x = _loc2_;
               _vec[0].x = _loc2_;
               _loc2_ = 228;
               _vec[9].x = _loc2_;
               _loc2_ = _loc2_;
               _vec[5].x = _loc2_;
               _vec[1].x = _loc2_;
               _loc2_ = 261;
               _vec[6].x = _loc2_;
               _vec[2].x = _loc2_;
               _loc2_ = 339;
               _vec[7].x = _loc2_;
               _vec[3].x = _loc2_;
               _loc2_ = 21;
               _vec[3].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[2].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[1].y = _loc2_;
               _vec[0].y = _loc2_;
               _loc2_ = 42;
               _vec[7].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[6].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[5].y = _loc2_;
               _vec[4].y = _loc2_;
               _loc2_ = 63;
               _vec[9].y = _loc2_;
               _vec[8].y = _loc2_;
               break;
            case 10:
               _loc2_ = 150;
               _vec[8].x = _loc2_;
               _loc2_ = _loc2_;
               _vec[4].x = _loc2_;
               _vec[0].x = _loc2_;
               _loc2_ = 228;
               _vec[9].x = _loc2_;
               _loc2_ = _loc2_;
               _vec[5].x = _loc2_;
               _vec[1].x = _loc2_;
               _loc2_ = 261;
               _vec[10].x = _loc2_;
               _loc2_ = _loc2_;
               _vec[6].x = _loc2_;
               _vec[2].x = _loc2_;
               _loc2_ = 339;
               _vec[11].x = _loc2_;
               _loc2_ = _loc2_;
               _vec[7].x = _loc2_;
               _vec[3].x = _loc2_;
               _loc2_ = 21;
               _vec[3].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[2].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[1].y = _loc2_;
               _vec[0].y = _loc2_;
               _loc2_ = 42;
               _vec[7].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[6].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[5].y = _loc2_;
               _vec[4].y = _loc2_;
               _loc2_ = 63;
               _vec[11].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[10].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[9].y = _loc2_;
               _vec[8].y = _loc2_;
               break;
            default:
               _loc2_ = 150;
               _vec[8].x = _loc2_;
               _loc2_ = _loc2_;
               _vec[4].x = _loc2_;
               _vec[0].x = _loc2_;
               _loc2_ = 228;
               _vec[9].x = _loc2_;
               _loc2_ = _loc2_;
               _vec[5].x = _loc2_;
               _vec[1].x = _loc2_;
               _loc2_ = 261;
               _vec[10].x = _loc2_;
               _loc2_ = _loc2_;
               _vec[6].x = _loc2_;
               _vec[2].x = _loc2_;
               _loc2_ = 339;
               _vec[11].x = _loc2_;
               _loc2_ = _loc2_;
               _vec[7].x = _loc2_;
               _vec[3].x = _loc2_;
               _loc2_ = 21;
               _vec[3].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[2].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[1].y = _loc2_;
               _vec[0].y = _loc2_;
               _loc2_ = 42;
               _vec[7].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[6].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[5].y = _loc2_;
               _vec[4].y = _loc2_;
               _loc2_ = 63;
               _vec[11].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[10].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[9].y = _loc2_;
               _vec[8].y = _loc2_;
               break;
            case 12:
               _loc2_ = 150;
               _vec[12].x = _loc2_;
               _loc2_ = _loc2_;
               _vec[8].x = _loc2_;
               _loc2_ = _loc2_;
               _vec[4].x = _loc2_;
               _vec[0].x = _loc2_;
               _loc2_ = 228;
               _vec[13].x = _loc2_;
               _loc2_ = _loc2_;
               _vec[9].x = _loc2_;
               _loc2_ = _loc2_;
               _vec[5].x = _loc2_;
               _vec[1].x = _loc2_;
               _loc2_ = 261;
               _vec[10].x = _loc2_;
               _loc2_ = _loc2_;
               _vec[6].x = _loc2_;
               _vec[2].x = _loc2_;
               _loc2_ = 339;
               _vec[11].x = _loc2_;
               _loc2_ = _loc2_;
               _vec[7].x = _loc2_;
               _vec[3].x = _loc2_;
               _loc2_ = 12;
               _vec[3].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[2].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[1].y = _loc2_;
               _vec[0].y = _loc2_;
               _loc2_ = 32;
               _vec[7].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[6].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[5].y = _loc2_;
               _vec[4].y = _loc2_;
               _loc2_ = 52;
               _vec[11].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[10].y = _loc2_;
               _loc2_ = _loc2_;
               _vec[9].y = _loc2_;
               _vec[8].y = _loc2_;
               _loc2_ = 72;
               _vec[13].y = _loc2_;
               _vec[12].y = _loc2_;
         }
         _loc1_ = 0;
         while(_loc1_ < _vec.length)
         {
            addChild(_vec[_loc1_]);
            _loc1_++;
         }
      }
      
      public function dispose() : void
      {
         if(_itemBg)
         {
            ObjectUtils.disposeObject(_itemBg);
            _itemBg = null;
         }
         if(_hp)
         {
            ObjectUtils.disposeObject(_hp);
            _hp = null;
         }
         if(_armor)
         {
            ObjectUtils.disposeObject(_armor);
            _armor = null;
         }
         if(_damage)
         {
            ObjectUtils.disposeObject(_damage);
            _damage = null;
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
         if(_agility)
         {
            ObjectUtils.disposeObject(_agility);
            _agility = null;
         }
         if(_lucky)
         {
            ObjectUtils.disposeObject(_lucky);
            _lucky = null;
         }
         if(_hpValue)
         {
            ObjectUtils.disposeObject(_hpValue);
            _hpValue = null;
         }
         if(_armorValue)
         {
            ObjectUtils.disposeObject(_armorValue);
            _armorValue = null;
         }
         if(_damageValue)
         {
            ObjectUtils.disposeObject(_damageValue);
            _damageValue = null;
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
         if(_agilityValue)
         {
            ObjectUtils.disposeObject(_agilityValue);
            _agilityValue = null;
         }
         if(_luckyValue)
         {
            ObjectUtils.disposeObject(_luckyValue);
            _luckyValue = null;
         }
      }
   }
}
