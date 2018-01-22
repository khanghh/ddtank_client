package roomLoading.encounter
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import room.model.RoomPlayer;
   import roomLoading.view.RoomLoadingCharacterItem;
   
   public class EncounterLoadingCharacterItem extends RoomLoadingCharacterItem
   {
       
      
      protected var _nameBG:Bitmap;
      
      protected var _sexIcon:ScaleFrameImage;
      
      protected var _bubble:MovieClip;
      
      protected var _arrow:ScaleFrameImage;
      
      public function EncounterLoadingCharacterItem(param1:RoomPlayer){super(null);}
      
      override protected function init() : void{}
      
      override protected function initIcons() : void{}
      
      protected function __onClick(param1:MouseEvent) : void{}
      
      public function set selectObject(param1:int) : void{}
      
      public function set arrowVisible(param1:Boolean) : void{}
      
      public function set bubbleVisible(param1:Boolean) : void{}
      
      override public function dispose() : void{}
   }
}
