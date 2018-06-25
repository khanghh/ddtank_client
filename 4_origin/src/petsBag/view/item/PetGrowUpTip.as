package petsBag.view.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.analyze.PetconfigAnalyzer;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   import pet.data.PetInfo;
   import petsBag.PetsBagManager;
   
   public class PetGrowUpTip extends BaseTip
   {
       
      
      private var _name:FilterFrameText;
      
      protected var _attackLbl:FilterFrameText;
      
      protected var _attackTxt:FilterFrameText;
      
      protected var _defenceLbl:FilterFrameText;
      
      protected var _defenceTxt:FilterFrameText;
      
      protected var _HPLbl:FilterFrameText;
      
      protected var _HPTxt:FilterFrameText;
      
      protected var _agilitykLbl:FilterFrameText;
      
      protected var _agilityTxt:FilterFrameText;
      
      protected var _luckLbl:FilterFrameText;
      
      protected var _luckTxt:FilterFrameText;
      
      private var _splitImg:ScaleBitmapImage;
      
      protected var _bg:ScaleBitmapImage;
      
      private var _container:Sprite;
      
      private var _info:PetInfo;
      
      private var _gradeImg:ScaleFrameImage;
      
      private var LEADING:int = 5;
      
      public function PetGrowUpTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         _name = ComponentFactory.Instance.creat("petbags.text.petName");
         _name.text = LanguageMgr.GetTranslation("ddt.petbags.text.petGrowUptipTitleName");
         _gradeImg = ComponentFactory.Instance.creatComponentByStylename("petsBag.washBone.petGrade");
         _gradeImg.setFrame(1);
         _attackLbl = ComponentFactory.Instance.creat("petbags.text.petGrowUpTipName");
         _attackLbl.text = LanguageMgr.GetTranslation("attack") + ":";
         _attackTxt = ComponentFactory.Instance.creat("petbags.text.petGrowUpTipValue");
         _defenceLbl = ComponentFactory.Instance.creat("petbags.text.petGrowUpTipName");
         _defenceLbl.text = LanguageMgr.GetTranslation("defence") + ":";
         _defenceTxt = ComponentFactory.Instance.creat("petbags.text.petGrowUpTipValue");
         _HPLbl = ComponentFactory.Instance.creat("petbags.text.petGrowUpTipName");
         _HPLbl.text = LanguageMgr.GetTranslation("MaxHp") + ":";
         _HPTxt = ComponentFactory.Instance.creat("petbags.text.petGrowUpTipValue");
         _agilitykLbl = ComponentFactory.Instance.creat("petbags.text.petGrowUpTipName");
         _agilitykLbl.text = LanguageMgr.GetTranslation("agility") + ":";
         _agilityTxt = ComponentFactory.Instance.creat("petbags.text.petGrowUpTipValue");
         _luckLbl = ComponentFactory.Instance.creat("petbags.text.petGrowUpTipName");
         _luckLbl.text = LanguageMgr.GetTranslation("luck") + ":";
         _luckTxt = ComponentFactory.Instance.creat("petbags.text.petGrowUpTipValue");
         _bg = ComponentFactory.Instance.creat("core.GoodsTipBg");
         _splitImg = ComponentFactory.Instance.creatComponentByStylename("petGrowUpTips.line");
         _container = new Sprite();
         _container.addChild(_name);
         _container.addChild(_gradeImg);
         _container.addChild(_attackLbl);
         _container.addChild(_attackTxt);
         _container.addChild(_defenceLbl);
         _container.addChild(_defenceTxt);
         _container.addChild(_HPLbl);
         _container.addChild(_HPTxt);
         _container.addChild(_agilitykLbl);
         _container.addChild(_agilityTxt);
         _container.addChild(_luckLbl);
         _container.addChild(_luckTxt);
         _container.addChild(_splitImg);
         super.init();
         this.tipbackgound = _bg;
      }
      
      private function fixPos() : void
      {
         _gradeImg.x = _name.x + _name.textWidth + LEADING * 2;
         _gradeImg.y = 2;
         _splitImg.y = _name.y + _name.textHeight + LEADING * 1.5;
         _HPLbl.y = _splitImg.y + _splitImg.height + LEADING;
         _HPTxt.y = _HPLbl.y;
         _HPTxt.x = _HPLbl.x + _HPLbl.textWidth + LEADING;
         _attackLbl.y = _HPLbl.y + _HPLbl.textHeight + LEADING;
         _attackTxt.x = _attackLbl.x + _attackLbl.textWidth + LEADING;
         _attackTxt.y = _attackLbl.y;
         _defenceLbl.y = _attackLbl.y + _agilitykLbl.textHeight + LEADING;
         _defenceTxt.y = _defenceLbl.y;
         _defenceTxt.x = _defenceLbl.x + _defenceLbl.textWidth + LEADING;
         _agilitykLbl.y = _defenceLbl.y + _defenceLbl.textHeight + LEADING;
         _agilityTxt.y = _agilitykLbl.y;
         _agilityTxt.x = _agilitykLbl.x + _agilitykLbl.textWidth + LEADING;
         _luckLbl.y = _agilitykLbl.y + _agilitykLbl.textHeight + LEADING;
         _luckTxt.y = _luckLbl.y;
         _luckTxt.x = _luckLbl.x + _luckLbl.textWidth + LEADING;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         addChild(_container);
         _container.mouseEnabled = false;
         _container.mouseChildren = false;
         this.mouseChildren = false;
         this.mouseEnabled = false;
      }
      
      override public function get tipData() : Object
      {
         return _info;
      }
      
      override public function set tipData(data:Object) : void
      {
         _info = data as PetInfo;
         if(_info)
         {
            updateView();
         }
      }
      
      private function updateView() : void
      {
         var propertiesRate:Number = PetconfigAnalyzer.PetCofnig.PropertiesRate;
         var attackRate:Number = _info.AttackGrow / propertiesRate;
         _attackTxt.text = _info.Attack > 0?"(" + attackRate.toFixed(2) + ")":"";
         var defenceRate:Number = _info.DefenceGrow / propertiesRate;
         _defenceTxt.text = _info.Defence > 0?"(" + defenceRate.toFixed(2) + ")":"";
         var agilityRate:Number = _info.AgilityGrow / propertiesRate;
         _agilityTxt.text = _info.Agility > 0?"(" + agilityRate.toFixed(2) + ")":"";
         _HPTxt.text = _info.Blood > 0?"(" + (_info.BloodGrow / propertiesRate).toFixed(2) + ")":"";
         var luckRate:Number = _info.LuckGrow / propertiesRate;
         _luckTxt.text = _info.Luck > 0?"(" + luckRate.toFixed(2) + ")":"";
         fixPos();
         _bg.width = _container.width + 15;
         _bg.height = _container.height + 20;
         _width = _bg.width;
         _height = _bg.height;
         if(_info == null)
         {
            return;
         }
         var index:int = PetsBagManager.instance().getPetQualityIndex(_info.petGraded);
         _gradeImg.setFrame(index + 1);
         var attackIndex:int = getProDatumIndex(_info.AttackGrowDatum) + 1;
         _attackLbl.setFrame(attackIndex);
         _attackTxt.setFrame(attackIndex);
         var defenceIndex:int = getProDatumIndex(_info.DefenceGrowDatum) + 1;
         _defenceLbl.setFrame(defenceIndex);
         _defenceTxt.setFrame(defenceIndex);
         var agilityIndex:int = getProDatumIndex(_info.AgilityGrowDatum) + 1;
         _agilitykLbl.setFrame(agilityIndex);
         _agilityTxt.setFrame(agilityIndex);
         var hpIndex:int = getProDatumIndex(_info.BloodGrowDatum) + 1;
         _HPLbl.setFrame(hpIndex);
         _HPTxt.setFrame(hpIndex);
         var luckIndex:int = getProDatumIndex(_info.LuckGrowDatum) + 1;
         _luckLbl.setFrame(luckIndex);
         _luckTxt.setFrame(luckIndex);
      }
      
      private function getProDatumIndex(datumValue:int) : int
      {
         var index:int = PetsBagManager.instance().getPetQualityIndex(datumValue);
         return index;
      }
      
      override public function dispose() : void
      {
         _info = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_luckTxt)
         {
            ObjectUtils.disposeObject(_luckTxt);
            _luckTxt = null;
         }
         if(_splitImg)
         {
            ObjectUtils.disposeObject(_splitImg);
            _splitImg = null;
         }
         if(_container)
         {
            ObjectUtils.disposeObject(_container);
            _container = null;
         }
         if(_luckLbl)
         {
            ObjectUtils.disposeObject(_luckLbl);
            _luckLbl = null;
         }
         if(_agilityTxt)
         {
            ObjectUtils.disposeObject(_agilityTxt);
            _agilityTxt = null;
         }
         if(_agilitykLbl)
         {
            ObjectUtils.disposeObject(_agilitykLbl);
            _agilitykLbl = null;
         }
         if(_HPLbl)
         {
            ObjectUtils.disposeObject(_HPLbl);
            _HPLbl = null;
         }
         if(_HPTxt)
         {
            ObjectUtils.disposeObject(_HPTxt);
            _HPTxt = null;
         }
         if(_defenceTxt)
         {
            ObjectUtils.disposeObject(_defenceTxt);
            _defenceTxt = null;
         }
         if(_defenceLbl)
         {
            ObjectUtils.disposeObject(_defenceLbl);
            _defenceLbl = null;
         }
         if(_attackTxt)
         {
            ObjectUtils.disposeObject(_attackTxt);
            _attackTxt = null;
         }
         if(_attackLbl)
         {
            ObjectUtils.disposeObject(_attackLbl);
            _attackLbl = null;
         }
         if(_name)
         {
            ObjectUtils.disposeObject(_name);
            _name = null;
         }
         ObjectUtils.disposeObject(_gradeImg);
         _gradeImg = null;
         super.dispose();
      }
   }
}
