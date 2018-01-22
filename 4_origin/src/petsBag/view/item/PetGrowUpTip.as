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
      
      private var LEADING:int = 5;
      
      public function PetGrowUpTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         _name = ComponentFactory.Instance.creat("petbags.text.petName");
         _name.text = LanguageMgr.GetTranslation("ddt.petbags.text.petGrowUptipTitleName");
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
      
      override public function set tipData(param1:Object) : void
      {
         _info = param1 as PetInfo;
         if(_info)
         {
            updateView();
         }
      }
      
      private function updateView() : void
      {
         var _loc5_:Number = PetconfigAnalyzer.PetCofnig.PropertiesRate;
         var _loc2_:Number = _info.AttackGrow / _loc5_;
         _attackTxt.text = _info.Attack > 0?"(" + _loc2_.toFixed(1) + ")":"";
         var _loc4_:Number = _info.DefenceGrow / _loc5_;
         _defenceTxt.text = _info.Defence > 0?"(" + _loc4_.toFixed(1) + ")":"";
         var _loc3_:Number = _info.AgilityGrow / _loc5_;
         _agilityTxt.text = _info.Agility > 0?"(" + _loc3_.toFixed(1) + ")":"";
         _HPTxt.text = _info.Blood > 0?"(" + (_info.BloodGrow / _loc5_).toFixed(1) + ")":"";
         var _loc1_:Number = _info.LuckGrow / _loc5_;
         _luckTxt.text = _info.Luck > 0?"(" + _loc1_.toFixed(1) + ")":"";
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
         super.dispose();
      }
   }
}
