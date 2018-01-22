package groupPurchase.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import groupPurchase.GroupPurchaseManager;
   
   public class GroupPurchaseShopCell extends Sprite implements Disposeable
   {
       
      
      private var _itemCell:BagCell;
      
      private var _buyTipSprite:Sprite;
      
      private var _buyTipBg:Bitmap;
      
      private var _buyTipTxt:FilterFrameText;
      
      private var _shopItemId:int;
      
      private var _buyCellShine:MovieClip;
      
      public function GroupPurchaseShopCell(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function clickHandler(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
