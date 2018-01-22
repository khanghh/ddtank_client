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
      
      public function PopupHFrameCommand(param1:String, param2:String = "", param3:Function = null, param4:String = "", param5:Function = null, param6:Boolean = true, param7:Boolean = false)
      {
         super();
         _infoString = param1;
         _okLabel = param2;
         _cancelLabel = param4;
         _okCallBack = param3;
         _cancellCallBack = param5;
         _showOkBtn = param6;
         _showCancelBtn = param7;
      }
      
      protected function __response(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
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
         var _loc1_:BaseAlerFrame = _alert;
         _alert = AlertManager.Instance.simpleAlert("",_infoString,_okLabel,_cancelLabel,false,false,false,2);
         _alert.addEventListener("response",__response);
         if(_loc1_ && _loc1_ != _alert)
         {
            _loc1_.removeEventListener("response",__response);
            ObjectUtils.disposeObject(_loc1_);
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
