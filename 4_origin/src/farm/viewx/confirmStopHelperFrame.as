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
   import farm.FarmEvent;
   import farm.FarmModelController;
   import flash.display.DisplayObject;
   
   public class confirmStopHelperFrame extends BaseAlerFrame
   {
       
      
      private var _addBtn:BaseButton;
      
      private var _removeBtn:BaseButton;
      
      private var _msgTxt:FilterFrameText;
      
      private var _bgTitle:DisplayObject;
      
      public function confirmStopHelperFrame()
      {
         super();
         var _loc1_:AlertInfo = new AlertInfo();
         _loc1_.title = LanguageMgr.GetTranslation("ddt.farms.stopHelperComfirm");
         _loc1_.bottomGap = 37;
         _loc1_.buttonGape = 65;
         _loc1_.customPos = ComponentFactory.Instance.creat("farm.confirmStopHelperFramePos");
         this.info = _loc1_;
         intView();
         initEvent();
      }
      
      private function intView() : void
      {
         _bgTitle = ComponentFactory.Instance.creat("assets.farm.titleSmall");
         addChild(_bgTitle);
         PositionUtils.setPos(_bgTitle,PositionUtils.creatPoint("farm.confirmStopHelperFrameTitlePos"));
         _msgTxt = ComponentFactory.Instance.creat("farm.killCrop.msgtext");
         _msgTxt.text = LanguageMgr.GetTranslation("ddt.farms.stopHelperComfirmText");
         addToContent(_msgTxt);
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
               FarmModelController.instance.dispatchEvent(new FarmEvent("confirmStopHelper"));
            default:
               FarmModelController.instance.dispatchEvent(new FarmEvent("confirmStopHelper"));
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
         if(_addBtn)
         {
            ObjectUtils.disposeObject(_addBtn);
            _addBtn = null;
         }
         if(_removeBtn)
         {
            ObjectUtils.disposeObject(_removeBtn);
            _removeBtn = null;
         }
         if(_bgTitle)
         {
            ObjectUtils.disposeObject(_bgTitle);
            _bgTitle = null;
         }
         super.dispose();
      }
   }
}
