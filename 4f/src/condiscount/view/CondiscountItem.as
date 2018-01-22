package condiscount.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import condiscount.CondiscountManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.GiftChildInfo;
   import wonderfulActivity.data.SendGiftInfo;
   
   public class CondiscountItem extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _normalPriceTxt:FilterFrameText;
      
      private var _disCountPriceTxt:FilterFrameText;
      
      private var buyBtn:BaseButton;
      
      private var buyIcon:Bitmap;
      
      private var _info:GiftBagInfo;
      
      private var icon:Component;
      
      private var _goodsIcon:MovieClip;
      
      private var arrow:MovieClip;
      
      private var frame:BaseAlerFrame;
      
      public function CondiscountItem(){super();}
      
      public function get info() : GiftBagInfo{return null;}
      
      private function init() : void{}
      
      private function clickHandler(param1:MouseEvent) : void{}
      
      private function onBuyConfirmResponse(param1:FrameEvent) : void{}
      
      protected function onCheckComplete() : void{}
      
      public function setInfo(param1:GiftBagInfo) : void{}
      
      public function changeData(param1:int) : void{}
      
      public function dispose() : void{}
   }
}
