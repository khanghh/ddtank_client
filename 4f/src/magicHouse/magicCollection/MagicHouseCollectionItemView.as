package magicHouse.magicCollection
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.tips.CallPropTxtTipInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import magicHouse.MagicHouseManager;
   import magicHouse.MagicHouseModel;
   import newTitle.NewTitleManager;
   
   public class MagicHouseCollectionItemView extends Sprite implements Disposeable
   {
       
      
      private var _self:SelfInfo;
      
      private var _item1:MagicHouseItemCell;
      
      private var _item2:MagicHouseItemCell;
      
      private var _item3:MagicHouseItemCell;
      
      private var _type:int;
      
      private var _addAttributeTxt:FilterFrameText;
      
      private var _attribute1:FilterFrameText;
      
      private var _attribute2:FilterFrameText;
      
      private var _attributeValue1:FilterFrameText;
      
      private var _attributeValue2:FilterFrameText;
      
      private var _nextLevelPromote:FilterFrameText;
      
      private var _nextAttribute1:FilterFrameText;
      
      private var _nextAttribute2:FilterFrameText;
      
      private var _nextValue1:FilterFrameText;
      
      private var _nextValue2:FilterFrameText;
      
      private var _itemLvl:FilterFrameText;
      
      private var _upGradeCell:BagCell;
      
      private var _progress:MagicHouseUpgradeProgress;
      
      private var _collectionType:Bitmap;
      
      private var _collectionTypeCon:Component;
      
      private var _upGradeBtn:SimpleBitmapButton;
      
      private var _potionCountSelecterFrame:MagicHouseMagicPotionSelectFrame;
      
      private var _lastStrengthTime:int = 0;
      
      public function MagicHouseCollectionItemView(param1:int){super();}
      
      private function initView() : void{}
      
      private function _initProgress() : void{}
      
      private function _updateProgress() : void{}
      
      private function _setCell() : void{}
      
      private function _setData() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function onBuyedGoods(param1:CrazyTankSocketEvent) : void{}
      
      private function __upGrade(param1:MouseEvent) : void{}
      
      private function __messageUpdate(param1:Event) : void{}
      
      public function upDatafitCount() : void{}
      
      public function dispose() : void{}
   }
}
