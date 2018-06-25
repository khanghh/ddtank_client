package AvatarCollection.view
{
   import AvatarCollection.AvatarCollectionManager;
   import AvatarCollection.data.AvatarCollectionUnitVo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.Helpers;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class AvatarCollectionUnitListCell extends Sprite implements Disposeable, IListCell
   {
       
      
      private var _bg:ScaleFrameImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _data:AvatarCollectionUnitVo;
      
      private var _canActivityIcon:Bitmap;
      
      private var _selector:SelectedCheckButton;
      
      private var _completeCount:int;
      
      public function AvatarCollectionUnitListCell()
      {
         super();
         this.mouseChildren = false;
         this.buttonMode = true;
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("avatarColl.unitListCell.bg");
         _bg.setFrame(1);
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("avatarColl.unitListCell.nameTxt");
         _nameTxt.setFrame(1);
         _canActivityIcon = ComponentFactory.Instance.creatBitmap("asset.avatarColl.unitCell.canActivityIcon");
         _canActivityIcon.visible = false;
         addChild(_bg);
         addChild(_nameTxt);
         addChild(_canActivityIcon);
         _selector = ComponentFactory.Instance.creat("avator.selector");
         addChild(_selector);
         this.addEventListener("click",onClick);
      }
      
      private function onClick(e:MouseEvent) : void
      {
         if(_data.totalActivityItemCount < _completeCount)
         {
            _selector.selected = false;
            return;
         }
         _selector.selected = !_selector.selected;
         AvatarCollectionManager.instance.onListCellClick(_data,_selector.selected);
      }
      
      public function set select(value:Boolean) : void
      {
         if(_data.totalActivityItemCount < _completeCount)
         {
            _selector.selected = false;
            return;
         }
         _selector.selected = value;
         AvatarCollectionManager.instance.onListCellClick(_data,_selector.selected);
      }
      
      public function get select() : Boolean
      {
         return _selector.selected;
      }
      
      private function updateViewData() : void
      {
         if(_data.totalActivityItemCount >= _completeCount)
         {
            Helpers.grey(_selector);
            _selector.enable = true;
            _selector.selected = AvatarCollectionManager.instance.getSelectState(_data);
         }
         else
         {
            _selector.selected = false;
            _selector.enable = false;
         }
         var totalCount:int = _data.totalItemList.length;
         var activityCount:int = _data.totalActivityItemCount;
         _nameTxt.text = _data.name + "（" + activityCount + "/" + totalCount + "）";
         if(_data.canActivityCount > 0)
         {
            _canActivityIcon.visible = true;
         }
         else
         {
            _canActivityIcon.visible = false;
         }
      }
      
      public function setListCellStatus(list:List, isSelected:Boolean, index:int) : void
      {
         _bg.setFrame(!!isSelected?2:1);
         _nameTxt.setFrame(!!isSelected?2:1);
      }
      
      public function getCellValue() : *
      {
         return _data;
      }
      
      public function setCellValue(value:*) : void
      {
         _data = value as AvatarCollectionUnitVo;
         _completeCount = _data.totalItemList.length / 2;
         updateViewData();
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         removeEventListener("click",onClick);
         _selector = null;
         _bg = null;
         _nameTxt = null;
         _canActivityIcon = null;
         _data = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
