package totem
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import totem.data.TotemUpGradDataVo;
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
      
      public function getGradeByTotemPage(page:int) : int
      {
         return TotemManager.instance.getGradeByTotemPage(page);
      }
      
      public function getUpGradeInfo(page:int, grade:int) : TotemUpGradDataVo
      {
         return TotemManager.instance.getUpGradeInfo(page,grade);
      }
      
      private function __onInfoView(e:CEvent) : void
      {
         var _loc2_:* = e.data.type;
         if("openview" !== _loc2_)
         {
            if("closeView" !== _loc2_)
            {
               if("setvisible" === _loc2_)
               {
                  if(_infoView)
                  {
                     _infoView.visible = e.data.visible;
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
            _infoView = new TotemInfoView(e.data.info);
            e.data.parent.addChild(_infoView);
         }
      }
      
      private function __onTotemView(e:CEvent) : void
      {
         var _loc2_:* = e.data.type;
         if("openview" !== _loc2_)
         {
            if("closeView" !== _loc2_)
            {
               if("setvisible" === _loc2_)
               {
                  if(_totemView)
                  {
                     _totemView.visible = e.data.visible;
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
            e.data.parent.addChild(_totemView);
         }
      }
   }
}
