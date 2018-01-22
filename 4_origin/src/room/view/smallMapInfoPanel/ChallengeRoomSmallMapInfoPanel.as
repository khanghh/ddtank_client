package room.view.smallMapInfoPanel
{
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PathManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import room.events.RoomPlayerEvent;
   import room.model.RoomInfo;
   import room.view.chooseMap.ChallengeChooseMapView;
   
   public class ChallengeRoomSmallMapInfoPanel extends MatchRoomSmallMapInfoPanel implements Disposeable
   {
      
      public static const CHANGE_RPOVIEW:String = "change_proView";
       
      
      private var _titleLoader:DisplayLoader;
      
      private var _titleIconContainer:Sprite;
      
      public function ChallengeRoomSmallMapInfoPanel()
      {
         super();
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(_titleIconContainer);
         _info.selfRoomPlayer.removeEventListener("isHostChange",__update);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      override public function set info(param1:RoomInfo) : void
      {
         .super.info = param1;
         if(_info)
         {
            _info.selfRoomPlayer.addEventListener("isHostChange",__update);
         }
         if(_info && _info.selfRoomPlayer.isHost)
         {
            buttonMode = true;
            addEventListener("click",__onClick);
         }
         else
         {
            buttonMode = true;
            removeEventListener("click",__onClick);
         }
         __update();
      }
      
      public function shine() : void
      {
      }
      
      public function stopShine() : void
      {
      }
      
      override protected function initView() : void
      {
         super.initView();
         _titleIconContainer = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.challenge.chooseMap.titleSprite");
         _timeType.setFrame(2);
         addChild(_titleIconContainer);
         _titleIconContainer.visible = false;
         buttonMode = true;
      }
      
      override protected function __onClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("045");
         var _loc2_:ChallengeChooseMapView = new ChallengeChooseMapView();
         _loc2_.show();
      }
      
      private function __update(param1:RoomPlayerEvent = null) : void
      {
         if(_info.selfRoomPlayer.isHost)
         {
            addEventListener("click",__onClick);
         }
         else
         {
            removeEventListener("click",__onClick);
         }
      }
      
      override protected function updateView() : void
      {
         _titleIconContainer.visible = _info.mapId != 0;
         super.updateView();
         this.dispatchEvent(new Event("change_proView"));
         if(_titleLoader)
         {
            _titleLoader = null;
         }
         _titleLoader = LoadResourceManager.Instance.createLoader(titlePath(),0);
         _titleLoader.addEventListener("complete",__titleCompleteHandler);
         LoadResourceManager.Instance.startLoad(_titleLoader);
      }
      
      private function __titleCompleteHandler(param1:LoaderEvent) : void
      {
         ObjectUtils.disposeAllChildren(_titleIconContainer);
         if(param1.loader.isSuccess)
         {
            param1.loader.removeEventListener("complete",__titleCompleteHandler);
            _titleIconContainer.addChild(param1.loader.content as Bitmap);
         }
      }
      
      private function titlePath() : String
      {
         if(_info && _info.mapId > 0)
         {
            return PathManager.SITE_MAIN + "image/map/" + _info.mapId.toString() + "/icon.png";
         }
         return PathManager.SITE_MAIN + "image/map/0/icon.png";
      }
   }
}
