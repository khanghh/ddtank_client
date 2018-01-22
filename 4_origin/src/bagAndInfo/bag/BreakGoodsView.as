package bagAndInfo.bag
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.ComponentEvent;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   
   public class BreakGoodsView extends BaseAlerFrame
   {
      
      private static const EnterKeyCode:int = 13;
      
      private static const ESCkeyCode:int = 27;
       
      
      private var _input:FilterFrameText;
      
      private var _NumString:FilterFrameText;
      
      private var _tipString:FilterFrameText;
      
      private var _inputBG:Scale9CornerImage;
      
      private var _cell:BagCell;
      
      private var _upBtn:SimpleBitmapButton;
      
      private var _downBtn:SimpleBitmapButton;
      
      public function BreakGoodsView()
      {
         super();
         cancelButtonStyle = "core.simplebt";
         submitButtonStyle = "core.simplebt";
         var _loc1_:AlertInfo = new AlertInfo();
         _loc1_.title = LanguageMgr.GetTranslation("tank.view.bagII.BreakGoodsView.split");
         info = _loc1_;
         _input = ComponentFactory.Instance.creatComponentByStylename("breakGoodsInput");
         _input.text = "1";
         _inputBG = ComponentFactory.Instance.creatComponentByStylename("breakInputbg");
         _inputBG.x = _input.x - 1;
         _inputBG.y = _input.y - 2;
         addToContent(_inputBG);
         addToContent(_input);
         _NumString = ComponentFactory.Instance.creatComponentByStylename("breakGoodsNumText");
         _NumString.text = LanguageMgr.GetTranslation("tank.view.bagII.BreakGoodsView.num");
         addToContent(_NumString);
         _tipString = ComponentFactory.Instance.creatComponentByStylename("breakGoodsPleasEnterText");
         _tipString.text = LanguageMgr.GetTranslation("tank.view.bagII.BreakGoodsView.input");
         addToContent(_tipString);
         submitButtonEnable = false;
         _upBtn = ComponentFactory.Instance.creatComponentByStylename("breakUpButton");
         addToContent(_upBtn);
         _downBtn = ComponentFactory.Instance.creatComponentByStylename("breakDownButton");
         addToContent(_downBtn);
         addEvent();
      }
      
      private function addEvent() : void
      {
         _input.addEventListener("change",__input);
         _input.addEventListener("keyUp",__onInputKeyUp);
         addEventListener("response",__responseHandler);
         addEventListener("addedToStage",__onToStage);
         _upBtn.addEventListener("click",__onUpBtn);
         _downBtn.addEventListener("click",__onDownBtn);
      }
      
      private function __onUpBtn(param1:Event) : void
      {
         var _loc2_:int = _input.text;
         _loc2_++;
         _input.text = String(_loc2_);
         downBtnEnable();
      }
      
      private function __onDownBtn(param1:Event) : void
      {
         var _loc2_:int = _input.text;
         if(_loc2_ == 0)
         {
            return;
         }
         _loc2_--;
         _input.text = String(_loc2_);
         downBtnEnable();
      }
      
      private function __onToStage(param1:Event) : void
      {
      }
      
      private function __onInputKeyUp(param1:KeyboardEvent) : void
      {
         switch(int(param1.keyCode) - 13)
         {
            case 0:
               okFun();
               break;
            default:
               okFun();
               break;
            default:
               okFun();
               break;
            default:
               okFun();
               break;
            default:
               okFun();
               break;
            default:
               okFun();
               break;
            default:
               okFun();
               break;
            default:
               okFun();
               break;
            default:
               okFun();
               break;
            default:
               okFun();
               break;
            default:
               okFun();
               break;
            default:
               okFun();
               break;
            default:
               okFun();
               break;
            default:
               okFun();
               break;
            case 14:
               dispose();
         }
      }
      
      private function __getFocus(param1:Event) : void
      {
         _input.setFocus();
      }
      
      private function removeEvent() : void
      {
         if(_input)
         {
            _input.removeEventListener("change",__input);
            _input.removeEventListener("keyUp",__onInputKeyUp);
         }
         removeEventListener("response",__responseHandler);
         removeEventListener("addedToStage",__onToStage);
         removeEventListener("click",__onUpBtn);
         removeEventListener("click",__onDownBtn);
      }
      
      private function __input(param1:Event) : void
      {
         submitButtonEnable = _input.text != "";
         downBtnEnable();
      }
      
      private function downBtnEnable() : void
      {
         if(!_input.text || _input.text == "" || int(_input.text) < 1)
         {
            _downBtn.enable = false;
         }
         else
         {
            _downBtn.enable = true;
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,2,true,1);
      }
      
      private function __okClickCall(param1:ComponentEvent) : void
      {
         okFun();
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
            case 3:
            case 4:
               okFun();
         }
      }
      
      private function getFocus() : void
      {
         if(stage)
         {
            stage.focus = _input;
         }
      }
      
      private function okFun() : void
      {
         SoundManager.instance.play("008");
         var _loc1_:int = _input.text;
         if(_loc1_ > 0 && _loc1_ < _cell.itemInfo.Count)
         {
            _cell.dragCountStart(_loc1_);
            dispose();
         }
         else if(_loc1_ == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.BreakGoodsView.wrong2"));
            _input.text = "";
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.BreakGoodsView.right"));
            _input.text = "";
         }
      }
      
      override public function dispose() : void
      {
         SoundManager.instance.play("008");
         removeEvent();
         ObjectUtils.disposeObject(_inputBG);
         _inputBG = null;
         ObjectUtils.disposeObject(_input);
         _input = null;
         ObjectUtils.disposeObject(_NumString);
         _NumString = null;
         ObjectUtils.disposeObject(_tipString);
         _tipString = null;
         _cell = null;
         if(_upBtn)
         {
            ObjectUtils.disposeObject(_upBtn);
         }
         _upBtn = null;
         if(_downBtn)
         {
            ObjectUtils.disposeObject(_downBtn);
         }
         _downBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
      
      public function get cell() : BagCell
      {
         return _cell;
      }
      
      public function set cell(param1:BagCell) : void
      {
         _cell = param1;
      }
   }
}
