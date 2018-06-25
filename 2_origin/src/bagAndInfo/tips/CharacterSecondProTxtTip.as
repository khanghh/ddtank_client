package bagAndInfo.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   
   public class CharacterSecondProTxtTip extends CharacterPropTxtTip
   {
       
      
      private var _line1:Image;
      
      private var _line2:Image;
      
      public function CharacterSecondProTxtTip()
      {
         super();
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_line1)
         {
            addChild(_line1);
         }
         if(_line2)
         {
            addChild(_line2);
         }
      }
      
      override protected function init() : void
      {
         super.init();
         property_txt = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.bag.secondProTips.titleName");
         _line1 = ComponentFactory.Instance.creatComponentByStylename("HRuleAsset");
         addChild(_line1);
         detail_txt = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.bag.secondProTips.desc");
         _line2 = ComponentFactory.Instance.creatComponentByStylename("HRuleAsset");
         addChild(_line2);
         _propertySourceTxt = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.bag.secondProTips.conten");
      }
      
      override protected function propertySourceText(value:String) : void
      {
         _propertySourceTxt.htmlText = value;
         updateWH();
      }
      
      override protected function updateWH(bool:Boolean = false) : void
      {
         if(!_propertySourceTxt)
         {
            return;
         }
         _line1.y = property_txt.y + property_txt.textHeight + 10;
         _propertySourceTxt.y = _line1.y + 10;
         _line2.y = _propertySourceTxt.y + _propertySourceTxt.textHeight + 10;
         detail_txt.y = _line2.y + 10;
         if(detail_txt.y + detail_txt.height >= _oriH)
         {
            _bg.height = detail_txt.y + detail_txt.height + 8;
         }
         else
         {
            _bg.height = _oriH;
         }
         _height = _bg.height;
      }
      
      override protected function updateWidth() : void
      {
         super.updateWidth();
         if(_line1 && _line2)
         {
            var _loc1_:* = _width;
            _line2.width = _loc1_;
            _line1.width = _loc1_;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeObject(_line1);
         _line1 = null;
         ObjectUtils.disposeObject(_line2);
         _line2 = null;
      }
   }
}
