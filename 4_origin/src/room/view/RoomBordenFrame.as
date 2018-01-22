package room.view
{
   import com.pickgliss.ui.controls.Frame;
   import ddt.events.BagEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import road7th.data.DictionaryData;
   
   public class RoomBordenFrame extends Frame
   {
       
      
      private var _roomBordenListView:RoomBordenBagListView;
      
      private var _equipBagInfo:DictionaryData;
      
      public function RoomBordenFrame()
      {
         super();
         updateMoveRect();
      }
      
      override protected function init() : void
      {
         super.init();
         titleText = LanguageMgr.GetTranslation("tank.room.roomBorden.title");
         autoExit = true;
         escEnable = true;
         initView();
         addEvents();
      }
      
      private function initView() : void
      {
         _roomBordenListView = new RoomBordenBagListView();
         _roomBordenListView.setup(43,54,6);
         addToContent(_roomBordenListView);
         refreshBagList();
      }
      
      private function refreshBagList() : void
      {
         _equipBagInfo = PlayerManager.Instance.Self.getBag(43).items;
         _roomBordenListView.setData(_equipBagInfo);
      }
      
      private function addEvents() : void
      {
         PlayerManager.Instance.Self.getBag(43).addEventListener("update",__updateBordenBag);
      }
      
      private function __updateBordenBag(param1:BagEvent) : void
      {
         refreshBagList();
      }
      
      private function removeEvents() : void
      {
         PlayerManager.Instance.Self.getBag(43).removeEventListener("update",__updateBordenBag);
      }
      
      override public function dispose() : void
      {
         removeEvents();
         _equipBagInfo = null;
         super.dispose();
      }
   }
}
