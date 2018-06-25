package room.view.bigMapInfoPanel
{
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.RoomEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.view.MainToolBar;
   import ddt.view.SelectStateButton;
   import dreamlandChallenge.DreamlandChallengeControl;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import room.RoomManager;
   import room.model.RoomInfo;
   
   public class DreamLandBigMapInfoPanel extends Sprite implements Disposeable
   {
       
      
      protected var _bg:MutipleImage;
      
      protected var _smallBg:Bitmap;
      
      protected var _titleIcon:ScaleFrameImage;
      
      protected var _timeTxt:FilterFrameText;
      
      protected var _timer:Timer;
      
      protected var _info:RoomInfo;
      
      protected var _mapShowContainer:Sprite;
      
      protected var _loader:DisplayLoader;
      
      protected var _modeContainer:Sprite;
      
      protected var _freeModeBtn:SelectStateButton;
      
      protected var _desc:FilterFrameText;
      
      protected var _requireTxt:FilterFrameText;
      
      public function DreamLandBigMapInfoPanel()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.bigMapinfo.bg");
         addChild(_bg);
         _mapShowContainer = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.bigMapIconContainer");
         addChild(_mapShowContainer);
         _modeContainer = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.modeContainer");
         addChild(_modeContainer);
         _smallBg = ComponentFactory.Instance.creatBitmap("asset.ddtroom.bigMapInfo.smallBg");
         addChild(_smallBg);
         _smallBg.visible = false;
         initMode();
         _info = RoomManager.Instance.current;
         if(_info)
         {
            _info.addEventListener("hardLevelChanged",__onMapChanged);
            updateMap();
         }
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.bigMapinfo.timeTxt");
         addChild(_timeTxt);
         _timer = new Timer(1000);
         _timer.addEventListener("timer",__timer);
      }
      
      protected function __onMapChanged(evt:RoomEvent) : void
      {
         updateMap();
      }
      
      protected function updateMap() : void
      {
         _titleIcon.setFrame(_info.hardLevel);
         var levObj:Object = DreamlandChallengeControl.instance.getLevByDifficlty(_info.hardLevel);
         _requireTxt.text = LanguageMgr.GetTranslation("ddt.dreamLand.roomMode.requireTxt",levObj.minLev,levObj.maxLev);
         if(_info && _info.mapId > 0)
         {
            if(_loader)
            {
               _loader.removeEventListener("complete",__showMap);
            }
            _loader = LoadResourceManager.Instance.createLoader(solvePath(),0);
            _loader.addEventListener("complete",__showMap);
            LoadResourceManager.Instance.startLoad(_loader);
         }
      }
      
      private function __showMap(evt:LoaderEvent) : void
      {
         if(evt.loader.isSuccess)
         {
            ObjectUtils.disposeAllChildren(_mapShowContainer);
            evt.loader.removeEventListener("complete",__showMap);
            _mapShowContainer.addChild(evt.loader.content as Bitmap);
            _mapShowContainer.width = 315;
            _mapShowContainer.height = 357;
         }
      }
      
      protected function solvePath() : String
      {
         var result:String = "";
         result = PathManager.SITE_MAIN + "image/map/" + _info.mapId + "/show1.jpg";
         return result;
      }
      
      protected function initMode() : void
      {
         _freeModeBtn = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.bigMapInfoPanel.freeModeButton");
         _freeModeBtn.backGround = ComponentFactory.Instance.creatBitmap("asset.ddtroom.bigMapInfo.dreamLandModeBtn");
         _titleIcon = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.dreamLand.mode.icon");
         _desc = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.dreamLand.descText");
         _desc.text = LanguageMgr.GetTranslation("ddt.dreamLand.roomMode.descTxt");
         _requireTxt = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.dreamLand.requireText");
         _modeContainer.addChild(_freeModeBtn);
         _modeContainer.addChild(_titleIcon);
         _modeContainer.addChild(_desc);
         _modeContainer.addChild(_requireTxt);
      }
      
      protected function __startedHandler(evt:RoomEvent) : void
      {
         RoomManager.Instance.isMatch = _info.started;
         if(_info.started)
         {
            if(!_timer.running)
            {
               _timeTxt.text = "00";
               _timer.start();
            }
         }
         else
         {
            _timer.stop();
            _timer.reset();
         }
         updateView();
      }
      
      private function updateView() : void
      {
         if(_freeModeBtn && _smallBg)
         {
            if(_info)
            {
               _smallBg.visible = _timeTxt.visible;
            }
         }
      }
      
      protected function __timer(evt:TimerEvent) : void
      {
         var min:uint = _timer.currentCount / 60;
         var sec:uint = _timer.currentCount % 60;
         _timeTxt.text = sec > 9?sec.toString():"0" + sec;
         if(_timer.currentCount == 20)
         {
            if(!_info.selfRoomPlayer.isHost && !_info.selfRoomPlayer.isViewer)
            {
               MainToolBar.Instance.setReturnEnable(true);
               dispatchEvent(new RoomEvent("tweentySec"));
            }
         }
      }
      
      protected function removeEvents() : void
      {
         if(_loader)
         {
            _loader.removeEventListener("complete",__showMap);
         }
         _info.removeEventListener("mapChanged",__onMapChanged);
      }
      
      public function dispose() : void
      {
         removeEvents();
         RoomManager.Instance.isMatch = false;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         ObjectUtils.disposeObject(_freeModeBtn);
         _freeModeBtn = null;
         ObjectUtils.disposeObject(_smallBg);
         _smallBg = null;
         ObjectUtils.disposeObject(_titleIcon);
         _titleIcon = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeObject(_desc);
         _desc = null;
         ObjectUtils.disposeObject(_requireTxt);
         _requireTxt = null;
         ObjectUtils.disposeAllChildren(_mapShowContainer);
         _mapShowContainer = null;
         ObjectUtils.disposeAllChildren(_modeContainer);
         _modeContainer = null;
         _loader = null;
         _info = null;
         _timer.stop();
         _timer = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
