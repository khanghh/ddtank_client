package im
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IDropListCell;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerState;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class PlayerStateItem extends Sprite implements IDropListCell, Disposeable
   {
       
      
      private var _date:PlayerState;
      
      private var _stateID:int;
      
      private var _icon:Bitmap;
      
      private var _overBg:Bitmap;
      
      private var _stateName:FilterFrameText;
      
      private var _selected:Boolean;
      
      public function PlayerStateItem()
      {
         super();
         buttonMode = true;
         initView();
      }
      
      private function initView() : void
      {
         graphics.beginFill(16777215,0);
         graphics.drawRect(0,0,80,22);
         graphics.endFill();
         _overBg = ComponentFactory.Instance.creatBitmap("sset.IM.stateItemOverBgAsset");
         addChild(_overBg);
         _overBg.visible = false;
         _stateName = ComponentFactory.Instance.creatComponentByStylename("IM.stateItem.stateName");
         addChild(_stateName);
         addEventListener("mouseOver",__over);
         addEventListener("mouseOut",__out);
      }
      
      public function getCellValue() : *
      {
         return _date;
      }
      
      public function setCellValue(value:*) : void
      {
         _date = value;
         update();
      }
      
      private function update() : void
      {
         if(_icon == null)
         {
            _icon = creatIcon();
            addChild(_icon);
            _icon.x = 0;
            _icon.y = 1;
         }
         _stateName.text = _date.convertToString();
      }
      
      private function __out(event:MouseEvent) : void
      {
         _overBg.visible = false;
      }
      
      private function __over(event:MouseEvent) : void
      {
         _overBg.visible = true;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(value:Boolean) : void
      {
         _selected = value;
      }
      
      private function creatIcon() : Bitmap
      {
         switch(int(_date.StateID) - 1)
         {
            case 0:
               return ComponentFactory.Instance.creatBitmap("asset.IM.onlineIconAsset");
            case 1:
               return ComponentFactory.Instance.creatBitmap("asset.IM.awayIconAsset");
            case 2:
               return ComponentFactory.Instance.creatBitmap("asset.IM.busyIconAsset");
            case 3:
               return ComponentFactory.Instance.creatBitmap("asset.IM.shoppingIconAsset");
            case 4:
               return ComponentFactory.Instance.creatBitmap("asset.IM.noDistrubIconAsset");
            case 5:
               return ComponentFactory.Instance.creatBitmap("asset.IM.cleanOutIconAsset");
         }
      }
      
      override public function get height() : Number
      {
         return 22;
      }
      
      override public function get width() : Number
      {
         return 80;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         removeEventListener("mouseOver",__over);
         removeEventListener("mouseOut",__out);
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_overBg);
         _overBg = null;
         ObjectUtils.disposeObject(_stateName);
         _stateName = null;
         _date = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
