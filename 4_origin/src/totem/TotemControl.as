package totem
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import totem.view.TotemInfoView;
   import totem.view.TotemMainView;
   
   public class TotemControl
   {
      
      private static var _instance:TotemControl;
       
      
      private var _infoView:TotemInfoView;
      
      private var _totemView:TotemMainView;
      
      public function TotemControl()
      {
         super();
      }
      
      public static function get instance() : TotemControl
      {
         if(!_instance)
         {
            _instance = new TotemControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         TotemManager.instance.addEventListener("infoview",__onInfoView);
         TotemManager.instance.addEventListener("totemview",__onTotemView);
      }
      
      private function __onInfoView(param1:CEvent) : void
      {
         var _loc2_:* = param1.data.type;
         if("openview" !== _loc2_)
         {
            if("closeView" !== _loc2_)
            {
               if("setvisible" === _loc2_)
               {
                  if(_infoView)
                  {
                     _infoView.visible = param1.data.visible;
                  }
               }
            }
            else
            {
               ObjectUtils.disposeObject(_infoView);
               _infoView = null;
            }
         }
         else if(!_infoView)
         {
            _infoView = new TotemInfoView(param1.data.info);
            param1.data.parent.addChild(_infoView);
         }
      }
      
      private function __onTotemView(param1:CEvent) : void
      {
         var _loc2_:* = param1.data.type;
         if("openview" !== _loc2_)
         {
            if("closeView" !== _loc2_)
            {
               if("setvisible" === _loc2_)
               {
                  if(_totemView)
                  {
                     _totemView.visible = param1.data.visible;
                  }
               }
            }
            else
            {
               ObjectUtils.disposeObject(_totemView);
               _totemView = null;
            }
         }
         else if(!_totemView)
         {
            _totemView = ComponentFactory.Instance.creatCustomObject("totemView");
            param1.data.parent.addChild(_totemView);
         }
      }
   }
}
