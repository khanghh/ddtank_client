package ddt.view.bossbox
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CellEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class BoxVipTipsInfoCell extends BaseCell
   {
       
      
      protected var _itemName:FilterFrameText;
      
      private var _di:ScaleBitmapImage;
      
      private var _isSelect:Boolean = false;
      
      private var _sunShinBg:Scale9CornerImage;
      
      public function BoxVipTipsInfoCell()
      {
         super(ComponentFactory.Instance.creat("asset.awardSystem.roulette.SelectCellBGAsset"));
         initView();
      }
      
      public function set isSelect(value:Boolean) : void
      {
         _isSelect = value;
         grayFilters = !_isSelect;
         if(_isSelect)
         {
            _sunShinBg = ComponentFactory.Instance.creat("Vip.GetAwardsShin");
            addChild(_sunShinBg);
         }
         else if(_sunShinBg)
         {
            ObjectUtils.disposeObject(_sunShinBg);
            _sunShinBg = null;
         }
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         _picPos = new Point(7,7);
      }
      
      protected function initView() : void
      {
         _di = ComponentFactory.Instance.creat("Vip.GetAwardsItemBG");
         addChild(_di);
         var di:* = ComponentFactory.Instance.creat("Vip.GetAwardsItemCellBG");
         addChild(di);
         _itemName = ComponentFactory.Instance.creat("BoxVipTips.ItemName");
         addChild(_itemName);
      }
      
      override protected function onMouseClick(evt:MouseEvent) : void
      {
         dispatchEvent(new CellEvent("itemclick",this));
      }
      
      public function set itemName(name:String) : void
      {
         _itemName.text = name;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_itemName)
         {
            ObjectUtils.disposeObject(_itemName);
         }
         _itemName = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
