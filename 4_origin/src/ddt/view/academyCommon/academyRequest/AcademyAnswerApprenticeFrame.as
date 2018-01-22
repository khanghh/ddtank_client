package ddt.view.academyCommon.academyRequest
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import flash.geom.Point;
   
   public class AcademyAnswerApprenticeFrame extends AcademyAnswerMasterFrame implements Disposeable
   {
       
      
      public function AcademyAnswerApprenticeFrame()
      {
         super();
      }
      
      override protected function initContent() : void
      {
         _alertInfo = new AlertInfo();
         _alertInfo.title = LanguageMgr.GetTranslation("ddt.view.academyCommon.academyRequest.AcademyRequestMasterFrame.title");
         var _loc3_:* = false;
         this.enterEnable = _loc3_;
         _loc3_ = _loc3_;
         _alertInfo.enterEnable = _loc3_;
         _loc3_ = _loc3_;
         _alertInfo.showSubmit = _loc3_;
         _alertInfo.showCancel = _loc3_;
         info = _alertInfo;
         var _loc1_:Point = ComponentFactory.Instance.creatCustomObject("AcademyAnswerMasterFrame.inputPos1");
         var _loc2_:Point = ComponentFactory.Instance.creatCustomObject("AcademyAnswerMasterFrame.inputPos2");
         _inputBG = ComponentFactory.Instance.creatComponentByStylename("academyCommon.academyRequest.inputBg2");
         addToContent(_inputBG);
         _inputBG.x = _loc1_.x;
         _inputBG.y = _loc1_.y;
         _messageText = ComponentFactory.Instance.creatComponentByStylename("academyCommon.academyRequest.MessageText");
         addToContent(_messageText);
         _messageText.x = _loc2_.x;
         _messageText.y = _loc2_.y;
         _explainText = ComponentFactory.Instance.creat("academyCommon.academyAnswerApprenticeFrame.explainText");
         addToContent(_explainText);
         _lookBtn = ComponentFactory.Instance.creatComponentByStylename("academy.AcademyAnswerApprenticeFrame.LookButton");
         _lookBtn.text = LanguageMgr.GetTranslation("civil.leftview.equipName");
         addToContent(_lookBtn);
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("academy.AcademyAnswerApprenticeFrame.submitButton");
         _cancelBtn.text = LanguageMgr.GetTranslation("ddt.view.academyCommon.academyRequest.AcademyRequestMasterFrame.submitLabel");
         addToContent(_cancelBtn);
         _unAcceptBtn = ComponentFactory.Instance.creatComponentByStylename("academy.AcademyAnswerApprenticeFrame.selectBtn");
         addToContent(_unAcceptBtn);
         _unAcceptBtn.text = LanguageMgr.GetTranslation("ddt.farms.refreshPetsNOAlert");
      }
      
      override protected function update() : void
      {
         _messageText.htmlText = _message;
         _explainText.htmlText = LanguageMgr.GetTranslation("ddt.view.academyCommon.academyRequest.AcademyAnswerApprenticeFrame.AnswerApprentice",_name);
      }
      
      override protected function submit() : void
      {
         SocketManager.Instance.out.sendAcademyApprenticeConfirm(true,_uid);
         dispose();
      }
      
      override protected function hide() : void
      {
         SocketManager.Instance.out.sendAcademyApprenticeConfirm(false,_uid);
         dispose();
      }
   }
}
