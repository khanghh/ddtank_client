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
      
      private function __onKeyDown(event:KeyboardEvent) : void
      {
         event.stopImmediatePropagation();
         event.stopPropagation();
         if(event.keyCode == 13)
         {
            PlayerManager.Instance.Self.playerState.AutoReply = _input.text;
            _input.text = getShortStr(PlayerManager.Instance.Self.playerState.AutoReply);
            StageReferance.stage.focus = null;
         }
      }
      
      private function __focusOut(event:FocusEvent) : void
      {
         _input.background = false;
         _input.text = getShortStr(PlayerManager.Instance.Self.playerState.AutoReply);
         _input.scrollH = 0;
      }
      
      private function __onChange(event:PlayerPropertyEvent) : void
      {
         if(event.changedProperties["State"])
         {
            _input.text = getShortStr(PlayerManager.Instance.Self.playerState.AutoReply);
         }
      }
      
      private function __focusIn(event:FocusEvent) : void
      {
         _overBg.visible = false;
         _input.background = true;
         _input.text = PlayerManager.Instance.Self.playerState.AutoReply;
      }
      
      private function __outHandler(event:MouseEvent) : void
      {
         _overBg.visible = false;
      }
      
      private function getShortStr(str:String) : String
      {
         var tf:TextField = new TextField();
         tf.wordWrap = true;
         tf.autoSize = "left";
         tf.width = _input.width;
         tf.text = str;
         if(tf.textWidth > _input.width - 15)
         {
            str = tf.getLineText(0);
            str = str.substr(0,str.length - 3) + "...";
         }
         return str;
      }
      
      private function __overHandler(event:MouseEvent) : void
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
