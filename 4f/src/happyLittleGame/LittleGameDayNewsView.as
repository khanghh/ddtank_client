package happyLittleGame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import happyLittleGame.bombshellGame.item.HappyMiniDayNewItem;
   import uiModeManager.bombUI.HappyLittleGameManager;
   import uiModeManager.bombUI.model.HappyMiniGameActiveInfo;
   
   public class LittleGameDayNewsView extends Sprite implements Disposeable
   {
       
      
      private var _title:Bitmap;
      
      private var _bgBottom:ScaleBitmapImage;
      
      private var _bg:ScaleBitmapImage;
      
      private var _itemBg:ScaleBitmapImage;
      
      private var _itemBgII:ScaleBitmapImage;
      
      private var _itemBg_1:ScaleBitmapImage;
      
      private var _itemBgII_1:ScaleBitmapImage;
      
      private var _itemBg_2:ScaleBitmapImage;
      
      private var _pagerightBtn:BaseButton;
      
      private var _pageleftBtn:BaseButton;
      
      private var _pageBg:Scale9CornerImage;
      
      private var _pageTxt:FilterFrameText;
      
      private var _item_1:HappyMiniDayNewItem;
      
      private var _item_2:HappyMiniDayNewItem;
      
      private var _item_3:HappyMiniDayNewItem;
      
      private var _item_4:HappyMiniDayNewItem;
      
      private var _item_5:HappyMiniDayNewItem;
      
      private var _items:Vector.<HappyMiniDayNewItem>;
      
      private var _dayPageIndex:int;
      
      private var _infos:Vector.<HappyMiniGameActiveInfo>;
      
      public function LittleGameDayNewsView(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __dayactiveHandler(param1:Event) : void{}
      
      private function __rightClickHandler(param1:MouseEvent) : void{}
      
      private function __leftBtnClickhandler(param1:MouseEvent) : void{}
      
      public function showDayRankByPage(param1:int) : void{}
      
      private function initItem() : void{}
      
      public function clearAll() : void{}
      
      public function dispose() : void{}
   }
}
