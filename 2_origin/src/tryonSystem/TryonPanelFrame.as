package tryonSystem
{
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   
   public class TryonPanelFrame extends BaseAlerFrame
   {
       
      
      private var _control:TryonSystemController;
      
      private var _view:TryonPanelView;
      
      public function TryonPanelFrame()
      {
         super();
         var alertInfo:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("ddt.tryonSystem.title"),"","",true,false);
         alertInfo.submitLabel = LanguageMgr.GetTranslation("ok");
         alertInfo.moveEnable = false;
         info = alertInfo;
      }
      
      public function set controller(control:TryonSystemController) : void
      {
         _control = control;
         initView();
      }
      
      public function initView() : void
      {
         _view = new TryonPanelView(_control,this);
         PositionUtils.setPos(_view,"quest.tryon.tryonPanelPos");
         addToContent(_view);
      }
      
      override public function dispose() : void
      {
         _view.dispose();
         _view = null;
         _control = null;
         super.dispose();
      }
   }
}
