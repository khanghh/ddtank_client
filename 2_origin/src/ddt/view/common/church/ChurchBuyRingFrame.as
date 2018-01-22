package ddt.view.common.church
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.view.DoubleSelectedItem;
   import flash.events.Event;
   
   public class ChurchBuyRingFrame extends BaseAlerFrame
   {
       
      
      private var _text1:FilterFrameText;
      
      private var _text2:FilterFrameText;
      
      private var _text3:FilterFrameText;
      
      private var _ringInfo:ShopItemInfo;
      
      private var _alertInfo:AlertInfo;
      
      private var _spouseID:int;
      
      private var _proposeStr:String;
      
      private var _useBugle:Boolean;
      
      private var _selectItem:DoubleSelectedItem;
      
      public function ChurchBuyRingFrame()
      {
         super();
         initialize();
      }
      
      public function get useBugle() : Boolean
      {
         return _useBugle;
      }
      
      public function set useBugle(param1:Boolean) : void
      {
         _useBugle = param1;
      }
      
      public function get proposeStr() : String
      {
         return _proposeStr;
      }
      
      public function set proposeStr(param1:String) : void
      {
         _proposeStr = param1;
      }
      
      public function get spouseID() : int
      {
         return _spouseID;
      }
      
      public function set spouseID(param1:int) : void
      {
         _spouseID = param1;
      }
      
      private function initialize() : void
      {
         cancelButtonStyle = "core.simplebt";
         submitButtonStyle = "core.simplebt";
         this.escEnable = true;
         _alertInfo = new AlertInfo();
         _alertInfo.moveEnable = false;
         info = _alertInfo;
         _text1 = ComponentFactory.Instance.creat("common.church.ChurchBuyRingFrame.text1");
         _text1.text = LanguageMgr.GetTranslation("common.church.ChurchBuyRingFrame.text1.text");
         addToContent(_text1);
         _text2 = ComponentFactory.Instance.creat("common.church.ChurchBuyRingFrame.text2");
         _text2.text = LanguageMgr.GetTranslation("common.church.ChurchBuyRingFrame.text2.text");
         addToContent(_text2);
         _text3 = ComponentFactory.Instance.creat("common.church.ChurchBuyRingFrame.text3");
         _text3.text = LanguageMgr.GetTranslation("common.church.ChurchBuyRingFrame.text3.text");
         addToContent(_text3);
         _ringInfo = ShopManager.Instance.getMoneyShopItemByTemplateID(11103);
         addEventListener("response",onFrameResponse);
      }
      
      private function confirmSubmit() : void
      {
         if(PathManager.solveChurchEnable())
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            CheckMoneyUtils.instance.checkMoney(false,_ringInfo.getItemPrice(1).bothMoneyValue,onCheckComplete);
         }
      }
      
      protected function onCheckComplete() : void
      {
         SocketManager.Instance.out.sendPropose(_spouseID,_proposeStr,_useBugle,CheckMoneyUtils.instance.isBind);
         dispose();
      }
      
      private function onFrameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               dispose();
               break;
            case 2:
            case 3:
            case 4:
               SoundManager.instance.play("008");
               confirmSubmit();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEventListener("response",onFrameResponse);
         _ringInfo = null;
         _alertInfo = null;
         if(_text1)
         {
            if(_text1.parent)
            {
               _text1.parent.removeChild(_text1);
            }
         }
         _text1 = null;
         if(_text2)
         {
            if(_text2.parent)
            {
               _text2.parent.removeChild(_text2);
            }
         }
         _text2 = null;
         if(_text3)
         {
            if(_text3.parent)
            {
               _text3.parent.removeChild(_text3);
            }
         }
         _text3 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         dispatchEvent(new Event("close"));
      }
   }
}
