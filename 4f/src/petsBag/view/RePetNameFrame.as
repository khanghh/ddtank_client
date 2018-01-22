package petsBag.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import ddt.view.DoubleSelectedItem;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import road7th.utils.StringHelper;
   
   public class RePetNameFrame extends BaseAlerFrame
   {
      
      public static const RENAME_NEED_MONEY:int = 500;
       
      
      protected var _inputBackground:DisplayObject;
      
      private var _alertInfo:AlertInfo;
      
      private var _inputText:FilterFrameText;
      
      private var _inputLbl:FilterFrameText;
      
      private var _alertTxt:FilterFrameText;
      
      private var _alertTxt2:FilterFrameText;
      
      private var _petName:String = "";
      
      private var _selectedItem:DoubleSelectedItem;
      
      public function RePetNameFrame(){super();}
      
      public function get selecetItem() : DoubleSelectedItem{return null;}
      
      public function get petName() : String{return null;}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __getFocus(param1:Event) : void{}
      
      override protected function __onSubmitClick(param1:MouseEvent) : void{}
      
      override protected function __onCancelClick(param1:MouseEvent) : void{}
      
      override protected function __onCloseClick(param1:MouseEvent) : void{}
      
      private function __inputChange(param1:Event) : void{}
      
      private function getStrActualLen(param1:String) : int{return 0;}
      
      private function nameInputCheck() : Boolean{return false;}
      
      protected function __onAlertResponse(param1:FrameEvent) : void{}
      
      public function show() : void{}
      
      override public function dispose() : void{}
   }
}
