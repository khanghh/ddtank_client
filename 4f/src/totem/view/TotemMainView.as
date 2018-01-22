package totem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import road7th.comm.PackageIn;
   import totem.TotemManager;
   import trainer.view.NewHandContainer;
   
   public class TotemMainView extends Sprite implements Disposeable
   {
       
      
      private var _leftView:TotemLeftView;
      
      private var _rightView:TotemRightView;
      
      public function TotemMainView(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function refresh(param1:PkgEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
