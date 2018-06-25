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
      
      public function EncounterLoadingCharacterItem($info:RoomPlayer)
      {
         super($info);
      }
      
      override protected function init() : void
      {
         if(_info.team == 1)
         {
            _perecentageTxt = ComponentFactory.Instance.creatComponentByStylename("roomLoading.CharacterItemPercentageBlueTxt");
         }
         else
         {
            _perecentageTxt = ComponentFactory.Instance.creatComponentByStylename("roomLoading.CharacterItemPercentageRedTxt");
         }
         _perecentageTxt.text = "0%";
         _info.addEventListener("progressChange",__onProgress);
         _info.character.scaleX = !!_info.playerInfo.Sex?1:-1;
         _info.character.stopAnimation();
         _info.character.setShowLight(false);
         _info.character.showWing = false;
         _info.character.showGun = false;
         addChild(_info.character);
         addChild(_perecentageTxt);
         _sexIcon = UICreatShortcut.creatAndAdd("roomLoading.encounter.EncounterLoadingCharacterItem.sexIcon",this);
         _sexIcon.setFrame(!!info.playerInfo.Sex?2:1);
         _bubble = UICreatShortcut.creatAndAdd("roomLoading.EncounterLoadingView.select",this);
         _bubble.visible = PlayerManager.Instance.Self.Sex != info.playerInfo.Sex;
         _arrow = UICreatShortcut.creatAndAdd("roomLoading.EncounterLoadingView.arrow",this);
         _arrow.visible = false;
         if(info.playerInfo.Sex)
         {
            _arrow.setFrame(2);
         }
         else
         {
            _arrow.setFrame(1);
            PositionUtils.setPos(_arrow,"roomLoading.EncounterLoadingView.arrowPos2");
         }
         _iconContainer = ComponentFactory.Instance.creatComponentByStylename("asset.roomLoadingPlayerItem.iconContainer");
         initIcons();
      }
      
      override protected function initIcons() : void
      {
         super.initIcons();
         _levelIcon.parent.removeChild(_levelIcon);
      }
      
      protected function __onClick(event:MouseEvent) : void
      {
         _arrow.rotation = _arrow.rotation + 4;
      }
      
      public function set selectObject(type:int) : void
      {
         _arrow.visible = true;
         switch(int(type) - 1)
         {
            case 0:
               break;
            case 1:
               if(info.playerInfo.Sex)
               {
                  _arrow.rotation = 16;
               }
               else
               {
                  _arrow.rotation = -20;
               }
               break;
            case 2:
               if(info.playerInfo.Sex)
               {
                  _arrow.rotation = -12;
                  break;
               }
               _arrow.rotation = 12;
               break;
         }
      }
      
      public function set arrowVisible(value:Boolean) : void
      {
         _arrow.visible = value;
         _bubble.visible = false;
      }
      
      public function set bubbleVisible(value:Boolean) : void
      {
         _bubble.visible = value;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_nameBG);
         _nameBG = null;
         ObjectUtils.disposeObject(_sexIcon);
         _sexIcon = null;
         ObjectUtils.disposeObject(_bubble);
         _bubble = null;
         ObjectUtils.disposeObject(_arrow);
         _arrow = null;
         super.dispose();
      }
   }
}
