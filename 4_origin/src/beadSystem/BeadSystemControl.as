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
      
      private function __onOpenView(e:CEvent) : void
      {
         var _spr:* = null;
         var _loc3_:* = e.data.type;
         if("infoframe" !== _loc3_)
         {
            if("infoview" !== _loc3_)
            {
               if("mainView" === _loc3_)
               {
                  _spr = ComponentFactory.Instance.creatCustomObject("beadInfoView");
               }
            }
            else
            {
               _spr = ComponentFactory.Instance.creatCustomObject("playerBeadInfoView");
            }
         }
         else
         {
            _spr = ComponentFactory.Instance.creat("BeadFeedInfoFrame");
         }
         beadSystemManager.Instance.dispatchEvent(new CEvent("createComplete",{
            "type":e.data.type,
            "spr":_spr
         }));
      }
   }
}
