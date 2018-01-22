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
      
      public function ConfirmKillCropAlertFrame()
      {
         super();
         var _loc1_:AlertInfo = new AlertInfo();
         _loc1_.title = LanguageMgr.GetTranslation("ddt.farms.killCropComfirmNumPnlTitle");
         _loc1_.bottomGap = 37;
         _loc1_.buttonGape = 65;
         _loc1_.customPos = ComponentFactory.Instance.creat("farm.confirmComposeAlertBtnPos");
         this.info = _loc1_;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bgTitle = ComponentFactory.Instance.creat("assets.farm.titleSmall");
         addChild(_bgTitle);
         PositionUtils.setPos(_bgTitle,PositionUtils.creatPoint("farm.confirmComposeAlertTitlePos"));
         _msgTxt = ComponentFactory.Instance.creat("farm.killCrop.msgtext");
         addToContent(_msgTxt);
      }
      
      public function cropName(param1:String, param2:Boolean = false) : void
      {
         this._cropName = param1;
         if(param2)
         {
            _msgTxt.text = LanguageMgr.GetTranslation("ddt.farms.comfirmKillCropMsg2",_cropName);
         }
         else
         {
            _msgTxt.text = LanguageMgr.GetTranslation("ddt.farms.comfirmKillCropMsg",_cropName);
         }
      }
      
      public function set fieldId(param1:int) : void
      {
         this._fieldId = param1;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__framePesponse);
      }
      
      protected function __framePesponse(param1:FrameEvent) : void
      {
         removeEventListener("response",__framePesponse);
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
               break;
            default:
               break;
            case 2:
            case 3:
               dispatchEvent(new SelectComposeItemEvent("killcropClick",_fieldId));
            default:
               dispatchEvent(new SelectComposeItemEvent("killcropClick",_fieldId));
         }
         dispose();
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__framePesponse);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_msgTxt)
         {
            ObjectUtils.disposeObject(_msgTxt);
            _msgTxt = null;
         }
         super.dispose();
      }
   }
}
