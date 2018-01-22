package explorerManual.view.shop
{
   import bagAndInfo.cell.CellFactory;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import shop.view.ShopItemCell;
   
   public class ManualShopCell extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _nameTxt:FilterFrameText;
      
      private var _needMoneyTxt:FilterFrameText;
      
      private var _integral:FilterFrameText;
      
      private var _buyBtn:SimpleBitmapButton;
      
      private var _confirmFrame:BaseAlerFrame;
      
      private var _itemCell:ShopItemCell;
      
      private var _shopItemInfo:ShopItemInfo;
      
      public function ManualShopCell(){super();}
      
      private function buyHandler(param1:MouseEvent) : void{}
      
      public function refreshShow(param1:ShopItemInfo) : void{}
      
      public function dispose() : void{}
   }
}
