package store.forge
{
   import bagAndInfo.bag.RichesButton;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import flash.display.Shape;
   import flash.display.Sprite;
   import store.StoreBagBgWHPoint;
   import store.view.storeBag.StoreBagbgbmp;
   
   public class ForgeRightBgView extends Sprite implements Disposeable
   {
       
      
      private var _bitmapBg:StoreBagbgbmp;
      
      private var bagBg:ScaleFrameImage;
      
      private var _equipmentsColumnBg:Image;
      
      private var _itemsColumnBg:Image;
      
      public var msg_txt:ScaleFrameImage;
      
      private var goldTxt:FilterFrameText;
      
      private var moneyTxt:FilterFrameText;
      
      private var giftTxt:FilterFrameText;
      
      private var _goldButton:RichesButton;
      
      private var _giftButton:RichesButton;
      
      private var _moneyButton:RichesButton;
      
      private var _bgPoint:StoreBagBgWHPoint;
      
      private var _bgShape:Shape;
      
      private var _equipmentTitleText:FilterFrameText;
      
      private var _itemTitleText:FilterFrameText;
      
      private var _equipmentTipText:FilterFrameText;
      
      private var _itemTipText:FilterFrameText;
      
      private var showMoneyBG:MutipleImage;
      
      public function ForgeRightBgView(){super();}
      
      private function initView() : void{}
      
      private function __propertyChange(param1:PlayerPropertyEvent) : void{}
      
      public function title1(param1:String) : void{}
      
      public function title2(param1:String) : void{}
      
      public function bgFrame(param1:int) : void{}
      
      public function equipmentTipText() : FilterFrameText{return null;}
      
      public function hideMoney() : void{}
      
      public function showStoreBagViewText(param1:String, param2:String, param3:Boolean = true) : void{}
      
      private function updateMoney() : void{}
      
      public function dispose() : void{}
   }
}
