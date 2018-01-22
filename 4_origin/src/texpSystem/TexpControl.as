package texpSystem
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import texpSystem.controller.TexpManager;
   import texpSystem.view.TexpInfoView;
   import texpSystem.view.TexpView;
   
   public class TexpControl
   {
      
      private static var _instance:TexpControl;
       
      
      private var _texpView:TexpView;
      
      private var _infoView:TexpInfoView;
      
      public function TexpControl()
      {
         super();
      }
      
      public static function get instance() : TexpControl
      {
         if(_instance == null)
         {
            _instance = new TexpControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         TexpManager.Instance.addEventListener("infoView",__onInfoViewEvent);
         TexpManager.Instance.addEventListener("texpView",__onTexpViewEvent);
      }
      
      private function __onInfoViewEvent(param1:CEvent) : void
      {
         var _loc2_:* = param1.data.type;
         if("openview" !== _loc2_)
         {
            if("closeView" !== _loc2_)
            {
               if("changevisible" !== _loc2_)
               {
                  if("cleaninfo" === _loc2_)
                  {
                     if(_infoView)
                     {
                        _infoView.info = param1.data.info;
                     }
                  }
               }
               else if(_infoView)
               {
                  _infoView.visible = param1.data.visible;
               }
            }
            else
            {
               ObjectUtils.disposeObject(_infoView);
               _infoView = null;
            }
         }
         else if(_infoView == null)
         {
            _infoView = ComponentFactory.Instance.creatCustomObject("texpSystem.texpInfoView.main");
            param1.data.parent.addChild(_infoView);
         }
      }
      
      private function __onTexpViewEvent(param1:CEvent) : void
      {
         var _loc2_:* = param1.data.type;
         if("openview" !== _loc2_)
         {
            if("closeView" !== _loc2_)
            {
               if("changevisible" !== _loc2_)
               {
                  if("shine" !== _loc2_)
                  {
                     if("changeinfo" === _loc2_)
                     {
                        if(_texpView)
                        {
                           _texpView.clearInfo();
                        }
                     }
                  }
                  else if(_texpView)
                  {
                     !!param1.data.shine?_texpView.startShine():_texpView.stopShine();
                  }
               }
               else if(_texpView)
               {
                  _texpView.visible = param1.data.visible;
               }
            }
            else
            {
               ObjectUtils.disposeObject(_texpView);
               _texpView = null;
            }
         }
         else if(!_texpView)
         {
            _texpView = ComponentFactory.Instance.creatCustomObject("texpSystem.main");
            param1.data.parent.addChild(_texpView);
         }
      }
   }
}
