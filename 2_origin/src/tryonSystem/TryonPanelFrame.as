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
         var _loc1_:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("ddt.tryonSystem.title"),"","",true,false);
         _loc1_.submitLabel = LanguageMgr.GetTranslation("ok");
         _loc1_.moveEnable = false;
         info = _loc1_;
      }
      
      public function set controller(param1:TryonSystemController) : void
      {
         _control = param1;
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
