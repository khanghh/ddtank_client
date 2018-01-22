package changeColor.view
{
   import changeColor.ChangeColorControl;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.ChangeColorCellEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.ChangeColorManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.geom.Rectangle;
   
   public class ChangeColorFrame extends Frame
   {
       
      
      private var _changeColorLeftView:ChangeColorLeftView;
      
      private var _changeColorRightView:ChangeColorRightView;
      
      public function ChangeColorFrame()
      {
         super();
      }
      
      override public function dispose() : void
      {
         remvoeEvent();
         ObjectUtils.disposeAllChildren(this);
         _changeColorLeftView = null;
         _changeColorRightView = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
         _changeColorLeftView.model = ChangeColorManager.instance.changeColorModel;
         _changeColorRightView.model = ChangeColorManager.instance.changeColorModel;
      }
      
      override protected function init() : void
      {
         var _loc1_:* = null;
         super.init();
         _changeColorLeftView = new ChangeColorLeftView();
         addToContent(_changeColorLeftView);
         _changeColorRightView = new ChangeColorRightView();
         _loc1_ = ComponentFactory.Instance.creatCustomObject("changeColor.rightViewRec");
         ObjectUtils.copyPropertyByRectangle(_changeColorRightView,_loc1_);
         addToContent(_changeColorRightView);
         addEvent();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         _changeColorRightView.addEventListener("changeColorCellClickEvent",__cellClickHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(182),__useCardHandler);
      }
      
      private function remvoeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
      }
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               ChangeColorControl.instance.close();
               ChangeColorManager.instance.close();
         }
      }
      
      private function __cellClickHandler(param1:ChangeColorCellEvent) : void
      {
         if(param1.data)
         {
            _changeColorLeftView.setCurrentItem(param1.data);
         }
      }
      
      private function __useCardHandler(param1:PkgEvent) : void
      {
         var _loc2_:Boolean = param1.pkg.readBoolean();
         if(_loc2_)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.im.IMController.success"));
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.changeColor.failed"));
         }
      }
      
      public function setFirstItemSelected() : void
      {
         _changeColorLeftView.setCurrentItem(_changeColorRightView.bag.cells[0]);
      }
   }
}
