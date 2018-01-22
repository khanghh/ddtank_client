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
      
      public function set place(param1:int) : void
      {
         _place = param1;
         _needSoulText.text = String(getNeedSoul());
         var _loc3_:int = PlayerManager.Instance.Self.CardSoul;
         var _loc2_:int = getNeedSoul();
         if(_loc2_ > _loc3_)
         {
            _InputTxt.text = String(_loc3_);
         }
         else
         {
            _InputTxt.text = String(getNeedSoul());
         }
      }
      
      public function set cardtype(param1:int) : void
      {
         _cardtype = param1;
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
      
      private function getNeedSoul(param1:String = null) : int
      {
         if(param1 == null)
         {
            param1 = String(CardManager.Instance.model.GrooveInfoVector[_place].Level + 1);
         }
         var _loc5_:GrooveInfo = CardManager.Instance.model.GrooveInfoVector[_place];
         var _loc6_:CardGrooveInfo = GrooveInfoManager.instance.getInfoByLevel(param1,String(_loc5_.Type));
         var _loc4_:int = _loc5_.GP;
         var _loc3_:int = _loc6_.Exp;
         var _loc2_:int = _loc3_ - _loc4_;
         return _loc2_;
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
      
      private function _change(param1:Event) : void
      {
         var _loc5_:String = "40";
         var _loc6_:int = _InputTxt.text;
         var _loc3_:int = PlayerManager.Instance.Self.CardSoul;
         var _loc4_:String = _InputTxt.text.toString();
         var _loc2_:int = getNeedSoul(_loc5_);
         if(_loc6_ > _loc3_)
         {
            _InputTxt.text = PlayerManager.Instance.Self.CardSoul.toString();
         }
         else if(_loc4_ == "00")
         {
            _InputTxt.text = "0";
         }
         else if(_loc4_ == "01")
         {
            _InputTxt.text = "1";
         }
         else if(_loc4_ == "02")
         {
            _InputTxt.text = "2";
         }
         else if(_loc4_ == "03")
         {
            _InputTxt.text = "3";
         }
         else if(_loc4_ == "04")
         {
            _InputTxt.text = "4";
         }
         else if(_loc4_ == "05")
         {
            _InputTxt.text = "5";
         }
         else if(_loc4_ == "06")
         {
            _InputTxt.text = "6";
         }
         else if(_loc4_ == "07")
         {
            _InputTxt.text = "7";
         }
         else if(_loc4_ == "08")
         {
            _InputTxt.text = "8";
         }
         else if(_loc4_ == "09")
         {
            _InputTxt.text = "9";
         }
      }
      
      private function __Response(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
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
         var _loc3_:String = "45";
         var _loc2_:int = PlayerManager.Instance.Self.CardSoul;
         var _loc4_:int = _InputTxt.text;
         var _loc1_:int = getNeedSoul(_loc3_);
         if(_loc4_ == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.cardSystem.CardSell.SellText2"));
         }
         else if(_loc4_ > _loc2_)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.cardSystem.CardSell.SellText3"));
         }
         else if(_loc4_ > _loc1_)
         {
            _InputTxt.text = _loc1_.toString();
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
         var _loc1_:int = PlayerManager.Instance.Self.CardSoul;
         var _loc2_:* = int(_InputTxt.text);
         if(_loc2_ >= _loc1_)
         {
            _loc2_ = _loc1_;
         }
         _InputTxt.text = String(_loc2_);
      }
      
      private function __keyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            param1.stopImmediatePropagation();
            SoundManager.instance.play("008");
            confirmSubmit();
         }
      }
      
      private function __focusOut(param1:FocusEvent) : void
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
