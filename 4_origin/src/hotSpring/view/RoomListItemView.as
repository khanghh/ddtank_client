package hotSpring.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.HotSpringRoomInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import hotSpring.event.HotSpringRoomListEvent;
   import hotSpring.model.HotSpringRoomListModel;
   
   public class RoomListItemView extends Sprite implements Disposeable
   {
       
      
      private var _roomVO:HotSpringRoomInfo;
      
      private var _selected:Boolean;
      
      private var _model:HotSpringRoomListModel;
      
      private var _itemBG:ScaleFrameImage;
      
      private var _mcLock:Bitmap;
      
      private var _lblRoomNumber:FilterFrameText;
      
      private var _lblRoomName:FilterFrameText;
      
      private var _lblCurCount:FilterFrameText;
      
      private var _percentSinge:FilterFrameText;
      
      private var _lblMaxCount:FilterFrameText;
      
      public function RoomListItemView(param1:HotSpringRoomListModel, param2:HotSpringRoomInfo)
      {
         super();
         _model = param1;
         _roomVO = param2;
         initialize();
      }
      
      private function initialize() : void
      {
         _mcLock = ComponentFactory.Instance.creatBitmap("asset.HotSpringMainView.roomItem.lockAsset");
         addChild(_mcLock);
         initField();
         updateView();
         setEvent();
      }
      
      private function initField() : void
      {
         _lblRoomNumber = ComponentFactory.Instance.creat("asset.HotSpringMainView.lblRoomNumber");
         addChild(_lblRoomNumber);
         _lblRoomName = ComponentFactory.Instance.creat("asset.HotSpringMainView.lblRoomName");
         addChild(_lblRoomName);
         _lblCurCount = ComponentFactory.Instance.creat("asset.HotSpringMainView.lblCurCount");
         addChild(_lblCurCount);
         _percentSinge = ComponentFactory.Instance.creat("asset.HotSpringMainView.percentSinge");
         _percentSinge.text = "/";
         addChild(_percentSinge);
         _lblMaxCount = ComponentFactory.Instance.creat("asset.HotSpringMainView.lblMaxCount");
         addChild(_lblMaxCount);
      }
      
      private function updateView() : void
      {
         var _loc1_:String = _roomVO.roomNumber.toString();
         _lblRoomNumber.text = _loc1_;
         _lblRoomName.text = _roomVO.roomName;
         _lblCurCount.text = _roomVO.curCount.toString();
         _lblMaxCount.text = _roomVO.maxCount.toString();
         _mcLock.visible = _roomVO.roomIsPassword;
      }
      
      private function setEvent() : void
      {
         _model.addEventListener("roomUpdate",roomUpdate);
      }
      
      private function roomUpdate(param1:HotSpringRoomListEvent) : void
      {
         var _loc2_:HotSpringRoomInfo = param1.data as HotSpringRoomInfo;
         if(_roomVO.roomID == _loc2_.roomID)
         {
            _roomVO = _loc2_;
            updateView();
         }
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(_selected == param1)
         {
            return;
         }
         _selected = param1;
      }
      
      public function get roomVO() : HotSpringRoomInfo
      {
         return _roomVO;
      }
      
      public function dispose() : void
      {
         _model.removeEventListener("roomUpdate",roomUpdate);
         _model = null;
         _roomVO = null;
         if(_itemBG)
         {
            ObjectUtils.disposeObject(_itemBG);
            _itemBG = null;
         }
         ObjectUtils.disposeObject(_mcLock);
         _mcLock = null;
         if(_lblRoomNumber)
         {
            ObjectUtils.disposeObject(_lblRoomNumber);
            _lblRoomNumber = null;
         }
         if(_lblRoomName)
         {
            ObjectUtils.disposeObject(_lblRoomName);
            _lblRoomName = null;
         }
         if(_lblCurCount)
         {
            ObjectUtils.disposeObject(_lblCurCount);
            _lblCurCount = null;
         }
         if(_percentSinge)
         {
            ObjectUtils.disposeObject(_percentSinge);
            _percentSinge = null;
         }
         if(_lblMaxCount)
         {
            ObjectUtils.disposeObject(_lblMaxCount);
            _lblMaxCount = null;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
