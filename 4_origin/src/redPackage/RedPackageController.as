package redPackage
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.CoreController;
   import ddt.events.CEvent;
   import ddt.utils.HelperUIModuleLoad;
   import redPackage.view.RedPackageConsortiaGainFrame;
   import redPackage.view.RedPackageConsortiaGainedRecordFrame;
   import redPackage.view.RedPackageConsortiaSelectFrame;
   import redPackage.view.RedPackageConsortiaSendFrame;
   
   public class RedPackageController extends CoreController
   {
      
      private static var instance:RedPackageController;
       
      
      private var _manager:RedPackageManager;
      
      private var _redPkgConsortiaSelectFrame:RedPackageConsortiaSelectFrame;
      
      private var _redPkgConsortiaSendFrame:RedPackageConsortiaSendFrame;
      
      private var _redPkgConsortiaGainFrame:RedPackageConsortiaGainFrame;
      
      private var _redPkgConsortiaGainedRecordFrame:RedPackageConsortiaGainedRecordFrame;
      
      public function RedPackageController(param1:inner)
      {
         super();
      }
      
      public static function getInstance() : RedPackageController
      {
         if(!instance)
         {
            instance = new RedPackageController(new inner());
         }
         return instance;
      }
      
      public function setup() : void
      {
         _manager = RedPackageManager.getInstance();
         addEventsMap([["RedPkg_show",onShowHandler],["RedPkg_update_send_record_view",onUpdateGainView],["RedPkg_update_gain_record_view",onUpdateGainRecordView]],_manager);
      }
      
      private function onShowHandler(param1:CEvent) : void
      {
         new HelperUIModuleLoad().loadUIModule(["redPackage"],onLoaded);
      }
      
      private function onLoaded() : void
      {
         var _loc1_:* = _manager.curFrameType;
         if("red_pkg_consortia_select" !== _loc1_)
         {
            if("red_pkg_consortia_send" !== _loc1_)
            {
               if("red_pkg_consortia_gain" === _loc1_)
               {
                  onConsortiaGain();
               }
            }
            else
            {
               onConsortiaSend();
            }
         }
         else
         {
            onConsortiaSelect();
         }
      }
      
      private function onUpdateGainView(param1:CEvent) : void
      {
         if(_redPkgConsortiaGainFrame != null)
         {
            _redPkgConsortiaGainFrame.update();
         }
      }
      
      private function onUpdateGainRecordView(param1:CEvent) : void
      {
         _redPkgConsortiaGainedRecordFrame = ComponentFactory.Instance.creatComponentByStylename("redpkg.consortia.gainRecordFrame");
         LayerManager.Instance.addToLayer(_redPkgConsortiaGainedRecordFrame,3,true,1);
      }
      
      private function onConsortiaGain() : void
      {
         _redPkgConsortiaGainFrame = ComponentFactory.Instance.creatComponentByStylename("redpkg.consortia.gainFrame");
         LayerManager.Instance.addToLayer(_redPkgConsortiaGainFrame,3,true,1);
         _manager.onConsortionSendRecord();
      }
      
      private function onConsortiaSend() : void
      {
         _redPkgConsortiaSendFrame = ComponentFactory.Instance.creatComponentByStylename("redpkg.consortia.sendFrame");
         LayerManager.Instance.addToLayer(_redPkgConsortiaSendFrame,3,true,1);
      }
      
      private function onConsortiaSelect() : void
      {
         _redPkgConsortiaSelectFrame = ComponentFactory.Instance.creatComponentByStylename("redpkg.consortia.selectFrame");
         LayerManager.Instance.addToLayer(_redPkgConsortiaSelectFrame,3,true,1);
      }
   }
}

class inner
{
    
   
   function inner()
   {
      super();
   }
}
