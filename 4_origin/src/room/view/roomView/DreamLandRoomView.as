package room.view.roomView
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import dreamlandChallenge.DreamlandChallengeControl;
   import dreamlandChallenge.DreamlandChallengeManager;
   import dreamlandChallenge.data.DreamLandModel;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import room.model.RoomInfo;
   import room.view.DreamLandRoomRightPropView;
   import room.view.RoomPlayerItem;
   import room.view.bigMapInfoPanel.DreamLandBigMapInfoPanel;
   import room.view.smallMapInfoPanel.MatchRoomSmallMapInfoPanel;
   
   public class DreamLandRoomView extends BaseRoomView
   {
       
      
      protected var _bg:MovieClip;
      
      protected var _crossZoneBtn:SelectedButton;
      
      protected var _itemListBg:MovieClip;
      
      protected var _smallMapInfoPanel:MatchRoomSmallMapInfoPanel;
      
      protected var _bigMapInfoPanel:DreamLandBigMapInfoPanel;
      
      protected var _playerItemContainer:SimpleTileList;
      
      public function DreamLandRoomView(info:RoomInfo)
      {
         DreamLandRoomRightPropView;
         super(info);
      }
      
      override protected function initView() : void
      {
         _bg = ClassUtils.CreatInstance("asset.background.room.right") as MovieClip;
         PositionUtils.setPos(_bg,"asset.ddtmatchroom.bgPos");
         addChild(_bg);
         _itemListBg = ClassUtils.CreatInstance("asset.ddtroom.playerItemlist.bg") as MovieClip;
         PositionUtils.setPos(_itemListBg,"asset.ddtroom.playerItemlist.bgPos");
         addChild(_itemListBg);
         _bigMapInfoPanel = ComponentFactory.Instance.creatCustomObject("ddtroom.dreamLand.bigMapInfoPanel");
         addChild(_bigMapInfoPanel);
         _smallMapInfoPanel = ComponentFactory.Instance.creatCustomObject("ddtroom.matchRoomSmallMapInfoPanel");
         _smallMapInfoPanel.info = _info;
         _smallMapInfoPanel.mouseChildren = false;
         _smallMapInfoPanel.mouseEnabled = false;
         addChild(_smallMapInfoPanel);
         _crossZoneBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.crossZoneButton");
         _crossZoneBtn.selected = _info.isCrossZone;
         _crossZoneBtn.enable = false;
         addChild(_crossZoneBtn);
         super.initView();
      }
      
      override protected function __prepareClick(evt:MouseEvent) : void
      {
         if(isEnoughChallengeCount)
         {
            super.__prepareClick(evt);
         }
      }
      
      override protected function __startClick(evt:MouseEvent) : void
      {
         if(isEnoughChallengeCount)
         {
            super.__startClick(evt);
         }
      }
      
      private function get isEnoughChallengeCount() : Boolean
      {
         var dreamLandMode:DreamLandModel = DreamlandChallengeManager.instance.mode;
         var count:int = dreamLandMode.surplusCount;
         if(count <= 0)
         {
            DreamlandChallengeControl.instance.showBuychallengeCountFrame();
            return false;
         }
         return true;
      }
      
      override protected function updateButtons() : void
      {
         super.updateButtons();
         _smallMapInfoPanel._actionStatus = false;
         _smallMapInfoPanel.filters = ComponentFactory.Instance.creatFilters("grayFilter");
      }
      
      override protected function initTileList() : void
      {
         var i:int = 0;
         var item:* = null;
         super.initTileList();
         _playerItemContainer = new SimpleTileList(2);
         var space:Point = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.matchRoom.listSpace");
         _playerItemContainer.hSpace = space.x;
         _playerItemContainer.vSpace = space.y;
         var p:Point = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.playerListPos");
         _playerItemContainer.x = _bg.x + p.x;
         _playerItemContainer.y = _bg.y + p.y;
         for(i = 0; i < 4; )
         {
            item = new RoomPlayerItem(i);
            _playerItemContainer.addChild(item);
            _playerItems.push(item);
            i++;
         }
         addChild(_playerItemContainer);
         if(isViewerRoom)
         {
            PositionUtils.setPos(_viewerItems[0],"asset.ddtmatchroom.ViewerItemPos");
            addChild(_viewerItems[0]);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_bg)
         {
            removeChild(_bg);
         }
         _bg = null;
         ObjectUtils.disposeObject(_bigMapInfoPanel);
         _bigMapInfoPanel = null;
         ObjectUtils.disposeObject(_smallMapInfoPanel);
         _smallMapInfoPanel = null;
         ObjectUtils.disposeObject(_playerItemContainer);
         _playerItemContainer = null;
         ObjectUtils.disposeObject(_crossZoneBtn);
         _crossZoneBtn = null;
         ObjectUtils.disposeObject(_itemListBg);
         _itemListBg = null;
      }
   }
}
