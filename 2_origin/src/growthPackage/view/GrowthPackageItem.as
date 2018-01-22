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
      
      public function GrowthPackageItem(param1:int)
      {
         super();
         _index = param1;
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
      
      private function __getBtnClickHandler(param1:MouseEvent) : void
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
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc1_:* = null;
         _cellsArr = [];
         var _loc2_:Vector.<GrowthPackageInfo> = GrowthPackageManager.instance.model.itemInfoList[_index];
         if(_loc2_)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc2_.length)
            {
               _loc4_ = _loc2_[_loc5_];
               _loc3_ = GrowthPackageManager.instance.model.getInventoryItemInfo(_loc4_);
               _loc1_ = creatItemCell(_loc3_);
               _cells.addChild(_loc1_);
               _cellsArr.push(_loc1_);
               _loc5_++;
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
         var _loc1_:int = GrowthPackageManager.instance.model.isCompleteList[_index];
         var _loc2_:int = GrowthPackageManager.instance.model.gradeList[_index];
         if(_index == 0 && _loc1_ != 1)
         {
            isComplete(2);
         }
         else if(_loc1_ == 0 && PlayerManager.Instance.Self.Grade >= _loc2_)
         {
            isComplete(2);
         }
         else
         {
            isComplete(_loc1_);
         }
      }
      
      public function isComplete(param1:int) : void
      {
         if(param1 == 0)
         {
            _getBtn.mouseEnabled = false;
            _getBtn.filters = ComponentFactory.Instance.creatFilters("grayFilter");
            _getBtn.visible = true;
            _getBtnGlow.visible = false;
            _getIcon.visible = false;
         }
         else if(param1 == 1)
         {
            _getBtn.visible = false;
            _getBtnGlow.visible = false;
            _getIcon.visible = true;
         }
         else if(param1 == 2)
         {
            _getBtn.mouseEnabled = true;
            _getBtn.filters = null;
            _getBtn.visible = true;
            _getBtnGlow.visible = true;
            _getIcon.visible = false;
         }
      }
      
      protected function creatItemCell(param1:InventoryItemInfo) : GrowthPackageCell
      {
         var _loc2_:GrowthPackageCell = new GrowthPackageCell(0,null);
         _loc2_.width = 47;
         _loc2_.height = 46;
         _loc2_.info = param1;
         return _loc2_;
      }
      
      private function clearCells() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < _cellsArr.length)
         {
            _loc1_ = GrowthPackageCell(_cellsArr[_loc2_]);
            ObjectUtils.disposeObject(_loc1_);
            _loc2_++;
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
