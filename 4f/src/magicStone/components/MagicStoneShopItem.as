package magicStone.components
{
   import bagAndInfo.cell.CellFactory;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.ItemEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import magicStone.MagicStoneControl;
   import magicStone.MagicStoneManager;
   
   public class MagicStoneShopItem extends Sprite implements Disposeable
   {
       
      
      protected var _itemBg:ScaleFrameImage;
      
      protected var _itemCellBg:Image;
      
      protected var _dotLine:Image;
      
      protected var _payType:ScaleFrameImage;
      
      protected var _itemNameTxt:FilterFrameText;
      
      protected var _itemPriceTxt:FilterFrameText;
      
      protected var _itemCell:EmbedMgStoneCell;
      
      protected var _itemCellBtn:Sprite;
      
      private var _needScore:FilterFrameText;
      
      private var _canNotBuyTips:FilterFrameText;
      
      private var _covertBtn:SimpleBitmapButton;
      
      private var _buyBtn:SimpleBitmapButton;
      
      private var _remainCount:FilterFrameText;
      
      private var _batFrame:MagicStoneBatFrame;
      
      protected var _shopItemInfo:ShopItemInfo;
      
      protected var _selected:Boolean;
      
      protected var _isMouseOver:Boolean;
      
      protected var _lightMc:MovieClip;
      
      public function MagicStoneShopItem(){super();}
      
      protected function initContent() : void{}
      
      public function set shopItemInfo(param1:ShopItemInfo) : void{}
      
      public function get shopItemInfo() : ShopItemInfo{return null;}
      
      protected function addEvent() : void{}
      
      protected function removeEvent() : void{}
      
      protected function __itemClick(param1:MouseEvent) : void{}
      
      protected function __covertBtnClick(param1:MouseEvent) : void{}
      
      protected function __buyBtnClick(param1:MouseEvent) : void{}
      
      protected function __itemMouseOver(param1:MouseEvent) : void{}
      
      protected function __itemMouseOut(param1:MouseEvent) : void{}
      
      public function setItemLight(param1:MovieClip) : void{}
      
      public function setRemainCount(param1:int) : void{}
      
      public function get selected() : Boolean{return false;}
      
      public function set selected(param1:Boolean) : void{}
      
      public function dispose() : void{}
   }
}
