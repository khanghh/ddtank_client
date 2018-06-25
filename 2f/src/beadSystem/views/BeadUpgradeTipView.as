package beadSystem.views{   import beadSystem.model.BeadInfo;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Component;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.image.MovieImage;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.EquipType;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.data.goods.QualityType;   import ddt.manager.BeadTemplateManager;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.ServerConfigManager;   import ddt.utils.PositionUtils;   import ddt.view.SimpleItem;   import ddt.view.tips.GoodTipInfo;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.geom.Point;   import road7th.utils.StringHelper;      public class BeadUpgradeTipView extends Component   {                   private var _strengthenLevelImage:MovieImage;            private var _fusionLevelImage:MovieImage;            private var _boundImage:ScaleFrameImage;            private var _nameTxt:FilterFrameText;            private var _qualityItem:SimpleItem;            private var _typeItem:SimpleItem;            private var _expItem:SimpleItem;            private var _descriptionTxt:FilterFrameText;            private var _bindTypeTxt:FilterFrameText;            private var _remainTimeTxt:FilterFrameText;            private var _info:ItemTemplateInfo;            private var _bindImageOriginalPos:Point;            private var _maxWidth:int;            private var _minWidth:int = 240;            private var _displayList:Vector.<DisplayObject>;            private var _displayIdx:int;            private var _lines:Vector.<Image>;            private var _lineIdx:int;            private var _isReAdd:Boolean;            private var _remainTimeBg:Bitmap;            private var _tipbackgound:MutipleImage;            private var _rightArrows:Bitmap;            private var _exp:int;            private var _UpExp:int;            public function BeadUpgradeTipView() { super(); }
            override protected function init() : void { }
            override public function get tipData() : Object { return null; }
            override public function set tipData(data:Object) : void { }
            public function showTip(info:ItemTemplateInfo, typeIsSecond:Boolean = false) : void { }
            private function updateView() : void { }
            private function clear() : void { }
            override protected function addChildren() : void { }
            private function createItemName() : void { }
            private function careteEXP() : void { }
            private function createCategoryItem() : void { }
            private function setPurpleHtmlTxt(title:String, value:int, add:String) : String { return null; }
            private function createDescript() : void { }
            private function ShowBound(info:InventoryItemInfo) : Boolean { return false; }
            private function createBindType() : void { }
            private function createRemainTime() : void { }
            private function seperateLine() : void { }
            override public function dispose() : void { }
   }}