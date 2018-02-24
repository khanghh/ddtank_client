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
      
      public function TexpControl(){super();}
      
      public static function get instance() : TexpControl{return null;}
      
      public function setup() : void{}
      
      private function __onInfoViewEvent(param1:CEvent) : void{}
      
      private function __onTexpViewEvent(param1:CEvent) : void{}
   }
}
