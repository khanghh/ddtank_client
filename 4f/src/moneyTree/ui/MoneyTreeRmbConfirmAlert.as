package moneyTree.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.SimpleAlert;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.DisplayUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   import moneyTree.MoneyTreeManager;
   
   public class MoneyTreeRmbConfirmAlert extends SimpleAlert
   {
       
      
      private var _scb:SelectedCheckButton;
      
      private var _selectGroup:SelectedButtonGroup;
      
      private var vBox:VBox;
      
      private var radio1Times:SelectedCheckButton;
      
      private var radioToGrown:SelectedCheckButton;
      
      private var _txt1TimesCommon:String;
      
      private var _txt1TimesSelected:String;
      
      private var _txtToGrownCommon:String;
      
      private var _txtToGrownSelected:String;
      
      private var msg:String;
      
      public function MoneyTreeRmbConfirmAlert(){super();}
      
      public function get isNoPrompt() : Boolean{return false;}
      
      public function get type() : int{return 0;}
      
      override public function set info(param1:AlertInfo) : void{}
      
      protected function __radioClick(param1:MouseEvent) : void{}
      
      override protected function updateMsg() : void{}
      
      override protected function onProppertiesUpdate() : void{}
   }
}
