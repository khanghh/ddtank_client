package bagAndInfo.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.view.tips.PropTxtTip;
   
   public class CharacterPropTxtTip extends PropTxtTip
   {
       
      
      protected var _propertySourceTxt:FilterFrameText;
      
      private var _vbox:VBox;
      
      public function CharacterPropTxtTip()
      {
         super();
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_propertySourceTxt)
         {
            addChild(_propertySourceTxt);
         }
      }
      
      override protected function init() : void
      {
         super.init();
         property_txt = ComponentFactory.Instance.creatComponentByStylename("core.CharacterPropertyTxt");
         detail_txt = ComponentFactory.Instance.creatComponentByStylename("core.CharacterPropertyDetailTxt");
         _propertySourceTxt = ComponentFactory.Instance.creatComponentByStylename("core.PropertySourceTxt");
      }
      
      override public function set tipData(data:Object) : void
      {
         .super.tipData = data;
         this.propertySourceText(data.propertySource);
      }
      
      override protected function updateWH(bool:Boolean = false) : void
      {
         if(!_propertySourceTxt)
         {
            return;
         }
         detail_txt.y = _propertySourceTxt.y + _propertySourceTxt.textHeight + 5;
         super.updateWH(true);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeObject(_propertySourceTxt);
         _propertySourceTxt = null;
      }
      
      protected function propertySourceText(value:String) : void
      {
         _propertySourceTxt.text = value;
         updateWH();
      }
   }
}
