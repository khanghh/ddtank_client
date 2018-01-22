package beadSystem.controls
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.cell.IDropListCell;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.display.BitmapLoaderProxy;
   import ddt.manager.ItemManager;
   import ddt.manager.PathManager;
   import ddt.utils.PositionUtils;
   import ddt.view.tips.GoodTipInfo;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class DrillItem extends Component implements IDropListCell
   {
       
      
      private var _itemInfo:DrillItemInfo;
      
      private var _date:InventoryItemInfo;
      
      private var _stateID:int;
      
      private var _icon:DisplayObject;
      
      private var _overBg:Image;
      
      private var _stateName:FilterFrameText;
      
      private var _selected:Boolean;
      
      private var _isInfoChanged:Boolean = false;
      
      public function DrillItem()
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
         _overBg = ComponentFactory.Instance.creatComponentByStylename("beadSystem.drillItemHighLight");
         addChild(_overBg);
         _overBg.visible = false;
         _stateName = ComponentFactory.Instance.creatComponentByStylename("beadSystem.drillItemText");
         addChild(_stateName);
         addEventListener("mouseOver",__over);
         addEventListener("mouseOut",__out);
         tipDirctions = "7,6,2,1,5,4,0,3,6";
         tipGapV = 10;
         tipGapH = 10;
         tipStyle = "core.GoodsTip";
         ShowTipManager.Instance.addTip(this);
      }
      
      public function getCellValue() : *
      {
         return _itemInfo;
      }
      
      public function setCellValue(param1:*) : void
      {
         _isInfoChanged = _date != param1;
         _itemInfo = param1;
         _date = !!_itemInfo?_itemInfo.itemInfo:null;
         var _loc2_:GoodTipInfo = new GoodTipInfo();
         _loc2_.itemInfo = !!_date?ItemManager.Instance.getTemplateById(_date.TemplateID):null;
         tipData = _loc2_;
         update();
      }
      
      private function update() : void
      {
         if(_date)
         {
            if(_icon == null || _isInfoChanged)
            {
               _isInfoChanged = false;
               ObjectUtils.disposeObject(_icon);
               _icon = null;
               _icon = creatIcon();
               addChildAt(_icon,0);
               PositionUtils.setPos(_icon,"beadSystem.DrillItemIconPos");
            }
            _stateName.text = _itemInfo.amount.toString();
         }
      }
      
      private function __out(param1:MouseEvent) : void
      {
         _overBg.visible = false;
      }
      
      private function __over(param1:MouseEvent) : void
      {
         _overBg.visible = true;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
      }
      
      private function creatIcon() : DisplayObject
      {
         var _loc1_:String = PathManager.solveGoodsPath(_date.CategoryID,_date.Pic,_date.NeedSex == 1,"icon","A","1",_date.Level,false,_date.type);
         return new BitmapLoaderProxy(_loc1_,new Rectangle(0,0,24,24));
      }
      
      override public function get height() : Number
      {
         return 25;
      }
      
      override public function get width() : Number
      {
         return 80;
      }
      
      override public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      override public function dispose() : void
      {
         ShowTipManager.Instance.removeTip(this);
         removeEventListener("mouseOver",__over);
         removeEventListener("mouseOut",__out);
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_overBg);
         _overBg = null;
         ObjectUtils.disposeObject(_stateName);
         _stateName = null;
         _date = null;
         _itemInfo = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
