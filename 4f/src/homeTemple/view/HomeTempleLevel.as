package homeTemple.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.QuickBuyAlertBase;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.BagEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.setTimeout;
   import homeTemple.HomeTempleController;
   import homeTemple.event.HomeTempleEvent;
   
   public class HomeTempleLevel extends Sprite implements Disposeable
   {
       
      
      private var _primaryImmolation:BagCell;
      
      private var _highImmolation:BagCell;
      
      private var _selectCell:BagCell;
      
      private var _rockBuy:BaseButton;
      
      private var _isInjectSelect:SelectedCheckButton;
      
      private var _immolationBtn:SimpleBitmapButton;
      
      private var _progress:HomeImmolationProgressBar;
      
      private var _textValue:HomeTempleTextValue;
      
      private var _levelMovie:MovieClip;
      
      private var _currentLevelTip:Image;
      
      private var _icon1Bmp:Bitmap;
      
      private var _icon2Bmp:Bitmap;
      
      private var _nowBmp:Bitmap;
      
      private var _levelLabelBmp:Bitmap;
      
      private var _nums:N_BitmapDataNumber;
      
      private var _levelBmp:Bitmap;
      
      private var _item1Txt:FilterFrameText;
      
      private var _item2Txt:FilterFrameText;
      
      public function HomeTempleLevel(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      protected function __onUpdateBlessingState(param1:HomeTempleEvent) : void{}
      
      private function creatLevelMovie() : void{}
      
      private function setImmolationInfo() : void{}
      
      private function setSelectImagePos(param1:BagCell) : void{}
      
      protected function __onPrimaryClick(param1:MouseEvent) : void{}
      
      protected function __onHighClick(param1:MouseEvent) : void{}
      
      protected function __onUpdateProperty(param1:HomeTempleEvent) : void{}
      
      private function setLevelText() : void{}
      
      private function playBombAnimation(param1:int, param2:int) : void{}
      
      protected function __onImmolationClick(param1:MouseEvent) : void{}
      
      protected function __onImmolationOver(param1:MouseEvent) : void{}
      
      protected function __onImmolationOut(param1:MouseEvent) : void{}
      
      protected function __onInjectSelectClick(param1:MouseEvent) : void{}
      
      protected function __onBuyRockClick(param1:MouseEvent) : void{}
      
      protected function __onBagUpdate(param1:BagEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
