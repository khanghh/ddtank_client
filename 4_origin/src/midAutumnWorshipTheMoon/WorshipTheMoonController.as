package midAutumnWorshipTheMoon
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import midAutumnWorshipTheMoon.model.WorshipTheMoonModel;
   import midAutumnWorshipTheMoon.view.WorshipTheMoonMainFrame;
   
   public class WorshipTheMoonController
   {
      
      private static var instance:WorshipTheMoonController;
       
      
      private var _mainFrameMidAutumn:WorshipTheMoonMainFrame;
      
      private var _manager:WorshipTheMoonManager;
      
      private var _isOpen:Boolean = false;
      
      public function WorshipTheMoonController(param1:inner)
      {
         super();
      }
      
      public static function getInstance() : WorshipTheMoonController
      {
         if(!instance)
         {
            instance = new WorshipTheMoonController(new inner());
         }
         return instance;
      }
      
      public function setup() : void
      {
         _manager = WorshipTheMoonManager.getInstance();
         addEvents();
      }
      
      private function addEvents() : void
      {
         _manager.addEventListener("wship_hide",onEventHandler);
         _manager.addEventListener("wship_show",onEventHandler);
         _manager.addEventListener("wship_dispose",onEventHandler);
         _manager.addEventListener("wship_dispose_frame",onEventHandler);
      }
      
      protected function onEventHandler(param1:CEvent) : void
      {
         var _loc2_:* = param1.type;
         if("wship_hide" !== _loc2_)
         {
            if("wship_show" !== _loc2_)
            {
               if("wship_dispose" !== _loc2_)
               {
                  if("wship_dispose_frame" === _loc2_)
                  {
                     disposeMainFrame();
                  }
               }
               else
               {
                  dispose();
               }
            }
            else
            {
               showFrame();
            }
         }
         else
         {
            hide();
         }
      }
      
      private function showFrame() : void
      {
         _mainFrameMidAutumn = ComponentFactory.Instance.creatComponentByStylename("worship.mainframe");
         _mainFrameMidAutumn.model = WorshipTheMoonModel.getInstance();
         WorshipTheMoonModel.getInstance().init(_mainFrameMidAutumn);
         LayerManager.Instance.addToLayer(_mainFrameMidAutumn,3,true,1);
      }
      
      private function hide() : void
      {
         if(_mainFrameMidAutumn != null)
         {
            ObjectUtils.disposeObject(_mainFrameMidAutumn);
            _mainFrameMidAutumn = null;
         }
      }
      
      private function disposeMainFrame() : void
      {
         if(_mainFrameMidAutumn != null)
         {
            ObjectUtils.disposeObject(_mainFrameMidAutumn);
            _mainFrameMidAutumn = null;
         }
      }
      
      private function dispose() : void
      {
         if(_mainFrameMidAutumn != null)
         {
            ObjectUtils.disposeObject(_mainFrameMidAutumn);
            _mainFrameMidAutumn = null;
         }
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
