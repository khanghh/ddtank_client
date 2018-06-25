package newTitle.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class NewTitleListCell extends Sprite implements Disposeable, IListCell
   {
       
      
      private var _index:int;
      
      private var _info;
      
      private var _titleBg:ScaleFrameImage;
      
      private var _titleName:FilterFrameText;
      
      private var _shine:Bitmap;
      
      public function NewTitleListCell()
      {
         super();
         this.buttonMode = true;
         initView();
         initEvent();
      }
      
      private function initEvent() : void
      {
      }
      
      private function initView() : void
      {
         _titleBg = ComponentFactory.Instance.creatComponentByStylename("newTitle.titleNameBg");
         addChild(_titleBg);
         _titleName = ComponentFactory.Instance.creatComponentByStylename("newTitle.titleNameItemText");
         addChild(_titleName);
         _shine = ComponentFactory.Instance.creat("asset.newTitle.shine");
         addChild(_shine);
         _shine.visible = false;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_titleBg);
         _titleBg = null;
         ObjectUtils.disposeObject(_titleName);
         _titleName = null;
         ObjectUtils.disposeObject(_shine);
         _shine = null;
      }
      
      private function removeEvent() : void
      {
      }
      
      public function setListCellStatus(list:List, isSelected:Boolean, index:int) : void
      {
         _index = index;
         _titleBg.setFrame(index % 2 + 1);
         _shine.visible = isSelected;
      }
      
      public function getCellValue() : *
      {
         return _info;
      }
      
      public function setCellValue(value:*) : void
      {
         _info = value;
         _titleName.text = String(_info);
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
   }
}
