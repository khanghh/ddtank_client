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
      
      public function CharacterPropTxtTip(){super();}
      
      override protected function addChildren() : void{}
      
      override protected function init() : void{}
      
      override public function set tipData(param1:Object) : void{}
      
      override protected function updateWH(param1:Boolean = false) : void{}
      
      override public function dispose() : void{}
      
      private function propertySourceText(param1:String) : void{}
   }
}
