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
      
      public function ManualLeftMenu(param1:ExplorerManualInfo)
      {
         super();
         initView();
         _model = param1;
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
      
      private function __modelUpdateHandler(param1:Event) : void
      {
         var _loc4_:int = _model.activePageID.length;
         var _loc2_:int = _model.havePage;
         var _loc3_:int = ExplorerManualManager.instance.getAllPageItemCount();
         _activeProgess.text = _loc4_ + "/" + _loc2_;
         _unActiveProgress.text = (_loc3_ - _loc2_).toString();
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
