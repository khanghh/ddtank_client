package braveDoor.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import room.model.RoomInfo;
   
   public class DuplicateRoomItemView extends Sprite implements Disposeable
   {
       
      
      private var _info:RoomInfo;
      
      private var _itemBg:Bitmap;
      
      private var _desc:FilterFrameText;
      
      private var _placeCountText:FilterFrameText;
      
      public function DuplicateRoomItemView(info:RoomInfo = null)
      {
         _info = info;
         super();
         init();
      }
      
      private function init() : void
      {
         this.buttonMode = true;
         _desc = UICreatShortcut.creatTextAndAdd("asset.braveDoor.duplicateRoom.decText","OOXX",this);
         _placeCountText = UICreatShortcut.creatTextAndAdd("asset.braveDoor.duplicateRoom.placeCountText","OOXX",this);
         update();
      }
      
      private function update() : void
      {
         if(_info != null)
         {
            _desc.text = LanguageMgr.GetTranslation("DuplicateRoomItemView.Number");
            _placeCountText.text = String(_info.totalPlayer) + "/" + String(_info.placeCount);
            updateBgItem(_info.mapId);
         }
      }
      
      private function updateBgItem(id:int) : void
      {
         if(_itemBg)
         {
            ObjectUtils.disposeObject(_itemBg);
            _itemBg = null;
         }
         _itemBg = ComponentFactory.Instance.creat("asset.braveDoor.room.duplicateIcon" + id);
         addChildAt(_itemBg,0);
      }
      
      public function get info() : RoomInfo
      {
         return _info;
      }
      
      public function set info(value:RoomInfo) : void
      {
         _info = value;
         update();
      }
      
      public function dispose() : void
      {
         if(_itemBg)
         {
            ObjectUtils.disposeObject(_itemBg);
         }
         _itemBg = null;
         if(_desc)
         {
            ObjectUtils.disposeObject(_desc);
         }
         _desc = null;
         if(_placeCountText)
         {
            ObjectUtils.disposeObject(_placeCountText);
         }
         _placeCountText = null;
         _info = null;
      }
   }
}
