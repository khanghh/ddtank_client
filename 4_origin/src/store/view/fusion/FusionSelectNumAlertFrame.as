package store.view.fusion
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class FusionSelectNumAlertFrame extends BaseAlerFrame
   {
       
      
      private var _alertInfo:AlertInfo;
      
      private var _bg:Bitmap;
      
      private var _btn1:BaseButton;
      
      private var _btn2:BaseButton;
      
      private var _inputText:FilterFrameText;
      
      private var _inputBg:Image;
      
      private var _maxNum:int = 0;
      
      private var _minNum:int = 1;
      
      private var _nowNum:int = 1;
      
      public var index:int;
      
      private var _goodsinfo:InventoryItemInfo;
      
      public function FusionSelectNumAlertFrame()
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
         _alertInfo = new AlertInfo(LanguageMgr.GetTranslation("store.fusion.autoSplit.inputNumber"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"));
         _alertInfo.moveEnable = false;
         info = _alertInfo;
         this.escEnable = true;
         _btn1 = ComponentFactory.Instance.creat("ddtstore.SellLeftAlerBt1");
         _btn2 = ComponentFactory.Instance.creat("ddtstore.SellLeftAlerBt2");
         _bg = ComponentFactory.Instance.creatBitmap("asset.ddtstore.FusionSpiltTextrBg");
         _inputBg = ComponentFactory.Instance.creat("ddtstore.SellLeftAlerInputTextBG");
         _inputText = ComponentFactory.Instance.creat("ddtstore.SellLeftAlerInputText");
         _inputText.restrict = "0-9";
         addToContent(_bg);
         addToContent(_inputBg);
         addToContent(_btn1);
         addToContent(_btn2);
         addToContent(_inputText);
      }
      
      public function show(param1:int = 5, param2:int = 1) : void
      {
         _maxNum = param1;
         _minNum = param2;
         _nowNum = _maxNum;
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      public function upSee() : void
      {
         _inputText.text = _nowNum.toString();
         _upbtView();
      }
      
      private function removeView() : void
      {
         if(_alertInfo)
         {
            _alertInfo = null;
         }
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_inputBg)
         {
            ObjectUtils.disposeObject(_inputBg);
         }
         _inputBg = null;
         if(_btn1)
         {
            ObjectUtils.disposeObject(_btn1);
         }
         _btn1 = null;
         if(_btn2)
         {
            ObjectUtils.disposeObject(_btn2);
         }
         _btn2 = null;
         if(_inputText)
         {
            ObjectUtils.disposeObject(_inputText);
         }
         _inputText = null;
      }
      
      private function setEvent() : void
      {
         addEventListener("addedToStage",__addToStageHandler);
         _inputText.addEventListener("change",_changeInput);
         _inputText.addEventListener("keyDown",__enterHanlder);
         addEventListener("response",onFrameResponse);
         _btn1.addEventListener("click",click_btn1);
         _btn2.addEventListener("click",click_btn2);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("addedToStage",__addToStageHandler);
         if(_inputText)
         {
            _inputText.removeEventListener("change",_changeInput);
         }
         if(_inputText)
         {
            _inputText.removeEventListener("keyDown",__enterHanlder);
         }
         removeEventListener("response",onFrameResponse);
         if(_btn1)
         {
            _btn1.removeEventListener("click",click_btn1);
         }
         if(_btn2)
         {
            _btn2.removeEventListener("click",click_btn2);
         }
      }
      
      private function __addToStageHandler(param1:Event) : void
      {
         _inputText.appendText(_nowNum.toString());
         _inputText.setFocus();
         _upbtView();
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
      
      private function __enterHanlder(param1:KeyboardEvent) : void
      {
         param1.stopImmediatePropagation();
         if(param1.keyCode == 13)
         {
            __confirm();
         }
         if(param1.keyCode == 27)
         {
            SoundManager.instance.play("008");
            dispose();
         }
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
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
               _loc2_ = new FusionSelectEvent("notsell",_nowNum);
               _loc2_.info = goodsinfo;
               _loc2_.index = index;
               dispatchEvent(_loc2_);
               break;
            case 2:
            case 3:
            case 4:
               __confirm();
         }
      }
      
      private function __confirm() : void
      {
         var _loc1_:* = null;
         if(int(_inputText.text) >= _maxNum)
         {
            _nowNum = _maxNum;
         }
         else if(int(_inputText.text) == 0)
         {
            _nowNum = 1;
         }
         _loc1_ = new FusionSelectEvent("sell",_nowNum);
         _loc1_.info = goodsinfo;
         _loc1_.index = index;
         dispatchEvent(_loc1_);
      }
      
      public function get goodsinfo() : InventoryItemInfo
      {
         return _goodsinfo;
      }
      
      public function set goodsinfo(param1:InventoryItemInfo) : void
      {
         _goodsinfo = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         removeView();
      }
   }
}
