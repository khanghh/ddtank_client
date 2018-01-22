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
      
      public function TotemControl(){super();}
      
      public static function get instance() : TotemControl{return null;}
      
      public function setup() : void{}
      
      private function __onInfoView(param1:CEvent) : void{}
      
      private function __onTotemView(param1:CEvent) : void{}
   }
}
