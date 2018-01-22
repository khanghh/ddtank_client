package bagAndInfo.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.view.tips.PropTxtTip;
   
   public class CharacterPropTxtTip extends PropTxtTip
   {
       
      
      private var _propertySourceTxt:FilterFrameText;
      
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
      
      override public function set tipData(param1:Object) : void
      {
         .super.tipData = param1;
         this.propertySourceText(param1.propertySource);
      }
      
      override protected function updateWH(param1:Boolean = false) : void
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
      
      private function propertySourceText(param1:String) : void
      {
         _propertySourceTxt.text = param1;
         updateWH();
      }
   }
}
