package ddtKingFloat.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.SimpleAlert;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.manager.LanguageMgr;
   
   public class DDTKingFloatBuyConfirmView extends SimpleAlert
   {
       
      
      private var _scb:SelectedCheckButton;
      
      public function DDTKingFloatBuyConfirmView(){super();}
      
      public function get isNoPrompt() : Boolean{return false;}
      
      override public function set info(param1:AlertInfo) : void{}
      
      override protected function onProppertiesUpdate() : void{}
   }
}
