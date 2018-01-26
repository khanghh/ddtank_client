package consortion.view.selfConsortia.consortiaTask
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   
   public class ConsortiaSubmitTaskFrame extends BaseAlerFrame
   {
      
      private static var RESET_MONEY:int = 500;
      
      private static var SUBMIT_RICHES:int = 5000;
       
      
      private var _myResetBtn:TextButton;
      
      private var _myOkBtn:TextButton;
      
      private var _itemTxtI:FilterFrameText;
      
      private var _itemTxtII:FilterFrameText;
      
      private var _itemTxtIII:FilterFrameText;
      
      public function ConsortiaSubmitTaskFrame(){super();}
      
      private function initView() : void{}
      
      private function initEvents() : void{}
      
      private function removeEvents() : void{}
      
      private function __response(param1:FrameEvent) : void{}
      
      private function __resetClick(param1:MouseEvent) : void{}
      
      private function __okClick(param1:MouseEvent) : void{}
      
      private function _responseI(param1:FrameEvent) : void{}
      
      private function __onNoMoneyResponse(param1:FrameEvent) : void{}
      
      private function __getTaskInfo(param1:ConsortiaTaskEvent) : void{}
      
      public function set taskInfo(param1:ConsortiaTaskInfo) : void{}
      
      public function show() : void{}
      
      override public function dispose() : void{}
   }
}
