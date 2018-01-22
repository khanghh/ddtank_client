package wonderfulActivity.newActivity.returnActivity
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.GiftChildInfo;
   import wonderfulActivity.data.GiftCurInfo;
   import wonderfulActivity.data.GiftRewardInfo;
   import wonderfulActivity.data.PlayerCurInfo;
   import wonderfulActivity.data.SendGiftInfo;
   import wonderfulActivity.items.GiftBagItem;
   import wonderfulActivity.items.PrizeListItem;
   
   public class ReturnListItem extends Sprite implements Disposeable
   {
       
      
      private var _back:MovieClip;
      
      private var _nameTxt:FilterFrameText;
      
      private var _prizeHBox:HBox;
      
      private var _prizeArr:Array;
      
      private var _btn:SimpleBitmapButton;
      
      private var _btnTxt:FilterFrameText;
      
      private var _tipsBtn:Bitmap;
      
      private var _type:int;
      
      private var _bgType:int;
      
      private var _actId:String;
      
      private var giftInfo:GiftBagInfo;
      
      private var condition:int;
      
      private var condition2:int;
      
      private var _canSelect:Boolean;
      
      private var _selectedIndex:int;
      
      public function ReturnListItem(param1:int, param2:int, param3:String){super();}
      
      private function initView() : void{}
      
      public function setData(param1:String, param2:GiftBagInfo, param3:Boolean) : void{}
      
      protected function __itemClick(param1:MouseEvent) : void{}
      
      private function classifyReward(param1:Vector.<GiftRewardInfo>) : Dictionary{return null;}
      
      public function setStatus(param1:Array, param2:Dictionary) : void{}
      
      protected function getRewardBtnClick(param1:MouseEvent) : void{}
      
      private function clearBtn() : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
