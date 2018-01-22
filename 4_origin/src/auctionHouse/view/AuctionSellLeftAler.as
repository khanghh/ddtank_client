package auctionHouse.view
{
   import auctionHouse.event.AuctionSellEvent;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class AuctionSellLeftAler extends BaseAlerFrame
   {
       
      
      private var _alertInfo:AlertInfo;
      
      private var _btn1:BaseButton;
      
      private var _btn2:BaseButton;
      
      private var _inputText:FilterFrameText;
      
      private var _SellText:FilterFrameText;
      
      private var _SellText1:FilterFrameText;
      
      private var _maxNum:int = 0;
      
      private var _minNum:int = 1;
      
      private var _nowNum:int = 1;
      
      private var _sellInputBg:Scale9CornerImage;
      
      public function AuctionSellLeftAler()
      {
         super();
         initialize();
      }
      
      protected function initialize() : void
      {
         setView();
         setEvent();
      }
      
      private function setView() : void
      {
         cancelButtonStyle = "core.simplebt";
         submitButtonStyle = "core.simplebt";
         _alertInfo = new AlertInfo(LanguageMgr.GetTranslation("tank.view.bagII.BreakGoodsView.number"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"));
         _alertInfo.moveEnable = false;
         info = _alertInfo;
         this.escEnable = true;
         _SellText = ComponentFactory.Instance.creatComponentByStylename("ddtauctionHouse.SellLeftAlerText");
         _SellText.text = LanguageMgr.GetTranslation("tank.ddtauctionHouse.text.SellNumber");
         _SellText1 = ComponentFactory.Instance.creatComponentByStylename("ddtauctionHouse.SellLeftAlerText1");
         _SellText1.text = LanguageMgr.GetTranslation("tank.view.bagII.BreakGoodsView.input");
         _sellInputBg = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.SellLeftAlerInputBg");
         _btn1 = ComponentFactory.Instance.creat("auctionHouse.SellLeftAlerBt1");
         _btn2 = ComponentFactory.Instance.creat("auctionHouse.SellLeftAlerBt2");
         _inputText = ComponentFactory.Instance.creat("auctionHouse.SellLeftAlerInputText");
         _inputText.restrict = "0-9";
         addToContent(_SellText);
         addToContent(_SellText1);
         addToContent(_sellInputBg);
         addToContent(_btn1);
         addToContent(_btn2);
         addToContent(_inputText);
         upSee();
      }
      
      public function show(param1:int = 5, param2:int = 1) : void
      {
         _maxNum = param1;
         _minNum = param2;
         _nowNum = _maxNum;
         LayerManager.Instance.addToLayer(this,2,true,1);
         upSee();
      }
      
      public function upSee() : void
      {
         _inputText.text = _nowNum.toString();
         _upbtView();
      }
      
      private function removeView() : void
      {
      }
      
      private function setEvent() : void
      {
         _inputText.addEventListener("change",_changeInput);
         addEventListener("response",onFrameResponse);
         _btn1.addEventListener("click",click_btn1);
         _btn2.addEventListener("click",click_btn2);
      }
      
      private function removeEvent() : void
      {
         _inputText.removeEventListener("change",_changeInput);
         removeEventListener("response",onFrameResponse);
         _btn1.removeEventListener("click",click_btn1);
         _btn2.removeEventListener("click",click_btn2);
      }
      
      private function _changeInput(param1:Event) : void
      {
         if(int(_inputText.text) == 0)
         {
            _nowNum = 1;
         }
         else if(int(_inputText.text) > _maxNum)
         {
            _nowNum = _maxNum;
         }
         else
         {
            _nowNum = int(_inputText.text);
         }
         upSee();
      }
      
      private function click_btn1(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _nowNum = _nowNum + 1;
         upSee();
      }
      
      private function click_btn2(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _nowNum = _nowNum - 1;
         upSee();
      }
      
      private function _upbtView() : void
      {
         _btn1.enable = true;
         _btn2.enable = true;
         if(_nowNum == _minNum)
         {
            _btn2.enable = false;
         }
         else if(_nowNum == _maxNum)
         {
            _btn1.enable = false;
         }
      }
      
      private function onFrameResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
               dispatchEvent(new AuctionSellEvent("notsell",_nowNum));
               break;
            case 2:
            case 3:
            case 4:
               if(int(_inputText.text) >= _maxNum)
               {
                  _nowNum = _maxNum;
               }
               else if(int(_inputText.text) == 0)
               {
                  _nowNum = 1;
               }
               dispatchEvent(new AuctionSellEvent("sell",_nowNum));
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         removeView();
      }
   }
}
