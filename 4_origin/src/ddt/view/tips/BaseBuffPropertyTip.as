package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   
   public class BaseBuffPropertyTip extends BaseTip
   {
       
      
      private var _titleTxt:FilterFrameText;
      
      protected var _conditionTxt:FilterFrameText;
      
      protected var _bg:ScaleBitmapImage;
      
      protected var _propertySpri:Sprite;
      
      protected var _propertyList:Vector.<FilterFrameText>;
      
      public function BaseBuffPropertyTip()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _bg = bg;
         _titleTxt = getTitle;
         _conditionTxt = conditionTxt;
         _propertySpri = new Sprite();
         _propertySpri.y = 45;
         _propertyList = new Vector.<FilterFrameText>();
         if(_bg)
         {
            addChild(_bg);
         }
         if(_titleTxt)
         {
            addChild(_titleTxt);
         }
         if(_conditionTxt)
         {
            addChild(_conditionTxt);
         }
         addChild(_propertySpri);
      }
      
      public function setBgWidth($width:int) : void
      {
         _bg.width = $width;
      }
      
      public function setBgHeight($height:int) : void
      {
         _bg.height = $height;
      }
      
      override public function set tipData(data:Object) : void
      {
         clearBuffProperty();
      }
      
      protected function getProName() : Array
      {
         return LanguageMgr.GetTranslation("ddt.totem.sevenProperty").split(",");
      }
      
      protected function get bg() : ScaleBitmapImage
      {
         return ComponentFactory.Instance.creatComponentByStylename("game.kingbless.scalebuffTipViewBg");
      }
      
      protected function get getTitle() : *
      {
         return ComponentFactory.Instance.creatComponentByStylename("game.kingbless.tipView.titleTxt");
      }
      
      public function set titleTxt(value:String) : void
      {
         if(_titleTxt)
         {
            _titleTxt.text = value;
         }
      }
      
      protected function get conditionTxt() : *
      {
         return ComponentFactory.Instance.creatComponentByStylename("game.kingbless.tipView.tipTxt");
      }
      
      protected function set conditionTxt(value:String) : void
      {
         if(_conditionTxt)
         {
            _conditionTxt.text = value;
         }
      }
      
      override public function get width() : Number
      {
         if(_bg)
         {
            return _bg.width;
         }
         return super.width;
      }
      
      override public function get height() : Number
      {
         if(_bg)
         {
            return _bg.height;
         }
         return super.height;
      }
      
      protected function clearBuffProperty() : void
      {
         if(_propertySpri)
         {
            ObjectUtils.disposeAllChildren(_propertySpri);
         }
      }
      
      override public function dispose() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_titleTxt)
         {
            ObjectUtils.disposeObject(_titleTxt);
         }
         _titleTxt = null;
         if(_conditionTxt)
         {
            ObjectUtils.disposeObject(_conditionTxt);
         }
         _conditionTxt = null;
         if(_propertySpri)
         {
            ObjectUtils.disposeAllChildren(_propertySpri);
            ObjectUtils.disposeObject(_propertySpri);
         }
         _propertySpri = null;
         super.dispose();
      }
   }
}
