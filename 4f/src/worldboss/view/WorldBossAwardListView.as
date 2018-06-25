package worldboss.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.ISelectable;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.DisplayUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ShopItemInfo;   import ddt.events.ItemEvent;   import ddt.manager.ShopManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;   import shop.view.ShopGoodItem;      public class WorldBossAwardListView extends Sprite implements Disposeable   {            public static const AWARD_ITEM_NUM:uint = 8;                   private var _goodItemContainerAll:Sprite;            private var _goodItems:Vector.<AwardGoodItem>;            private var _firstPage:BaseButton;            private var _prePageBtn:BaseButton;            private var _nextPageBtn:BaseButton;            private var _endPageBtn:BaseButton;            private var _currentPage:int;            private var _currentPageTxt:FilterFrameText;            private var _noteDesc:Bitmap;            private var _pageBg:Scale9CornerImage;            private var _list:Vector.<ShopItemInfo>;            public function WorldBossAwardListView() { super(); }
            private function initView() : void { }
            private function addEvent() : void { }
            public function updata() : void { }
            private function removeEvent() : void { }
            public function loadList() : void { }
            public function setList(list:Vector.<ShopItemInfo>) : void { }
            private function clearitems() : void { }
            private function __pageBtnClick(evt:MouseEvent) : void { }
            private function __itemClick(evt:ItemEvent) : void { }
            private function __itemSelect(evt:ItemEvent) : void { }
            public function dispose() : void { }
   }}