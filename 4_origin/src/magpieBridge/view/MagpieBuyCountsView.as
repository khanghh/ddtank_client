package magpieBridge.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.NumberSelecter;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.Price;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class MagpieBuyCountsView extends BaseAlerFrame
   {
       
      
      private var _text:FilterFrameText;
      
      private var _numberSelecter:NumberSelecter;
      
      private var _okBtn:TextButton;
      
      private var _cancelBtn:TextButton;
      
      private var _totalTipText:FilterFrameText;
      
      private var _totalText:FilterFrameText;
      
      private var _price:int;
      
      public function MagpieBuyCountsView()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         titleText = "Mua lực hành động";
         _text = ComponentFactory.Instance.creatComponentByStylename("magpieBridge.buyCountsView.text");
         _text.text = "Số lần mua lực \nhành động";
         addToContent(_text);
         _numberSelecter = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.NumberSelecter");
         PositionUtils.setPos(_numberSelecter,"magpieBridgeView.numSelecterPos");
         addToContent(_numberSelecter);
         _totalTipText = ComponentFactory.Instance.creatComponentByStylename("ddtcore.TotalTipsText");
         PositionUtils.setPos(_totalTipText,"magpieBridgeView.totalTipPos");
         _totalTipText.text = LanguageMgr.GetTranslation("ddt.QuickFrame.TotalTipText");
         addToContent(_totalTipText);
         _totalText = ComponentFactory.Instance.creatComponentByStylename("ddtcore.TotalText");
         PositionUtils.setPos(_totalText,"magpieBridgeView.totalTxtPos");
         _totalText.text = "100";
         addToContent(_totalText);
         _okBtn = ComponentFactory.Instance.creatComponentByStylename("core.simplebt");
         _okBtn.text = LanguageMgr.GetTranslation("ok");
         PositionUtils.setPos(_okBtn,"magpieBridgeView.okBtnPos");
         addToContent(_okBtn);
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("core.simplebt");
         _cancelBtn.text = LanguageMgr.GetTranslation("cancel");
         PositionUtils.setPos(_cancelBtn,"magpieBridgeView.cancelBtnPos");
         addToContent(_cancelBtn);
      }
      
      private function initEvents() : void
      {
         addEventListener("response",__frameEventHandler);
         _numberSelecter.addEventListener("change",__seleterChange);
         _okBtn.addEventListener("click",__okBtnClick);
         _cancelBtn.addEventListener("click",__cancelBtnClick);
      }
      
      protected function __selectedItemChange(param1:Event) : void
      {
         updateTotalCost();
      }
      
      public function updateTotalCost() : void
      {
         var _loc1_:int = _price * int(_numberSelecter.currentValue);
         _totalText.text = _loc1_ + " " + Price.MONEYTOSTRING;
      }
      
      protected function __okBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:int = _price * int(_numberSelecter.currentValue);
         if(PlayerManager.Instance.Self.Money < _loc2_)
         {
            LeavePageManager.showFillFrame();
            return;
         }
         SocketManager.Instance.out.buyMagpieCount(int(_numberSelecter.currentValue),false);
         dispose();
      }
      
      private function reConfirmHandler(param1:FrameEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("008");
         var _loc3_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc3_.removeEventListener("response",reConfirmHandler);
         switch(int(param1.responseCode))
         {
            default:
            default:
            case 2:
            case 3:
               _loc2_ = _price * int(_numberSelecter.currentValue);
               if(PlayerManager.Instance.Self.Money < _loc2_)
               {
                  LeavePageManager.showFillFrame();
                  return;
               }
               SocketManager.Instance.out.buyMagpieCount(int(_numberSelecter.currentValue),false);
               break;
            default:
               _loc2_ = _price * int(_numberSelecter.currentValue);
               if(PlayerManager.Instance.Self.Money < _loc2_)
               {
                  LeavePageManager.showFillFrame();
                  return;
               }
               SocketManager.Instance.out.buyMagpieCount(int(_numberSelecter.currentValue),false);
               break;
         }
         param1.currentTarget.removeEventListener("response",reConfirmHandler);
         ObjectUtils.disposeObject(param1.currentTarget);
         dispose();
      }
      
      protected function __cancelBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      private function __seleterChange(param1:Event) : void
      {
         SoundManager.instance.play("008");
         updateTotalCost();
      }
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",__frameEventHandler);
         _numberSelecter.removeEventListener("change",__seleterChange);
         _okBtn.removeEventListener("click",__okBtnClick);
         _cancelBtn.removeEventListener("click",__cancelBtnClick);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvents();
         ObjectUtils.disposeObject(_numberSelecter);
         _numberSelecter = null;
         ObjectUtils.disposeObject(_text);
         _text = null;
         ObjectUtils.disposeObject(_totalTipText);
         _totalTipText = null;
         ObjectUtils.disposeObject(_totalText);
         _totalText = null;
         ObjectUtils.disposeObject(_okBtn);
         _okBtn = null;
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
      }
      
      public function set price(param1:int) : void
      {
         _price = param1;
         updateTotalCost();
      }
   }
}
