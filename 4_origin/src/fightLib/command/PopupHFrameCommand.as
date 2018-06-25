package fightLib.command
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   
   public class PopupHFrameCommand extends BaseFightLibCommand
   {
       
      
      private var _infoString:String;
      
      private var _okLabel:String;
      
      private var _cancelLabel:String;
      
      private var _okCallBack:Function;
      
      private var _cancellCallBack:Function;
      
      private var _showOkBtn:Boolean;
      
      private var _showCancelBtn:Boolean;
      
      private var _alert:BaseAlerFrame;
      
      public function PopupHFrameCommand(infoString:String, okLabel:String = "", okCallBack:Function = null, cancelLabel:String = "", cancelCallBack:Function = null, showOkBtn:Boolean = true, showCancelBtn:Boolean = false)
      {
         super();
         _infoString = infoString;
         _okLabel = okLabel;
         _cancelLabel = cancelLabel;
         _okCallBack = okCallBack;
         _cancellCallBack = cancelCallBack;
         _showOkBtn = showOkBtn;
         _showCancelBtn = showCancelBtn;
      }
      
      protected function __response(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(evt.responseCode))
         {
            case 0:
            case 1:
               if(_cancellCallBack != null)
               {
                  _cancellCallBack.apply();
               }
               closeAlert();
               break;
            case 2:
            case 3:
            case 4:
               if(_okCallBack != null)
               {
                  _okCallBack.apply();
               }
               closeAlert();
         }
      }
      
      override public function excute() : void
      {
         super.excute();
         var alert:BaseAlerFrame = _alert;
         _alert = AlertManager.Instance.simpleAlert("",_infoString,_okLabel,_cancelLabel,false,false,false,2);
         _alert.addEventListener("response",__response);
         if(alert && alert != _alert)
         {
            alert.removeEventListener("response",__response);
            ObjectUtils.disposeObject(alert);
         }
      }
      
      override public function finish() : void
      {
         if(_okCallBack != null)
         {
            _okCallBack.apply();
         }
         closeAlert();
         super.finish();
      }
      
      override public function undo() : void
      {
         closeAlert();
         super.undo();
      }
      
      override public function dispose() : void
      {
         _okCallBack = null;
         _cancellCallBack = null;
         _okLabel = null;
         _cancelLabel = null;
         closeAlert();
      }
      
      private function closeFrame() : void
      {
      }
      
      private function closeAlert() : void
      {
         if(_alert)
         {
            ObjectUtils.disposeObject(_alert);
            _alert.removeEventListener("response",__response);
            _alert = null;
         }
      }
   }
}
