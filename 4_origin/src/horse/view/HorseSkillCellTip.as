package horse.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   import horse.data.HorseSkillVo;
   
   public class HorseSkillCellTip extends BaseTip
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _consumeTitleTxt:FilterFrameText;
      
      private var _consumeContentTxt:FilterFrameText;
      
      private var _descTitleTxt:FilterFrameText;
      
      private var _descContentTxt:FilterFrameText;
      
      private var _coolDownTxt:FilterFrameText;
      
      private var _lineImg:ScaleBitmapImage;
      
      private var _lineImg2:ScaleBitmapImage;
      
      private var _container:Sprite;
      
      private var _tipInfo:HorseSkillVo;
      
      private var LEADING:int = 5;
      
      public function HorseSkillCellTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipBg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("horse.skillCellTip.nameTxt");
         _consumeTitleTxt = ComponentFactory.Instance.creatComponentByStylename("horse.skillCellTip.titleTxt");
         _consumeTitleTxt.text = LanguageMgr.GetTranslation("ddt.pets.skillTipLost");
         _consumeContentTxt = ComponentFactory.Instance.creatComponentByStylename("horse.skillCellTip.contentTxt");
         _descTitleTxt = ComponentFactory.Instance.creatComponentByStylename("horse.skillCellTip.titleTxt");
         _descTitleTxt.text = LanguageMgr.GetTranslation("ddt.pets.skillTipDesc");
         _descContentTxt = ComponentFactory.Instance.creatComponentByStylename("horse.skillCellTip.contentTxt");
         _coolDownTxt = ComponentFactory.Instance.creatComponentByStylename("horse.skillCellTip.coolDownTxt");
         _lineImg = ComponentFactory.Instance.creatComponentByStylename("horse.skillCellTip.line");
         _lineImg2 = ComponentFactory.Instance.creatComponentByStylename("horse.skillCellTip.line");
         _container = new Sprite();
         _container.addChild(_nameTxt);
         _container.addChild(_consumeTitleTxt);
         _container.addChild(_consumeContentTxt);
         _container.addChild(_descTitleTxt);
         _container.addChild(_descContentTxt);
         _container.addChild(_coolDownTxt);
         _container.addChild(_lineImg);
         _container.addChild(_lineImg2);
         super.init();
         this.tipbackgound = _bg;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         addChild(_container);
      }
      
      override public function get tipData() : Object
      {
         return _tipInfo;
      }
      
      override public function set tipData(data:Object) : void
      {
         _tipInfo = data as HorseSkillVo;
         updateView();
      }
      
      private function updateView() : void
      {
         _nameTxt.text = _tipInfo.Name;
         _consumeContentTxt.text = _tipInfo.CostEnergy + LanguageMgr.GetTranslation("energy");
         _descContentTxt.text = _tipInfo.Description;
         _coolDownTxt.text = LanguageMgr.GetTranslation("tank.game.actions.cooldown") + ": " + _tipInfo.ColdDown + LanguageMgr.GetTranslation("tank.game.actions.turn");
         fixPos();
         _bg.width = _container.width + 15;
         _bg.height = _container.height + 15;
         _width = _bg.width;
         _height = _bg.height;
      }
      
      private function fixPos() : void
      {
         _lineImg.y = _nameTxt.y + _nameTxt.textHeight + LEADING;
         _consumeTitleTxt.y = _lineImg.y + _lineImg.height + LEADING;
         _consumeTitleTxt.x = _nameTxt.x;
         _consumeContentTxt.x = _consumeTitleTxt.x + _consumeTitleTxt.textWidth + LEADING;
         _consumeContentTxt.y = _consumeTitleTxt.y;
         _descTitleTxt.x = _nameTxt.x;
         _descTitleTxt.y = _consumeContentTxt.y + _consumeContentTxt.textHeight + LEADING;
         _descContentTxt.x = _descTitleTxt.x + _descTitleTxt.textWidth + LEADING;
         _descContentTxt.y = _descTitleTxt.y;
         _lineImg2.y = _descContentTxt.y + _descContentTxt.textHeight + LEADING * 2;
         _coolDownTxt.x = _nameTxt.x;
         _coolDownTxt.y = _lineImg2.y + _lineImg2.height + LEADING;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(_container);
         ObjectUtils.disposeObject(_container);
         _bg = null;
         _nameTxt = null;
         _consumeTitleTxt = null;
         _consumeContentTxt = null;
         _descTitleTxt = null;
         _descContentTxt = null;
         _coolDownTxt = null;
         _lineImg = null;
         _lineImg2 = null;
         _container = null;
         _tipInfo = null;
         super.dispose();
      }
   }
}
