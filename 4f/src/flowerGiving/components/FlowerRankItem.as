package flowerGiving.components{   import bagAndInfo.info.PlayerInfoViewControl;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.text.GradientText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.utils.PositionUtils;   import ddt.view.tips.GoodTipInfo;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.events.TextEvent;   import flash.text.TextFormat;   import flowerGiving.data.FlowerRankInfo;   import vip.VipController;   import wonderfulActivity.data.GiftRewardInfo;      public class FlowerRankItem extends Sprite implements Disposeable   {                   private var _sprite:Sprite;            private var _backOverBit:Bitmap;            private var _topThreeIcon:ScaleFrameImage;            private var _placeTxt:FilterFrameText;            private var _vipName:GradientText;            private var _nameTxt:FilterFrameText;            private var _numTxt:FilterFrameText;            private var _baseIcon:Image;            private var _superIcon:Image;            private var _info:FlowerRankInfo;            private var _baseTip:GoodTipInfo;            private var _superTip:GoodTipInfo;            public function FlowerRankItem() { super(); }
            private function initData() : void { }
            private function initView() : void { }
            private function addEvents() : void { }
            protected function __onOutHandler(event:MouseEvent) : void { }
            protected function __onOverHanlder(event:MouseEvent) : void { }
            public function set info(info:FlowerRankInfo) : void { }
            private function addNickName() : void { }
            private function __textClickHandler(evt:TextEvent) : void { }
            private function __vipNameClick_Handler(evt:MouseEvent) : void { }
            private function openPlayerInfoFrame() : void { }
            private function setRankNum(num:int) : void { }
            private function addTips() : void { }
            private function removeEvents() : void { }
            public function dispose() : void { }
   }}