package growthPackage.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.container.HBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.MouseEvent;   import growthPackage.GrowthPackageManager;   import growthPackage.data.GrowthPackageInfo;      public class GrowthPackageItem extends Sprite implements Disposeable   {                   private var _index:int;            private var _levelHead:Bitmap;            private var _cellsBg:ScaleBitmapImage;            private var _cells:HBox;            private var _cellsArr:Array;            private var _getBtn:TextButton;            private var _getBtnGlow:MovieClip;            private var _getIcon:Bitmap;            private var _cellsBgWidth:Number;            public function GrowthPackageItem($index:int) { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function __getBtnClickHandler(evt:MouseEvent) : void { }
            private function updateView() : void { }
            public function updateState() : void { }
            public function isComplete(value:int) : void { }
            protected function creatItemCell($info:InventoryItemInfo) : GrowthPackageCell { return null; }
            private function clearCells() : void { }
            public function dispose() : void { }
   }}