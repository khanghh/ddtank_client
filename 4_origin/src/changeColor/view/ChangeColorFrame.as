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
         var rec:* = null;
         super.init();
         _changeColorLeftView = new ChangeColorLeftView();
         addToContent(_changeColorLeftView);
         _changeColorRightView = new ChangeColorRightView();
         rec = ComponentFactory.Instance.creatCustomObject("changeColor.rightViewRec");
         ObjectUtils.copyPropertyByRectangle(_changeColorRightView,rec);
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
      
      private function __frameEventHandler(event:FrameEvent) : void
      {
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               ChangeColorControl.instance.close();
               ChangeColorManager.instance.close();
         }
      }
      
      private function __cellClickHandler(evt:ChangeColorCellEvent) : void
      {
         if(evt.data)
         {
            _changeColorLeftView.setCurrentItem(evt.data);
         }
      }
      
      private function __useCardHandler(evt:PkgEvent) : void
      {
         var state:Boolean = evt.pkg.readBoolean();
         if(state)
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
