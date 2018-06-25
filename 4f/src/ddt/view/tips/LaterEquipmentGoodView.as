package ddt.view.tips{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Component;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.EquipSuitTemplateInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.data.goods.QualityType;   import ddt.data.goods.SuitTemplateInfo;   import ddt.data.player.PlayerInfo;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;      public class LaterEquipmentGoodView extends Component   {            public static const THISWIDTH:int = 200;            public static const EQUIPNUM:int = 19;            public static var isShow:Boolean = true;                   private var SUITNUM:int;            private var _bg:ScaleBitmapImage;            private var _topName:FilterFrameText;            private var _setNum:FilterFrameText;            private var _rule1:ScaleBitmapImage;            private var _rule2:ScaleBitmapImage;            private var _setsPropVec:Vector.<FilterFrameText>;            private var _validity:Vector.<FilterFrameText>;            private var _thisHeight:int;            private var _thisWidht:int;            private var _info:SuitTemplateInfo;            private var _itemInfo:ItemTemplateInfo;            private var _EquipInfo:InventoryItemInfo;            private var _playerInfo:PlayerInfo;            private var _suitId:int;            private var _ContainEquip:Array;            public function LaterEquipmentGoodView() { super(); }
            override protected function init() : void { }
            private function initData() : void { }
            private function showText() : void { }
            override public function get tipData() : Object { return null; }
            override public function set tipData(data:Object) : void { }
            public function showTip() : void { }
            private function updateView() : void { }
            override protected function addChildren() : void { }
            private function showHeadPart() : void { }
            private function showMiddlePart() : void { }
            private function showButtomPart() : void { }
            private function upBackground() : void { }
            private function updateWH() : void { }
            private function clear() : void { }
            public function getBGWidth() : int { return 0; }
            override public function dispose() : void { }
   }}