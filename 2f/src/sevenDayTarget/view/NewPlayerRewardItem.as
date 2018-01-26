package sevenDayTarget.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import sevenDayTarget.model.NewPlayerRewardInfo;
   
   public class NewPlayerRewardItem extends Sprite
   {
       
      
      private var _bg:Bitmap;
      
      private var _titleText:FilterFrameText;
      
      private var _getRewardBnt:BaseButton;
      
      private var _rewardList:SimpleTileList;
      
      private var _info:NewPlayerRewardInfo;
      
      public function NewPlayerRewardItem(){super();}
      
      public function setInfo(param1:NewPlayerRewardInfo) : void{}
      
      private function __getReward(param1:MouseEvent) : void{}
      
      private function initView(param1:int) : void{}
   }
}
