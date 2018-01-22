package bagAndInfo.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   
   public class CallPropTxtTip extends BaseTip
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _tempData:Object;
      
      private var _oriW:int;
      
      private var _oriH:int;
      
      private var _attack:FilterFrameText;
      
      private var _attackValue:FilterFrameText;
      
      private var _defense:FilterFrameText;
      
      private var _defenseValue:FilterFrameText;
      
      private var _agility:FilterFrameText;
      
      private var _agilityValue:FilterFrameText;
      
      private var _lucky:FilterFrameText;
      
      private var _luckyValue:FilterFrameText;
      
      private var _validDate:FilterFrameText;
      
      private var _validDateValue:FilterFrameText;
      
      public var lukAdd:int = 0;
      
      public function CallPropTxtTip()
      {
         super();
         visible = false;
      }
      
      override protected function init() : void
      {
         visible = false;
         mouseChildren = false;
         mouseEnabled = false;
         super.init();
         _bg = ComponentFactory.Instance.creat("core.GoodsTipBg");
         _attack = ComponentFactory.Instance.creatComponentByStylename("ddtbagandinfo.Calltip.ability");
         _defense = ComponentFactory.Instance.creatComponentByStylename("ddtbagandinfo.Calltip.ability");
         _agility = ComponentFactory.Instance.creatComponentByStylename("ddtbagandinfo.Calltip.ability");
         _lucky = ComponentFactory.Instance.creatComponentByStylename("ddtbagandinfo.Calltip.ability");
         _validDate = ComponentFactory.Instance.creatComponentByStylename("ddtbagandinfo.Calltip.ability");
         _validDate.visible = false;
         _attackValue = ComponentFactory.Instance.creatComponentByStylename("ddtbagandinfo.Calltip.ability");
         _defenseValue = ComponentFactory.Instance.creatComponentByStylename("ddtbagandinfo.Calltip.ability");
         _agilityValue = ComponentFactory.Instance.creatComponentByStylename("ddtbagandinfo.Calltip.ability");
         _luckyValue = ComponentFactory.Instance.creatComponentByStylename("ddtbagandinfo.Calltip.ability");
         _validDateValue = ComponentFactory.Instance.creatComponentByStylename("ddtbagandinfo.Calltip.ability");
         _validDateValue.visible = false;
         _attack.text = LanguageMgr.GetTranslation("ddt.GodSyah.tip.attack");
         _defense.text = LanguageMgr.GetTranslation("ddt.GodSyah.tip.defense");
         _agility.text = LanguageMgr.GetTranslation("ddt.GodSyah.tip.agility");
         _lucky.text = LanguageMgr.GetTranslation("ddt.GodSyah.tip.lucky");
         _validDate.text = LanguageMgr.GetTranslation("ddt.GodSyah.tip.validDate");
         _attackValue.text = "+999";
         _defenseValue.text = "+999";
         _agilityValue.text = "+999";
         _luckyValue.text = "+999";
         _validDateValue.text = "三个月";
         PositionUtils.setPos(_attack,"Call.tip.attack.Pos");
         PositionUtils.setPos(_defense,"Call.tip.defense.Pos");
         PositionUtils.setPos(_agility,"Call.tip.agility.Pos");
         PositionUtils.setPos(_lucky,"Call.tip.lucky.Pos");
         PositionUtils.setPos(_validDate,"Call.tip.validDate.Pos");
         PositionUtils.setPos(_attackValue,"Call.tip.attackValue.Pos");
         PositionUtils.setPos(_defenseValue,"Call.tip.defenseValue.Pos");
         PositionUtils.setPos(_agilityValue,"Call.tip.agilityValue.Pos");
         PositionUtils.setPos(_luckyValue,"Call.tip.luckyValue.Pos");
         PositionUtils.setPos(_validDateValue,"Call.tip.validDateValue.Pos");
         addChild(_attack);
         addChild(_defense);
         addChild(_agility);
         addChild(_lucky);
         addChild(_validDate);
         addChild(_attackValue);
         addChild(_defenseValue);
         addChild(_agilityValue);
         addChild(_luckyValue);
         addChild(_validDateValue);
         setBGWidth(150);
         setBGHeight(130);
         this.tipbackgound = _bg;
      }
      
      public function setBGWidth(param1:int = 0) : void
      {
         _bg.width = param1;
      }
      
      public function setBGHeight(param1:int = 0) : void
      {
         _bg.height = param1;
      }
      
      private function _buildTipInfo(param1:String) : void
      {
      }
      
      override public function set tipData(param1:Object) : void
      {
         visible = false;
         .super.tipData = param1;
         this.atcAddValueText(param1.Attack);
         this.defAddValueText(param1.Defend);
         this.agiAddValueText(param1.Agility);
         this.lukAddValueText(param1.Lucky);
         setBGWidth(150);
         setBGHeight(130);
         _validDate.visible = false;
         _validDateValue.visible = false;
         var _loc2_:int = param1.Attack + param1.Defend + param1.Agility + param1.Lucky;
         if(_loc2_ > 0)
         {
            visible = true;
         }
      }
      
      private function atcAddValueText(param1:int) : void
      {
         _attackValue.text = "+" + String(param1);
      }
      
      private function defAddValueText(param1:int) : void
      {
         _defenseValue.text = "+" + String(param1);
      }
      
      private function agiAddValueText(param1:int) : void
      {
         _agilityValue.text = "+" + String(param1);
      }
      
      private function lukAddValueText(param1:int) : void
      {
         _luckyValue.text = "+" + String(param1);
      }
      
      private function validDateValueText(param1:String) : void
      {
         _validDateValue.text = param1;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_attack)
         {
            addChild(_attack);
         }
         if(_defense)
         {
            addChild(_defense);
         }
         if(_agility)
         {
            addChild(_agility);
         }
         if(_lucky)
         {
            addChild(_lucky);
         }
         if(_validDate)
         {
            addChild(_validDate);
         }
         if(_attackValue)
         {
            addChild(_attackValue);
         }
         if(_defenseValue)
         {
            addChild(_defenseValue);
         }
         if(_agilityValue)
         {
            addChild(_agilityValue);
         }
         if(_luckyValue)
         {
            addChild(_luckyValue);
         }
         if(_validDateValue)
         {
            addChild(_validDateValue);
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
         if(_validDate)
         {
            ObjectUtils.disposeObject(_validDate);
            _validDate = null;
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
         if(_validDateValue)
         {
            ObjectUtils.disposeObject(_validDateValue);
            _validDateValue = null;
         }
      }
   }
}
