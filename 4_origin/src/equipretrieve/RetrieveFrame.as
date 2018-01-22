package equipretrieve
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.BagEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelperUIModuleLoad;
   import equipretrieve.view.RetrieveBagFrame;
   import equipretrieve.view.RetrieveBagView;
   import equipretrieve.view.RetrieveBgView;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class RetrieveFrame extends Frame
   {
       
      
      private var _retrieveBgView:RetrieveBgView;
      
      private var _retrieveBagView:RetrieveBagFrame;
      
      private var _alertInfo:AlertInfo;
      
      private var _BG:ScaleBitmapImage;
      
      public function RetrieveFrame()
      {
         super();
         this.mouseEnabled = false;
         new HelperUIModuleLoad().loadUIModule(["ddtbagandinfo"],start);
      }
      
      private function start() : void
      {
         _retrieveBgView = ComponentFactory.Instance.creatCustomObject("retrieve.retrieveBgView");
         _retrieveBagView = ComponentFactory.Instance.creatCustomObject("retrieve.retrieveBagView");
         addToContent(_retrieveBagView);
         addToContent(_retrieveBgView);
         PlayerManager.Instance.Self.StoreBag.addEventListener("update",_updateStoreBag);
         RetrieveController.Instance.addEventListener("doubleclick",__onDoubleClick);
         RetrieveController.Instance.addEventListener("retrievetype",__onRetrieveType);
         RetrieveController.Instance.addEventListener("shine",__onShine);
         RetrieveController.Instance.addEventListener("mouseenable",__onMouseEnable);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,2,true,1);
      }
      
      public function updateBag(param1:Dictionary) : void
      {
      }
      
      private function _updateStoreBag(param1:BagEvent) : void
      {
         if(_retrieveBgView)
         {
            _retrieveBgView.refreshData(param1.changedSlots);
         }
      }
      
      public function cellDoubleClick(param1:BagCell) : void
      {
         if(_retrieveBgView)
         {
            _retrieveBgView.cellDoubleClick(param1);
         }
      }
      
      public function set bagType(param1:int) : void
      {
         RetrieveBagView(_retrieveBagView.bagView).resultPoint(param1,_retrieveBagView.x - _retrieveBgView.x,_retrieveBagView.y - _retrieveBgView.y);
      }
      
      public function set shine(param1:Boolean) : void
      {
         if(param1 == true)
         {
            if(_retrieveBgView)
            {
               _retrieveBgView.startShine();
            }
         }
         else if(_retrieveBgView)
         {
            _retrieveBgView.stopShine();
         }
      }
      
      override public function set visible(param1:Boolean) : void
      {
         .super.visible = param1;
         if(!param1)
         {
            SocketManager.Instance.out.sendClearStoreBag();
         }
      }
      
      public function clearItemCell() : void
      {
         if(_retrieveBgView)
         {
            _retrieveBgView.clearCellInfo();
         }
      }
      
      private function _response(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(!RetrieveController.Instance.viewMouseEvtBoolean)
         {
            return;
         }
         if(param1.responseCode == 0 || param1.responseCode == 1 || RetrieveController.Instance.viewMouseEvtBoolean)
         {
            RetrieveController.Instance.close();
         }
      }
      
      private function __onDoubleClick(param1:Event) : void
      {
         cellDoubleClick(RetrieveController.Instance.cell);
      }
      
      private function __onRetrieveType(param1:Event) : void
      {
         bagType = RetrieveController.Instance.type;
      }
      
      private function __onShine(param1:Event) : void
      {
         shine = RetrieveController.Instance.shine;
      }
      
      private function __onMouseEnable(param1:Event) : void
      {
         this.mouseChildren = RetrieveController.Instance.viewMouseEvtBoolean;
         this.mouseEnabled = RetrieveController.Instance.viewMouseEvtBoolean;
      }
      
      override public function dispose() : void
      {
         PlayerManager.Instance.Self.StoreBag.removeEventListener("update",_updateStoreBag);
         RetrieveController.Instance.removeEventListener("doubleclick",__onDoubleClick);
         RetrieveController.Instance.removeEventListener("retrievetype",__onRetrieveType);
         RetrieveController.Instance.removeEventListener("shine",__onShine);
         RetrieveController.Instance.removeEventListener("mouseenable",__onMouseEnable);
         RetrieveController.Instance.close();
         if(_retrieveBagView)
         {
            _retrieveBagView.bagView.setBagType(0);
         }
         disposeChildren = true;
         if(_retrieveBgView)
         {
            ObjectUtils.disposeObject(_retrieveBgView);
         }
         _retrieveBgView = null;
         if(_retrieveBagView)
         {
            ObjectUtils.disposeObject(_retrieveBagView);
         }
         _retrieveBagView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}
