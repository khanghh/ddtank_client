package cardSystem.view
{
   import cardSystem.CardManager;
   import cardSystem.GrooveInfoManager;
   import cardSystem.data.CardGrooveInfo;
   import cardSystem.data.GrooveInfo;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   
   public class CardInputFrame extends BaseAlerFrame
   {
      
      public static const RESTRICT:String = "0-9";
      
      public static const DEFAULT:String = "0";
       
      
      private var _alertInfo:AlertInfo;
      
      private var _needSoulText:FilterFrameText;
      
      private var _SellText:FilterFrameText;
      
      private var _SellText1:FilterFrameText;
      
      private var _SellText2:FilterFrameText;
      
      private var _InputTxt:FilterFrameText;
      
      private var _sellInputBg:Scale9CornerImage;
      
      private var _place:int;
      
      private var _cardtype:int;
      
      public function CardInputFrame()
      {
         super();
         setView();
         setEvent();
      }
      
      public function set place(vaule:int) : void
      {
         _place = vaule;
         _needSoulText.text = String(getNeedSoul());
         var total:int = PlayerManager.Instance.Self.CardSoul;
         var need:int = getNeedSoul();
         if(need > total)
         {
            _InputTxt.text = String(total);
         }
         else
         {
            _InputTxt.text = String(getNeedSoul());
         }
      }
      
      public function set cardtype(value:int) : void
      {
         _cardtype = value;
      }
      
      private function setView() : void
      {
         cancelButtonStyle = "core.simplebt";
         submitButtonStyle = "core.simplebt";
         _alertInfo = new AlertInfo(LanguageMgr.GetTranslation("ddt.cardSystem.CardSell.SellText"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"));
         _alertInfo.moveEnable = false;
         info = _alertInfo;
         this.escEnable = true;
         _needSoulText = ComponentFactory.Instance.creatComponentByStylename("ddtcardSystem.SellNeedSoulText");
         _SellText = ComponentFactory.Instance.creatComponentByStylename("ddtcardSystem.SellLeftAlerText2");
         _SellText.text = LanguageMgr.GetTranslation("ddt.cardSystem.CardSell.SellText1");
         _SellText1 = ComponentFactory.Instance.creatComponentByStylename("ddtcardSystem.SellLeftAlerText3");
         _SellText1.text = LanguageMgr.GetTranslation("ddt.cardSystem.CardSell.SellText5");
         _SellText2 = ComponentFactory.Instance.creatComponentByStylename("ddtcardSystem.SellLeftAlerText5");
         _SellText2.text = LanguageMgr.GetTranslation("ddt.cardSystem.CardSell.SellText4");
         _sellInputBg = ComponentFactory.Instance.creatComponentByStylename("ddtcardSystem.SellInputBg");
         _InputTxt = ComponentFactory.Instance.creatComponentByStylename("ddtcardSystem.SellLeftAlerText4");
         _InputTxt.maxChars = 8;
         _InputTxt.restrict = "0-9";
         _InputTxt.text = "0";
         addToContent(_needSoulText);
         addToContent(_SellText);
         addToContent(_SellText1);
         addToContent(_SellText2);
         addToContent(_sellInputBg);
         addToContent(_InputTxt);
      }
      
      private function getNeedSoul(level:String = null) : int
      {
         if(level == null)
         {
            level = String(CardManager.Instance.model.GrooveInfoVector[_place].Level + 1);
         }
         var _cardGrooveInfo:GrooveInfo = CardManager.Instance.model.GrooveInfoVector[_place];
         var _grooveInfo:CardGrooveInfo = GrooveInfoManager.instance.getInfoByLevel(level,String(_cardGrooveInfo.Type));
         var GP:int = _cardGrooveInfo.GP;
         var Exp:int = _grooveInfo.Exp;
         var needSoul:int = Exp - GP;
         return needSoul;
      }
      
      private function setEvent() : void
      {
         addEventListener("response",__Response);
         _InputTxt.addEventListener("mouseFocusChange",__focusOut);
         _InputTxt.addEventListener("keyDown",__keyDown);
         _InputTxt.addEventListener("change",_change);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__Response);
         _InputTxt.removeEventListener("mouseFocusChange",__focusOut);
         _InputTxt.removeEventListener("keyDown",__keyDown);
         _InputTxt.removeEventListener("change",_change);
      }
      
      private function _change(event:Event) : void
      {
         var level:String = "40";
         var current:int = _InputTxt.text;
         var total:int = PlayerManager.Instance.Self.CardSoul;
         var num:String = _InputTxt.text.toString();
         var needSoul:int = getNeedSoul(level);
         if(current > total)
         {
            _InputTxt.text = PlayerManager.Instance.Self.CardSoul.toString();
         }
         else if(num == "00")
         {
            _InputTxt.text = "0";
         }
         else if(num == "01")
         {
            _InputTxt.text = "1";
         }
         else if(num == "02")
         {
            _InputTxt.text = "2";
         }
         else if(num == "03")
         {
            _InputTxt.text = "3";
         }
         else if(num == "04")
         {
            _InputTxt.text = "4";
         }
         else if(num == "05")
         {
            _InputTxt.text = "5";
         }
         else if(num == "06")
         {
            _InputTxt.text = "6";
         }
         else if(num == "07")
         {
            _InputTxt.text = "7";
         }
         else if(num == "08")
         {
            _InputTxt.text = "8";
         }
         else if(num == "09")
         {
            _InputTxt.text = "9";
         }
      }
      
      private function __Response(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
            case 3:
            case 4:
               confirmSubmit();
         }
      }
      
      private function confirmSubmit() : void
      {
         var level:String = "45";
         var total:int = PlayerManager.Instance.Self.CardSoul;
         var current:int = _InputTxt.text;
         var needSoul:int = getNeedSoul(level);
         if(current == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.cardSystem.CardSell.SellText2"));
         }
         else if(current > total)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.cardSystem.CardSell.SellText3"));
         }
         else if(current > needSoul)
         {
            _InputTxt.text = needSoul.toString();
            SocketManager.Instance.out.sendUpdateSLOT(_place,int(_InputTxt.text));
            CardManager.Instance.model.inputSoul = int(_InputTxt.text);
            dispose();
         }
         else
         {
            SocketManager.Instance.out.sendUpdateSLOT(_place,int(_InputTxt.text));
            CardManager.Instance.model.inputSoul = int(_InputTxt.text);
            dispose();
         }
      }
      
      private function checkSoul() : void
      {
         var total:int = PlayerManager.Instance.Self.CardSoul;
         var current:* = int(_InputTxt.text);
         if(current >= total)
         {
            current = total;
         }
         _InputTxt.text = String(current);
      }
      
      private function __keyDown(event:KeyboardEvent) : void
      {
         if(event.keyCode == 13)
         {
            event.stopImmediatePropagation();
            SoundManager.instance.play("008");
            confirmSubmit();
         }
      }
      
      private function __focusOut(event:FocusEvent) : void
      {
      }
      
      override public function dispose() : void
      {
         if(_needSoulText)
         {
            ObjectUtils.disposeObject(_needSoulText);
            _needSoulText = null;
         }
         super.dispose();
         removeEvent();
      }
   }
}
