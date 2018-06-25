package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   
   public class DreamLandBuffTip extends BaseTip
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _container:Sprite;
      
      private var _splitImg:ScaleBitmapImage;
      
      private var _splitImg2:ScaleBitmapImage;
      
      private var _titleTxt:FilterFrameText;
      
      private var _shelterTxt:FilterFrameText;
      
      private var _powerTxt:FilterFrameText;
      
      private var _shelterBuffCount:FilterFrameText;
      
      private var _powerBuffCount:FilterFrameText;
      
      private var _shelterProNameTxt:FilterFrameText;
      
      private var _shelterProValueTxt:FilterFrameText;
      
      private var _powerProNameTxt:FilterFrameText;
      
      private var _powerProValueTxt:FilterFrameText;
      
      private var _descTxt:FilterFrameText;
      
      private var _tempData;
      
      private var LEADING:int = 5;
      
      public function DreamLandBuffTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         _bg = ComponentFactory.Instance.creat("core.GoodsTipBg");
         _splitImg = ComponentFactory.Instance.creatComponentByStylename("petTips.line");
         _splitImg2 = ComponentFactory.Instance.creatComponentByStylename("petTips.line");
         _titleTxt = ComponentFactory.Instance.creat("dreamland.buffTip.titleName");
         _titleTxt.text = LanguageMgr.GetTranslation("ddt.reamLand.challenge.buffTips.titleTxt");
         _shelterTxt = ComponentFactory.Instance.creat("dreamland.buffTip.buffName");
         _shelterTxt.text = LanguageMgr.GetTranslation("ddt.reamLand.challenge.buffTips.shelterName");
         _powerTxt = ComponentFactory.Instance.creat("dreamland.buffTip.buffName");
         _powerTxt.text = LanguageMgr.GetTranslation("ddt.reamLand.challenge.buffTips.powerName");
         _shelterBuffCount = ComponentFactory.Instance.creat("dreamland.buffTip.buffCount");
         _powerBuffCount = ComponentFactory.Instance.creat("dreamland.buffTip.buffCount");
         _shelterProNameTxt = ComponentFactory.Instance.creat("dreamland.buffTip.buffProName");
         _shelterProNameTxt.htmlText = LanguageMgr.GetTranslation("ddt.reamLand.challenge.buffTips.shelterProName");
         _shelterProValueTxt = ComponentFactory.Instance.creat("dreamland.buffTip.buffProValue");
         _powerProNameTxt = ComponentFactory.Instance.creat("dreamland.buffTip.buffProName");
         _powerProNameTxt.htmlText = LanguageMgr.GetTranslation("ddt.reamLand.challenge.buffTips.powerProName");
         _powerProValueTxt = ComponentFactory.Instance.creat("dreamland.buffTip.buffProValue");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("dreamland.buffTip.buffDesc");
         _descTxt.htmlText = LanguageMgr.GetTranslation("ddt.reamLand.challenge.buffTips.desc");
         _container = new Sprite();
         _container.addChild(_titleTxt);
         _container.addChild(_splitImg);
         _container.addChild(_shelterTxt);
         _container.addChild(_shelterBuffCount);
         _container.addChild(_shelterProNameTxt);
         _container.addChild(_shelterProValueTxt);
         _container.addChild(_splitImg2);
         _container.addChild(_powerTxt);
         _container.addChild(_powerBuffCount);
         _container.addChild(_powerProNameTxt);
         _container.addChild(_powerProValueTxt);
         _container.addChild(_splitImg2);
         _container.addChild(_descTxt);
         super.init();
         this.tipbackgound = _bg;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         addChild(_container);
         this.mouseChildren = false;
         this.mouseEnabled = false;
      }
      
      override public function get tipData() : Object
      {
         return _tempData;
      }
      
      override public function set tipData(data:Object) : void
      {
         updateView();
      }
      
      private function updateView() : void
      {
         _shelterBuffCount.text = "(1/8)";
         _powerBuffCount.text = "(2/3)";
         _shelterProValueTxt.htmlText = "20\n30\n30";
         _powerProValueTxt.htmlText = "30\n10\n20";
         fixPos();
         _bg.width = _container.width + 15;
         _bg.height = _container.height + 15;
         _width = _bg.width;
         _height = _bg.height;
      }
      
      private function fixPos() : void
      {
         _splitImg.y = _titleTxt.y + _titleTxt.height + LEADING;
         _shelterTxt.x = _titleTxt.x;
         _shelterTxt.y = _splitImg.y + LEADING;
         _shelterBuffCount.x = _shelterTxt.x + _shelterTxt.width;
         _shelterBuffCount.y = _shelterTxt.y;
         _shelterProNameTxt.x = _shelterBuffCount.x + _shelterBuffCount.width + LEADING;
         _shelterProNameTxt.y = _shelterTxt.y;
         _shelterProValueTxt.x = _shelterProNameTxt.x + _shelterProNameTxt.width;
         _shelterProValueTxt.y = _shelterTxt.y;
         _powerTxt.x = _titleTxt.x;
         _powerTxt.y = _shelterProNameTxt.y + _shelterProNameTxt.height + LEADING * 2;
         _powerBuffCount.x = _powerTxt.x + _powerTxt.width;
         _powerBuffCount.y = _powerTxt.y;
         _powerProNameTxt.x = _powerBuffCount.x + _powerBuffCount.width + LEADING;
         _powerProNameTxt.y = _powerTxt.y;
         _powerProValueTxt.x = _powerProNameTxt.x + _powerProNameTxt.width;
         _powerProValueTxt.y = _powerTxt.y;
         _splitImg2.y = _powerProNameTxt.y + _powerProNameTxt.height + LEADING * 2;
         _descTxt.x = _titleTxt.x;
         _descTxt.y = _splitImg2.y + LEADING * 2;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeAllChildren(_container);
         _container = null;
         _bg = null;
         _splitImg = null;
         _titleTxt = null;
         _splitImg2 = null;
      }
   }
}
