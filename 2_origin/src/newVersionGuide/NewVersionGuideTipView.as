package newVersionGuide
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.OpitionEnum;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class NewVersionGuideTipView extends Sprite implements Disposeable
   {
       
      
      private var _bg:MovieClip;
      
      private var _contentBit:Bitmap;
      
      private var _btn:TextButton;
      
      private var _completeGuideFunc:Function;
      
      private var _type:int;
      
      public function NewVersionGuideTipView(param1:int, param2:Function = null)
      {
         super();
         _type = param1;
         _completeGuideFunc = param2;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("hall.newVersionGuide.tipBg");
         addChild(_bg);
         _contentBit = ComponentFactory.Instance.creat("hall.newVersionGuide.tip" + _type);
         addChild(_contentBit);
         _btn = ComponentFactory.Instance.creatComponentByStylename("newVersionGuide.btn");
         _btn.text = LanguageMgr.GetTranslation("ok");
         addChild(_btn);
      }
      
      private function initEvent() : void
      {
         _btn.addEventListener("click",__clickHandler);
      }
      
      protected function __clickHandler(param1:MouseEvent) : void
      {
         if(_type == 1)
         {
            dispose();
            NewVersionGuideManager.instance.startGuide();
         }
         else
         {
            dispose();
            PlayerManager.Instance.Self.OptionOnOff = OpitionEnum.setOpitionState(true,128);
            SocketManager.Instance.out.sendOpition(PlayerManager.Instance.Self.OptionOnOff);
            _completeGuideFunc();
            NewVersionGuideManager.instance.dispatchEvent(new NewVersionGuideEvent(NewVersionGuideEvent.GUIDECOMPLETE));
         }
      }
      
      private function removeEvent() : void
      {
         _btn.removeEventListener("click",__clickHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_contentBit);
         _contentBit = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
