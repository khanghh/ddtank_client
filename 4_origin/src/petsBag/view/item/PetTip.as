package petsBag.view.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.analyze.PetconfigAnalyzer;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   import pet.data.PetInfo;
   
   public class PetTip extends BaseTip
   {
       
      
      private var _name:FilterFrameText;
      
      private var _descTxt:FilterFrameText;
      
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
      
      private var _splitImg2:ScaleBitmapImage;
      
      protected var _bg:ScaleBitmapImage;
      
      private var _container:Sprite;
      
      private var _info:PetInfo;
      
      private var LEADING:int = 5;
      
      public function PetTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         _name = ComponentFactory.Instance.creat("farm.text.PetName");
         _attackLbl = ComponentFactory.Instance.creat("farm.text.petTipName");
         _attackLbl.text = LanguageMgr.GetTranslation("attack") + ":";
         _attackTxt = ComponentFactory.Instance.creat("farm.text.petTipValue");
         _defenceLbl = ComponentFactory.Instance.creat("farm.text.petTipName");
         _defenceLbl.text = LanguageMgr.GetTranslation("defence") + ":";
         _defenceTxt = ComponentFactory.Instance.creat("farm.text.petTipValue");
         _HPLbl = ComponentFactory.Instance.creat("farm.text.petTipName");
         _HPLbl.text = LanguageMgr.GetTranslation("MaxHp") + ":";
         _HPTxt = ComponentFactory.Instance.creat("farm.text.petTipValue");
         _agilitykLbl = ComponentFactory.Instance.creat("farm.text.petTipName");
         _agilitykLbl.text = LanguageMgr.GetTranslation("agility") + ":";
         _agilityTxt = ComponentFactory.Instance.creat("farm.text.petTipValue");
         _luckLbl = ComponentFactory.Instance.creat("farm.text.petTipName");
         _luckLbl.text = LanguageMgr.GetTranslation("luck") + ":";
         _luckTxt = ComponentFactory.Instance.creat("farm.text.petTipValue");
         _descTxt = ComponentFactory.Instance.creat("farm.text.petDesc");
         _bg = ComponentFactory.Instance.creat("core.GoodsTipBg");
         _splitImg = ComponentFactory.Instance.creatComponentByStylename("petTips.line");
         _splitImg2 = ComponentFactory.Instance.creatComponentByStylename("petTips.line");
         _container = new Sprite();
         _container.addChild(_name);
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
         _container.addChild(_descTxt);
         _container.addChild(_splitImg);
         _container.addChild(_splitImg2);
         super.init();
         this.tipbackgound = _bg;
      }
      
      private function fixPos() : void
      {
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
         _splitImg2.y = _luckTxt.y + _luckTxt.textHeight + LEADING * 1.5;
         _descTxt.y = _splitImg2.y + _splitImg2.height + LEADING * 1.5;
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
         updateView();
      }
      
      private function updateView() : void
      {
         var growthText:String = LanguageMgr.GetTranslation("ddt.pets.growthText");
         _name.text = String(_info.Name);
         _attackTxt.text = _info.Attack > 0?String(_info.Attack) + "(" + growthText + (_info.AttackGrow / PetconfigAnalyzer.PetCofnig.PropertiesRate).toFixed(1) + ")":"";
         _defenceTxt.text = _info.Defence > 0?String(_info.Defence) + "(" + growthText + (_info.DefenceGrow / PetconfigAnalyzer.PetCofnig.PropertiesRate).toFixed(1) + ")":"";
         _agilityTxt.text = _info.Agility > 0?String(_info.Agility) + "(" + growthText + (_info.AgilityGrow / PetconfigAnalyzer.PetCofnig.PropertiesRate).toFixed(1) + ")":"";
         _HPTxt.text = _info.Blood > 0?String(_info.Blood) + "(" + growthText + (_info.BloodGrow / PetconfigAnalyzer.PetCofnig.PropertiesRate).toFixed(1) + ")":"";
         _luckTxt.text = _info.Luck > 0?String(_info.Luck) + "(" + growthText + (_info.LuckGrow / PetconfigAnalyzer.PetCofnig.PropertiesRate).toFixed(1) + ")":"";
         _descTxt.text = String(_info.Description);
         if(_HPTxt.textWidth > _HPTxt.width)
         {
            _HPTxt.width = _HPTxt.textWidth;
            _container.width = _container.width + 10;
         }
         fixPos();
         _bg.width = _container.width + 10;
         _bg.height = _container.height + 20;
         _width = _bg.width;
         _height = _bg.height;
      }
      
      override public function dispose() : void
      {
         _info = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_splitImg2)
         {
            ObjectUtils.disposeObject(_splitImg2);
            _splitImg2 = null;
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
         if(_descTxt)
         {
            ObjectUtils.disposeObject(_descTxt);
            _descTxt = null;
         }
         if(_name)
         {
            ObjectUtils.disposeObject(_name);
            _name = null;
         }
         super.dispose();
      }
   }
}
