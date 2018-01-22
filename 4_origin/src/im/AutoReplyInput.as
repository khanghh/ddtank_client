package im
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.PlayerManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.setTimeout;
   
   public class AutoReplyInput extends Sprite implements Disposeable
   {
       
      
      private var WIDTH:int = 150;
      
      private var _input:FilterFrameText;
      
      private var _overBg:Bitmap;
      
      public function AutoReplyInput()
      {
         super();
         _input = ComponentFactory.Instance.creatComponentByStylename("IM.stateItem.AutoReplyInputTxt");
         addChild(_input);
         _input.text = PlayerManager.Instance.Self.playerState.AutoReply;
         _input.type = "input";
         _input.autoSize = "none";
         _input.width = 160;
         _input.height = 20;
         _input.maxChars = 20;
         _overBg = ComponentFactory.Instance.creatBitmap("asset.IM.replyInputBgAsset");
         addChild(_overBg);
         _overBg.visible = false;
         initEvents();
      }
      
      private function initEvents() : void
      {
         addEventListener("mouseOver",__overHandler);
         addEventListener("mouseOut",__outHandler);
         _input.addEventListener("focusIn",__focusIn);
         _input.addEventListener("focusOut",__focusOut);
         _input.addEventListener("keyDown",__onKeyDown);
         PlayerManager.Instance.Self.addEventListener("propertychange",__onChange);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("mouseOver",__overHandler);
         removeEventListener("mouseOut",__outHandler);
         _input.removeEventListener("focusIn",__focusIn);
         _input.removeEventListener("focusOut",__focusOut);
         _input.removeEventListener("keyDown",__onKeyDown);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__onChange);
      }
      
      private function __onKeyDown(param1:KeyboardEvent) : void
      {
         param1.stopImmediatePropagation();
         param1.stopPropagation();
         if(param1.keyCode == 13)
         {
            PlayerManager.Instance.Self.playerState.AutoReply = _input.text;
            _input.text = getShortStr(PlayerManager.Instance.Self.playerState.AutoReply);
            StageReferance.stage.focus = null;
         }
      }
      
      private function __focusOut(param1:FocusEvent) : void
      {
         _input.background = false;
         _input.text = getShortStr(PlayerManager.Instance.Self.playerState.AutoReply);
         _input.scrollH = 0;
      }
      
      private function __onChange(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["State"])
         {
            _input.text = getShortStr(PlayerManager.Instance.Self.playerState.AutoReply);
         }
      }
      
      private function __focusIn(param1:FocusEvent) : void
      {
         _overBg.visible = false;
         _input.background = true;
         _input.text = PlayerManager.Instance.Self.playerState.AutoReply;
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         _overBg.visible = false;
      }
      
      private function getShortStr(param1:String) : String
      {
         var _loc2_:TextField = new TextField();
         _loc2_.wordWrap = true;
         _loc2_.autoSize = "left";
         _loc2_.width = _input.width;
         _loc2_.text = param1;
         if(_loc2_.textWidth > _input.width - 15)
         {
            param1 = _loc2_.getLineText(0);
            param1 = param1.substr(0,param1.length - 3) + "...";
         }
         return param1;
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         if(_input.background == false)
         {
            _overBg.visible = true;
         }
      }
      
      public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_overBg);
         _overBg = null;
         ObjectUtils.disposeObject(_input);
         _input = null;
      }
   }
}
