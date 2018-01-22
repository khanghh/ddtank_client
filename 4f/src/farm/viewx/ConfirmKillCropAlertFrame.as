package farm.viewx
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import farm.view.compose.event.SelectComposeItemEvent;
   import flash.display.DisplayObject;
   
   public class ConfirmKillCropAlertFrame extends BaseAlerFrame
   {
       
      
      private var _addBtn:BaseButton;
      
      private var _removeBtn:BaseButton;
      
      private var _msgTxt:FilterFrameText;
      
      private var _bgTitle:DisplayObject;
      
      private var _cropName:String;
      
      private var _fieldId:int = -1;
      
      public function ConfirmKillCropAlertFrame(){super();}
      
      private function initView() : void{}
      
      public function cropName(param1:String, param2:Boolean = false) : void{}
      
      public function set fieldId(param1:int) : void{}
      
      private function initEvent() : void{}
      
      protected function __framePesponse(param1:FrameEvent) : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
