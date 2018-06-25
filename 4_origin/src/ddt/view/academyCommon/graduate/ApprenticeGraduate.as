package ddt.view.academyCommon.graduate
{
   import academy.AcademyManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.text.TextFormat;
   
   public class ApprenticeGraduate extends BaseAlerFrame implements Disposeable
   {
       
      
      protected var _textBG:Bitmap;
      
      protected var _alertInfo:AlertInfo;
      
      protected var _explainText:FilterFrameText;
      
      protected var _tieleText:FilterFrameText;
      
      protected var _nameLabel:TextFormat;
      
      public function ApprenticeGraduate()
      {
         super();
         initContent();
         initEvent();
      }
      
      protected function initContent() : void
      {
         _alertInfo = new AlertInfo();
         _alertInfo.title = LanguageMgr.GetTranslation("ddt.view.academyCommon.graduate.ApprenticeGraduate");
         _alertInfo.submitLabel = LanguageMgr.GetTranslation("ddt.view.academyCommon.academyRequest.AcademyRequestApprenticeFrame.submitLabel");
         _alertInfo.showCancel = false;
         info = _alertInfo;
         _textBG = ComponentFactory.Instance.creatBitmap("asset.academyCommon.Graduate.graduateTitle");
         addToContent(_textBG);
         _tieleText = ComponentFactory.Instance.creatComponentByStylename("academyCommon.graduate.ApprenticeGraduate.titleText");
         _tieleText.htmlText = LanguageMgr.GetTranslation("ddt.view.academyCommon.graduate.ApprenticeGraduate.title");
         addToContent(_tieleText);
         _explainText = ComponentFactory.Instance.creatComponentByStylename("academyCommon.graduate.ApprenticeGraduate.explainText");
         _explainText.htmlText = LanguageMgr.GetTranslation("ddt.view.academyCommon.graduate.ApprenticeGraduate.explain");
         addToContent(_explainText);
         update();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,false,2);
      }
      
      protected function initEvent() : void
      {
         addEventListener("response",__frameEvent);
      }
      
      protected function update() : void
      {
      }
      
      protected function __frameEvent(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
            case 3:
            case 4:
               AcademyManager.Instance.recommends();
         }
      }
      
      override public function dispose() : void
      {
         removeEventListener("response",__frameEvent);
         if(_textBG)
         {
            ObjectUtils.disposeObject(_textBG);
            _textBG = null;
         }
         if(_explainText)
         {
            _explainText.dispose();
            _explainText = null;
         }
         if(_tieleText)
         {
            _tieleText.dispose();
            _tieleText = null;
         }
         _nameLabel = null;
         super.dispose();
      }
   }
}
