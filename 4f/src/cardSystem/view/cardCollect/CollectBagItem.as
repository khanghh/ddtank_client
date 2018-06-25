package cardSystem.view.cardCollect{   import cardSystem.data.CardInfo;   import cardSystem.data.SetsInfo;   import cardSystem.elements.CardBagCell;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.container.HBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.MovieImage;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.text.GradientText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import flash.display.Sprite;   import road7th.data.DictionaryData;      public class CollectBagItem extends Sprite implements Disposeable   {            public static const itemCellWidth:int = 78;                   private var _container:HBox;            private var _setsInfo:SetsInfo;            private var _setsName:GradientText;            private var _cardsVector:Vector.<CardBagCell>;            private var _seleted:Boolean;            private var _itemBG:MovieImage;            private var _light:Scale9CornerImage;            private var _itemInfo:DictionaryData;            public function CollectBagItem() { super(); }
            public function set seleted(value:Boolean) : void { }
            public function get seleted() : Boolean { return false; }
            private function initView() : void { }
            public function set setsInfo(value:SetsInfo) : void { }
            public function get setsInfo() : SetsInfo { return null; }
            private function upView() : void { }
            public function setSetsDate(date:Vector.<CardInfo>) : void { }
            public function dispose() : void { }
   }}