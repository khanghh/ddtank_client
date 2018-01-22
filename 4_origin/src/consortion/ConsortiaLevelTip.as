package consortion
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   
   public class ConsortiaLevelTip extends BaseTip
   {
       
      
      private var _tempData:Vector.<String>;
      
      private var _bg:ScaleBitmapImage;
      
      private var _explainText:FilterFrameText;
      
      private var _explainText2:FilterFrameText;
      
      private var _nextLevelText:FilterFrameText;
      
      private var _nextLevelText2:FilterFrameText;
      
      private var _requirementsText:FilterFrameText;
      
      private var _requirementsText2:FilterFrameText;
      
      private var _consumptionText:FilterFrameText;
      
      private var _consumptionText2:FilterFrameText;
      
      private var _explain:String;
      
      private var _nextLevel:String;
      
      private var _requirements:String;
      
      private var _consumption:String;
      
      public function ConsortiaLevelTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         _bg = ComponentFactory.Instance.creat("core.GoodsTipBg");
         _explainText = ComponentFactory.Instance.creatComponentByStylename("consortia.tipText1");
         _explainText2 = ComponentFactory.Instance.creatComponentByStylename("consortia.tipText2");
         _nextLevelText = ComponentFactory.Instance.creatComponentByStylename("consortia.tipText1");
         _nextLevelText2 = ComponentFactory.Instance.creatComponentByStylename("consortia.tipText2");
         _requirementsText = ComponentFactory.Instance.creatComponentByStylename("consortia.tipText1");
         _requirementsText2 = ComponentFactory.Instance.creatComponentByStylename("consortia.tipText2");
         _consumptionText = ComponentFactory.Instance.creatComponentByStylename("consortia.tipText1");
         _consumptionText2 = ComponentFactory.Instance.creatComponentByStylename("consortia.tipText2");
         _explainText.text = LanguageMgr.GetTranslation("ddt.consortion.levelTip.explain");
         _nextLevelText.text = LanguageMgr.GetTranslation("ddt.consortion.levelTip.nextLevel");
         _requirementsText.text = LanguageMgr.GetTranslation("ddt.consortion.levelTip.requirements");
         _consumptionText.text = LanguageMgr.GetTranslation("ddt.consortion.levelTip.consumption");
         this.tipbackgound = _bg;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         mouseChildren = false;
         mouseEnabled = false;
         addChild(_explainText);
         addChild(_explainText2);
         addChild(_nextLevelText);
         addChild(_nextLevelText2);
         addChild(_requirementsText);
         addChild(_requirementsText2);
         addChild(_consumptionText);
         addChild(_consumptionText2);
      }
      
      override public function get tipData() : Object
      {
         return _tempData;
      }
      
      override public function set tipData(param1:Object) : void
      {
         _tempData = param1 as Vector.<String>;
         _explainText2.text = param1[0] == null?"":param1[0];
         var _loc2_:* = _explainText2.y + _explainText2.textHeight + 5;
         _nextLevelText2.y = _loc2_;
         _nextLevelText.y = _loc2_;
         _nextLevelText2.text = param1[1] == null?"":param1[1];
         _loc2_ = _nextLevelText2.y + _nextLevelText2.textHeight + 5;
         _requirementsText2.y = _loc2_;
         _requirementsText.y = _loc2_;
         _requirementsText2.htmlText = param1[2] == null?"":param1[2];
         _loc2_ = _requirementsText2.y + _requirementsText2.textHeight + 5;
         _consumptionText2.y = _loc2_;
         _consumptionText.y = _loc2_;
         _consumptionText2.htmlText = param1[3] == null?"":param1[3];
         drawBG();
      }
      
      private function reset() : void
      {
         _bg.height = 0;
         _bg.width = 0;
      }
      
      private function drawBG(param1:int = 0) : void
      {
         reset();
         _bg.width = 286;
         _bg.height = _consumptionText2.y + _consumptionText2.textHeight + 10;
         _width = _bg.width;
         _height = _bg.height;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
         _tempData = null;
         _bg = null;
         _explainText = null;
         _explainText2 = null;
         _nextLevelText = null;
         _nextLevelText2 = null;
         _requirementsText = null;
         _requirementsText2 = null;
         _consumptionText = null;
         _consumptionText2 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
