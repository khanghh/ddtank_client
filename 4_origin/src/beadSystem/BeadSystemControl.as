package beadSystem
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.events.CEvent;
   import flash.display.Sprite;
   
   public class BeadSystemControl
   {
      
      private static var _instance:BeadSystemControl;
       
      
      public function BeadSystemControl()
      {
         super();
      }
      
      public static function get instance() : BeadSystemControl
      {
         if(!_instance)
         {
            _instance = new BeadSystemControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         beadSystemManager.Instance.addEventListener("openview",__onOpenView);
      }
      
      private function __onOpenView(param1:CEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = param1.data.type;
         if("infoframe" !== _loc3_)
         {
            if("infoview" !== _loc3_)
            {
               if("mainView" === _loc3_)
               {
                  _loc2_ = ComponentFactory.Instance.creatCustomObject("beadInfoView");
               }
            }
            else
            {
               _loc2_ = ComponentFactory.Instance.creatCustomObject("playerBeadInfoView");
            }
         }
         else
         {
            _loc2_ = ComponentFactory.Instance.creat("BeadFeedInfoFrame");
         }
         beadSystemManager.Instance.dispatchEvent(new CEvent("createComplete",{
            "type":param1.data.type,
            "spr":_loc2_
         }));
      }
   }
}
