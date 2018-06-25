package AvatarCollection.view{   import AvatarCollection.data.AvatarCollectionUnitVo;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Sprite;      public class AvatarCollectionRightView extends Sprite implements Disposeable   {                   private var _data:AvatarCollectionUnitVo;            private var _itemListView:AvatarCollectionItemListView;            private var _propertyView:AvatarCollectionPropertyView;            private var _moneyView:AvatarCollectionMoneyView;            private var _timeView:AvatarCollectionTimeView;            public function AvatarCollectionRightView() { super(); }
            private function initView() : void { }
            public function refreshView(data:AvatarCollectionUnitVo) : void { }
            public function set selectedAllBtn(value:Boolean) : void { }
            public function dispose() : void { }
   }}