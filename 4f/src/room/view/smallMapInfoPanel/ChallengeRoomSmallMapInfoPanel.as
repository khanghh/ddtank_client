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
      
      public function ChallengeRoomSmallMapInfoPanel(){super();}
      
      override public function dispose() : void{}
      
      override public function set info(param1:RoomInfo) : void{}
      
      public function shine() : void{}
      
      public function stopShine() : void{}
      
      override protected function initView() : void{}
      
      override protected function __onClick(param1:MouseEvent) : void{}
      
      private function __update(param1:RoomPlayerEvent = null) : void{}
      
      override protected function updateView() : void{}
      
      private function __titleCompleteHandler(param1:LoaderEvent) : void{}
      
      private function titlePath() : String{return null;}
   }
}
