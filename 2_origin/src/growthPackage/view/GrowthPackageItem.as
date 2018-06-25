package growthPackage.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import growthPackage.GrowthPackageManager;
   import growthPackage.data.GrowthPackageInfo;
   
   public class GrowthPackageItem extends Sprite implements Disposeable
   {
       
      
      private var _index:int;
      
      private var _levelHead:Bitmap;
      
      private var _cellsBg:ScaleBitmapImage;
      
      private var _cells:HBox;
      
      private var _cellsArr:Array;
      
      private var _getBtn:TextButton;
      
      private var _getBtnGlow:MovieClip;
      
      private var _getIcon:Bitmap;
      
      private var _cellsBgWidth:Number;
      
      public function GrowthPackageItem($index:int)
      {
         super();
         _index = $index;
         initView();
         updateView();
         initEvent();
      }
      
      private function initView() : void
      {
         _levelHead = ComponentFactory.Instance.creatBitmap("assets.growthPackage.Item" + _index);
         if(_index < 3)
         {
            _cellsBg = ComponentFactory.Instance.creatComponentByStylename("growthPackage.LevelBg1");
         }
         else if(_index < 6)
         {
            _cellsBg = ComponentFactory.Instance.creatComponentByStylename("growthPackage.LevelBg2");
         }
         else if(_index < 9)
         {
            _cellsBg = ComponentFactory.Instance.creatComponentByStylename("growthPackage.LevelBg3");
         }
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("growthPackage.getBtn");
         _getBtn.text = LanguageMgr.GetTranslation("ddt.growthPackage.itemGetBtnTxt");
         _getBtnGlow = ClassUtils.CreatInstance("assets.growthPackage.BtnGlow");
         _getBtnGlow.mouseChildren = false;
         _getBtnGlow.mouseEnabled = false;
         _getBtnGlow.x = _getBtn.x - 5;
         _getBtnGlow.y = _getBtn.y - 1;
         _getIcon = ComponentFactory.Instance.creatBitmap("assets.growthPackage.getIcon");
         addChild(_levelHead);
         if(_cellsBg)
         {
            _cellsBgWidth = _cellsBg.width;
            PositionUtils.setPos(_cellsBg,"growthPackageItem.cellsBgPos");
            addChild(_cellsBg);
         }
         _cells = new HBox();
         _cells.spacing = 2;
         PositionUtils.setPos(_cells,"growthPackageItem.cellsPos");
         if(_index > 5)
         {
            _cells.y = 5;
         }
         addChild(_cells);
         addChild(_getBtn);
         addChild(_getBtnGlow);
         addChild(_getIcon);
         isComplete(0);
      }
      
      private function initEvent() : void
      {
         _getBtn.addEventListener("click",__getBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         _getBtn.removeEventListener("click",__getBtnClickHandler);
      }
      
      private function __getBtnClickHandler(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(GrowthPackageManager.instance.model.isBuy < 1)
         {
            GrowthPackageManager.instance.showBuyFrame();
         }
         else
         {
            SocketManager.Instance.out.sendGrowthPackageGetItems(_index);
         }
      }
      
      private function updateView() : void
      {
         var i:int = 0;
         var growthPackageInfo:* = null;
         var _info:* = null;
         var cell:* = null;
         _cellsArr = [];
         var itemInfoList:Vector.<GrowthPackageInfo> = GrowthPackageManager.instance.model.itemInfoList[_index];
         if(itemInfoList)
         {
            for(i = 0; i < itemInfoList.length; )
            {
               growthPackageInfo = itemInfoList[i];
               _info = GrowthPackageManager.instance.model.getInventoryItemInfo(growthPackageInfo);
               cell = creatItemCell(_info);
               _cells.addChild(cell);
               _cellsArr.push(cell);
               i++;
            }
            _cells.arrange();
         }
         _cellsBg.width = _cells.width + 33;
         if(_cellsBg.width < _cellsBgWidth)
         {
            _cellsBg.width = _cellsBgWidth;
         }
         updateState();
      }
      
      public function updateState() : void
      {
         var isComp:int = GrowthPackageManager.instance.model.isCompleteList[_index];
         var grade:int = GrowthPackageManager.instance.model.gradeList[_index];
         if(_index == 0 && isComp != 1)
         {
            isComplete(2);
         }
         else if(isComp == 0 && PlayerManager.Instance.Self.Grade >= grade)
         {
            isComplete(2);
         }
         else
         {
            isComplete(isComp);
         }
      }
      
      public function isComplete(value:int) : void
      {
         if(value == 0)
         {
            _getBtn.mouseEnabled = false;
            _getBtn.filters = ComponentFactory.Instance.creatFilters("grayFilter");
            _getBtn.visible = true;
            _getBtnGlow.visible = false;
            _getIcon.visible = false;
         }
         else if(value == 1)
         {
            _getBtn.visible = false;
            _getBtnGlow.visible = false;
            _getIcon.visible = true;
         }
         else if(value == 2)
         {
            _getBtn.mouseEnabled = true;
            _getBtn.filters = null;
            _getBtn.visible = true;
            _getBtnGlow.visible = true;
            _getIcon.visible = false;
         }
      }
      
      protected function creatItemCell($info:InventoryItemInfo) : GrowthPackageCell
      {
         var _cell:GrowthPackageCell = new GrowthPackageCell(0,null);
         _cell.width = 47;
         _cell.height = 46;
         _cell.info = $info;
         return _cell;
      }
      
      private function clearCells() : void
      {
         var i:int = 0;
         var cell:* = null;
         for(i = 0; i < _cellsArr.length; )
         {
            cell = GrowthPackageCell(_cellsArr[i]);
            ObjectUtils.disposeObject(cell);
            i++;
         }
         _cellsArr = null;
         ObjectUtils.disposeAllChildren(_cells);
         ObjectUtils.disposeObject(_cells);
         _cells = null;
      }
      
      public function dispose() : void
      {
         removeEvent();
         clearCells();
         ObjectUtils.disposeObject(_levelHead);
         _levelHead = null;
         ObjectUtils.disposeObject(_cellsBg);
         _cellsBg = null;
         ObjectUtils.disposeObject(_getBtn);
         _getBtn = null;
         if(_getBtnGlow)
         {
            _getBtnGlow.stop();
            ObjectUtils.disposeObject(_getBtnGlow);
            _getBtnGlow = null;
         }
         ObjectUtils.disposeObject(_getIcon);
         _getIcon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
