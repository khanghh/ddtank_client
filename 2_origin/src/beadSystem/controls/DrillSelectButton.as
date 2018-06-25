package beadSystem.controls
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.list.IDropListTarget;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.display.BitmapLoaderProxy;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import ddt.view.tips.GoodTipInfo;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   
   public class DrillSelectButton extends Component implements IDropListTarget
   {
       
      
      private var _btn:BaseButton;
      
      private var _itemInfo:DrillItemInfo;
      
      private var _data:InventoryItemInfo;
      
      private var _frameText:FilterFrameText;
      
      private var _dataIcon:BitmapLoaderProxy;
      
      public function DrillSelectButton()
      {
         super();
         _btn = ComponentFactory.Instance.creatComponentByStylename("beadSystem.selectDrillBtn");
         addChild(_btn);
         _frameText = ComponentFactory.Instance.creatComponentByStylename("beadSystem.drillItemText");
         PositionUtils.setPos(_frameText,"beadSystem.DrillSelectBtnTextPos");
         _frameText.text = LanguageMgr.GetTranslation("ddt.beadSystem.chooseDrill");
         addChild(_frameText);
         tipDirctions = "5,4,2,1,7,6,3,0,6";
         tipGapV = 10;
         tipGapH = 10;
         tipStyle = "core.GoodsTip";
         ShowTipManager.Instance.addTip(this);
      }
      
      public function setCursor(index:int) : void
      {
      }
      
      public function get caretIndex() : int
      {
         return 0;
      }
      
      public function setValue(value:*) : void
      {
         var url:* = null;
         var tipInfo:* = null;
         var oldData:InventoryItemInfo = _data;
         _itemInfo = value;
         _data = !!_itemInfo?_itemInfo.itemInfo:null;
         if(_data != null)
         {
            if(_data != oldData)
            {
               ObjectUtils.disposeObject(_dataIcon);
               _dataIcon = null;
               url = PathManager.solveGoodsPath(_data.CategoryID,_data.Pic,_data.NeedSex == 1,"icon","A","1",_data.Level,false,_data.type);
               _dataIcon = new BitmapLoaderProxy(url,new Rectangle(0,0,24,24));
               PositionUtils.setPos(_dataIcon,"beadSystem.DrillItemIconPos");
               addChild(_dataIcon);
               tipInfo = new GoodTipInfo();
               tipInfo.itemInfo = ItemManager.Instance.getTemplateById(_data.TemplateID);
               tipData = tipInfo;
            }
            PositionUtils.setPos(_frameText,"beadSystem.DrillItemTextPos");
            _frameText.text = _itemInfo.amount.toString();
         }
         else
         {
            ObjectUtils.disposeObject(_dataIcon);
            _dataIcon = null;
            PositionUtils.setPos(_frameText,"beadSystem.DrillSelectBtnTextPos");
            _frameText.text = LanguageMgr.GetTranslation("ddt.beadSystem.chooseDrill");
            tipData = null;
         }
      }
      
      public function get DrillItem() : InventoryItemInfo
      {
         if(_data)
         {
            _frameText.text = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(_data.TemplateID).toString();
            return _data;
         }
         return null;
      }
      
      public function getValueLength() : int
      {
         return 0;
      }
      
      override public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      override public function dispose() : void
      {
         ShowTipManager.Instance.removeTip(this);
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_frameText);
         _frameText = null;
         ObjectUtils.disposeObject(_dataIcon);
         _dataIcon = null;
      }
   }
}
