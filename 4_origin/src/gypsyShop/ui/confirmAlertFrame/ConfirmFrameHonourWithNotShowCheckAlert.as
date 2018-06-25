package gypsyShop.ui.confirmAlertFrame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ConfirmFrameHonourWithNotShowCheckAlert extends Frame
   {
      
      public static const OK:String = "ok";
      
      public static const CANCEL:String = "cancel";
       
      
      private var _itemInfo:InventoryItemInfo;
      
      private var _confirm:TextButton;
      
      private var _cancel:TextButton;
      
      private var _detailText:FilterFrameText;
      
      private var _scb:SelectedCheckButton;
      
      private var _titleTxt:String;
      
      private var _detail:String;
      
      private var _needHonour:int;
      
      private var _onNotShowAgain:Function;
      
      private var _onComfirm:Function;
      
      public function ConfirmFrameHonourWithNotShowCheckAlert()
      {
         super();
      }
      
      protected function __confirmhandler(event:MouseEvent) : void
      {
         _confirm && _confirm.removeEventListener("click",__confirmhandler);
         dispatchEvent(new FrameEvent(3));
         ok();
      }
      
      protected function __cancelHandler(event:MouseEvent) : void
      {
         cancel();
      }
      
      protected function __responseHandler(event:FrameEvent) : void
      {
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               cancel();
               break;
            case 2:
            case 3:
            case 4:
               ok();
         }
      }
      
      private function ok() : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      private function cancel() : void
      {
         SoundManager.instance.play("008");
         dispatchEvent(new Event("cancel"));
         dispose();
      }
      
      public function initView() : void
      {
         titleText = _titleTxt;
         _confirm = ComponentFactory.Instance.creatComponentByStylename("sellGoodsFrame.ok");
         _confirm.x = 31;
         _confirm.y = 120;
         _confirm.text = LanguageMgr.GetTranslation("ok");
         _cancel = ComponentFactory.Instance.creatComponentByStylename("sellGoodsFrame.cancel");
         _cancel.x = 228;
         _cancel.y = 120;
         _cancel.text = LanguageMgr.GetTranslation("cancel");
         _detailText = ComponentFactory.Instance.creat("simpleAlertContentText");
         _detailText.x = 58;
         _detailText.y = 58;
         _detailText.text = _detail;
         if(_scb == null)
         {
            _scb = ComponentFactory.Instance.creatComponentByStylename("ddtGame.buyConfirmNo.scb");
         }
         _scb.x = 99;
         _scb.y = 96;
         addToContent(_scb);
         _scb.text = LanguageMgr.GetTranslation("ddt.consortiaBattle.buyConfirm.noAlertTxt");
         addToContent(_detailText);
         addToContent(_confirm);
         addToContent(_cancel);
         addToContent(_scb);
         addEventListener("response",__responseHandler);
         _confirm.addEventListener("click",__confirmhandler);
         _cancel.addEventListener("click",__cancelHandler);
      }
      
      public function get isNoPrompt() : Boolean
      {
         return _scb.selected;
      }
      
      public function set selectedCheckButton(value:SelectedCheckButton) : void
      {
         _scb = value;
      }
      
      override public function dispose() : void
      {
         removeEventListener("response",__responseHandler);
         if(_confirm)
         {
            _confirm.removeEventListener("click",__confirmhandler);
         }
         if(_cancel)
         {
            _cancel.removeEventListener("click",__cancelHandler);
         }
         super.dispose();
         _itemInfo = null;
         if(_confirm)
         {
            ObjectUtils.disposeObject(_confirm);
         }
         _confirm = null;
         if(_cancel)
         {
            ObjectUtils.disposeObject(_cancel);
         }
         _cancel = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function set needHonour(value:int) : void
      {
         _needHonour = value;
      }
      
      public function set detail(value:String) : void
      {
         _detail = value;
      }
      
      public function set onNotShowAgain(value:Function) : void
      {
         _onNotShowAgain = value;
      }
      
      public function set onComfirm(value:Function) : void
      {
         _onComfirm = value;
      }
      
      public function set titleTxt(value:String) : void
      {
         _titleTxt = value;
      }
   }
}
