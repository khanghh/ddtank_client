package toyMachine.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.geom.Point;
   import road7th.comm.PackageIn;
   import toyMachine.ToyMachineManager;
   import trainer.view.NewHandContainer;
   
   public class ToyMachineFrame extends Frame implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _silverItem:ToyMachineItem;
      
      private var _goldItem:ToyMachineItem;
      
      public function ToyMachineFrame()
      {
         super();
         initView();
         initEvent();
         sendPkg();
      }
      
      private function sendPkg() : void
      {
         SocketManager.Instance.out.getToyMachineInfo();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("ddt.farm.toyMachine.titleText");
         _bg = ComponentFactory.Instance.creat("asset.toyMachine.bg");
         addToContent(_bg);
         _silverItem = new ToyMachineItem(1);
         PositionUtils.setPos(_silverItem,"toyMachine.silverPos");
         addToContent(_silverItem);
         _goldItem = new ToyMachineItem(2);
         PositionUtils.setPos(_goldItem,"toyMachine.goldPos");
         addToContent(_goldItem);
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(135))
         {
            if(PlayerManager.Instance.Self.Grade >= 25)
            {
               NewHandContainer.Instance.showArrow(146,135,new Point(285,443),"","",LayerManager.Instance.getLayerByType(0));
            }
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__onResponse);
         SocketManager.Instance.addEventListener(PkgEvent.format(324),__onUpdateView);
         SocketManager.Instance.addEventListener(PkgEvent.format(326),__onGetReward);
      }
      
      protected function __onGetReward(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         pkg.position = 20;
         var type:int = pkg.readInt();
         if(type == 1)
         {
            _silverItem.getReward(pkg);
         }
         else
         {
            _goldItem.getReward(pkg);
         }
      }
      
      protected function __onUpdateView(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var silverTime:Date = pkg.readDate();
         var silverCount:int = pkg.readInt();
         var goldTime:Date = pkg.readDate();
         _silverItem.setItemInfo(silverTime,silverCount);
         _goldItem.setItemInfo(goldTime);
      }
      
      protected function __onResponse(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               ToyMachineManager.instance.hide();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__onResponse);
         SocketManager.Instance.removeEventListener(PkgEvent.format(324),__onUpdateView);
         SocketManager.Instance.removeEventListener(PkgEvent.format(326),__onGetReward);
      }
      
      override public function dispose() : void
      {
         NewHandContainer.Instance.clearArrowByID(146);
         removeEvent();
         super.dispose();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         _silverItem = null;
         _goldItem = null;
      }
   }
}
