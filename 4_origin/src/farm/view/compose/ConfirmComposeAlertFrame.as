package farm.view.compose
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import farm.view.compose.event.SelectComposeItemEvent;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import petsBag.PetsBagManager;
   
   public class ConfirmComposeAlertFrame extends BaseAlerFrame
   {
      
      private static const MaxNum:int = 999;
       
      
      private var _minBtn:BaseButton;
      
      private var _maxBtn:BaseButton;
      
      private var _addBtn:BaseButton;
      
      private var _removeBtn:BaseButton;
      
      private var _inputNumBg:DisplayObject;
      
      private var _inputTxt:FilterFrameText;
      
      private var _inputNum:int = 1;
      
      private var _bgTitle:DisplayObject;
      
      public function ConfirmComposeAlertFrame()
      {
         super();
         var alertInfo:AlertInfo = new AlertInfo();
         alertInfo.title = LanguageMgr.GetTranslation("ddt.farms.composeComfirmNumPnlTitle");
         alertInfo.bottomGap = 37;
         alertInfo.buttonGape = 65;
         alertInfo.customPos = ComponentFactory.Instance.creat("farm.confirmComposeAlertBtnPos");
         this.info = alertInfo;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bgTitle = ComponentFactory.Instance.creat("assets.farm.titleSmall");
         addChild(_bgTitle);
         PositionUtils.setPos(_bgTitle,PositionUtils.creatPoint("farm.confirmComposeAlertTitlePos"));
         _inputNumBg = ComponentFactory.Instance.creat("farmHouse.confimCompose.inputBG");
         addToContent(_inputNumBg);
         _inputTxt = ComponentFactory.Instance.creat("farmHouse.text.composeNum");
         addToContent(_inputTxt);
         _inputTxt.restrict = "0-9";
         _inputTxt.text = _inputNum.toString();
         _minBtn = ComponentFactory.Instance.creat("farmHouse.houseCompose.minBtn");
         addToContent(_minBtn);
         _maxBtn = ComponentFactory.Instance.creat("farmHouse.houseCompose.maxBtn");
         addToContent(_maxBtn);
         _addBtn = ComponentFactory.Instance.creat("farmHouse.houseCompose.addBtn");
         addToContent(_addBtn);
         _removeBtn = ComponentFactory.Instance.creat("farmHouse.houseCompose.removeBtn");
         addToContent(_removeBtn);
         if(PetsBagManager.instance().haveTaskOrderByID(370))
         {
            PetsBagManager.instance().clearCurrentPetFarmGuildeArrow(111);
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__framePesponse);
         _inputTxt.addEventListener("change",__inputCheck);
         _minBtn.addEventListener("click",__changeInputNumber);
         _maxBtn.addEventListener("click",__changeInputNumber);
         _addBtn.addEventListener("click",__changeInputNumber);
         _removeBtn.addEventListener("click",__changeInputNumber);
      }
      
      protected function __framePesponse(event:FrameEvent) : void
      {
         removeEventListener("response",__framePesponse);
         SoundManager.instance.play("008");
         switch(int(event.responseCode) - 2)
         {
            case 0:
            case 1:
               dispatchEvent(new SelectComposeItemEvent("compose_count",_inputTxt.text));
         }
         dispose();
      }
      
      private function __inputCheck(e:Event) : void
      {
         _inputNum = int(_inputTxt.text);
         if(_inputNum > 999)
         {
            _inputNum = 999;
         }
         else if(_inputNum < 1)
         {
            _inputNum = 1;
         }
         _inputTxt.text = String(_inputNum);
      }
      
      private function checkInput() : void
      {
         if(_inputNum > 999)
         {
            _inputNum = 999;
         }
         else if(_inputNum < 1)
         {
            _inputNum = 1;
         }
         _inputTxt.text = _inputNum.toString();
      }
      
      private function __changeInputNumber(e:MouseEvent) : void
      {
         var _loc2_:* = e.currentTarget;
         if(_maxBtn !== _loc2_)
         {
            if(_minBtn !== _loc2_)
            {
               if(_addBtn !== _loc2_)
               {
                  if(_removeBtn === _loc2_)
                  {
                     _inputNum = Number(_inputNum) - 1;
                  }
               }
               else
               {
                  _inputNum = Number(_inputNum) + 1;
               }
            }
            else
            {
               _inputNum = 1;
            }
         }
         else
         {
            _inputNum = 999;
         }
         checkInput();
      }
      
      public function set maxCount(value:int) : void
      {
         _inputNum = value;
         _inputTxt.text = _inputNum.toString();
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__framePesponse);
         _inputTxt.removeEventListener("change",__inputCheck);
         _minBtn.removeEventListener("click",__changeInputNumber);
         _maxBtn.removeEventListener("click",__changeInputNumber);
         _addBtn.removeEventListener("click",__changeInputNumber);
         _removeBtn.removeEventListener("click",__changeInputNumber);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _inputNum = 1;
         if(_minBtn)
         {
            ObjectUtils.disposeObject(_minBtn);
            _minBtn = null;
         }
         if(_inputTxt)
         {
            ObjectUtils.disposeObject(_inputTxt);
            _inputTxt = null;
         }
         if(_inputNumBg)
         {
            ObjectUtils.disposeObject(_inputNumBg);
            _inputNumBg = null;
         }
         if(_removeBtn)
         {
            ObjectUtils.disposeObject(_removeBtn);
            _removeBtn = null;
         }
         if(_addBtn)
         {
            ObjectUtils.disposeObject(_addBtn);
            _addBtn = null;
         }
         if(_maxBtn)
         {
            ObjectUtils.disposeObject(_maxBtn);
            _maxBtn = null;
         }
         super.dispose();
      }
   }
}
