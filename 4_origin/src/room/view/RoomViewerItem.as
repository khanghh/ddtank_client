package room.view
{
   import bagAndInfo.info.PlayerInfoViewControl;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.RoomEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerTipManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.MainToolBar;
   import ddt.view.PlayerPortraitView;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import gameCommon.GameControl;
   import gameCommon.model.GameInfo;
   import room.RoomManager;
   import room.events.RoomPlayerEvent;
   import room.model.RoomPlayer;
   
   public class RoomViewerItem extends Sprite implements Disposeable
   {
      
      public static const LONG:uint = 186;
      
      public static const SHORT:uint = 90;
       
      
      private var _bg:Bitmap;
      
      private var _bgWidth:int;
      
      private var _waitingBitmap:Bitmap;
      
      private var _closeBitmap:Bitmap;
      
      private var _headFigureFrame:Bitmap;
      
      private var _info:RoomPlayer;
      
      private var _portrait:PlayerPortraitView;
      
      private var _kickOutBtn:SimpleBitmapButton;
      
      private var _viewInfoBtn:SimpleBitmapButton;
      
      private var _addFriendBtn:SimpleBitmapButton;
      
      private var _nameTxt:FilterFrameText;
      
      private var _place:int;
      
      private var _opened:Boolean;
      
      private var _loadingMode:Boolean;
      
      public function RoomViewerItem(place:int = 8, widthType:uint = 186)
      {
         super();
         _place = place;
         _bgWidth = widthType;
         init();
      }
      
      private function init() : void
      {
         buttonMode = true;
         if(_bgWidth == 186)
         {
            _bg = ComponentFactory.Instance.creatBitmap("asset.ddtroom.viewerItem.bigbg");
            _waitingBitmap = ComponentFactory.Instance.creatBitmap("asset.ddtroom.viewerItem.bigWaitAsset");
            _closeBitmap = ComponentFactory.Instance.creatBitmap("asset.ddtroom.viewerItem.bigOpenAsset");
         }
         else
         {
            _bg = ComponentFactory.Instance.creatBitmap("asset.ddtroom.viewerItem.smallbg");
            _waitingBitmap = ComponentFactory.Instance.creatBitmap("asset.ddtroom.viewerItem.smallWaitAsset");
            _closeBitmap = ComponentFactory.Instance.creatBitmap("asset.ddtroom.viewerItem.smallOpenAsset");
         }
         _headFigureFrame = ComponentFactory.Instance.creatBitmap("asset.ddtroom.ViewerHeadFigureFrame");
         _viewInfoBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.playerItem.ViewInfoButton");
         PositionUtils.setPos(_viewInfoBtn,"asset.ddtroom.viewer.viewInfoPos");
         _kickOutBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.playerItem.kickOutButton");
         PositionUtils.setPos(_kickOutBtn,"asset.ddtroom.viewer.closePos");
         _addFriendBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.playerItem.addFriendButton");
         PositionUtils.setPos(_addFriendBtn,"asset.ddtroom.viewer.addFriendPos");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.ViewerItem.NameTxt");
         var _loc1_:* = true;
         _addFriendBtn.transparentEnable = _loc1_;
         _loc1_ = _loc1_;
         _kickOutBtn.transparentEnable = _loc1_;
         _viewInfoBtn.transparentEnable = _loc1_;
         _portrait = new PlayerPortraitView("right");
         _portrait.isShowFrame = false;
         _loc1_ = 0.5;
         _portrait.scaleY = _loc1_;
         _portrait.scaleX = _loc1_;
         PositionUtils.setPos(_portrait,"asset.ddtroom.ViewerItem.PortraitPos");
         _addFriendBtn.tipData = LanguageMgr.GetTranslation("tank.room.RoomIIPlayerItem.addFriend");
         _viewInfoBtn.tipData = LanguageMgr.GetTranslation("tank.room.RoomIIPlayerItem.view");
         _kickOutBtn.tipData = LanguageMgr.GetTranslation("tank.room.RoomIIPlayerItem.exitRoom");
         if(_bgWidth == 90)
         {
            _addFriendBtn.x = 39;
            _viewInfoBtn.x = 57;
            _kickOutBtn.x = 73;
            _nameTxt.width = 44;
            _nameTxt.x = 43;
         }
         setCenterPos(_waitingBitmap);
         addChild(_bg);
         addChild(_waitingBitmap);
         initEvents();
      }
      
      public function changeBg() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = ComponentFactory.Instance.creatBitmap("asset.roomloading.hasViewer");
         addChildAt(_bg,0);
      }
      
      public function set opened(value:Boolean) : void
      {
         _opened = value;
         if(_opened && _info == null)
         {
            if(contains(_closeBitmap))
            {
               removeChild(_closeBitmap);
            }
            setCenterPos(_waitingBitmap);
            addChildAt(_waitingBitmap,1);
            buttonMode = true;
         }
         else if(_info == null)
         {
            if(contains(_waitingBitmap))
            {
               removeChild(_waitingBitmap);
            }
            setCenterPos(_closeBitmap);
            addChildAt(_closeBitmap,1);
            if(!RoomManager.Instance.current.selfRoomPlayer.isHost)
            {
               buttonMode = false;
            }
         }
      }
      
      public function set loadingMode(value:Boolean) : void
      {
         if(value)
         {
            _loadingMode = value;
            if(contains(_viewInfoBtn))
            {
               removeChild(_viewInfoBtn);
            }
            if(contains(_kickOutBtn))
            {
               removeChild(_kickOutBtn);
            }
            if(contains(_addFriendBtn))
            {
               removeChild(_addFriendBtn);
            }
         }
      }
      
      private function setCenterPos(display:DisplayObject) : void
      {
         display.x = (_bgWidth - display.width) / 2;
         display.y = (_bg.height - display.height) / 2;
      }
      
      public function get info() : RoomPlayer
      {
         return _info;
      }
      
      public function set info(info:RoomPlayer) : void
      {
         var _gameInfo:* = null;
         if(info != null && info.isSelf)
         {
            MainToolBar.Instance.setRoomStartState();
            MainToolBar.Instance.setReturnEnable(true);
         }
         _kickOutBtn.enable = RoomManager.Instance.current.selfRoomPlayer.isHost;
         if(_info == info)
         {
            return;
         }
         _info = info;
         if(_info)
         {
            if(contains(_closeBitmap))
            {
               removeChild(_closeBitmap);
            }
            if(contains(_waitingBitmap))
            {
               removeChild(_waitingBitmap);
            }
            if(!_loadingMode)
            {
               addChild(_viewInfoBtn);
               addChild(_kickOutBtn);
               addChild(_addFriendBtn);
            }
            _gameInfo = GameControl.Instance.Current;
            if(!_loadingMode && _gameInfo != null && _gameInfo.hasNextMission && (RoomManager.Instance.current.type == 4 || RoomManager.Instance.current.type == 23 || RoomManager.Instance.current.type == 11 || RoomManager.Instance.current.type == 123))
            {
               _gameInfo.livingToViewer(_info.playerInfo.ID,_info.playerInfo.ZoneID);
            }
            _info.place = _place;
            _portrait.info = _info.playerInfo;
            _nameTxt.text = _info.playerInfo.NickName;
            addChild(_headFigureFrame);
            addChild(_portrait);
            addChild(_nameTxt);
            if(_info == RoomManager.Instance.current.selfRoomPlayer)
            {
               dispatchEvent(new RoomEvent("viewerItemInfoSet",[1]));
            }
            return;
         }
         if(contains(_headFigureFrame))
         {
            removeChild(_headFigureFrame);
         }
         if(contains(_portrait))
         {
            removeChild(_portrait);
         }
         if(contains(_nameTxt))
         {
            removeChild(_nameTxt);
         }
         if(contains(_viewInfoBtn))
         {
            removeChild(_viewInfoBtn);
         }
         if(contains(_kickOutBtn))
         {
            removeChild(_kickOutBtn);
         }
         if(contains(_addFriendBtn))
         {
            removeChild(_addFriendBtn);
         }
         setCenterPos(_waitingBitmap);
         addChildAt(_waitingBitmap,1);
         dispatchEvent(new RoomEvent("viewerItemInfoSet",[0]));
      }
      
      private function __infoStateChange(event:RoomPlayerEvent) : void
      {
      }
      
      private function initEvents() : void
      {
         _viewInfoBtn.addEventListener("click",__clickHandler);
         _addFriendBtn.addEventListener("click",__clickHandler);
         _kickOutBtn.addEventListener("click",__clickHandler);
         addEventListener("click",__changePlace);
         RoomManager.Instance.current.addEventListener("startedChanged",__updateBtns);
         RoomManager.Instance.current.selfRoomPlayer.addEventListener("isHostChange",__updateBtns);
      }
      
      private function removeEvents() : void
      {
         _viewInfoBtn.removeEventListener("click",__clickHandler);
         _addFriendBtn.removeEventListener("click",__clickHandler);
         _kickOutBtn.removeEventListener("click",__clickHandler);
         removeEventListener("click",__changePlace);
         RoomManager.Instance.current.removeEventListener("startedChanged",__updateBtns);
         RoomManager.Instance.current.selfRoomPlayer.removeEventListener("isHostChange",__updateBtns);
      }
      
      private function __updateBtns(e:Event) : void
      {
         buttonMode = !RoomManager.Instance.current.started;
         if(_info != null)
         {
            buttonMode = true;
         }
         _kickOutBtn.enable = !RoomManager.Instance.current.started && RoomManager.Instance.current.selfRoomPlayer.isHost;
      }
      
      private function __changePlace(event:MouseEvent) : void
      {
         if(_info)
         {
            PlayerInfoViewControl.view(_info.playerInfo);
            SoundManager.instance.play("008");
            return;
         }
         if(RoomManager.Instance.current.started)
         {
            return;
         }
         if(RoomManager.Instance.current.selfRoomPlayer.isHost)
         {
            GameInSocketOut.sendGameRoomPlaceState(_place,!!_opened?0:-1);
         }
         else
         {
            if(!_opened)
            {
               return;
            }
            if(RoomManager.Instance.current.selfRoomPlayer.isViewer)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("room.UnableToSwitchToAnotherViewer"));
            }
            else if(RoomManager.Instance.current.selfRoomPlayer.isReady)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("room.UnableToSwitchToAnotherViewerWhenIsReady"));
            }
            else
            {
               GameInSocketOut.sendGameRoomPlaceState(RoomManager.Instance.current.selfRoomPlayer.place,-1,true,_place);
            }
         }
         SoundManager.instance.play("008");
      }
      
      private function __clickHandler(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         e.stopImmediatePropagation();
         var _loc2_:* = e.currentTarget;
         if(_viewInfoBtn !== _loc2_)
         {
            if(_addFriendBtn !== _loc2_)
            {
               if(_kickOutBtn === _loc2_)
               {
                  GameInSocketOut.sendGameRoomKick(_info.place);
               }
            }
            else
            {
               IMManager.Instance.addFriend(_info.playerInfo.NickName);
            }
         }
         else
         {
            PlayerTipManager.show(_info.playerInfo,localToGlobal(new Point(0,0)).y);
         }
      }
      
      public function dispose() : void
      {
         removeEvents();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_waitingBitmap)
         {
            if(_waitingBitmap.parent)
            {
               _waitingBitmap.parent.removeChild(_waitingBitmap);
            }
            _waitingBitmap.bitmapData.dispose();
            _waitingBitmap = null;
         }
         if(_closeBitmap)
         {
            if(_closeBitmap.parent)
            {
               _closeBitmap.parent.removeChild(_closeBitmap);
            }
            _closeBitmap.bitmapData.dispose();
            _closeBitmap = null;
         }
         if(_headFigureFrame)
         {
            if(_headFigureFrame.parent)
            {
               _headFigureFrame.parent.removeChild(_headFigureFrame);
            }
            _headFigureFrame.bitmapData.dispose();
            _headFigureFrame = null;
         }
         _info = null;
         if(_nameTxt)
         {
            _nameTxt.dispose();
         }
         _nameTxt = null;
         if(_portrait)
         {
            _portrait.dispose();
         }
         _portrait = null;
         if(_viewInfoBtn)
         {
            _viewInfoBtn.dispose();
         }
         _viewInfoBtn = null;
         if(_addFriendBtn)
         {
            _addFriendBtn.dispose();
         }
         _addFriendBtn = null;
         if(_kickOutBtn)
         {
            _kickOutBtn.dispose();
         }
         _kickOutBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
