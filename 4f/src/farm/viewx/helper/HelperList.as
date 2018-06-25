package farm.viewx.helper{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ShopItemInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.ShopManager;   import farm.FarmEvent;   import farm.FarmModelController;   import farm.modelx.FieldVO;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.utils.Dictionary;      public class HelperList extends Sprite implements Disposeable   {                   private var _vbox:VBox;            private var _scrollPanel:ScrollPanel;            private var _helperListBG:MovieClip;            private var _helperListVLine:MutipleImage;            private var _fieldIndex:BaseButton;            private var _seedID:BaseButton;            private var _fertilizerID:BaseButton;            private var _isAuto:BaseButton;            private var _fieldIndexText:FilterFrameText;            private var _seedIDText:FilterFrameText;            private var _fertilizerIDText:FilterFrameText;            private var _isAutoText:FilterFrameText;            private var _seedInfos:Dictionary;            private var _fertilizerInfos:Dictionary;            private var _helperItemList:Array;            private var _currentSelectHelperItem:HelperItem;            public function HelperList() { super(); }
            private function initView() : void { }
            private function setTip(btn:BaseButton, value:String) : void { }
            public function get helperItemList() : Array { return null; }
            private function findNumState(seedId:int, fertilizerId:int) : int { return 0; }
            private function setListData() : void { }
            public function onKeyStart() : void { }
            public function onKeyStop() : void { }
            private function __onItemClickHandler(event:MouseEvent) : void { }
            private function initEvent() : void { }
            private function __helperSwitchHandler(e:FarmEvent) : void { }
            private function __helperKeyHandler(e:FarmEvent) : void { }
            public function getHelperItem(pFieldID:int) : HelperItem { return null; }
            public function dispose() : void { }
   }}