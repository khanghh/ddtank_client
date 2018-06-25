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
      
      public function updateBag(dic:Dictionary) : void
      {
      }
      
      private function _updateStoreBag(e:BagEvent) : void
      {
         if(_retrieveBgView)
         {
            _retrieveBgView.refreshData(e.changedSlots);
         }
      }
      
      public function cellDoubleClick(cell:BagCell) : void
      {
         if(_retrieveBgView)
         {
            _retrieveBgView.cellDoubleClick(cell);
         }
      }
      
      public function set bagType(i:int) : void
      {
         RetrieveBagView(_retrieveBagView.bagView).resultPoint(i,_retrieveBagView.x - _retrieveBgView.x,_retrieveBagView.y - _retrieveBgView.y);
      }
      
      public function set shine(boo:Boolean) : void
      {
         if(boo == true)
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
      
      override public function set visible(value:Boolean) : void
      {
         .super.visible = value;
         if(!value)
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
      
      private function _response(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(!RetrieveController.Instance.viewMouseEvtBoolean)
         {
            return;
         }
         if(e.responseCode == 0 || e.responseCode == 1 || RetrieveController.Instance.viewMouseEvtBoolean)
         {
            RetrieveController.Instance.close();
         }
      }
      
      private function __onDoubleClick(e:Event) : void
      {
         cellDoubleClick(RetrieveController.Instance.cell);
      }
      
      private function __onRetrieveType(e:Event) : void
      {
         bagType = RetrieveController.Instance.type;
      }
      
      private function __onShine(e:Event) : void
      {
         shine = RetrieveController.Instance.shine;
      }
      
      private function __onMouseEnable(e:Event) : void
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
