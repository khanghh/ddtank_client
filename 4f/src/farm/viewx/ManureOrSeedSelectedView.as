package farm.viewx{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.container.HBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.BagEvent;   import ddt.manager.ItemManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;   import petsBag.PetsBagManager;   import shop.manager.ShopBuyManager;      public class ManureOrSeedSelectedView extends Sprite implements Disposeable   {            public static const SEED:int = 1;            public static const MANURE:int = 2;            public static const manureIdArr:Array = [333101,333102,333103,333104];                   private var manureVec:Array;            private var _manureSelectViewBg:ScaleBitmapImage;            private var _title:ScaleFrameImage;            private var _preBtn:BaseButton;            private var _nextBtn:BaseButton;            private var _closeBtn:SimpleBitmapButton;            private var _hBox:HBox;            private var _cells:Vector.<FarmCell>;            private var _type:int;            private var _cellInfos:Array;            private var _currentPage:int;            private var _totlePage:int;            private var _currentCell:FarmCell;            private var _currentImg:Bitmap;            private var _isHelping:Boolean;            public function ManureOrSeedSelectedView(isHelping:Boolean = false) { super(); }
            public function set viewType(value:int) : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function initView() : void { }
            private function __clickHandler(event:MouseEvent) : void { }
            private function __bagUpdate(event:BagEvent) : void { }
            private function __onClose(e:MouseEvent) : void { }
            private function __onPageBtnClick(e:MouseEvent) : void { }
            private function cellInfos() : void { }
            private function upCells(page:int = 0) : void { }
            private function compareFun(x:int, y:int) : Number { return 0; }
            public function dispose() : void { }
   }}