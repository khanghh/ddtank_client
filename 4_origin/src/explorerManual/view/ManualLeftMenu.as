package explorerManual.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import explorerManual.ExplorerManualManager;
   import explorerManual.data.ExplorerManualInfo;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class ManualLeftMenu extends Sprite implements Disposeable
   {
       
      
      private var _activeIcon:ScaleFrameImage;
      
      private var _activeProgess:FilterFrameText;
      
      private var _unActiveIcon:ScaleFrameImage;
      
      private var _unActiveProgress:FilterFrameText;
      
      private var _model:ExplorerManualInfo;
      
      public function ManualLeftMenu(model:ExplorerManualInfo)
      {
         super();
         initView();
         _model = model;
         addEvent();
         mouseEnabled = true;
         buttonMode = true;
      }
      
      private function initView() : void
      {
         _activeIcon = ComponentFactory.Instance.creatComponentByStylename("explorerManual.activeIcon");
         addChild(_activeIcon);
         _activeIcon.tipData = LanguageMgr.GetTranslation("explorerManual.leftMenu.activeTips");
         _activeProgess = ComponentFactory.Instance.creatComponentByStylename("explorerManual.activeProgessTxt");
         addChild(_activeProgess);
         _unActiveIcon = ComponentFactory.Instance.creatComponentByStylename("explorerManual.unActiveIcon");
         addChild(_unActiveIcon);
         _unActiveIcon.tipData = LanguageMgr.GetTranslation("explorerManual.leftMenu.unActiveTips");
         _unActiveProgress = ComponentFactory.Instance.creatComponentByStylename("explorerManual.unActiveProgessTxt");
         addChild(_unActiveProgress);
      }
      
      private function addEvent() : void
      {
         if(_model)
         {
            _model.addEventListener("manualModelUpdate",__modelUpdateHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_model)
         {
            _model.removeEventListener("manualModelUpdate",__modelUpdateHandler);
         }
      }
      
      private function __modelUpdateHandler(evt:Event) : void
      {
         var activeCount:int = _model.activePageID.length;
         var haveCount:int = _model.havePage;
         var totalCount:int = ExplorerManualManager.instance.getAllPageItemCount();
         _activeProgess.text = activeCount + "/" + haveCount;
         _unActiveProgress.text = (totalCount - haveCount).toString();
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_activeIcon);
         _activeIcon = null;
         ObjectUtils.disposeObject(_unActiveIcon);
         _unActiveIcon = null;
         ObjectUtils.disposeObject(_activeProgess);
         _activeProgess = null;
         ObjectUtils.disposeObject(_unActiveProgress);
         _unActiveProgress = null;
         _model = null;
      }
   }
}
