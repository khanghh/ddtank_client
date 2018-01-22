package farm.viewx.helper
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import farm.FarmModelController;
   import farm.view.compose.event.SelectComposeItemEvent;
   import farm.viewx.shop.FarmShopView;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import shop.view.ShopItemCell;
   
   public class HelperSetView extends Frame
   {
      
      private static const MaxNum:int = 50;
       
      
      private var _titleBg:Bitmap;
      
      private var _titleTxt:FilterFrameText;
      
      private var _btmBg:ScaleBitmapImage;
      
      private var _ResetBtn:TextButton;
      
      private var _okBtn:TextButton;
      
      private var _Bg:ScaleBitmapImage;
      
      private var _SetBg:Scale9CornerImage;
      
      private var _SetBg1:Scale9CornerImage;
      
      private var _AddBtn:BaseButton;
      
      private var _AddBtn1:BaseButton;
      
      private var _MinusBtn:BaseButton;
      
      private var _MinusBtn1:BaseButton;
      
      private var _SetInputBg:Scale9CornerImage;
      
      private var _SetInputBg1:Scale9CornerImage;
      
      private var _setNumTxt:TextInput;
      
      private var _setNumTxt1:TextInput;
      
      private var _setNum:int = 0;
      
      private var _setFertilizerNum:int = 0;
      
      private var _NumerTxt:FilterFrameText;
      
      private var _NumerTxt1:FilterFrameText;
      
      private var _seedBtn:BaseButton;
      
      private var _FertilizerBtn:BaseButton;
      
      private var _seedSetBg:Bitmap;
      
      private var _fertilizerSetBg:Bitmap;
      
      private var _seedList:SeedSelect;
      
      private var _fertilizerList:FertilizerSelect;
      
      private var _result:ShopItemCell;
      
      private var _fertiliresult:ShopItemCell;
      
      private var _helperSetViewSelectResult:Function;
      
      private var _buyFrame:HelperBuyAlertFrame;
      
      private var seednum:int;
      
      private var manure:int;
      
      private var _farmShop:FarmShopView;
      
      private var _findNumState:Function;
      
      public function HelperSetView(){super();}
      
      private function initView() : void{}
      
      public function set helperSetViewSelectResult(param1:Function) : void{}
      
      public function update(param1:FilterFrameText, param2:FilterFrameText, param3:FilterFrameText, param4:FilterFrameText) : void{}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __txtchange(param1:Event) : void{}
      
      private function __txtchange1(param1:Event) : void{}
      
      private function __selectNum(param1:MouseEvent) : void{}
      
      private function __resetHandler(param1:MouseEvent) : void{}
      
      private function __okHandler(param1:MouseEvent) : void{}
      
      private function buyAlert() : void{}
      
      private function __onBuyResponse(param1:FrameEvent) : void{}
      
      private function __closeFarmShop(param1:FrameEvent) : void{}
      
      public function get getTxtNum1() : int{return 0;}
      
      public function get getTxtNum2() : int{return 0;}
      
      public function get getTxtId1() : int{return 0;}
      
      public function get getTxtId2() : int{return 0;}
      
      private function checkInput() : void{}
      
      private function checkInputOne() : void{}
      
      private function __frameHandler(param1:FrameEvent) : void{}
      
      private function __seedHandler(param1:MouseEvent) : void{}
      
      private function __fertiliHandler(param1:MouseEvent) : void{}
      
      private function __setseed(param1:SelectComposeItemEvent) : void{}
      
      private function __setfertilizer(param1:SelectComposeItemEvent) : void{}
      
      public function show() : void{}
      
      public function set findNumState(param1:Function) : void{}
      
      override public function dispose() : void{}
   }
}
