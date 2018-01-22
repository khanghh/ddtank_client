package magicHouse.magicBox
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
   
   public class MagicBoxExtractionSelectedNumAlertFrame extends BaseAlerFrame
   {
       
      
      protected var _alertInfo:AlertInfo;
      
      protected var _sellFunction:Function;
      
      protected var _notSellFunction:Function;
      
      protected var _maxNum:int = 0;
      
      protected var _minNum:int = 1;
      
      protected var _nowNum:int = 1;
      
      protected var _btn1:BaseButton;
      
      protected var _btn2:BaseButton;
      
      protected var _inputText:FilterFrameText;
      
      protected var _inputBg:Image;
      
      protected var _txtExplain:Bitmap;
      
      public var index:int;
      
      private var _goodsinfo:InventoryItemInfo;
      
      public function MagicBoxExtractionSelectedNumAlertFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         cancelButtonStyle = "core.simplebt";
         submitButtonStyle = "core.simplebt";
         _alertInfo = new AlertInfo(LanguageMgr.GetTranslation("magichouse.magicboxView.extractionSelectedNumTitle"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"));
         _alertInfo.moveEnable = false;
         info = _alertInfo;
         this.escEnable = true;
         _btn1 = ComponentFactory.Instance.creat("magicbox.SellLeftAlerBt1");
         _btn2 = ComponentFactory.Instance.creat("magicbox.SellLeftAlerBt2");
         _txtExplain = ComponentFactory.Instance.creatBitmap("magichouse.magicbox.selectedNum");
         _inputBg = ComponentFactory.Instance.creat("magicbox.SellLeftAlerInputTextBG");
         _inputText = ComponentFactory.Instance.creat("magicbox.SellLeftAlerInputText");
         _inputText.restrict = "0-9";
         addToContent(_txtExplain);
         addToContent(_inputBg);
         addToContent(_btn1);
         addToContent(_btn2);
         addToContent(_inputText);
      }
      
      private function initEvent() : void
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
      
      private function onFrameResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               if(_notSellFunction != null)
               {
                  _notSellFunction.call(this);
               }
               dispose();
               break;
            case 2:
            case 3:
            case 4:
               __confirm();
         }
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
      
      public function upSee() : void
      {
         _inputText.text = _nowNum.toString();
         _upbtView();
      }
      
      private function __confirm() : void
      {
         if(int(_inputText.text) >= _maxNum)
         {
            _nowNum = _maxNum;
         }
         else if(int(_inputText.text) == 0)
         {
            _nowNum = 1;
         }
         if(_sellFunction != null)
         {
            _sellFunction.call(this,_nowNum,goodsinfo,index);
         }
      }
      
      public function addExeFunction(param1:Function, param2:Function) : void
      {
         this._sellFunction = param1;
         this._notSellFunction = param2;
      }
      
      public function get goodsinfo() : InventoryItemInfo
      {
         return _goodsinfo;
      }
      
      public function set goodsinfo(param1:InventoryItemInfo) : void
      {
         _goodsinfo = param1;
      }
      
      public function show(param1:int = 5, param2:int = 1) : void
      {
         _maxNum = param1;
         _minNum = param2;
         _nowNum = _maxNum;
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      private function removeView() : void
      {
         if(_alertInfo)
         {
            _alertInfo = null;
         }
         if(_txtExplain)
         {
            ObjectUtils.disposeObject(_txtExplain);
         }
         _txtExplain = null;
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
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         removeView();
         if(_sellFunction != null)
         {
            _sellFunction = null;
         }
         if(_notSellFunction != null)
         {
            _notSellFunction = null;
         }
         if(this.parent)
         {
            removeChild(this);
         }
      }
   }
}
