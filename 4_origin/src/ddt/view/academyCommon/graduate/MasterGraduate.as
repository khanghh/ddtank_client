package ddt.view.academyCommon.graduate
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.manager.LanguageMgr;
   
   public class MasterGraduate extends ApprenticeGraduate implements Disposeable
   {
       
      
      private var _name:String;
      
      public function MasterGraduate()
      {
         super();
      }
      
      override protected function initContent() : void
      {
         _alertInfo = new AlertInfo();
         _alertInfo.title = LanguageMgr.GetTranslation("ddt.view.academyCommon.graduate.MasterGraduate");
         _alertInfo.submitLabel = LanguageMgr.GetTranslation("ddt.view.academyCommon.academyRequest.AcademyRequestApprenticeFrame.submitLabel");
         _alertInfo.showCancel = false;
         info = _alertInfo;
         _textBG = ComponentFactory.Instance.creatBitmap("asset.academyCommon.Graduate.graduateTitle");
         addToContent(_textBG);
         _tieleText = ComponentFactory.Instance.creatComponentByStylename("academyCommon.graduate.ApprenticeGraduate.titleText");
         addToContent(_tieleText);
         _explainText = ComponentFactory.Instance.creatComponentByStylename("academyCommon.graduate.MasterGraduate.explainText");
         addToContent(_explainText);
      }
      
      public function setName(value:String) : void
      {
         _name = value;
         update();
      }
      
      override protected function update() : void
      {
         _tieleText.htmlText = LanguageMgr.GetTranslation("ddt.view.academyCommon.graduate.MasterGraduate.title",_name);
         _explainText.text = LanguageMgr.GetTranslation("ddt.view.academyCommon.graduate.MasterGraduate.explain");
      }
   }
}
