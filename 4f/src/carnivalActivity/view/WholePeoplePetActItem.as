package carnivalActivity.view
{
   import carnivalActivity.CarnivalActivityControl;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.PlayerCurInfo;
   import wonderfulActivity.data.SendGiftInfo;
   
   public class WholePeoplePetActItem extends CarnivalActivityItem
   {
       
      
      private var _selfNeedPetNum:int = -1;
      
      private var _selfNeedPetStar:int;
      
      private var _personNeedPetNum:int = -1;
      
      private var _personNeedPetStar:int;
      
      private var _addedNeedPetNum:int = -1;
      
      private var _addedNeedPetStar:int;
      
      private var _getCount:int = -1;
      
      private var _addedIsSuperPet:Boolean;
      
      private var _personIsSuperPet:Boolean;
      
      private var _selfIsSuperPet:Boolean;
      
      private var _btnTxt:FilterFrameText;
      
      private var _tipsBtn:Bitmap;
      
      private var _tipStr:String = "";
      
      private var _tipSp:WholePeopleTipSp;
      
      private var _awardCount:int;
      
      public function WholePeoplePetActItem(param1:int, param2:GiftBagInfo, param3:int){super(null,null,null);}
      
      override protected function initItem() : void{}
      
      override public function updateView() : void{}
      
      override protected function __getAwardHandler(param1:MouseEvent) : void{}
      
      override public function dispose() : void{}
   }
}
