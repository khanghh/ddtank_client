package signActivity.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import signActivity.SignActivityMgr;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.GiftCurInfo;
   import wonderfulActivity.data.GiftRewardInfo;
   import wonderfulActivity.data.PlayerCurInfo;
   import wonderfulActivity.data.SendGiftInfo;
   
   public class SignActivityItem extends Sprite
   {
      
      public static var length:int = 1;
      
      public static var btnIndex:int = 1;
      
      public static var btnBigIndex:int = 1;
      
      public static var continuousGoodsIndex:int = 1;
       
      
      private var giftInfo:GiftBagInfo;
      
      private var _smallBtn:BaseButton;
      
      private var _goodEveryDayItemContainerAll:Sprite;
      
      private var _goodItemContainerAll:Sprite;
      
      private var _tag:Bitmap;
      
      private var _day:int;
      
      private var _money:int;
      
      private var _index:int;
      
      private var condition:int;
      
      private var tagIndex:int;
      
      private var leftIndex:int;
      
      private var dayArray:Array;
      
      public function SignActivityItem(param1:int, param2:int){super();}
      
      private function removeEvent() : void{}
      
      private function getRewardBtnClick(param1:MouseEvent) : void{}
      
      public function setGetBtnEnalbe(param1:*) : void{}
      
      public function setGoods(param1:GiftBagInfo) : void{}
      
      private function everyDayGoods() : void{}
      
      private function addEvent() : void{}
      
      private function __onOver(param1:MouseEvent) : void{}
      
      private function __onOut(param1:MouseEvent) : void{}
      
      private function continuousGoods() : void{}
      
      public function setStatus(param1:Array, param2:Dictionary, param3:int) : void{}
      
      private function createBigBtn(param1:int, param2:Boolean = true) : void{}
      
      private function createTag(param1:int) : void{}
      
      private function clearBtn() : void{}
      
      public function dispose() : void{}
   }
}
